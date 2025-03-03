FROM python:3.13-slim
WORKDIR /opt/app

# Install python-dvuploader dependencies
COPY requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt

ENTRYPOINT [ "dvuploader" ]