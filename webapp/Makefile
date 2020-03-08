PRETTIER_FILES := src/*.js

check:
	npm run prettier -- --check $(PRETTIER_FILES)

clean:
	rm -rf .cache/ dist/ .env

deps:
	npm ci

env:
	echo "API_URL=127.0.0.1:8080" > .env

lint:
	npm run eslint

prettier:
	npm run prettier -- --write $(PRETTIER_FILES)

serve:
	npm run serve

watch: clean env
	npm run parcel -- src/index.html
