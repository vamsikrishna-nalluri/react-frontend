FROM node:alpine as builder
WORKDIR /app/temp
COPY ./package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

# nginx is a production compatible server.
FROM nginx
# use --from to refer to the previous builds
COPY --from=builder /app/temp/build /usr/share/nginx/html
