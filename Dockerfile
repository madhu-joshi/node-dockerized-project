FROM node:latest
WORKDIR /helloworld
ADD . .
RUN npm install
CMD [ "node", "index.js" ]