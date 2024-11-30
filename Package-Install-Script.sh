#!/bin/bash

# یک تابع برای نمایش بنر زیبا
show_banner() {
  clear
  echo -e "\033[1;34m==============================================="
  echo -e "      \033[1;32m  Welcome to Ubuntu Software Installer      "
  echo -e "\033[1;34m===============================================\033[0m"
  echo ""
}

# لیست نرم‌افزارها همراه با توضیحات
SOFTWARES=(
  "vim|Powerful text editor"
  "nano|Simple text editor"
  "git|Version control system"
  "htop|Interactive process viewer"
  "curl|Command-line web client"
  "wget|Download files from the web"
  "build-essential|Tools for compiling software"
  "cmake|Build system generator"
  "python3|Python programming language"
  "pip|Package manager for Python"
  "nodejs|JavaScript runtime"
  "npm|Package manager for JavaScript"
  "yarn|Alternative to npm"
  "docker.io|Containerization platform"
  "kubectl|Kubernetes CLI"
  "terraform|Infrastructure as code tool"
  "ansible|IT automation tool"
  "mysql-client|MySQL database client"
  "postgresql|PostgreSQL database server"
  "sqlite3|Lightweight database engine"
  "php|Server-side scripting language"
  "openjdk-17-jdk|Java development kit"
  "nginx|High-performance web server"
  "apache2|Classic web server"
  "vlc|Multimedia player"
  "ffmpeg|Video/audio processing tool"
  "gimp|Image editing software"
  "inkscape|Vector graphics editor"
  "audacity|Audio editing tool"
  "obs-studio|Screen recording and streaming"
  "imagemagick|Image manipulation software"
  "clamav|Antivirus software"
  "lynis|System security auditor"
  "openvpn|VPN client and server"
  "hashcat|Password recovery tool"
  "john|Password cracking tool"
  "wireshark|Network analysis tool"
  "tcpdump|Packet capture tool"
  "nmap|Network scanner"
  "fail2ban|Brute-force protection tool"
  "ufw|Uncomplicated firewall"
  "iptables|Advanced firewall"
  "net-tools|Classic networking tools"
  "iftop|Bandwidth monitoring tool"
  "snapd|Snap package manager"
  "flatpak|Flatpak package manager"
  "tmux|Terminal multiplexer"
  "zsh|Alternative to bash shell"
  "build-essential|Essential compilation tools"
)

# تابع نصب نرم‌افزار
install_software() {
  local software="$1"
  echo -e "\033[1;33mInstalling $software...\033[0m"
  sudo apt update -qq && sudo apt install -y "$software" >/dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    echo -e "\033[1;32m$software installed successfully!\033[0m"
    return 0
  else
    echo -e "\033[1;31mFailed to install $software.\033[0m"
    return 1
  fi
}

# تابع اصلی اسکریپت
main() {
  show_banner
  echo -e "Please select the software(s) you want to install:"
  echo ""
  
  # نمایش نرم‌افزارها به ترتیب صحیح
  index=1
  for software in "${SOFTWARES[@]}"; do
    software_name="${software%%|*}"
    software_desc="${software#*|}"
    echo -e "\033[1;34m$index) $software_name - $software_desc\033[0m"
    ((index++))
  done
  echo -e "\033[1;34m0) Exit\033[0m"
  echo ""

  # گرفتن ورودی کاربر
  echo -n "Enter your choices (e.g., 1 3 5): "
  read -r choices

  # بررسی انتخاب‌ها
  report=""
  for choice in $choices; do
    if [[ $choice -eq 0 ]]; then
      echo -e "\033[1;33mExiting...\033[0m"
      exit 0
    elif [[ $choice -gt 0 && $choice -le ${#SOFTWARES[@]} ]]; then
      software="${SOFTWARES[$((choice-1))]}"
      software_name="${software%%|*}"
      install_software "$software_name"
      if [[ $? -eq 0 ]]; then
        report+="\033[1;32m✔ $software_name installed successfully.\n\033[0m"
      else
        report+="\033[1;31m✖ Failed to install $software_name.\n\033[0m"
      fi
    else
      echo -e "\033[1;31mInvalid choice: $choice\033[0m"
    fi
  done

  # نمایش گزارش نهایی
  echo ""
  echo -e "\033[1;34mInstallation Report:\033[0m"
  echo -e "$report"
}

# اجرای تابع اصلی
main
