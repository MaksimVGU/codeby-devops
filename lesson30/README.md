# Lesson 30 — Reddit и EFK

## Состав стенда
- Reddit: ui, post, comment
- MongoDB
- Elasticsearch
- Fluentd
- Kibana

## Запуск
Из корня репозитория сначала запускается EFK:

    docker compose -f lesson30/efk/docker-compose.yml up -d --build

Затем Reddit:

    docker compose -f lesson30/reddit/docker-compose.yml up -d

## Адреса
- Reddit UI: http://localhost:9292
- Elasticsearch: http://localhost:9200
- Kibana: http://localhost:5601

## Индексы
- post-*
- ui-regexp-*
- ui-grok-*

Скриншоты Kibana Discover хранятся в screenshots/.
