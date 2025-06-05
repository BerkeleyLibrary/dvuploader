FROM python:3.13-slim
WORKDIR /opt/app

ENV APP_USER=dvtools
ENV APP_UID=40088

ENV APP_GROUP=dpgdil
ENV APP_GID=105

RUN groupadd --system --gid $APP_UID $APP_USER \
    && groupadd --system --gid $APP_GID $APP_GROUP \
    && useradd --home-dir /opt/app --system --uid $APP_UID --gid $APP_USER -G $APP_GROUP $APP_USER

RUN chown -R $APP_USER:$APP_USER /opt/app

USER $APP_USER:$APP_GROUP

# Install python-dvuploader dependencies
COPY --chown=$APP_USER requirements.txt .
RUN pip install -r requirements.txt

ENV PATH="/opt/app/.local/bin:$PATH"

ENTRYPOINT [ "dvuploader" ]
