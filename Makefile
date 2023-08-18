SHELL=/bin/zsh

all :
	make laravel

########################################

laravel :
	make laravel/8.1
	make laravel/8.2

laravel/8.1 :
	docker build -t local/laravel:8.1 -f src/laravel/8.1/Dockerfile --target=laravel src/laravel
	docker build -t local/horizon:8.1 -f src/laravel/8.1/Dockerfile --target=horizon src/laravel

laravel/8.2 :
	docker build -t local/laravel:8.2 -f src/laravel/8.2/Dockerfile --target=laravel src/laravel
	docker build -t local/horizon:8.2 -f src/laravel/8.2/Dockerfile --target=horizon src/laravel

########################################
