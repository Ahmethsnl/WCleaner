#!/bin/bash

# WClean - WesaClean Cache & Trash Cleaner

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
      return
      ;;
    *)
      echo "Geçersiz giriş! Temizleme iptal edildi."
      return
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
      echo -e "\n🧹 Silinen Dosyalar:"
      for dir in "${CACHE_DIRS[@]}"; do
        if [[ -d "$dir" ]]; then
          find "$dir" -mindepth 1 -print -delete 2>/dev/null
        fi
      done
      ;;
    n|no)
      for dir in "${CACHE_DIRS[@]}"; do
        [[ -d "$dir" ]] && find "$dir" -mindepth 1 -delete 2>/dev/null
      done
      ;;
    *)
      echo "Geçersiz giriş! Varsayılan olarak dosyalar gösterilmeyecek."
      for dir in "${CACHE_DIRS[@]}"; do
        [[ -d "$dir" ]] && find "$dir" -mindepth 1 -delete 2>/dev/null
      done
      ;;
  esac

  echo -e "\n⚠️ Geçici dosyaları silmek istiyor musunuz?"
  read -rp "Boş dosyaları silmek istiyor musunuz? (y/n) " confirm_tmp
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
clean
print_disk_space "Temizleme sonrası kullanılabilir disk alanı"

echo -e "\n🎉 WClean - WesaClean başarıyla tamamlandı! 🚀"

echo -e "\033[1;32m GitHub   ➜\033[0m  \033[4;36mahmethsnl\033[0m"
echo -e "\033[1;32m 42 Slack ➜\033[0m  \033[4;36mahmsanli\033[0m"

echo -e "\033[1;32m Örnek aldığım repo ➜\033[0m \033[4;36mhttps://github.com/34-ata/AFCleaner-42.git\033[0m"
echo "\033[1;32mGüncellemeleri kontrol edin\033[0m"
echo "\033[1;32mversion 1.0\033[0m"
