#!/bin/bash
# RustFS Privileged Helper
# Installed to /usr/local/bin/rustfs-helper
# Runs via sudo NOPASSWD — no password prompt needed after setup.
#
# Usage:
#   rustfs-helper hosts-add <domain> <console_port> <api_port>
#   rustfs-helper hosts-remove
#   rustfs-helper nginx-reload
#   rustfs-helper setup

MARKER="RustFS-managed"
HOSTS="/etc/hosts"
NGINX_DIR="$HOME/Library/Application Support/Herd/config/valet/Nginx"

case "$1" in
    hosts-add)
        DOMAIN="$2"
        CONSOLE_PORT="$3"
        API_PORT="$4"

        [ -z "$DOMAIN" ] && echo "Error: domain required" && exit 1
        [ -z "$CONSOLE_PORT" ] && CONSOLE_PORT=9001
        [ -z "$API_PORT" ] && API_PORT=9000

        # Update /etc/hosts
        sed -i '' "/$MARKER/d" "$HOSTS"
        echo "127.0.0.1 $DOMAIN # $MARKER" >> "$HOSTS"
        echo "127.0.0.1 api.$DOMAIN # $MARKER" >> "$HOSTS"

        # Reload nginx
        NGINX_PID=$(pgrep -f "nginx: master" | head -1)
        [ -n "$NGINX_PID" ] && kill -HUP "$NGINX_PID" 2>/dev/null

        echo "OK: $DOMAIN + api.$DOMAIN added, nginx reloaded"
        ;;

    hosts-remove)
        sed -i '' "/$MARKER/d" "$HOSTS"

        NGINX_PID=$(pgrep -f "nginx: master" | head -1)
        [ -n "$NGINX_PID" ] && kill -HUP "$NGINX_PID" 2>/dev/null

        echo "OK: hosts cleaned, nginx reloaded"
        ;;

    nginx-reload)
        NGINX_PID=$(pgrep -f "nginx: master" | head -1)
        [ -n "$NGINX_PID" ] && kill -HUP "$NGINX_PID" 2>/dev/null
        echo "OK: nginx reloaded"
        ;;

    setup)
        # Install this script to /usr/local/bin
        SCRIPT_SRC="$0"
        INSTALL_PATH="/usr/local/bin/rustfs-helper"
        mkdir -p /usr/local/bin
        cp "$SCRIPT_SRC" "$INSTALL_PATH"
        chmod 755 "$INSTALL_PATH"
        chown root:wheel "$INSTALL_PATH"

        # Add sudoers entry (NOPASSWD)
        SUDOERS_FILE="/etc/sudoers.d/rustfs"
        USER_NAME="$2"
        [ -z "$USER_NAME" ] && USER_NAME=$(stat -f '%Su' /dev/console)

        cat > "$SUDOERS_FILE" << EOF
# RustFS helper — allow without password
$USER_NAME ALL=(ALL) NOPASSWD: $INSTALL_PATH *
EOF
        chmod 440 "$SUDOERS_FILE"
        chown root:wheel "$SUDOERS_FILE"

        # Enable Touch ID for sudo (if available)
        SUDO_LOCAL="/etc/pam.d/sudo_local"
        if ! grep -q "pam_tid.so" "$SUDO_LOCAL" 2>/dev/null; then
            cat > "$SUDO_LOCAL" << 'PAMEOF'
# sudo_local: local config for sudo (Touch ID enabled)
auth       sufficient     pam_tid.so
PAMEOF
            echo "Touch ID for sudo: enabled"
        fi

        echo "OK: setup complete — no more password prompts for rustfs-helper"
        ;;

    *)
        echo "Usage: rustfs-helper {hosts-add|hosts-remove|nginx-reload|setup}"
        echo "  hosts-add <domain> <console_port> <api_port>"
        echo "  hosts-remove"
        echo "  nginx-reload"
        echo "  setup              (one-time, requires admin)"
        exit 1
        ;;
esac
