FROM fluent/fluentd:v1.19-debian-1

USER root

RUN gem install elasticsearch -v 8.19.2 --no-document \
    && gem install fluent-plugin-elasticsearch -v 6.0.0 --no-document \
    && gem install fluent-plugin-grok-parser --no-document

COPY fluent.conf /fluentd/etc/fluent.conf

USER fluent
