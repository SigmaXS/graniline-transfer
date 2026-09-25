# GrandLine Transfer

Сайт трансфера Молдова ⇄ Украина ⇄ Европа.

## Структура

- `graniline.html` — исходник страницы (используется для публикации в Claude Artifact).
- `index.html` — собранная самостоятельная версия для хостинга (Netlify / Railway), с SEO-тегами, favicon, JSON-LD.
- `build-netlify.sh` — пересобирает `index.html` из `graniline.html`.
- `cars/` — фото автопарка (фон уже удалён).
- `removebg.ps1` — скрипт удаления белого фона с фото (PowerShell, без внешних сервисов).
- `favicon.svg`, `robots.txt`, `sitemap.xml` — для поисковиков.
- `package.json` — минимальный конфиг, чтобы Railway могло запустить статику через `serve`.

## Пересборка после правок в graniline.html

```bash
sh build-netlify.sh
```

## Деплой

- **Netlify**: перетащить папку/zip на app.netlify.com/drop, либо подключить этот GitHub-репозиторий.
- **Railway**: New Project → Deploy from GitHub repo → выбрать этот репозиторий. Railway сам подхватит `package.json` и запустит `npm start`.

Перед запуском в продакшн замените `REPLACE-WITH-YOUR-DOMAIN.com` в `index.html`, `robots.txt` и `sitemap.xml` на настоящий домен.
