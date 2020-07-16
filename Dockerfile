FROM node:alpine
WORKDIR /app/temp
# copied only package.json to avoid rebuilding the image because of source change
COPY ./package.json ./
RUN npm install
COPY ./ ./
# As this is not the final we can use RUN command
RUN npm run build

# nginx is a production compatible server.
FROM nginx
EXPOSE 80
# use --from to refer to the previous builds
COPY --from=0 /app/temp/build /usr/share/nginx/html
