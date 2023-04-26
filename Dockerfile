#FROM node:16-alpine 

#WORKDIR /app

#COPY . .

#RUN npm ci 

#RUN npm run build

#EXPOSE 3000

#CMD [ "npx", "serve", "build" ]

# ==== SEGUNDO MÉTODO ==== 

 FROM node:16-alpine as build-step

 WORKDIR /app

 COPY package.json /app/

 RUN npm i

 COPY . /app

 RUN npm run build

# ========================================
# NGINX STAGE
# ========================================

 FROM nginx:1.23-alpine 

 WORKDIR /usr/share/nginx/html/

 COPY --from=build-step /app/build ./

 CMD [ "nginx", "-g", "daemon off;" ]