#I can tag different steps (phases) to call them in another phase
FROM node:19-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm i
COPY . .
RUN npm run build

FROM nginx
#specifies that I want to copy the /app/build folder from the builder phase, the /usr/share/nginx/html is the default path from nginx to serve static HTML files\
#the default command for the nginx image is going to run nginx so I don't have to run any command
COPY --from=builder /app/build /usr/share/nginx/html