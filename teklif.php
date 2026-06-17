<?php
require_once __DIR__ . '/inc/helpers.php';
$mesaj=''; $hata='';
$hizmetler = getList('hizmetler','durum=1','sira ASC');
if($_SERVER['REQUEST_METHOD']==='POST'){
    csrf_check();
    $f = [
        'ad'        => trim($_POST['ad'] ?? ''),
        'mail'      => trim($_POST['mail'] ?? ''),
        'tel'       => trim($_POST['tel'] ?? ''),
        'hizmet'    => trim($_POST['hizmet'] ?? ''),
        'il'        => trim($_POST['il'] ?? ''),
        'adres'     => trim($_POST['adres'] ?? ''),
        'alan'      => trim($_POST['alan'] ?? ''),
        'butce'     => trim($_POST['butce'] ?? ''),
        'baslangic' => trim($_POST['baslangic'] ?? ''),
        'detay'     => trim($_POST['detay'] ?? ''),
    ];
    if(!$f['ad'] || !$f['tel'] || !$f['hizmet']){
        $hata = 'Ad, telefon ve hizmet alanları zorunludur.';
    } elseif($f['mail'] && !filter_var($f['mail'], FILTER_VALIDATE_EMAIL)){
        $hata = 'Geçerli bir e-posta adresi giriniz.';
    } else {
        $stmt = $db->prepare("INSERT INTO teklifler(ad,mail,tel,hizmet,il,adres,alan,butce,baslangic,detay) VALUES(:ad,:mail,:tel,:hizmet,:il,:adres,:alan,:butce,:baslangic,:detay)");
        $stmt->execute($f);
        $mesaj = 'Teklif talebiniz alındı. Uzman ekibimiz en kısa sürede sizinle iletişime geçecek.';
    }
}
require_once __DIR__ . '/inc/header.php';
?>
<section class="page-head">
  <div class="container">
    <h1>Fiyat Teklifi Al</h1>
    <nav><ol class="breadcrumb"><li class="breadcrumb-item"><a href="<?= SITE_URL ?>/">Anasayfa</a></li><li class="breadcrumb-item active">Fiyat Teklifi</li></ol></nav>
  </div>
</section>

<section>
  <div class="container">
    <div class="row g-5">
      <div class="col-lg-7">
        <span class="badge-mini">Ücretsiz Keşif & Teklif</span>
        <h2>Taşınmanız İçin <span style="color:var(--primary)">Fiyat Teklifi</span> Alın</h2>
        <p class="text-muted mb-4">Formu doldurun, uzman ekibimiz sizi arasın ve taşınmanıza en uygun fiyatı hazırlasın.</p>

        <?php if($mesaj): ?><div class="alert alert-success"><i class="bi bi-check-circle-fill me-2"></i><?= e($mesaj) ?></div><?php endif; ?>
        <?php if($hata):  ?><div class="alert alert-danger"><i class="bi bi-exclamation-triangle-fill me-2"></i><?= e($hata) ?></div><?php endif; ?>

        <form method="post" class="contact-form">
          <input type="hidden" name="csrf" value="<?= csrf_token() ?>">
          <h5 class="mb-3 mt-2" style="color:var(--primary)"><i class="bi bi-person me-2"></i>İletişim Bilgileri</h5>
          <div class="row g-3">
            <div class="col-md-6"><label class="form-label">Ad Soyad / Firma *</label><input class="form-control" name="ad" required></div>
            <div class="col-md-6"><label class="form-label">Telefon *</label><input class="form-control" name="tel" required></div>
            <div class="col-md-12"><label class="form-label">E-posta</label><input type="email" class="form-control" name="mail"></div>
          </div>

          <h5 class="mb-3 mt-4" style="color:var(--primary)"><i class="bi bi-truck me-2"></i>Taşıma Detayları</h5>
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label">Hizmet Türü *</label>
              <select class="form-select" name="hizmet" required>
                <option value="">— Seçiniz —</option>
                <?php foreach($hizmetler as $h): ?>
                  <option value="<?= e($h['baslik']) ?>" <?= (isset($_GET['hizmet']) && $_GET['hizmet']===$h['slug'])?'selected':'' ?>><?= e($h['baslik']) ?></option>
                <?php endforeach; ?>
                <option value="Diğer">Diğer</option>
              </select>
            </div>
            <div class="col-md-6"><label class="form-label">Nereden (İl / İlçe)</label><input class="form-control" name="il" placeholder="örn. İstanbul / Kadıköy"></div>
            <div class="col-12"><label class="form-label">Nereye (Varış Adresi / İl)</label><input class="form-control" name="adres" placeholder="örn. Ankara / Çankaya"></div>
            <div class="col-md-4">
              <label class="form-label">Eşya / Daire Tipi</label>
              <select class="form-select" name="alan">
                <option value="">— Seçiniz —</option>
                <option>1+1 Daire</option>
                <option>2+1 Daire</option>
                <option>3+1 Daire</option>
                <option>4+1 ve üzeri / Villa</option>
                <option>Ofis / İşyeri</option>
                <option>Parça Eşya</option>
              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label">Kat & Asansör Durumu</label>
              <select class="form-select" name="butce">
                <option value="">— Seçiniz —</option>
                <option>Zemin / Bahçe katı</option>
                <option>Bina asansörü var</option>
                <option>Asansör yok (yüksek kat)</option>
                <option>Mobil asansör gerekli</option>
                <option>Emin değilim</option>
              </select>
            </div>
            <div class="col-md-4">
              <label class="form-label">Taşınma Tarihi</label>
              <select class="form-select" name="baslangic">
                <option value="">— Seçiniz —</option>
                <option>Acil (bu hafta)</option>
                <option>Bu ay içinde</option>
                <option>1 ay içinde</option>
                <option>Tarih esnek</option>
                <option>Sadece bilgi alıyorum</option>
              </select>
            </div>
            <div class="col-12"><label class="form-label">Eklemek İstedikleriniz / Notlar</label><textarea class="form-control" name="detay" rows="5" placeholder="Özel eşya (piyano, kasa vb.), paketleme ihtiyacı, ek bilgiler..."></textarea></div>
            <div class="col-12 d-flex gap-2 align-items-center flex-wrap mt-2">
              <button class="btn btn-primary-c"><i class="bi bi-send"></i> Fiyat Teklifi Al</button>
              <span class="text-muted small ms-2"><i class="bi bi-shield-check me-1"></i>Bilgileriniz gizli tutulur, asla 3. kişilerle paylaşılmaz.</span>
            </div>
          </div>
        </form>
      </div>

      <div class="col-lg-5">
        <div class="quote-call">
          <div class="quote-call-icon"><i class="bi bi-telephone-fill"></i></div>
          <div>
            <small>Hemen Arayın</small>
            <a href="tel:<?= e(ayar('telefon')) ?>"><?= e(ayar('telefon')) ?></a>
          </div>
        </div>
        <ul class="quote-perks">
          <li><i class="bi bi-clipboard2-check"></i><div><strong>Ücretsiz Teklif</strong><span>Detaylı ihtiyaç analizi yapıyoruz.</span></div></li>
          <li><i class="bi bi-clock-history"></i><div><strong>24 Saatte Dönüş</strong><span>En geç 1 iş gününde.</span></div></li>
          <li><i class="bi bi-shield-check"></i><div><strong>Gizlilik</strong><span>Bilgileriniz 3. kişilerle paylaşılmaz.</span></div></li>
        </ul>
      </div>
    </div>
  </div>
</section>
<?php require_once __DIR__ . '/inc/footer.php'; ?>
