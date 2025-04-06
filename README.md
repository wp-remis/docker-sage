<p align="center">
  <img src="https://cdn.roots.io/app/uploads/logo-bedrock.svg" alt="Bedrock" height="60" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://tailwindcss.com/favicons/apple-touch-icon.png" alt="Tailwind CSS" height="60" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://dokku.com/images/mark.svg" alt="Dokku" height="60" />
</p>

<p align="center">
  A modern WordPress development boilerplate using <strong>Bedrock</strong> + <strong>Sage</strong> with <strong>Tailwind CSS v4</strong>, built for local Docker environments and deployed via <strong>Dokku</strong>.
</p>

---

## 🚀 Stack Overview

- [Bedrock](https://roots.io/bedrock/): WordPress boilerplate with Composer, Dotenv, and better structure
- [Sage](https://roots.io/sage/): Modern WordPress theme using Blade, Vite, and Tailwind CSS
- [Tailwind CSS v4](https://tailwindcss.com): Utility-first CSS framework
- [Docker](https://www.docker.com): For isolated local dev environments
- [Dokku](https://dokku.com): Lightweight Heroku-style app deployment for self-hosting

---

## 📁 Features

- Modern project structure based on Bedrock
- Laravel-style WordPress theme development with Blade and Composer
- Vite-powered asset bundling with Tailwind CSS v4 and hot reload
- Built-in REST healthcheck endpoint (`/wp-json/sage/v1/healthcheck`) for Dokku health checks
- Environment-based config via `.env`
- Full Docker/Dokku-ready setup (with `Dockerfile`, `docker-compose.yml`, `app.json`, etc.)

---

## 📦 Requirements

- Docker (for local development)
- Dokku (for deployment)
- Node.js / Yarn (for frontend tooling)
- Composer (for PHP dependency management)

---

## 🛠 Local Development

```bash
# Clone the repo
git clone git@github.com:your-org/docker-sage.git && cd docker-sage

# Copy env config
cp .env.example .env

# Start containers
docker-compose up -d --build

# Install PHP dependencies
docker-compose exec app composer install

# Install frontend dependencies
cd web/app/themes/sage
yarn install
yarn dev
```

## 🌐 Dokku Deployment

```
"healthcheck": {
  "web": {
    "path": "/wp-json/sage/v1/healthcheck",
    "interval": 30,
    "timeout": 4,
    "retries": 6
  }
}
```

```
git remote add dokku dokku@your-server:your-app-name
git push dokku main
```

---

## ✨ Credits

- [Roots](https://roots.io) for Bedrock and Sage  
- [Tailwind Labs](https://tailwindcss.com) for Tailwind CSS  
- [Dokku](https://dokku.com) for easy app deployments

---

## 📬 Stay in the Loop

- Join the [Roots Discourse](https://discourse.roots.io/)
- Follow [@rootswp on Twitter](https://twitter.com/rootswp)
- Check out [Tailwind CSS v4 progress](https://github.com/tailwindlabs/tailwindcss/releases)
- Visit [dokku.com](https://dokku.com) for server setup and scaling
