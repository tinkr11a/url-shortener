#===========
#Build Stage
#===========
FROM bitwalker/alpine-elixir:1.9 as build

#Copy the source folder into the Docker image
COPY . .

#Install dependencies and build Release
RUN export MIX_ENV=prod && \
  rm -Rf _build && \
  mix deps.get && \
  mix release

#Extract Release archive to /rel for copying in next stage
RUN APP_NAME="url_shortener" && \
  RELEASE_DIR=`ls -d _build/prod/rel/$APP_NAME/` && \
  mkdir /export && \
  cp -r "$RELEASE_DIR" /export

#================
#Deployment Stage
#================
FROM pentacent/alpine-erlang-base:latest

#Set environment variables and expose port
EXPOSE 4001
ENV REPLACE_OS_VARS=true \
  PORT=4001

#Copy and extract .tar.gz Release file from the previous stage
COPY --from=build /export/ .


RUN chown -R nobody: /opt/app/
RUN chmod -R 777 /opt/app

#Change user
USER default

#Set default entrypoint and command
ENTRYPOINT ["/opt/app/url_shortener/bin/url_shortener"]
CMD ["start"]