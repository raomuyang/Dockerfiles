# Author raomengnan

FROM python:3.7.5-slim

RUN apt-get update
RUN apt-get install -y git
COPY interval_fetch.py /usr/local/bin/git_interval_fetch
RUN chmod a+x /usr/local/bin/git_interval_fetch
ENTRYPOINT [ "git_interval_fetch" ]
