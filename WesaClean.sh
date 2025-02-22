#!/bin/bash

# WClean - WesaClean Cache & Trash Cleaner

echo -e "\n"
echo -e "\033[1;32m"

echo -e "{__        {__    {__   {__      {________      {_       {___     {__
{__        {__ {__   {__{__      {__           {_ __     {_ {__   {__
{__   {_   {__{__       {__      {__          {_  {__    {__ {__  {__
{__  {__   {__{__       {__      {______     {__   {__   {__  {__ {__
{__ {_ {__ {__{__       {__      {__        {______ {__  {__   {_ {__
{_ {_    {____ {__   {__{__      {__       {__       {__ {__    {_ __
{__        {__   {____  {________{________{__         {__{__      {__
                                                                     "
echo -e "\033[1;32m"
echo -en "\n                       By: "
echo -e "\033[33mWesaClean - WClean\033[0m\n"

BASE_DIR="$HOME"

function print_disk_space {
  local message=$1
  local free_space
  free_space=$(df -h "$BASE_DIR" | awk 'NR==2 {print $4}')
  echo "$message: $free_space"
}

function clean_glob {
  [ -n "$1" ] && /bin/rm -rf "$@" &>/dev/null
}

function clean {
  read -p "Önbellek ve çöp kutusunu temizlemek istediğinize emin misiniz? (y/n) " confirm
  [[ "$confirm" != [yY] ]] && { echo "Temizleme iptal edildi."; return; }

  sleep 2
  
  CACHE_DIRS=(
    "$BASE_DIR/.var/app/com.visualstudio.code/cache/vscode-cpptools/*"
    "$BASE_DIR/.var/app/com.visualstudio.code/cache/tmp"
    "$BASE_DIR/.var/app/com.visualstudio.code/data/recently-used.xbel"
    "$BASE_DIR/.var/app/com.google.Chrome/cache"
    "$BASE_DIR/.var/app/com.brave.Browser/cache/*"
    "$BASE_DIR/.var/app/org.mozilla.firefox/cache/*"
    "$BASE_DIR/.var/app/com.opera.Opera/cache/*"
    "$HOME/.local/share/Trash/*"
  )

  for dir in "${CACHE_DIRS[@]}"; do
    for file in $dir; do
      clean_glob "$file"
      echo -n "Temizleniyor..."
      sleep 0.6
      echo -ne "\r               \r"
    done
  done

  find "$HOME/.cache/" -type f \( -name "*.log" -o -name "*.tmp" -o -name "*.cache" \) -exec bash -c 'clean_glob "$0"; echo -n "Temizleniyor..."; sleep 0.6; echo -ne "\r               \r"' {} \;
}

print_disk_space "Temizleme öncesi kullanılabilir disk alanı"
clean
print_disk_space "Temizleme sonrası kullanılabilir disk alanı"

echo -e "\n          WClean - WesaClean başarıyla tamamlandı! 🚀"
echo -e "   \033[1;32mGitHub   ➜\033[0m  \033[4;36mahmethsnl\033[0m"
echo -e "   \033[1;32m42 Slack ➜\033[0m  \033[4;36mahmsanli\033[0m\n"
