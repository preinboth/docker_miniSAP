FROM opensuse:latest
RUN zypper --non-interactive install --replacefiles uuidd hostname wget unrar tcsh tar which net-tools iproute2
RUN echo $'#!/bin/bash \n\
echo "Free space - initial:" \n\
df -h \n\
URL_LIST=$(cat <<-END\n\
  "https://tools.hana.ondemand.com/additional/sap_netweaver_as_abap_750_sp02_ase_dev_edition.part1.rar" \n\
  "https://tools.hana.ondemand.com/additional/sap_netweaver_as_abap_750_sp02_ase_dev_edition.part2.rar" \n\
  "https://tools.hana.ondemand.com/additional/sap_netweaver_as_abap_750_sp02_ase_dev_edition.part3.rar" \n\
  "https://tools.hana.ondemand.com/additional/sap_netweaver_as_abap_750_sp02_ase_dev_edition.part4.rar" \n\
  "https://tools.hana.ondemand.com/additional/sap_netweaver_as_abap_750_sp02_ase_dev_edition.part5.rar" \n\
  "https://tools.hana.ondemand.com/additional/sap_netweaver_as_abap_750_sp02_ase_dev_edition.part6.rar" \n\
  "https://tools.hana.ondemand.com/additional/sap_netweaver_as_abap_750_sp02_ase_dev_edition.part7.rar" \n\
  "https://tools.hana.ondemand.com/additional/sap_netweaver_as_abap_750_sp02_ase_dev_edition.part8.rar" \n\
END\n\
)\n\
echo $URL_LIST | xargs -n 1 wget -P /tmp -c --tries=0 --read-timeout=20 --no-cookies --header "Cookie: eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt" \n\
echo "Free space - after download" \n\
df -h \n\
mkdir /tmp/sap_netweaver_as_abap_750_sp02_ase_dev_edition \n\
unrar x /tmp/sap_netweaver_as_abap_750_sp02_ase_dev_edition.part1.rar /tmp/sap_netweaver_as_abap_750_sp02_ase_dev_edition \n\
echo "Free space - after extraction" \n\
df -h \n\
rm /tmp/*.rar \n\
echo "Free space - after download deletion" \n\
df -h \n\
chmod +x /tmp/sap_netweaver_as_abap_750_sp02_ase_dev_edition/install.sh \n\
/tmp/sap_netweaver_as_abap_750_sp02_ase_dev_edition/install.sh -s \n\
echo "Free space - after installation" \n\
df -h' >> /tmp/install.sh; chmod +x /tmp/install.sh
EXPOSE 8000
EXPOSE 44300
EXPOSE 3300
EXPOSE 3200

# docker build -t nwabap .
# docker run -P -h vhcalnplci --name nwabap750 -it nwabap /bin/bash
# /tmp/install.sh
