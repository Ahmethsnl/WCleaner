#!/bin/bash

BASE_DIR="/home/$(whoami)"
INSTALL_DIR="$BASE_DIR/WClean"
THIS_FOLDER="$(pwd)"

mkdir -p "$INSTALL_DIR"

rsync -av --progress --exclude='.git' --exclude='.gitignore' "$THIS_FOLDER/" "$INSTALL_DIR/"

echo "Projeni '$INSTALL_DIR' dizinine taşıdım (.git hariç)."

add_alias() {
  local alias_name="$1"
  local file="$2"
  if ! grep -q "alias $alias_name=" "$file"; then
    echo "alias $alias_name='bash $INSTALL_DIR/WesaClean.sh'" >> "$file"
    echo "Alias '$alias_name' eklendi: $file"
  else
    echo "Alias '$alias_name' zaten $file içinde mevcut."
  fi
}

BASH_RC="$BASE_DIR/.bashrc"
ZSH_RC="$BASE_DIR/.zshrc"

SOURCE_LINE="source $INSTALL_DIR/.bash_completion"
if ! grep -Fxq "$SOURCE_LINE" "$BASH_RC"; then
  echo "$SOURCE_LINE" >> "$BASH_RC"
  echo ".bash_completion için source satırı eklendi: $BASH_RC"
else
  echo ".bash_completion için source satırı zaten mevcut: $BASH_RC"
fi

add_alias "wclean" "$BASH_RC"
add_alias "wclean" "$ZSH_RC"

CURRENT_DIR="$(pwd)"
echo -e "\nŞu an bu dizindesiniz: \033[1;33m$CURRENT_DIR\033[0m"

GIT_FOLDER="$(basename $(git rev-parse --show-toplevel 2>/dev/null))"

if [[ -n "$GIT_FOLDER" ]]; then
  read -rp "Şu an '$GIT_FOLDER' klasöründesiniz. Bu klasörü silmek istiyor musunuz? (y/n) " confirm
  if [[ "$confirm" == [yY] ]]; then
    cd ~
    rm -rf "$CURRENT_DIR"
    echo "'$GIT_FOLDER' klasörü silindi."
  else
    echo "Silme işlemi iptal edildi."
  fi
else
  echo "Bu bir Git deposu değil veya Git klasör adını belirleyemedim. Manuel kontrol etmeniz gerekebilir."
fi

# Home altındaki installer.sh sil (taşınan kopya)
if [[ -f "$INSTALL_DIR/installer.sh" ]]; then
  rm -f "$INSTALL_DIR/installer.sh"
  echo "Home altındaki installer.sh silindi."
fi

echo -e "\nTerminalinizi kapatıp açın veya 'source ~/.bashrc' komutunu çalıştırın."
echo -e "Bundan sonra 'wclean' komutuyla WesaClean'i çalıştırabilirsiniz! 🚀"

# Klonlanan dizindeki installer.sh kendi kendini siler
rm -- "$0"
