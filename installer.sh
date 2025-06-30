#!/bin/bash

BASE_DIR="/home/$(whoami)"
INSTALL_DIR="$BASE_DIR/WClean"
THIS_FOLDER="$(pwd)"

mkdir -p "$INSTALL_DIR"

# Taşınacak dosyalar listesi
FILES_TO_MOVE=("WesaClean.sh" ".bash_completion" "docs/usage.md")

for f in "${FILES_TO_MOVE[@]}"; do
  if [[ -e "$THIS_FOLDER/$f" ]]; then
    # Eğer dosya veya klasör varsa taşı
    cp -r "$THIS_FOLDER/$f" "$INSTALL_DIR/"
    echo "Taşındı: $f"
  else
    echo "Uyarı: $f bulunamadı."
  fi
done

# Alias ekleme fonksiyonu (aynı alias'ı tekrar eklememek için kontrol eder)
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

# .bash_completion source satırı ekle (varsa eklemeyi kontrol et)
if ! grep -q "source $INSTALL_DIR/.bash_completion" "$BASH_RC"; then
  echo "source $INSTALL_DIR/.bash_completion" >> "$BASH_RC"
  echo ".bash_completion için source satırı eklendi: $BASH_RC"
else
  echo ".bash_completion için source satırı zaten mevcut: $BASH_RC"
fi

# Alias ekle
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

echo -e "\nTerminalinizi kapatıp açın veya 'source ~/.bashrc' komutunu çalıştırın."
echo -e "Bundan sonra 'wclean' komutuyla WesaClean'i çalıştırabilirsiniz! 🚀"

# installer.sh dosyasını kendi kendini silmek için
rm -- "$0"
