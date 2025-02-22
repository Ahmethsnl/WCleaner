
# Kullanım Talimatları

1. **Terminali Açın:**
   - Bilgisayarınızda bir terminal penceresi açın.

2. **Shell Script Dosyasını Oluşturun:**
   - Aşağıdaki komutları kullanarak bir `cleaner.sh` dosyası oluşturun:
     ```bash
     nano cleaner.sh
     ```

3. **Kodları Yapıştırın:**
   - Terminalde açtığınız dosyaya aşağıdaki kodları yapıştırın:

     ```bash
     #!/bin/bash
     echo -e "\n\033[1;33m[!] Need help? You can reach us here:\033[0m\n"
     echo -e "   \033[1;34mGitHub  ➜\033[0m  \033[1;32mahmethsnl\033[0m"
     echo -e "   \033[1;34m42 Slack ➜\033[0m  \033[1;32mahmsanli\033[0m\n"
     ```

4. **Dosyayı Kaydedin:**
   - `CTRL + O` tuşlarına basarak dosyayı kaydedin ve `CTRL + X` ile çıkın.

5. **Çalıştırılabilir Hale Getirin:**
   - Terminalde dosyanızı çalıştırılabilir yapmak için aşağıdaki komutu girin:
     ```bash
     chmod +x cleaner.sh
     ```

6. **Script'i Çalıştırın:**
   - Aşağıdaki komutu kullanarak script'i çalıştırın:
     ```bash
     ./cleaner.sh
     ```

7. **Sonuçları Görüntüleyin:**
   - Terminalde, kullanıcı adları yeşil renkte ve diğer bilgilerin yanında görüntülenecektir. Sorun ya da yardım ihtiyacınız olursa belirtilen iletişim bilgilerini kullanabilirsiniz.

### Sonuç
Yukarıdaki adımları izleyerek terminaldeki script'inizi çalıştırabilir ve istediğiniz renkli mesajları görebilirsiniz. Eğer başka bir konuda yardıma ihtiyacınız varsa, sormaktan çekinmeyin! 😊
