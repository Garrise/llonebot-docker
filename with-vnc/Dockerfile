FROM garrise/ll-cc-docker:latest

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