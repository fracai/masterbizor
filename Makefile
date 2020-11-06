build:
	docker build . -t constructionsincongrues/masterbizor:latest

login:
	docker login

push: login
	docker push constructionsincongrues/masterbizor:latest