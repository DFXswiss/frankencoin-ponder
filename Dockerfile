FROM node:20-alpine

WORKDIR /app

# Install dependencies including devDependencies: the postinstall hook runs
# patch-package (patches/ponder+0.16.6.patch), which is a devDependency. A
# `--production` install would drop it and break the build.
COPY package.json yarn.lock ./
COPY patches ./patches
RUN yarn install --frozen-lockfile

# Application sources
COPY . .

# Ponder's default HTTP / GraphQL port. The deployment stack overrides it
# explicitly via the PORT env var (the DFX stacks run it on 3000).
EXPOSE 42069

CMD ["yarn", "start"]
