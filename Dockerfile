FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Start base image
FROM nginx
# The expose is for aws elastic beanstalk to expose the port 80
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
