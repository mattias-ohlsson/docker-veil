# Dockerfile for Veil–Framework (https://www.veil-framework.com)
FROM fedora

LABEL maintainer="mattias.ohlsson@inprose.com"

RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > /usr/local/bin/msfinstall
RUN chmod +x /usr/local/bin/msfinstall
RUN msfinstall
RUN dnf -y update && dnf -y install git which sudo python3-crypto unzip && dnf clean all
RUN git clone https://github.com/Veil-Framework/Veil.git
RUN sed -i 's|raw_input(" \[>\] Please enter the path of your metasploit installation: ")|"/opt/metasploit-framework/"|' /Veil/config/update.py
RUN cd /Veil/setup; ./setup.sh --silent

COPY veil /usr/local/bin/

CMD ["veil"]
