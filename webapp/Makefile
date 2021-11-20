API_URL ?= 127.0.0.1:8080

build: env
	npx parcel build src/index.html

check:
	npx prettier --check src/*.js

clean:
	rm -rf .cache/ dist/ .env

deps:
	npm ci

env:
	echo "API_URL=$(API_URL)" > .env

lint:
	npx eslint src/*.js

prettier:
	npx prettier --write src/*.js

serve:
	npx serve dist/

watch: clean env
	npx parcel src/index.html
