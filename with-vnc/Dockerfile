FROM mlikiowa/llonebot-docker:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWD=vncpasswd
COPY start.sh /root/start.sh


RUN apt-get update && apt-get install -y \
    fluxbox \
    x11vnc && \    
    apt-get clean --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p ~/.vnc && \
    chmod +x /root/start.sh

# 安装NoVnc
RUN git config --global http.sslVerify false && git config --global http.postBuffer 1048576000 && \
    cd /opt && git clone https://github.com/novnc/noVNC.git && \
    cd /opt/noVNC/utils && git clone https://github.com/novnc/websockify.git && \
    cp /opt/noVNC/vnc.html /opt/noVNC/index.html

