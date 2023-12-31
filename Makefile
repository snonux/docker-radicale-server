build:
	docker build -t radicale .
run:
	if [ ! -d collections ]; then mkdir collections; fi
	if [ ! -d auth ]; then mkdir auth; fi
	cp -v htpasswd-test auth/htpasswd
	sh -c 'docker rm radicale; exit 0'
	docker run \
		-v collections:/collections \
		-v auth:/auth \
		-p 5232:5232 \
		--name radicale radicale
br: build run
