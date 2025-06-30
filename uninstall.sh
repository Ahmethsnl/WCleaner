#!/bin/bash
# uninstall_wclean.sh

INSTALL_DIR="$HOME/WClean"
BASHRC="$HOME/.bashrc"
ZSHRC="$HOME/.zshrc"
ALIAS_NAME="wclean"

# Alias satırlarını temizle
sed -i "/alias $ALIAS_NAME=/d" "$BASHRC"
sed -i "/alias $ALIAS_NAME=/d" "$ZSHRC"

# .bash_completion source satırını temizle
sed -i "/source $INSTALL_DIR\/\.bash_completion/d" "$BASHRC"

# Dizini sil
if [ -d "$INSTALL_DIR" ]; then
  rm -rf "$INSTALL_DIR"
  echo "✅ $ALIAS_NAME kaldırıldı ve $INSTALL_DIR silindi."
else
  echo "ℹ️  $INSTALL_DIR zaten yoktu."
fi

echo "🔁 Terminali yeniden başlat veya 'source ~/.bashrc' çalıştır."

