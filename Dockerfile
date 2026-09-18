FROM python:3.12-slim

WORKDIR /app

ENV DBT_PROFILES_DIR=/app \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY dbt_project.yml profiles.yml ./
COPY models ./models
COPY scripts ./scripts
COPY seeds ./seeds
COPY tests ./tests

CMD ["python", "scripts/run_pipeline.py"]

