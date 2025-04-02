FROM python:3.13-slim
WORKDIR /opt/app

# Install python-dvuploader dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

ENTRYPOINT [ "dvuploader" ]