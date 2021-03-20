FROM python:3.9-alpine
MAINTAINER ssaakkii

ENV PYTHONUNBUFFERED 1

# 必要な module のインストール
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# app 用のディレクトリを準備
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# ユーザ user を追加する
RUN adduser -D user
# 以下の RUN/CMD コマンドを user で行う
USER user