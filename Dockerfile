FROM node:18-alpine AS builder
WORKDIR /app

ADD . .

RUN npm install
RUN wget https://gobinaries.com/tj/node-prune --output-document - | /bin/sh && node-prune

FROM node:18-alpine
WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder /app/ .

EXPOSE 8080
CMD ["server.js"]
