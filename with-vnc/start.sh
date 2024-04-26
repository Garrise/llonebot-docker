#!/bin/bash

mkdir -p /opt/QQ/resources/app/LiteLoader/plugins/LLOneBot
mkdir -p /opt/QQ/resources/app/LiteLoader/plugins/LLWebUiApi
# 安装 LiteLoader
if [ ! -f "/opt/QQ/resources/app/LiteLoader/package.json" ]; then
    unzip /tmp/LiteLoaderQQNT.zip -d /opt/QQ/resources/app/LiteLoader/
fi

# 安装 LLOneBot、LLWebUiApi
if [ ! -f "/opt/QQ/resources/app/LiteLoader/plugins/LLOneBot/manifest.json" ]; then
    unzip /tmp/LLOneBot.zip -d /opt/QQ/resources/app/LiteLoader/plugins/LLOneBot/
    unzip /tmp/LLWebUiApi.zip -d /opt/QQ/resources/app/LiteLoader/plugins/LLWebUiApi/
    # 设置启动模式
    if [ "$BOOT_MODE" ]; then
        mkdir -p /opt/QQ/resources/app/LiteLoader/data/LLWebUiApi
        echo '{"Server":{"Port":6099},"AutoLogin":true,"BootMode":BOOT_MODE,"Debug":false}' > /opt/QQ/resources/app/LiteLoader/data/LLWebUiApi/config.json
        sed -i "s/BOOT_MODE/$BOOT_MODE/" /opt/QQ/resources/app/LiteLoader/data/LLWebUiApi/config.json
    fi
fi

# 安装 chronocat-api
if [ ! -f "/opt/QQ/resources/app/LiteLoader/plugins/LiteLoaderQQNT-Plugin-Chronocat-Engine-Chronocat-Api/manifest.json" ]; then
    unzip /tmp/chronocat-llqqnt-engine-chronocat-api.zip -d /opt/QQ/resources/app/LiteLoader/plugins/
fi

# 安装 chronocat-event
if [ ! -f "/opt/QQ/resources/app/LiteLoader/plugins/LiteLoaderQQNT-Plugin-Chronocat-Engine-Chronocat-Event/manifest.json" ]; then
    unzip /tmp/chronocat-llqqnt-engine-chronocat-event.zip -d /opt/QQ/resources/app/LiteLoader/plugins/
fi

# 安装 poke
if [ ! -f "/opt/QQ/resources/app/LiteLoader/plugins/LiteLoaderQQNT-Plugin-Chronocat-Engine-Crychiccat-master/manifest.json" ]; then
    unzip /tmp/chronocat-llqqnt-engine-crychiccat.zip -d /opt/QQ/resources/app/LiteLoader/plugins/
fi

# 安装 chronocat
if [ ! -f "/opt/QQ/resources/app/LiteLoader/plugins/LiteLoaderQQNT-Plugin-Chronocat/manifest.json" ]; then
    unzip /tmp/chronocat-llqqnt.zip -d /opt/QQ/resources/app/LiteLoader/plugins/
fi

chmod 777 /tmp &
rm -rf /run/dbus/pid &
rm /tmp/.X1-lock &
mkdir -p /var/run/dbus &
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address &
Xvfb :1 -screen 0 1080x760x16 &
fluxbox &
x11vnc -display :1 -noxrecord -noxfixes -noxdamage -forever -rfbauth ~/.vnc/passwd &
nohup /opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 6081 --file-only &
x11vnc -storepasswd $VNC_PASSWD ~/.vnc/passwd &
export DISPLAY=:1
# --disable-gpu 不加入
exec supervisord