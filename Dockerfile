FROM python:3.13.1-slim

# Impede geração de bytecode e garante logs em tempo real
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_CREATE=false \
    PATH="/opt/poetry/bin:$PATH"

# Instala dependências do sistema operacional
RUN apt-get update && apt-get install --no-install-recommends -y \
    curl \
    build-essential \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Instala o Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Define o diretório de trabalho único
WORKDIR /app

# Copia arquivos de dependência (aproveita o cache do Docker)
COPY pyproject.toml poetry.lock* /app/

# Instala as dependências diretamente no ambiente Python do container
RUN poetry install --no-root --only main

# Copia o código-fonte da aplicação
COPY . /app/

# Coleta os arquivos estáticos do Admin e REST Framework
RUN python manage.py collectstatic --noinput

EXPOSE 8000

# Aplica migrações no PostgreSQL e inicia o Gunicorn
CMD ["sh", "-c", "python manage.py migrate && gunicorn bookstore.wsgi:application --bind 0.0.0.0:8000"]