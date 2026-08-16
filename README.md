# Supermemory Local Docker

A simple Docker Compose setup for [Supermemory Local](https://docs.supermemory.ai/self-hosting/quickstart).

It puts the official local server in Docker. It does not change Supermemory or add a new memory product.

## Start

You need Docker with Docker Compose and a supported language-model provider.

```bash
git clone https://github.com/seagpt/supermemory-local-docker.git
cd supermemory-local-docker
cp .env.example .env
# Add your provider settings to .env
docker compose up --build -d
```

Check that it started:

```bash
docker compose ps
curl http://127.0.0.1:6767/v3/health
```

## What this includes

- The official Supermemory Local server
- A Docker Compose file
- A place for data to persist between restarts
- A few basic checks and notes for upgrades

## Important

- This project is not made by or endorsed by Supermemory.
- It does not include a hosted service, managed support, or extra Supermemory features.
- Keep `.env`, backups, and private data out of GitHub.

For Supermemory features and API help, use the [official documentation](https://docs.supermemory.ai/).

## Contributing

Small, clear improvements are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md).

## License

The Docker files and documentation here are released under [MIT](LICENSE). Supermemory and its software remain subject to their own terms.
