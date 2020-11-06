FROM python:3.8-slim as builder

WORKDIR /app

ENTRYPOINT [ "masterbizor" ]

CMD [ "--help" ]

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        build-essential \
        libjpeg62-turbo-dev \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY masterbizor /usr/local/bin/masterbizor
