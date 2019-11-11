FROM minimsecure/ruby-docker-image:2.6.5-slim

WORKDIR /tmp

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get install -yq python3-dev yarn && \
    update-alternatives --install /usr/bin/python python $(which python3) 0

#install aws
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install --upgrade pip && \
    pip install --upgrade awscli requests

#install sonarqube
ENV SONAR_SCANNER_VER 3.3.0.1492-linux
RUN curl -O https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VER}.zip && \
    unzip -d /opt sonar-scanner-cli-${SONAR_SCANNER_VER}.zip && \
    rm sonar-scanner-cli-${SONAR_SCANNER_VER}.zip && \
    ln -s /opt/sonar-scanner-${SONAR_SCANNER_VER}/bin/sonar-scanner /usr/local/bin/sonar-scanner

#install docker
COPY install-docker.sh ./
RUN ./install-docker.sh

# Install Helm
RUN curl -o helm-v2.16.0-linux-amd64.tar.gz https://get.helm.sh/helm-v2.16.0-linux-amd64.tar.gz && \
    tar xzf helm-v2.16.0-linux-amd64.tar.gz && cp ./linux-amd64/helm /usr/local/bin/

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl  && \
    chmod +x ./kubectl && cp ./kubectl /usr/local/bin/


COPY sonar-waittask /usr/local/bin/
