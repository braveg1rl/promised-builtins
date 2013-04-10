build:
	mkdir -p lib
	node_modules/.bin/coffee --compile -m --output lib/ src/

watch:
	node_modules/.bin/coffee --watch --compile --output lib/ src/
	
test:
	node_modules/.bin/mocha

jumpstart:
	npm install
	curl -u 'meryn' https://api.github.com/user/repos -d '{"name":"promised-builtins", "description":"Promises that somewhat act like the builtins that are promised.","private":false}'
	mkdir -p src
	touch src/promised-builtins.coffee
	mkdir -p test
	touch test/promised-builtins.coffee
	git init
	git remote add origin git@github.com:meryn/promised-builtins
	git add .
	git commit -m "jumpstart commit."
	git push -u origin master

.PHONY: test