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
<title>GrandLine Transfer — трансфер Молдова ⇄ Украина ⇄ Европа</title>
<meta name="description" content="Комфортный трансфер от двери до двери: Кишинёв ⇄ Киев, Одесса, Бухарест, Яссы, Львов и другие города. Фиксированная цена, опытные водители, знание всех погранпереходов.">
<meta name="robots" content="index, follow">
<link rel="canonical" href="https://gltransfer.com/">
<link rel="icon" type="image/svg+xml" href="favicon.svg">
<meta property="og:type" content="website">
<meta property="og:site_name" content="GrandLine Transfer">
<meta property="og:title" content="GrandLine Transfer — трансфер через границу без пересадок">
<meta property="og:description" content="Комфортный трансфер Кишинёв ⇄ Киев, Одесса, Бухарест и другие направления. Фиксированные цены, опытные водители.">
<meta property="og:image" content="https://gltransfer.com/og-cover.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:url" content="https://gltransfer.com/">
<meta property="og:locale" content="ru_RU">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="https://gltransfer.com/og-cover.png">
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
