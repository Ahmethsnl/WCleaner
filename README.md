# 🧹 WCLEAN - WesaClean

[![Last Commit](https://img.shields.io/github/last-commit/ahmethsnl/WCleaner?style=flat)](https://github.com/ahmethsnl/WCleaner/commits)

WCleaner (WesaClean), Linux sistemlerde kullanılmayan önbellekleri, çöp kutularını ve geçici dosyaları temizlemek için geliştirilmiş basit bir komut satırı aracıdır.

---

# WesaClean Script Açıklaması

**WesaClean** script’i, sisteminizdeki gereksiz dosyaları ve önbellekleri temizlemeye yarayan bir araçtır. Bu script, kullanıcıların belirli dizinlerdeki gereksiz dosyaları silmesine ve böylece sistemlerinde daha fazla alan açmalarına yardımcı olur. Aşağıda script'in nasıl çalıştığını ve kullanıcının yapması gereken adımları bulabilirsiniz.

## Script'in Temel Bileşenleri

1. **Kullanıcı Dizinini ve Dosya Yollarını Tanımlama:**
    
    * Script, kullanıcı dizinini otomatik olarak belirler ve çalıştırılabilir dosya yollarını ayarlar. `BASE_DIR` değişkeni, kullanıcı ana dizinini belirtirken, `WCLEAN_DIR` temizleme işleminin yapılacağı dizini tanımlar.
    
2. **Gerekli Dizinin Oluşturulması:**
    
    * Script, `WClean` adında bir dizin oluşturur ve içerisinde `WesaClean.sh` adlı script dosyasını kopyalar. Bu sayede script her zaman erişilebilir bir konumda olur.
    
3. **Alias Ekleme:**
    
    * Kullanıcı, `wclean` komutunu terminalde kullanabilmesi için `~/.bashrc` ve `~/.zshrc` dosyalarına bir alias eklenir. Böylece kullanıcı, script’i çağırmak için her seferinde tam yol yazmak zorunda kalmaz.
    
4. **Disk Alanı Kontrolü:**
    
    * Script, temizleme işlemi öncesinde ve sonrasında kullanıcıya mevcut disk alanını gösterir. Bu, kullanıcıların temizleme işleminin ne kadar etkili olduğunu görmelerine yardımcı olur.
    
5. **Temizleme İşlemi:**
    
    * Kullanıcıdan onay aldıktan sonra, script belirli dizinlerdeki önbellek ve çöp kutusu dosyalarını siler. Belirli dosya türleri (örn. `.log`, `.tmp`, `.cache`) için de temizlik yapılır. Kullanıcı, silme işlemi sırasında ilerlemeyi görebilir.

## Kullanım Adımları

1. **Script’i Çalıştırın:**
    
    * Terminalde `./WesaClean.sh` komutunu çalıştırarak script’i başlatın.
    
2. **Onay Verin:**
    
    * Script çalışmaya başladığında, önbellek ve çöp kutusunu temizlemek istediğinizi onaylamanız istenecektir. Onay vermek için 'y' tuşuna basın.
    
3. **Temizleme İşlemini Takip Edin:**
    
    * Temizleme işlemi sırasında terminalde ilerleme göstergesi göreceksiniz. İşlem tamamlandığında, temizleme öncesi ve sonrası disk alanı bilgileri görüntülenecektir.
4. **Wclean**
   * installer.sh komutunu bir kere çalıştırdıktan sonra *wclean* olarak bir alias tanımlanır. Daha açıklayıcı olmak gerekirse terminale yalnızca "*wclean*" yazarak scripti çalıştırabilirsiniz.
  
 ## Özellikler
Çöp kutusu, tarayıcı cache’leri ve tmp klasörlerini temizler

Silinen dosyaları gösterme seçeneği

Temizleme öncesi/sonrası disk alanı ölçümü

Tek komutla çalıştırmak için alias desteği (örn: wclean)

--help ve --version gibi argümanlar

Bash otomatik tamamlama (bash-completion)

## Kurulum
1. **Depoyu klonla**
* git clone https://github.com/ahmethsnl/WCleaner.git
* cd WCleaner
* chmod +x WesaClean.sh installer.sh

2. **Kurulumu çalıştır**
./installer.sh
Bu işlem:
WCleaner dizinini $HOME/WClean altına kopyalar
.bashrc veya .zshrc dosyana şu alias'ı ekler:
alias wclean="$HOME/WClean/WesaClean.sh"
Terminalini yeniden başlatmayı unutma. Artık sadece wclean yazarak aracı çalıştırabilirsin.

3. **🖥️ Kullanım**
wclean               # Temizleme işlemini başlatır
wclean --help        # Yardım mesajı
wclean --version     # Sürüm bilgisi
  

```bash
WCleaner/
├── README.md           
├── LICENSE             
├── WesaClean.sh        
├── installer.sh        
├── docs/
│   └── usage.md        
├── assets/
│   └── demo.gif        
├── .bash_completion    
