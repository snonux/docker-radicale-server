TAG ?= latest

build:
	docker build -t radicale$(TAG) .
run: build
	if [ ! -d collections ]; then mkdir collections; fi
	if [ ! -d auth ]; then mkdir auth; fi
	cp -v htpasswd-test auth/htpasswd
	sh -c 'docker rm radicale; exit 0'
	docker run \
		-v collections:/collections \
		-v auth:/auth \
		-p 8080:8080 \
		--name radicale radicale$(TAG)
f3s: build
	docker tag radicale:$(TAG) r0.lan.buetow.org:30001/radicale:$(TAG)
	docker push r0.lan.buetow.org:30001/radicale:$(TAG)
f3s_external: build
	docker tag radicale:$(TAG) registry.f3s.buetow.org/radicale:$(TAG)
	docker push registry.f3s.buetow.org/radicale:$(TAG)
aws: build
	docker tag radicale$(TAG) 634617747016.dkr.ecr.eu-central-1.amazonaws.com/radicale$(TAG)
	docker push 634617747016.dkr.ecr.eu-central-1.amazonaws.com/radicale$(TAG)
