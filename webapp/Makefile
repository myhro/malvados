API_URL ?= 127.0.0.1:8080
PARCEL_FILES := src/index.html src/404.html

build: env
	npx parcel build $(PARCEL_FILES)

check:
	npx prettier --check src/*.js

clean:
	rm -rf .parcel-cache/ dist/ .env

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
	npx parcel $(PARCEL_FILES)
