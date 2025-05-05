#!/bin/bash

echo "🚧 Parando e desabilitando o serviço MySQL..."
sudo systemctl stop mysql
sudo systemctl disable mysql

echo "🧹 Removendo pacotes MySQL principais..."
sudo apt-get remove --purge -y mysql-server mysql-client mysql-common

echo "🧼 Removendo o configurador de repositório MySQL (mysql-apt-config)..."
sudo apt-get remove --purge -y mysql-apt-config

echo "🧽 Limpando pacotes residuais e dependências não utilizadas..."
sudo apt-get autoremove -y
sudo apt-get autoclean

echo "📁 Removendo diretórios e arquivos de configuração restantes..."
sudo rm -rf /etc/mysql /var/lib/mysql /var/log/mysql* /etc/apparmor.d/disable/usr.sbin.mysqld

echo "👥 Removendo usuário e grupo MySQL (se existirem)..."
sudo deluser --remove-home mysql 2>/dev/null
sudo delgroup mysql 2>/dev/null

echo "🔍 Verificação final (dpkg)..."
dpkg -l | grep mysql || echo "✅ Todos os pacotes MySQL foram removidos."

echo "✅ Processo concluído. O MySQL foi removido com segurança."
