FROM jenkins/jenkins:lts-jdk17

USER root

RUN apt-get update && apt-get install -y lsb-release python3 python3-pip

RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg

RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y docker-ce-cli zip \ 
  && curl -L "https://github.com/docker/compose/releases/download/v2.28.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \ 
  && chmod +x /usr/local/bin/docker-compose

RUN apt install -y ansible python3-winrm 

RUN curl -o packages-microsoft-prod.deb https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && rm packages-microsoft-prod.deb \
  && apt-get update -y \
  && apt-get install -y dotnet-sdk-8.0

RUN curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh \
  && bash nodesource_setup.sh \
  && apt-get install -y nodejs

USER jenkins

RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"