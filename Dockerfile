FROM debian
LABEL maintainer="loblab"

ARG DEBIAN_FRONTEND=noninteractive
ARG PYTHON=python3
ARG TARGETPLATFORM

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install chromium-chromedriver || \
    apt-get -y install chromium-driver || \
    apt-get -y install chromedriver
RUN if [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then apt-get -y install libffi-dev rustc; fi
RUN apt-get -y install ${PYTHON}-pip
RUN $PYTHON -m pip install --upgrade pip
RUN $PYTHON -m pip install selenium
RUN apt-get -y install curl wget

RUN mkdir -p /home/loblab && \
    useradd -d /home/loblab -u 1001 loblab && \
    chown loblab:loblab /home/loblab
USER loblab
WORKDIR /home/loblab
COPY /noip-renew.py /home/loblab/
ENTRYPOINT ["python3", "/home/loblab/noip-renew.py"]
