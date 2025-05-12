# Meme Archives Ops

Scripts for local development and production deployment.

## Environment Variables

See the `config/*.env.example` files for more information on required environment variables.

## Docker Images

For localhost development, you only need to run the postgres database, and you can use the `docker-compose-local.yml` file.

The `docker-compose-prod.yml` file loads the following Docker images:

- **`postgres:16.1`**: Database container for storing application data.
- **`nginxproxy/nginx-proxy`**: Reverse proxy for routing requests to the appropriate services.
- **`nginxproxy/acme-companion`**: Handles SSL certificate generation and renewal.
- **`meme-archives-api`**: Backend API for the meme archives.
- **`meme-archives-web`**: Frontend web application for the meme archives.
- **`meme-archives-tg-bot`**: Telegram bot for interacting with the meme archives.

## Initialize Database

After running the database container, create the tables and indexes by importing `meme-archives-api/database/combined/init_database.sql` from the meme-archives-api repo.

## Makefile Commands

The `Makefile` in this repository provides several commands to simplify local development and production deployment. Below is a description of each command:

### Local Development

- **`local_up_db`**  
  Starts the local database container.  
  ```sh
  make local_up_db
  ```

- **`local_up_all`**  
  Starts all local containers defined in `docker/docker-compose-local.yml`.  
  ```sh
  make local_up_all
  ```

- **`local_down_all`**  
  Stops and removes all local containers.  
  ```sh
  make local_down_all
  ```

### Production Deployment

- **`prod_up_db`**  
  Starts the production database container.  
  ```sh
  make prod_up_db
  ```

- **`prod_up_all`**  
  Starts all production containers, including the database, API, web, and other services.  
  ```sh
  make prod_up_all
  ```

- **`prod_down_all`**  
  Stops and removes all production containers.  
  ```sh
  make prod_down_all
  ```

### Rebuilding Services

- **`rebuild_api`**  
  Rebuilds the `meme_archives_api` container without using the cache and restarts it.  
  ```sh
  make rebuild_api
  ```

- **`rebuild_tg_bot`**  
  Rebuilds the `meme_archives_tg_bot` container without using the cache and restarts it.  
  ```sh
  make rebuild_tg_bot
  ```
