#!/bin/bash

BLUE='\033[0;34m'       
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

display_welcome() {
  echo -e ""
  echo -e "${RED}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                                                 [+]${NC}"
  echo -e "${YELLOW}[+]                AUTO INSTALLER THEMA             [+]${NC}"
  echo -e "${BLUE}[+]                  ©  INSTALLER                [+]${NC}"
  echo -e "${GREEN}[+]                                                 [+]${NC}"
  echo -e "${RED}[+] =============================================== [+]${NC}"
  echo -e ""
  echo -e "ZEEDUN STORE INDONESIA"
  echo -e ""
  sleep 2
  clear
}
 
install_jq() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]             UPDATE & INSTALL SERVER             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sudo apt update -y && sudo apt install -y jq unzip curl wget
  if [ $? -eq 0 ]; then
    echo -e "                                                       "
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "${GREEN}[+]              INSTALL UPDATE BERHASIL            [+]${NC}"
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
  else
    echo -e "                                                       "
    echo -e "${RED}[+] =============================================== [+]${NC}"
    echo -e "${RED}[+]              INSTALL UPDATE GAGAL               [+]${NC}"
    echo -e "${RED}[+] =============================================== [+]${NC}"
    exit 1
  fi
  echo -e "                                                       "
  sleep 1
  clear
}

clean_previous_theme() {
  echo -e "${YELLOW}[+] Membersihkan theme sebelumnya...${NC}"
  
  if [ -d /root/pterodactyl ]; then
    sudo rm -rf /root/pterodactyl
  fi
  
  if [ -d /root/pterodactyl_temp ]; then
    sudo rm -rf /root/pterodactyl_temp
  fi
  
  if [ -f /root/theme.zip ]; then
    sudo rm -f /root/theme.zip
  fi
  
  if [ -f /root/nebula.sh ]; then
    sudo rm -f /root/nebula.sh
  fi
  
  cd /var/www/pterodactyl
  php artisan down
  
  sudo rm -rf /var/www/pterodactyl/resources/scripts/components/*
  sudo rm -rf /var/www/pterodactyl/resources/scripts/api/*
  sudo rm -rf /var/www/pterodactyl/resources/views/*
  sudo rm -rf /var/www/pterodactyl/public/assets/*
  
  echo -e "${GREEN}[+] Pembersihan selesai${NC}"
  sleep 1
}

detect_theme_structure() {
  local extract_dir="$1"
  
  if [ -d "$extract_dir/pterodactyl" ]; then
    echo "$extract_dir/pterodactyl"
    return
  fi
  
  if [ -d "$extract_dir/resources" ] && [ -d "$extract_dir/public" ]; then
    echo "$extract_dir"
    return
  fi
  
  local found_resources=$(find "$extract_dir" -type d -name "resources" -path "*/resources" | head -n 1)
  if [ -n "$found_resources" ]; then
    local parent_dir=$(dirname "$found_resources")
    if [ -d "$parent_dir/public" ]; then
      echo "$parent_dir"
      return
    fi
  fi
  
  local first_subdir=$(find "$extract_dir" -mindepth 1 -maxdepth 1 -type d | head -n 1)
  if [ -n "$first_subdir" ]; then
    if [ -d "$first_subdir/resources" ] && [ -d "$first_subdir/public" ]; then
      echo "$first_subdir"
      return
    fi
    
    if [ -d "$first_subdir/pterodactyl" ]; then
      echo "$first_subdir/pterodactyl"
      return
    fi
  fi
  
  echo "$extract_dir"
}

