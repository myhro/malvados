PARCEL_FILES := src/index.html src/404.html

build:
	npx parcel build $(PARCEL_FILES)

check:
	npx prettier --check src/*.js

clean:
	rm -rf .parcel-cache/ dist/

deps:
	npm ci

lint:
	npx eslint src/*.js

prettier:
	npx prettier --write src/*.js

serve:
	npx serve dist/

watch: clean
	npx parcel $(PARCEL_FILES)
