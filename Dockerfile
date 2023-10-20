# Étape 1 : Utiliser une image Node.js pour construire l'application
FROM node:14 as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

# Étape 2 : Utiliser une image légère pour servir l'application
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

