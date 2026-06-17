-- ============================================
-- NAKLİYAT / LOJİSTİK TEMASI — Kurulum SQL
-- Kurumsal/Hizmet arketipinden türetildi (tema-master).
-- Kullanım: phpMyAdmin > Import  (veya: mysql -u root < kurulum.sql)
-- ============================================
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS `nakliyat_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `nakliyat_db`;

-- ============ AYARLAR ============
DROP TABLE IF EXISTS `ayarlar`;
CREATE TABLE `ayarlar` (
  `anahtar` VARCHAR(80) NOT NULL PRIMARY KEY,
  `deger` TEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `ayarlar` (`anahtar`,`deger`) VALUES
('site_adi','Rota Nakliyat'),
('site_baslik','Rota Nakliyat — Evden Eve & Şehirler Arası Taşımacılık'),
('site_aciklama','Eşyalarınızı sigortalı, hasarsız ve zamanında taşıyoruz. Evden eve nakliyat, şehirler arası taşımacılık, ofis taşıma ve depolama hizmetlerinde uzman kadro.'),
('telefon','+90 444 0 000'),
('telefon2','+90 532 000 00 00'),
('mail','info@rotanakliyat.com'),
('adres','Sanayi Mah. Lojistik Cad. No:5, Esenyurt / İstanbul'),
('calisma_saati','7/24 Hizmet • Pzt - Cmt: 08:00 - 20:00'),
('hakkimizda_kisa','Rota Nakliyat olarak 15 yılı aşkın tecrübemizle evden eve ve şehirler arası taşımacılıkta güvenin adresiyiz. Profesyonel ekibimiz, asansörlü araçlarımız ve eşya sigortamızla taşınma sürecinizi sorunsuz hale getiriyoruz.'),
('hakkimizda_uzun','Rota Nakliyat; evden eve nakliyat, şehirler arası taşımacılık, ofis ve işyeri taşıma, eşya depolama ve uluslararası taşımacılık alanlarında profesyonel çözümler sunan köklü bir lojistik firmasıdır. Eğitimli taşıma ekibimiz, modern asansörlü kamyonlarımız, profesyonel ambalaj malzemelerimiz ve eşya sigortası güvencemizle eşyalarınızı ilk günkü gibi yeni adresinize ulaştırıyoruz. Şeffaf fiyat politikası, zamanında teslim ve müşteri memnuniyeti önceliğimizdir. Ücretsiz keşif ve fiyat teklifi için bizi arayın; taşınmanın tüm yükünü biz üstlenelim.'),
('misyon','Müşterilerimizin eşyalarını sigortalı, hasarsız ve söz verdiğimiz zamanda taşımak; taşınma sürecindeki tüm yükü profesyonel ekibimizle üstlenerek stressiz bir deneyim sunmak.'),
('vizyon','Türkiye genelinde ilk akla gelen, güvenilir ve teknolojik nakliyat markası olmak; hizmet ağımızı uluslararası taşımacılıkta da büyütmek.'),
('yil','15'),
('proje_sayi','12000'),
('musteri_sayi','9500'),
('personel_sayi','60'),
('facebook','#'),('instagram','#'),('twitter','#'),('linkedin','#'),('youtube','#');

-- ============ HİZMETLER ============
DROP TABLE IF EXISTS `hizmetler`;
CREATE TABLE `hizmetler` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `baslik` VARCHAR(150) NOT NULL,
  `slug` VARCHAR(180),
  `ozet` TEXT,
  `icerik` LONGTEXT,
  `ikon` VARCHAR(60) DEFAULT 'bi-truck',
  `gorsel` VARCHAR(255),
  `sira` INT DEFAULT 0,
  `durum` TINYINT DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `hizmetler` (`baslik`,`slug`,`ozet`,`icerik`,`ikon`,`gorsel`,`sira`) VALUES
('Evden Eve Nakliyat','evden-eve-nakliyat','Eşyalarınızı profesyonel ambalajla paketleyip asansörlü araçlarla hasarsız taşıyoruz.','Evden eve nakliyat hizmetimizde eşyalarınız uzman ekibimiz tarafından özel ambalaj malzemeleriyle (baloncuklu naylon, streç film, koli, battaniye) paketlenir. Asansörlü kamyonlarımızla kat farkı gözetmeksizin güvenli taşıma yapılır. Demontaj-montaj, paketleme ve yerleştirme dahil anahtar teslim hizmet sunuyoruz. Tüm eşyalarınız taşıma sigortası kapsamındadır.','bi-house-door','https://images.unsplash.com/photo-1600518464441-9154a4dea21b?w=800&q=80',1),
('Şehirler Arası Taşımacılık','sehirler-arasi-tasimacilik','Türkiye''nin her iline sigortalı, takip edilebilir ve zamanında taşımacılık.','Şehirler arası nakliyat hizmetimizle eşyalarınızı Türkiye''nin 81 iline güvenle ulaştırıyoruz. Parsiyel ve komple taşıma seçenekleri, GPS ile araç takibi ve sigortalı taşıma güvencesi sunuyoruz. Uzun yol konusunda deneyimli şoförlerimiz ve bakımlı araç filomuzla eşyalarınız zamanında yeni adresinde.','bi-signpost-split','https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?w=800&q=80',2),
('Ofis & İşyeri Taşıma','ofis-isyeri-tasima','İş akışınızı aksatmadan, hafta sonu ve mesai dışı ofis taşıma çözümleri.','Ofis ve işyeri taşımacılığında iş sürekliliğiniz önceliğimizdir. Mobilya, dosya, arşiv ve hassas elektronik ekipmanlarınız etiketlenerek sistemli şekilde taşınır. Mesai dışı ve hafta sonu çalışma seçenekleriyle iş kaybı yaşamadan yeni ofisinize geçiş yaparsınız. Demontaj-montaj ve yerleşim planlaması dahildir.','bi-building','https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=800&q=80',3),
('Eşya Depolama','esya-depolama','Klimatize, güvenlikli ve sigortalı depolarda kısa veya uzun süreli eşya saklama.','Taşınma arası dönemde veya uzun süreli ihtiyaçlarınız için modern depolama tesislerimiz hizmetinizde. Nem ve sıcaklık kontrollü, 7/24 kamera güvenlikli, yangın sistemli depolarımızda eşyalarınız sigortalı olarak saklanır. İstediğiniz zaman erişim ve teslim imkanı sunuyoruz.','bi-box-seam','https://images.unsplash.com/photo-1553413077-190dd305871c?w=800&q=80',4),
('Asansörlü Taşıma','asansorlu-tasima','Yüksek katlardan güvenli ve hızlı taşıma için modern mobil asansör hizmeti.','Dar merdiven ve yüksek katlarda eşyalarınızın güvenli taşınması için mobil taşıma asansörlerimiz devrede. 30 kata kadar çıkabilen asansörlerimizle büyük ve hacimli eşyalar (beyaz eşya, mobilya, piyano) hasarsız ve hızlı şekilde taşınır. Hem zaman hem güvenlik kazandırır.','bi-arrows-vertical','https://images.unsplash.com/photo-1581094794329-c8112a89af12?w=800&q=80',5),
('Paketleme & Ambalaj','paketleme-ambalaj','Profesyonel malzemelerle kırılacak ve hassas eşyalarınıza özel ambalaj.','Eşyalarınızın taşıma sırasında zarar görmemesi için profesyonel ambalajlama hizmeti sunuyoruz. Cam, porselen, tablo, beyaz eşya ve elektronik cihazlar için özel koruyucu malzemeler kullanılır. İsteğe bağlı sadece paketleme veya komple taşıma paketi seçilebilir.','bi-box2-heart','https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=800&q=80',6);

-- ============ PROJELER / REFERANS TAŞIMALAR ============
DROP TABLE IF EXISTS `projeler`;
CREATE TABLE `projeler` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `baslik` VARCHAR(150) NOT NULL,
  `slug` VARCHAR(180),
  `kategori` VARCHAR(60),
  `gorsel` VARCHAR(255),
  `aciklama` TEXT,
  `tarih` VARCHAR(40),
  `sira` INT DEFAULT 0,
  `durum` TINYINT DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `projeler` (`baslik`,`slug`,`kategori`,`gorsel`,`aciklama`,`tarih`,`sira`) VALUES
('İstanbul - Ankara Villa Taşıma','istanbul-ankara-villa','Şehirler Arası','https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&q=80','3 katlı villa eşyası asansörlü araçla paketlenip sigortalı şekilde Ankara''ya hasarsız teslim edildi.','2026',1),
('Kurumsal Ofis Taşıma - Levent','kurumsal-ofis-levent','Ofis Taşıma','https://images.unsplash.com/photo-1524758631624-e2822e304c36?w=800&q=80','80 kişilik teknoloji firmasının ofisi hafta sonu boyunca taşınarak Pazartesi iş kaybı yaşanmadan açıldı.','2026',2),
('Evden Eve Nakliyat - Kadıköy','evden-eve-kadikoy','Evden Eve','https://images.unsplash.com/photo-1600518464441-9154a4dea21b?w=800&q=80','3+1 daire eşyası tam paketleme ve demontaj-montaj hizmetiyle aynı gün yeni adrese taşındı.','2025',3),
('Fabrika Makine Taşıma - Gebze','fabrika-makine-gebze','Endüstriyel','https://images.unsplash.com/photo-1581094794329-c8112a89af12?w=800&q=80','Ağır tonajlı üretim makineleri özel vinç ve forklift desteğiyle güvenle yeni fabrikaya taşındı.','2025',4),
('Uzun Süreli Eşya Depolama','uzun-sureli-depolama','Depolama','https://images.unsplash.com/photo-1553413077-190dd305871c?w=800&q=80','Yurt dışına giden ailenin tüm ev eşyası 8 ay boyunca klimatize depomuzda sigortalı saklandı.','2025',5),
('Asansörlü Piyano Taşıma','asansorlu-piyano','Asansörlü','https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?w=800&q=80','12. kattaki kuyruklu piyano mobil asansörle pencereden indirilerek çiziksiz şekilde taşındı.','2024',6);

-- ============ BLOG ============
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `baslik` VARCHAR(200) NOT NULL,
  `slug` VARCHAR(200),
  `kategori` VARCHAR(60),
  `ozet` TEXT,
  `icerik` LONGTEXT,
  `gorsel` VARCHAR(255),
  `tarih` DATE,
  `durum` TINYINT DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `blog` (`baslik`,`slug`,`kategori`,`ozet`,`icerik`,`gorsel`,`tarih`) VALUES
('Evden Eve Taşınmadan Önce Yapılması Gereken 10 Şey','tasinma-oncesi-10-sey','Taşınma Rehberi','Taşınma stresini azaltmak için önceden planlama şart. İşte taşınmadan önce mutlaka yapmanız gereken 10 madde.','Taşınma süreci doğru planlandığında çok daha kolay ilerler. Öncelikle taşınma tarihinizi en az 2 hafta önceden belirleyin ve nakliyat firmasından ücretsiz keşif talep edin. Kullanmadığınız eşyaları ayıklayın, bağışlayın veya satın. Kıymetli ve kişisel evraklarınızı (kimlik, tapu, ziynet) ayrı bir çantada kendiniz taşıyın. Kolileri oda oda etiketleyin. Beyaz eşyaların suyunu önceden boşaltın. Elektrik, su, doğalgaz ve internet aboneliklerinizi yeni adrese taşıtın. Bu adımlar taşınma gününüzü sorunsuz kılar.','https://images.unsplash.com/photo-1530103862676-de8c9debad1d?w=800&q=80','2026-05-20'),
('Eşya Sigortası Neden Önemli? Nelere Dikkat Edilmeli?','esya-sigortasi-onemi','Bilgi','Taşıma sırasında oluşabilecek hasarlara karşı eşya sigortası size güvence sağlar. Detaylar yazımızda.','Nakliyat sırasında eşyalarınızın zarar görme riski her zaman vardır. Profesyonel nakliyat firmaları eşya taşıma sigortası sunar. Sigorta kapsamını mutlaka yazılı olarak teyit edin; hangi durumların (kırılma, kaybolma, hasar) kapsam içinde olduğunu sorun. Değerli eşyalarınızın listesini ve fotoğraflarını taşımadan önce çekin. Sözleşmesiz ve faturasız çalışan firmalardan kaçının. Rota Nakliyat olarak tüm taşımalarımız sigorta güvencesi altındadır.','https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=800&q=80','2026-04-28'),
('Şehirler Arası Nakliyatta Dikkat Edilecek Noktalar','sehirler-arasi-dikkat','Taşınma Rehberi','Uzun mesafe taşımalarda sürpriz yaşamamak için bu önemli noktalara dikkat edin.','Şehirler arası taşımalarda mesafe ve süre uzadığı için planlama daha da önemlidir. Firmanın araç takip sistemi olup olmadığını sorun. Parsiyel (paylaşımlı) mı komple (size özel) araç mı kullanılacağını netleştirin; teslim tarihi buna göre değişir. Yol sigortası ve sözleşmeyi yazılı alın. Eşyaların teslim alınırken ve teslim edilirken sayım yapıldığından emin olun. Şeffaf fiyatlandırma için keşif sonrası net teklif isteyin.','https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?w=800&q=80','2026-03-22');

-- ============ REFERANSLAR (MÜŞTERİ YORUMLARI) ============
DROP TABLE IF EXISTS `referanslar`;
CREATE TABLE `referanslar` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `ad` VARCHAR(100) NOT NULL,
  `unvan` VARCHAR(120),
  `yorum` TEXT,
  `foto` VARCHAR(255),
  `yildiz` TINYINT DEFAULT 5,
  `durum` TINYINT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `referanslar` (`ad`,`unvan`,`yorum`,`foto`,`yildiz`) VALUES
('Mehmet Yıldız','Kadıköy / İstanbul','Evden eve taşınmamızda ekip çok profesyoneldi. Tek bir eşyamız bile çizilmedi, montaja kadar her şeyi hallettiler. Söz verdikleri saatte geldiler. Kesinlikle tavsiye ederim.','https://i.pravatar.cc/100?img=12',5),
('Ayşe Demir','Ofis Müdürü','Firmamızın ofis taşıma işini hafta sonu yaptılar, Pazartesi hiçbir aksama olmadan çalışmaya başladık. Etiketleme ve yerleşim sistemleri harikaydı.','https://i.pravatar.cc/100?img=32',5),
('Caner Aksoy','Ankara','İstanbul''dan Ankara''ya şehirler arası taşımada eşyalarım sigortalıydı ve aynı gün teslim edildi. Fiyat keşifte söyledikleriyle birebir aynıydı, sürpriz çıkmadı.','https://i.pravatar.cc/100?img=15',5);

-- ============ MESAJLAR ============
DROP TABLE IF EXISTS `mesajlar`;
CREATE TABLE `mesajlar` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `ad` VARCHAR(100),
  `mail` VARCHAR(150),
  `tel` VARCHAR(40),
  `konu` VARCHAR(200),
  `mesaj` TEXT,
  `okundu` TINYINT DEFAULT 0,
  `tarih` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============ TEKLİFLER (FİYAT TEKLİFİ TALEPLERİ) ============
DROP TABLE IF EXISTS `teklifler`;
CREATE TABLE `teklifler` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `ad` VARCHAR(100),
  `mail` VARCHAR(150),
  `tel` VARCHAR(40),
  `hizmet` VARCHAR(120),
  `il` VARCHAR(60),
  `adres` VARCHAR(255),
  `alan` VARCHAR(60),
  `butce` VARCHAR(60),
  `baslangic` VARCHAR(60),
  `detay` TEXT,
  `durum` ENUM('yeni','degerlendiriliyor','teklif_verildi','kazanildi','kaybedildi') DEFAULT 'yeni',
  `notlar` TEXT,
  `tarih` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============ ADMIN ============
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `kullanici` VARCHAR(60) NOT NULL UNIQUE,
  `sifre_hash` VARCHAR(255) NOT NULL,
  `ad_soyad` VARCHAR(120),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Şifre: admin123  (password_hash bcrypt) — CANLIDA MUTLAKA DEĞİŞTİR
INSERT INTO `admin` (`kullanici`,`sifre_hash`,`ad_soyad`) VALUES
('admin','$2y$10$6gNrpOXRLof.Toy.Ugy.yu4DrKP23OcnJa7UBhKOH1iMxbtH8GK0.','Yönetici');

SET FOREIGN_KEY_CHECKS = 1;
