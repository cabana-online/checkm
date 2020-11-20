FROM cabanaonline/ubuntu-dev:1.0

# Metadata
LABEL base.image="cabanaonline/ubuntu"
LABEL description="An Ubuntu container with Python."
LABEL maintainer="Alejandro Madrigal Leiva"
LABEL maintainer.email="me@alemadlei.tech"

USER root

# Installs development tools.
RUN set -xe; \
    \
    apt-get update -y && apt-get upgrade -y && \
    apt-get install -y python3 python3-pip && \
    pip3 install checkm && \
    apt-get clean && \
    apt-get autoclean;

# Reverts to standard user.
USER cabana

# Entrypoint to keep the container running.
ENTRYPOINT ["tail", "-f", "/dev/null"]
