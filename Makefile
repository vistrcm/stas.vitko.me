.DEFAULT_GOAL := hugo

clean:
	rm -rf public

hugo: clean
	hugo

publish: clean hugo
	gsutil -m rsync -R -d public gs://stas.vitko.me && \
	gsutil -m acl ch -R -u AllUsers:R gs://stas.vitko.me
