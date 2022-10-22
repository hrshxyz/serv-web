#!/bin/bash

#!/bin/bash

# Verifica se o script está sendo executando com o usuário root.
if [[ $(id -u) -ne 0 ]] ; then
	echo -e "\n -- Por favor, rode o script como root. -- "
	echo -e " ==> Exemplo: sudo ./$(basename $0)\n"
	exit 1
fi


# Realiza update dos repositorios.
echo " -- Atualizando Respositótios -- "
apt update

# Realiza upgrade do S.O
echo -e "\n -- Atualizando Sistema -- "
apt upgrade -y

# Nome dos pacotes que serão baixados.
PACOTES="apache2 unzip"

# Instala os pacotes.
echo -e "\n -- Instalando pacotes ${PACOTES} -- "
apt install ${PACOTES} -y

# Faz o download da aplicação que será exposta pelo apache.
echo -e "\n -- Baixando aplicação -- "
wget -n -q --show-progress https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip -O /tmp/main.zip

# Remove index.html
echo -e "\n -- Remove index.html padrão -- "
rm -rf /var/www/html/index.html

# Extrai o pacote da aplicação.
echo -e "\n -- Extrai pacote -- "
unzip -o /tmp/main.zip "linux-site-dio-main/*" -d /tmp

# Move arquivos da aplicação para /var/www/html
echo -e "\n -- Move arquivos da aplicação para /var/www/html -- "
mv -fv /tmp/linux-site-dio-main/* /var/www/html

# Inicia e habilita o apache na inicialização do S.O
echo -e "\n -- Inicia e habilita o apache na inicialização do S.O -- "
systemctl enable --now apache2

# Verifica o status do apache
echo -e "\n -- Verifica o status do apache -- "
systemctl is-active apache2

