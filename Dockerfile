FROM debian:bullseye-slim

RUN sed -i -e's/ main/ main contrib non-free/g' /etc/apt/sources.list

COPY packages.txt .
COPY install_packages.sh .
RUN ./install_packages.sh

COPY users.csv .
COPY install_users.sh .
RUN ./install_users.sh

COPY install_net-snmp.sh .
RUN ./install_net-snmp.sh

EXPOSE 22/tcp
EXPOSE 80/tcp

ENTRYPOINT service ssh restart && bash
