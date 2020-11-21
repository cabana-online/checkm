FROM cabanaonline/ubuntu-dev:1.0

# Metadata
LABEL base.image="cabanaonline/ubuntu"
LABEL description="An Ubuntu container with Python."
LABEL maintainer="Alejandro Madrigal Leiva"
LABEL maintainer.email="me@alemadlei.tech"

USER root

ARG USER=cabana

# Installs development tools.
RUN set -xe; \
    \
    apt-get update -y && apt-get upgrade -y && \
    apt-get install -y python3 python3-pip hmmer prodigal && \
    pip3 install numpy matplotlib pysam checkm-genome==1.1.2 && \
    apt-get clean && \
    apt-get autoclean;

RUN \
    mkdir /home/cabana/.config && \
    mkdir /home/cabana/tools/checkm && \
    checkm data setRoot /home/cabana/tools/checkm && \
    chown -R $USER:$USER /home/cabana/.config && \
    chown -R $USER:$USER /home/cabana/tools/checkm;

RUN \
    cd /tmp && \
    wget https://github.com/matsen/pplacer/releases/download/v1.1.alpha19/pplacer-linux-v1.1.alpha19.zip && \
    unzip pplacer-linux-v1.1.alpha19.zip && \
    mv pplacer-Linux-v1.1.alpha19 /home/cabana/tools/pplacer && \
    rm -rf /tmp/* && \
    cd /usr/local/bin && \
    ln -s /home/cabana/tools/pplacer/guppy guppy && \
    ln -s /home/cabana/tools/pplacer/pplacer pplacer && \
    ln -s /home/cabana/tools/pplacer/rppr rppr;

# Reverts to standard user.
USER cabana

# Entrypoint to keep the container running.
ENTRYPOINT ["tail", "-f", "/dev/null"]
