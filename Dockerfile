#It will use node:19-alpine3.16 as the parent image for building the Docker image
FROM node:latest

EXPOSE 3000

CMD ["node", "app.js"]
