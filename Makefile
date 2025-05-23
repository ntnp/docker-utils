SHELL=/bin/zsh

all :
	make laravel

########################################

expo-builder :
	make build/expo-builder
	make tag/expo-builder
	make push/expo-builder

########################################

laravel :
	make build/laravel
	make tag/laravel
	make push/laravel

########################################

build/laravel :
	make build/laravel/8.1
	make build/laravel/8.2
	make build/laravel/8.3
	make build/laravel/8.4

tag/laravel :
	make tag/laravel/8.1
	make tag/laravel/8.2
	make tag/laravel/8.3
	make tag/laravel/8.4

push/laravel :
	make push/laravel/8.1
	make push/laravel/8.2
	make push/laravel/8.3
	make push/laravel/8.4

########################################

laravel/8.1 :
	make build/laravel/8.1
	make tag/laravel/8.1
	make push/laravel/8.1

laravel/8.2 :
	make build/laravel/8.2
	make tag/laravel/8.2
	make push/laravel/8.2

laravel/8.3 :
	make build/laravel/8.3
	make tag/laravel/8.3
	make push/laravel/8.3

laravel/8.4 :
	make build/laravel/8.4
	make tag/laravel/8.4
	make push/laravel/8.4

########################################
# Expo android builder

build/expo-builder :
	docker build -t local/expo-builder:52 -f src/expo-builder/52/Dockerfile src/expo-builder/52

tag/expo-builder :
	docker tag local/expo-builder:52 ntnp/expo-builder:52
	docker tag local/expo-builder:52 ntnp/expo-builder

push/expo-builder :
	docker push ntnp/expo-builder:52
	docker push ntnp/expo-builder

########################################
# PHP 8.1 for Laravel

build/laravel/8.1 :
	docker build -t local/laravel:8.1 -f src/laravel/8.1/Dockerfile --target=laravel src/laravel
	docker build -t local/horizon:8.1 -f src/laravel/8.1/Dockerfile --target=horizon src/laravel
	docker build -t local/reverb:8.1 -f src/laravel/8.1/Dockerfile --target=reverb src/laravel

tag/laravel/8.1 :
	docker tag local/laravel:8.1 ntnp/laravel-dev:8.1
	docker tag local/horizon:8.1 ntnp/laravel-horizon-dev:8.1
	docker tag local/reverb:8.1 ntnp/laravel-reverb-dev:8.1

push/laravel/8.1 :
	docker push ntnp/laravel-dev:8.1
	docker push ntnp/laravel-horizon-dev:8.1
	docker push ntnp/laravel-reverb-dev:8.1

########################################
# PHP 8.2 for Laravel

build/laravel/8.2 :
	docker build -t local/laravel:8.2 -f src/laravel/8.2/Dockerfile --target=laravel src/laravel
	docker build -t local/horizon:8.2 -f src/laravel/8.2/Dockerfile --target=horizon src/laravel
	docker build -t local/reverb:8.2 -f src/laravel/8.2/Dockerfile --target=reverb src/laravel

tag/laravel/8.2 :
	docker tag local/laravel:8.2 ntnp/laravel-dev:8.2
	docker tag local/horizon:8.2 ntnp/laravel-horizon-dev:8.2
	docker tag local/reverb:8.2 ntnp/laravel-reverb-dev:8.2

push/laravel/8.2 :
	docker push ntnp/laravel-dev:8.2
	docker push ntnp/laravel-horizon-dev:8.2
	docker push ntnp/laravel-reverb-dev:8.2

########################################
# PHP 8.3 for Laravel

build/laravel/8.3 :
	docker build -t local/laravel:8.3 -f src/laravel/8.3/Dockerfile --target=laravel src/laravel
	docker build -t local/horizon:8.3 -f src/laravel/8.3/Dockerfile --target=horizon src/laravel
	docker build -t local/reverb:8.3 -f src/laravel/8.3/Dockerfile --target=reverb src/laravel

tag/laravel/8.3 :
	docker tag local/laravel:8.3 ntnp/laravel-dev:8.3
	docker tag local/horizon:8.3 ntnp/laravel-horizon-dev:8.3
	docker tag local/reverb:8.3 ntnp/laravel-reverb-dev:8.3

push/laravel/8.3 :
	docker push ntnp/laravel-dev:8.3
	docker push ntnp/laravel-horizon-dev:8.3
	docker push ntnp/laravel-reverb-dev:8.3

########################################
# PHP 8.4 for Laravel

build/laravel/8.4 :
	docker build -t local/laravel:8.4 -f src/laravel/8.4/Dockerfile --target=laravel src/laravel
	docker build -t local/horizon:8.4 -f src/laravel/8.4/Dockerfile --target=horizon src/laravel
	docker build -t local/reverb:8.4 -f src/laravel/8.4/Dockerfile --target=reverb src/laravel

tag/laravel/8.4 :
	docker tag local/laravel:8.4 ntnp/laravel-dev:8.4
	docker tag local/horizon:8.4 ntnp/laravel-horizon-dev:8.4
	docker tag local/reverb:8.4 ntnp/laravel-reverb-dev:8.4

push/laravel/8.4 :
	docker push ntnp/laravel-dev:8.4
	docker push ntnp/laravel-horizon-dev:8.4
	docker push ntnp/laravel-reverb-dev:8.4

########################################