install_theme() {
  while true; do
    echo -e "                                                       "
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "${GREEN}[+]                   SELECT THEME                  [+]${NC}"
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "                                                       "
    echo -e "PILIH THEME YANG INGIN DI INSTALL"
    echo "1. Ultra Theme"
    echo "2. Cheese Theme"
    echo "3. Glasmorphism Theme"
    echo "4. Eleganty Theme"
    echo "5. HI Theme"
    echo "6. Billing"
    echo "7. Enigma"
    echo "8. Futuristic Theme"
    echo "9. Kunefe Theme"
    echo "10. Nebula"
    echo "11. Pterodactyl Theme - Pure UI Light + Dark"
    echo "12. Stellar"
    echo "13. Theme Midnight v1.4.3"
    echo "14. Unix Theme v2.71"
    echo "15. Custom Theme"
    echo "x. Kembali"
    echo -e "Masukan pilihan (1-15/x) :"
    read -r SELECT_THEME
    
    case "$SELECT_THEME" in
      1)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/1.%20Ultra%20Theme.zip"
        THEME_NAME="Ultra Theme"
        THEME_TYPE="standard"
        break
        ;;
      2)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/2.%20Cheese%20Theme.zip"
        THEME_NAME="Cheese Theme"
        THEME_TYPE="standard"
        break
        ;;
      3)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/3.%20Glasmorphism%20Theme.zip"
        THEME_NAME="Glasmorphism Theme"
        THEME_TYPE="standard"
        break
        ;;
      4)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/4.%20Eleganty%20Theme.zip"
        THEME_NAME="Eleganty Theme"
        THEME_TYPE="standard"
        break
        ;;
      5)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/5.%20HI%20Theme.zip"
        THEME_NAME="HI Theme"
        THEME_TYPE="standard"
        break
        ;;
      6)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/billing.zip"
        THEME_NAME="Billing"
        THEME_TYPE="billing"
        break
        ;;
      7)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/enigma.zip"
        THEME_NAME="Enigma"
        THEME_TYPE="standard"
        break
        ;;
      8)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/Futuristic%20Theme.zip"
        THEME_NAME="Futuristic Theme"
        THEME_TYPE="standard"
        break
        ;;
      9)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/kunefe-theme.zip"
        THEME_NAME="Kunefe Theme"
        THEME_TYPE="standard"
        break
        ;;
      10)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/nebula.zip"
        THEME_NAME="Nebula"
        THEME_TYPE="nebula"
        break
        ;;
      11)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/Pterodactyl%20Theme%20-%20Pure%20UI%20%20Light%20+%20Dark.zip"
        THEME_NAME="Pterodactyl Pure UI"
        THEME_TYPE="standard"
        break
        ;;
      12)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/stellar.zip"
        THEME_NAME="Stellar"
        THEME_TYPE="standard"
        break
        ;;
      13)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/theme_midnigh-_v1.4.3.zip"
        THEME_NAME="Theme Midnight v1.4.3"
        THEME_TYPE="standard"
        break
        ;;
      14)
        THEME_URL="https://github.com/Zeedun0432/theme/raw/refs/heads/main/Unix_Theme_v2.71.zip"
        THEME_NAME="Unix Theme v2.71"
        THEME_TYPE="standard"
        break
        ;;
      15)
        echo -e "${YELLOW}Masukkan link download theme custom (URL): ${NC}"
        read -r CUSTOM_THEME_URL
        THEME_URL="$CUSTOM_THEME_URL"
        THEME_NAME="Custom Theme"
        THEME_TYPE="standard"
        break
        ;;
      x)
        return
        ;;
      *)
        echo -e "${RED}Pilihan tidak valid, silahkan coba lagi.${NC}"
        sleep 2
        ;;
    esac
  done
  
  clean_previous_theme
  
  THEME_FILE="theme.zip"
  if [ "$THEME_TYPE" = "nebula" ]; then
    THEME_FILE="nebula.sh"
  fi
  
  echo -e "${YELLOW}[+] Downloading $THEME_NAME...${NC}"
  wget -q --show-progress "$THEME_URL" -O "/root/$THEME_FILE"
  
  if [ ! -f "/root/$THEME_FILE" ]; then
    echo -e "${RED}[+] Download gagal! File tidak ditemukan.${NC}"
    php artisan up
    sleep 3
    return
  fi
  
  if [ "$THEME_TYPE" = "nebula" ]; then
    echo -e "                                                       "
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "${GREEN}[+]                  INSTALLASI THEMA               [+]${NC}"
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "                                                       "
    chmod +x "/root/$THEME_FILE"
    bash "/root/$THEME_FILE"
    sudo rm -f "/root/$THEME_FILE"
  else
    mkdir -p /root/pterodactyl_temp
    echo -e "${YELLOW}[+] Extracting theme...${NC}"
    sudo unzip -q -o "/root/$THEME_FILE" -d /root/pterodactyl_temp
    
    if [ $? -ne 0 ]; then
      echo -e "${RED}[+] Extract gagal!${NC}"
      sudo rm -f "/root/$THEME_FILE"
      sudo rm -rf /root/pterodactyl_temp
      php artisan up
      sleep 3
      return
    fi
    
    THEME_SOURCE=$(detect_theme_structure "/root/pterodactyl_temp")
    
    echo -e "${YELLOW}[+] Theme source detected at: $THEME_SOURCE${NC}"
    
    if [ ! -d "$THEME_SOURCE" ]; then
      echo -e "${RED}[+] Struktur theme tidak valid!${NC}"
      sudo rm -f "/root/$THEME_FILE"
      sudo rm -rf /root/pterodactyl_temp
      php artisan up
      sleep 3
      return
    fi
    
    echo -e "                                                       "
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "${GREEN}[+]                  INSTALLASI THEMA               [+]${NC}"
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "                                                       "
    
    if [ "$THEME_TYPE" = "billing" ]; then
      sudo cp -rfT "$THEME_SOURCE" /var/www/pterodactyl
      
      if ! command -v node &> /dev/null; then
        echo -e "${YELLOW}[+] Installing Node.js...${NC}"
        curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        sudo apt install -y nodejs
      fi
      
      if ! command -v yarn &> /dev/null; then
        echo -e "${YELLOW}[+] Installing Yarn...${NC}"
        sudo npm i -g yarn
      fi
      
      cd /var/www/pterodactyl
      yarn add react-feather
      php artisan billing:install stable
      php artisan migrate --force
      yarn build:production
      php artisan view:clear
      php artisan config:clear
      php artisan route:clear
      
    else
      sudo cp -rfT "$THEME_SOURCE" /var/www/pterodactyl
      
      if ! command -v node &> /dev/null; then
        echo -e "${YELLOW}[+] Installing Node.js...${NC}"
        curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        sudo apt install -y nodejs
      fi
      
      if ! command -v yarn &> /dev/null; then
        echo -e "${YELLOW}[+] Installing Yarn...${NC}"
        sudo npm i -g yarn
      fi
      
      cd /var/www/pterodactyl
      yarn add react-feather
      php artisan migrate --force
      yarn build:production
      php artisan view:clear
      php artisan config:clear
      php artisan route:clear
    fi
    
    sudo chown -R www-data:www-data /var/www/pterodactyl/*
    
    sudo rm -f "/root/$THEME_FILE"
    sudo rm -rf /root/pterodactyl_temp
  fi

  php artisan up
  
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                   INSTALL SUCCESS               [+]${NC}"
  echo -e "${GREEN}[+]            $THEME_NAME BERHASIL DIINSTALL       [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e ""
  sleep 3
  clear
}

uninstall_theme() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                    DELETE THEME                 [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  bash <(curl -s https://raw.githubusercontent.com/VallzHost/installer-theme/main/repair.sh)
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 DELETE THEME SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
}

create_node() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                    CREATE NODE                  [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "

  read -p "Masukkan nama lokasi: " location_name
  read -p "Masukkan deskripsi lokasi: " location_description
  read -p "Masukkan domain: " domain
  read -p "Masukkan nama node: " node_name
  read -p "Masukkan RAM (dalam MB): " ram
  read -p "Masukkan jumlah maksimum disk space (dalam MB): " disk_space
  read -p "Masukkan Locid: " locid

  cd /var/www/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }

  php artisan p:location:make <<EOF
$location_name
$location_description
EOF

  php artisan p:node:make <<EOF
$node_name
$location_description
$locid
https
$domain
yes
no
no
$ram
$ram
$disk_space
$disk_space
100
8080
2022
/var/lib/pterodactyl/volumes
EOF

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]        CREATE NODE & LOCATION SUKSES            [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
}

uninstall_panel() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                    UNINSTALL PANEL              [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "

  bash <(curl -s https://pterodactyl-installer.se) <<EOF
y
y
y
y
EOF

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]              UNINSTALL PANEL SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
}

configure_wings() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 CONFIGURE WINGS                 [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "

  read -p "Masukkan token Configure menjalankan wings: " wings_token

  eval "$wings_token"
  
  sudo systemctl start wings

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]              CONFIGURE WINGS SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
}

hackback_panel() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 HACK BACK PANEL                 [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  
  read -p "Masukkan Username Panel: " user
  read -sp "Password login: " psswdhb
  echo ""
  
  cd /var/www/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }

  php artisan p:user:make <<EOF
yes
hackback@gmail.com
$user
$user
$user
$psswdhb
EOF

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 AKUN TELAH DI ADD              [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
}

display_welcome
install_jq

while true; do
  clear
  echo -e "                                                                     "
  echo -e "${RED}        _,gggggggggg.                                     ${NC}"
  echo -e "${RED}    ,ggggggggggggggggg.                                   ${NC}"
  echo -e "${RED}  ,ggggg        gggggggg.                                 ${NC}"
  echo -e "${RED} ,ggg'               'ggg.                                ${NC}"
  echo -e "${RED}',gg       ,ggg.      'ggg:                               ${NC}"
  echo -e "${RED}'ggg      ,gg'''  .    ggg       Auto Installer Zeedun Host  ${NC}"
  echo -e "${RED}gggg      gg     ,     ggg      ------------------------  ${NC}"
  echo -e "${RED}ggg:     gg.     -   ,ggg       • Telegram : ZeedunHost      ${NC}"
  echo -e "${RED} ggg:     ggg._    _,ggg        • Creadit  : ZeedunHost      ${NC}"
  echo -e "${RED} ggg.    '.'''ggggggp           • Support by ZeedunHost      ${NC}"
  echo -e "${RED}  'ggg    '-.__                                           ${NC}"
  echo -e "${RED}    ggg                                                   ${NC}"
  echo -e "${RED}      ggg                                                 ${NC}"
  echo -e "${RED}        ggg.                                              ${NC}"
  echo -e "${RED}          ggg.                                            ${NC}"
  echo -e "${RED}             b.                                           ${NC}"
  echo -e "                                                                     "
  echo -e "BERIKUT LIST INSTALL :"
  echo "1. Install theme"
  echo "2. Uninstall theme"
  echo "3. Configure Wings"
  echo "4. Create Node"
  echo "5. Uninstall Panel"
  echo "6. Hack Back Panel"
  echo "x. Exit"
  echo -e "Masukkan pilihan (1/2/3/4/5/6/x):"
  read -r MENU_CHOICE
  clear

  case "$MENU_CHOICE" in
    1)
      install_theme
      ;;
    2)
      uninstall_theme
      ;;
    3)
      configure_wings
      ;;
    4)
      create_node
      ;;
    5)
      uninstall_panel
      ;;
    6)
      hackback_panel
      ;;
    x)
      echo "Keluar dari skrip."
      exit 0
      ;;
    *)
      echo "Pilihan tidak valid, silahkan coba lagi."
      sleep 2
      ;;
  esac
done
