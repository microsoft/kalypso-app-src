FROM golang:1.17 as build

WORKDIR /src
RUN go mod init kalypso.io/sample
COPY . .

RUN CGO_ENABLED=0 go build

FROM scratch
COPY --from=build /src/sample /opt/app/
WORKDIR /opt/app

ENV PORT=8080
ENV CLUSTER_NAME=UDEFINED
ENV REGION=UDEFINED
ENV ENVIRONMENT=UDEFINED
ENV DATABASE_URL=UDEFINED

ENTRYPOINT ["/opt/app/sample"]
