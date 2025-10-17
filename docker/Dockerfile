FROM python:3.12-alpine3.19 as base

ARG DJANGO_ENV

ENV DJANGO_ENV=${DJANGO_ENV} \
    PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1

WORKDIR /code

FROM base as builder

ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1

COPY docker/setup/requirements.txt /tmp/requirements.txt

RUN apk add --no-cache postgresql-dev gcc musl-dev linux-headers && \
    pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt

COPY entrypoint.sh /code/

RUN sed -i 's/\r$//g' /code/entrypoint.sh && \
    chmod +x /code/entrypoint.sh

COPY pacha/ /code/pacha/

ENTRYPOINT ["/code/entrypoint.sh"]
