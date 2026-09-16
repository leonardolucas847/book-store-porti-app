# Bookstore API

Bookstore APP from the Backend Python course at EBAC.

## Prerequisites

```text
Python 3.13+
Poetry 2.x
Docker & Docker Compose v2
```

## Quickstart

1. Clone this project

```shell
git clone [https://github.com/YOUR_USERNAME/bookstore.git](https://github.com/YOUR_USERNAME/bookstore.git)
cd bookstore
Install dependencies:
```
2. Install dependencies:

```shell
poetry install
Run local dev server:
```
3. Run local dev server:

```shell
poetry run python manage.py migrate
poetry run python manage.py runserver
Run Docker dev environment:
```
4. Run docker dev server environment:

```shell
docker compose up -d --build
docker compose exec web python manage.py migrate
Run tests inside Docker:
```

5. Run tests inside of docker:
```shell
docker compose exec web python manage.py test
```