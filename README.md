# README

This is the README of the Wineskills project which intents to import, display and search wines.

### /!\ THIS IS A DEMO PROJECT /!\

The platform will serve web pages and expose an API using gRPC. It will let you find wines listed in the page, access to a wine details and search for wines with specific criterias, as
- harmonizes
- grapes
- kind
- body
- acidity
- elaborate
- region
- winery

![Screenshot 2024-08-25 at 18 55 39](https://github.com/user-attachments/assets/a9150285-cd96-470d-8f83-5f15cbe655e4)

# Informations

The project has been built with tailwindcss and uses
- Postgresql
- Redis (for async jobs)
- Elastisearch (for searches)
- Minio (for assets storage)

## Dependencies
- `active storage` for assets storage on minio with S3 protocols
- `haml`
- `countries` gem (for i18n and more)
- `draper` for decorators
- `loaf` for breadcrumbs
- `pagy` for paginations
- `searchkick` for searchs with elasticsearch
- `gruf` for gRPC client/server
- `dotenv` for env load
- `faker` for fake data loadings
- `factory_bot` for test factories

Wines dataset has been fetched from https://github.com/rogerioxavier/X-Wines

The gRPC service is running by default on `0.0.0.0:50051`

It works along two other projects:

## Protos

https://github.com/wineskills/protos

A repository to store and share gRPC protos with the platform and the ruby-client repositories.

## Ruby client

https://github.com/wineskills/ruby-client

The ruby client is a gem ready to consume the API through gRPC.

The client has been deployed on Rubygems: https://rubygems.org/gems/wineskills

# Prerequisites

- Docker with composer
- Ruby 3.3.4
- Rails 7.2.0

# Start

## Server

```bash
git clone https://github.com/wineskills/platform
cd platform
docker compose up -d # wait 10s until elasticsearch is ready
rake db:prepare

./bin/dev
open "http://localhost:3000"
```

## Client

From the project sources:

```bash
git clone https://github.com/wineskills/ruby-client
cd ruby-client
gem build wineskills.gemspec
gem install wineskills-0.1.0.gem

# Fetch all wines
GRPC_SERVICES_URL=127.0.0.1:50051 wineskills wines
```

From Rubygems: https://rubygems.org/gems/wineskills
```bash
gem install wineskills # CURRENT VERSION=0.1.1

# Fetch all wines
GRPC_SERVICES_URL=127.0.0.1:50051 wineskills wines

# Search wines
GRPC_SERVICES_URL=127.0.0.1:50051 wineskills search beef
```

# Tests

```bash
git clone https://github.com/wineskills/platform
cd platform
docker compose up -d # wait 10s until elasticsearch is ready

rails test
```

```bash
yarn install v1.22.22
[1/4] 🔍  Resolving packages...
success Already up-to-date.
✨  Done in 0.08s.
yarn run v1.22.22
$ esbuild app/javascript/*.* --bundle --sourcemap --format=esm --outdir=app/assets/builds --public-path=/assets

  app/assets/builds/application.js      261.9kb
  app/assets/builds/application.js.map  481.9kb

✨  Done in 0.33s.
yarn install v1.22.22
[1/4] 🔍  Resolving packages...
success Already up-to-date.
✨  Done in 0.05s.
yarn run v1.22.22
$ tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify

Rebuilding...

Done in 161ms.
✨  Done in 0.69s.
Running 15 tests in a single process (parallelization threshold is 50)
Run options: --seed 39652

# Running:

...............

Finished in 1.083148s, 13.8485 runs/s, 13.8485 assertions/s.
15 runs, 15 assertions, 0 failures, 0 errors, 0 skips
```

# What's next?
- [x] Add the ability to search wines via the API
- [ ] Add pagination on API
- [ ] Deploy the project and hard code the ruby client gRPC services url to it
- [ ] Deploy on minikube
