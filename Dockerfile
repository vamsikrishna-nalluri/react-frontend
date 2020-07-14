FROM node:alpine as builder
WORKDIR /app/temp
COPY ./package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

# nginx is a production compatible server.
FROM nginx
COPY --from=builder /app/temp/build /usr/share/nginx/html