#!/bin/bash

# WClean - WesaClean Cache & Trash Cleaner

clear
echo -e "\n\033[1;32m"
cat << "EOF"
{__        {__    {__   {__      {________      {_       {___     {__
{__        {__ {__   {__{__      {__           {_ __     {_ {__   {__
{__   {_   {__{__       {__      {__          {_  {__    {__ {__  {__
{__  {__   {__{__       {__      {______     {__   {__   {__  {__ {__
{__ {_ {__ {__{__       {__      {__        {______ {__  {__   {_ {__
{_ {_    {____ {__   {__{__      {__       {__       {__ {__    {_ __
{__        {__   {____  {________{________{__         {__{__      {__
EOF
echo -e "\033[1;32m\n"
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
    *)
      echo "Temizleme iptal edildi."
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

  echo -e "\n🧹 Silinen Dosyalar:"
  
  for dir in "${CACHE_DIRS[@]}"; do
    if [[ -d "$dir" ]]; then
      find "$dir" -mindepth 1 -print -delete 2>/dev/null
    fi
  done

  # Geçici dosyaları silerken dikkat edin
  echo -e "\n⚠️ Geçici dosyaları silmek istiyor musunuz?"
  read -rp "Boş dosyaları silmek istiyor musunuz? (y/n) " confirm_tmp
  case "${confirm_tmp,,}" in
    y|yes)
      echo "Geçici dosyalar siliniyor..."
      find /tmp -mindepth 1 -type f -print -delete 2>/dev/null
      ;;
    *)
      echo "Geçici dosyalar silinmedi."
      ;;
  esac

  find "$HOME/.cache/" -type f \( -name "*.log" -o -name "*.tmp" -o -name "*.cache" \) ! -name "important.log" -print -delete
  echo -e "\n✅ Temizlik tamamlandı!"
}

print_disk_space "Temizleme öncesi kullanılabilir disk alanı"
clean
print_disk_space "Temizleme sonrası kullanılabilir disk alanı"

echo -e "\n🎉 WClean - WesaClean başarıyla tamamlandı! 🚀"

echo -e "\033[1;32mGitHub   ➜\033[0m  \033[4;36mahmethsnl\033[0m"
echo -e "\033[1;32m42 Slack ➜\033[0m  \033[4;36mahmsanli\033[0m"
echo -e "             GitHub   ~> \033[4;1;34m34-ata\033[0m"
echo -e "             GitHub   ~> \033[4;1;34macbst0\033[0m"
