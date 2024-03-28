# docker-utils

## Building

```bash
$ make
```

### Laravel

```bash
$ make laravel
```

#### Laravel — PHP 8.1

```bash
$ make laravel/8.1
```

#### Laravel — PHP 8.2

```bash
$ make laravel/8.2
```

#### Laravel — PHP 8.3

```bash
$ make laravel/8.3
```

## Publishing

### Laravel

#### Laravel — PHP 8.1

```bash
$ docker tag local/laravel:8.1 ntnp/laravel-dev:8.1
$ docker tag local/horizon:8.1 ntnp/laravel-horizon-dev:8.1
```

#### Laravel — PHP 8.2

```bash
$ docker tag local/laravel:8.2 ntnp/laravel-dev:8.2
$ docker tag local/horizon:8.2 ntnp/laravel-horizon-dev:8.2
```

#### Laravel — PHP 8.3

```bash
$ docker tag local/laravel:8.3 ntnp/laravel-dev:8.3
$ docker tag local/horizon:8.3 ntnp/laravel-horizon-dev:8.3
```
