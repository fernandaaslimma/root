FROM node:22-alpine as builder

WORKDIR /app

COPY . .

RUN npm install

RUN npm run build

FROM nginx:1.22.1

COPY --from=builder /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

COPY public/import.json /usr/share/nginx/html
COPY public/env-prod-monolito.js /usr/share/nginx/html
COPY public/env-front-version.js /usr/share/nginx/html
COPY public/dynatrace.js /usr/share/nginx/html
COPY public/hotjar.js /usr/share/nginx/html

COPY start.sh /usr/share/nginx/html

EXPOSE 9000

RUN ["chmod", "+x", "/usr/share/nginx/html/start.sh"]

CMD ["/usr/share/nginx/html/start.sh"]