#!/bin/sh
set -e
cd "$(dirname "$0")"

{
  cat <<'HEAD'
<!doctype html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<!-- Google tag (gtag.js) -->
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('consent', 'default', {
    'ad_storage': 'denied',
    'ad_user_data': 'denied',
    'ad_personalization': 'denied',
    'analytics_storage': 'denied',
    'wait_for_update': 500
  });
  gtag('set', 'ads_data_redaction', true);
  gtag('set', 'url_passthrough', true);
  (function(){
    try{
      var saved = localStorage.getItem('glConsent');
      if(saved === 'granted' || saved === 'denied'){
        gtag('consent', 'update', {
          'ad_storage': saved, 'ad_user_data': saved, 'ad_personalization': saved, 'analytics_storage': saved
        });
      }
    }catch(e){}
  })();
</script>
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-18474566267"></script>
<script>
  gtag('js', new Date());
  gtag('config', 'AW-18474566267');
</script>
<!-- Event snippet for Отправка формы для потенциальных клиентов conversion page -->
<script>
  function gtag_report_conversion(url) {
    var callback = function () {
      if (typeof url != 'undefined') {
        window.location = url;
      }
    };
    gtag('event', 'conversion', {
        'send_to': 'AW-18474566267/YFvYCLDajoUdEPuErulE',
        'value': 1.0,
        'currency': 'USD',
        'event_callback': callback
    });
    return false;
  }
</script>
<title>GrandLine Transfer — трансфер Молдова ⇄ Украина ⇄ Европа</title>
<meta name="description" content="Комфортный трансфер от двери до двери: Кишинёв ⇄ Киев, Одесса, Бухарест, Яссы, Львов и другие города. Фиксированная цена, опытные водители, знание всех погранпереходов.">
<meta name="robots" content="index, follow">
<link rel="canonical" href="https://gltransfer.com/">
<link rel="icon" type="image/svg+xml" href="favicon.svg">
<meta property="og:type" content="website">
<meta property="og:site_name" content="GrandLine Transfer">
<meta property="og:title" content="GrandLine Transfer — трансфер через границу без пересадок">
<meta property="og:description" content="Комфортный трансфер Кишинёв ⇄ Киев, Одесса, Бухарест и другие направления. Фиксированные цены, опытные водители.">
<meta property="og:image" content="https://gltransfer.com/og-cover.jpg">
<meta property="og:image:width" content="2000">
<meta property="og:image:height" content="1116">
<meta property="og:url" content="https://gltransfer.com/">
<meta property="og:locale" content="ru_RU">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="https://gltransfer.com/og-cover.jpg">
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "TaxiService",
  "name": "GrandLine Transfer",
  "description": "Комфортный трансфер от двери до двери между Молдовой, Украиной и странами Евросоюза.",
  "areaServed": ["Кишинёв","Киев","Одесса","Бухарест","Яссы","Львов","Измаил","Могилёв-Подольский"],
  "telephone": "+37378293919",
  "priceRange": "$$",
  "url": "https://gltransfer.com/"
}
</script>
<style>body{margin:0}</style>
HEAD

  # Drop the plain <title> line from the artifact source; the head above supplies a richer one.
  tail -n +2 graniline.html | sed '0,/<\/style>/{s#</style>#</style>\n</head>\n<body>#}'

  printf '\n</body>\n</html>\n'
} > index.html

echo "built index.html: $(wc -l < index.html) lines"
