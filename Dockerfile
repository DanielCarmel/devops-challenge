# Stage 1: Build stage
FROM python:3.12-slim AS builder

# Install pipenv and compilation dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && pip install --no-cache-dir pipenv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Pipfile .
COPY Pipfile.lock .

# Install python dependencies in .venv
RUN PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy --ignore-pipfile

# Stage 2: Final stage
FROM python:3.12-slim

WORKDIR /app

# Copy virtual env from python-deps stage
COPY --from=builder /app/.venv /app/.venv
COPY . .
ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 3000
CMD ["python", "app.py"]
