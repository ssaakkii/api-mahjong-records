FROM python:3.9-alpine
MAINTAINER ssaakkii

ENV PYTHONUNBUFFERED 1

# 必要な module のインストール
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
		gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# app 用のディレクトリを準備
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# ユーザ user を追加する
RUN adduser -D user
# 以下の RUN/CMD コマンドを user で行う
USER user