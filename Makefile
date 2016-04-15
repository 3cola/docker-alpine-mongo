VERSION = 3.2.4-1
IMAGE = 3cola/alpine-mongo

all: image publish

latest: image-latest publish-latest

image-latest:
	docker build -t $(IMAGE):latest --no-cache .

publish-latest:
	docker push $(IMAGE):latest

image:
	docker build -t $(IMAGE):$(VERSION) --no-cache .

publish:
	docker push $(IMAGE):$(VERSION)
