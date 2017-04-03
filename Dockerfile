FROM arooneyva/ruby-docker-image:2.4.0

WORKDIR /tmp

#install aws
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

RUN apt-get update && apt-get install -yq python-dev
RUN pip install awscli --upgrade

#install docker
COPY install-docker.sh ./
RUN ./install-docker.sh
