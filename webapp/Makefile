PARCEL_ENTRYPOINT := src/index.html
PRETTIER_FILES := src/*.js

build:
	npm run parcel -- build $(PARCEL_ENTRYPOINT)

build-prod: clean env-prod build

build-staging: clean env-staging build

check:
	npm run prettier -- --check $(PRETTIER_FILES)

clean:
	rm -rf .cache/ dist/ .env

deploy: build-staging
	npm run wrangler -- publish

deploy-prod: build-prod
	npm run wrangler -- publish --env production

deps:
	npm ci

env:
	echo "API_URL=127.0.0.1:8080" > .env

env-prod:
	echo "API_URL=malvados-api.myhro.info" > .env

env-staging:
	echo "API_URL=malvados-api.myhro.net" > .env

lint:
	npm run eslint

prettier:
	npm run prettier -- --write $(PRETTIER_FILES)

serve:
	npm run serve

watch: clean env
	npm run parcel -- $(PARCEL_ENTRYPOINT)
