FROM node:23-alpine AS builder
WORKDIR /app
COPY package*.json .
RUN npm ci
COPY . .
RUN npm run build
RUN npm prune --omit-dev

FROM node:23-alpine
WORKDIR /app
COPY --from=builder /app/build build/
COPY --from=builder /app/node_modules node_modules/
COPY package.json .
EXPOSE 3000
ENV HOST=0.0.0.0
ENV POST=3000
ENV NODE_ENV=production
CMD [ "node","build" ]
