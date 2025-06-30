#!/bin/bash

clear
echo -e "\n\033[1;32m"
echo -e "                 By: \033[33mWesaClean - WClean\033[0m\n"

BASE_DIR="$HOME"

function print_disk_space {
  local message=$1
  local free_space=$(df -h --output=avail "$BASE_DIR" | tail -1)
  echo "$message: $free_space"
}

function clean {
  read -rp "Önbellek ve çöp kutusunu temizlemek istediğinize emin misiniz? (y/n) " confirm
  case "${confirm,,}" in
    y|yes)
      echo "Temizlik başlatılıyor..."
      ;;
    n|no)
      echo "Temizleme iptal edildi."
      return 1
      ;;
    *)
      echo "Geçersiz giriş! Temizleme iptal edildi."
      return 1
      ;;
  esac

  CACHE_DIRS=(
    "$BASE_DIR/.var/app/com.visualstudio.code/cache/vscode-cpptools"
    "$BASE_DIR/.var/app/com.visualstudio.code/cache/tmp"
    "$BASE_DIR/.var/app/com.google.Chrome/cache"
    "$BASE_DIR/.var/app/com.brave.Browser/cache"
    "$BASE_DIR/.var/app/org.mozilla.firefox/cache"
    "$BASE_DIR/.var/app/com.opera.Opera/cache"
    "$HOME/.local/share/Trash"
  )

  read -rp "Silinen dosyaları görmek ister misiniz? (y/n) " show_files
  case "${show_files,,}" in
    y|yes)
      echo -e "\n🧹 Silinecek Dosyalar:"
      for dir in "${CACHE_DIRS[@]}"; do
        if [[ -d "$dir" ]]; then
          find "$dir" -mindepth 1 -print
        fi
      done
      ;;
    n|no)
      echo "Dosyalar listelenmeyecek."
      ;;
    *)
      echo "Geçersiz giriş! Dosyalar listelenmeyecek."
      ;;
  esac

  read -rp "Temizlemeyi onaylıyor musunuz? (y/n) " final_confirm
  case "${final_confirm,,}" in
    y|yes)
      echo -e "\nTemizlik yapılıyor..."
      for dir in "${CACHE_DIRS[@]}"; do
        [[ -d "$dir" ]] && find "$dir" -mindepth 1 -delete 2>/dev/null
      done
      ;;
    n|no)
      echo "Temizleme iptal edildi."
      return 1
      ;;
    *)
      echo "Geçersiz giriş! Temizleme iptal edildi."
      return 1
      ;;
  esac

  read -rp "Geçici dosyaları silmek istiyor musunuz? (y/n) " confirm_tmp
  case "${confirm_tmp,,}" in
    y|yes)
      echo "Geçici dosyalar siliniyor..."
      find /tmp -mindepth 1 -type f -delete 2>/dev/null
      ;;
    n|no)
      echo "Geçici dosyalar silinmedi."
      ;;
    *)
      echo "Geçersiz giriş! Geçici dosyalar silinmedi."
      ;;
  esac

  find "$HOME/.cache/" -type f \( -name "*.log" -o -name "*.tmp" -o -name "*.cache" \) ! -name "important.log" -print -delete
  echo -e "\n✅ Temizlik tamamlandı!"
}

print_disk_space "Temizleme öncesi kullanılabilir disk alanı"
if clean; then
  print_disk_space "Temizleme sonrası kullanılabilir disk alanı"
else
  echo "Temizlik işlemi gerçekleştirilmedi."
fi

echo -e "\n🎉 WClean - WesaClean başarıyla tamamlandı! 🚀"

echo -e "\033[1;32m GitHub   ➜\033[0m  \033[4;36m ahmethsnl \033[0m"
echo -e "\033[1;32m 42 Slack ➜\033[0m  \033[4;36m ahmsanli \033[0m"

echo -e "\033[1;32m Örnek aldığım repo ➜\033[0m \033[4;36m https://github.com/34-ata/AFCleaner-42.git \033[0m"
echo -e "\033[1;32m Güncellemeleri kontrol edin \033[0m"
echo -e "\033[1;32m Version 1.1 \033[0m"
