FROM node:lts-alpine

RUN apk --no-cache add curl \
    && mkdir /app && chown -R node:node /app

WORKDIR /app
USER node

COPY --chown=node . .
RUN yarn install --production --frozen-lockfile

CMD ["yarn", "start"]