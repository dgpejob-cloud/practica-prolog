FROM node:18-bookworm

RUN apt-get update && apt-get install -y swi-prolog

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "server.js"]