FROM arooneyva/ruby-docker-image:2.5.3

WORKDIR /tmp

#install aws
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -yq python-dev yarn
RUN pip install awscli --upgrade

#install docker
COPY install-docker.sh ./
RUN ./install-docker.sh
