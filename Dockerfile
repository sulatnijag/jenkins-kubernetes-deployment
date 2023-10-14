#It will use node:19-alpine3.16 as the parent image for building the Docker image
FROM node:19-alpine3.16

#It will create a working directory for Docker. The Docker image will be created in this working directory.
WORKDIR /react-app

RUN npm i

COPY . .

EXPOSE 3000

CMD ["node", "app.js"]