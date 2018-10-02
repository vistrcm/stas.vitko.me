.DEFAULT_GOAL := hugo
.PHONY: clean hugo publish publish_gs publish_s3 publish

clean:
	rm -rf public

hugo: clean
	hugo

publish_gs: clean hugo
	gsutil -m rsync -R -d public gs://stas.vitko.me && \
	gsutil -m acl ch -R -u AllUsers:R gs://stas.vitko.me

publish_s3: clean hugo
	aws s3 sync ./public/ s3://stas.vitko.me --delete

publish: publish_gs publish_s3
