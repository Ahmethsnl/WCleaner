#!/bin/bash
BASE_DIR="/home/$(whoami)"
THIS_FOLDER="$(pwd)"

mkdir -p "$BASE_DIR/WClean"

TARGET_DIR="$BASE_DIR/WClean/WesaClean.sh"
cp "$THIS_FOLDER/WesaClean.sh" "$TARGET_DIR"

BASH_RC="$BASE_DIR/.bashrc"
ZSH_RC="$BASE_DIR/.zshrc"

touch "$BASH_RC"
touch "$ZSH_RC"

add_alias() {
  local alias_name="$1"
  local file="$2"
  if ! grep -q "alias $alias_name=" "$file"; then
    echo "alias $alias_name='bash $TARGET_DIR'" >> "$file"
  else
    echo "Alias $alias_name zaten $file içinde mevcut."
  fi
}

add_alias "wclean" "$BASH_RC"
add_alias "wclean" "$ZSH_RC"

CURRENT_DIR="$(pwd)"
echo -e "\nŞu an bu dizindesiniz: \033[1;33m$CURRENT_DIR\033[0m"
GIT_FOLDER="$(basename $(git rev-parse --show-toplevel 2>/dev/null))"

if [[ -n "$GIT_FOLDER" ]]; then
  read -p "Şu an '$GIT_FOLDER' klasöründesiniz. Bu klasörü silmek istiyor musunuz? (y/n) " confirm
  if [[ "$confirm" == [yY] ]]; then
    cd ~ 
    rm -rf "$CURRENT_DIR"
    echo "'$GIT_FOLDER' klasörü silindi."
  else
    echo "Silme işlemi iptal edildi."
  fi
else
  echo "Bu bir Git deposu değil veya Git klasör adını belirleyemedim. Manuel kontrol etmen gerekebilir."
fi


echo -e "\nTerminalinizi kapatıp açın veya '\033[1;34msource ~/.bashrc\033[0m' komutunu çalıştırın."
echo -e "Bundan sonra '\033[1;34mwclean\033[0m' komutuyla WesaClean'i çalıştırabilirsiniz! 🚀"
