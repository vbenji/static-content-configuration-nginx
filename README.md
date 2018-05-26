# Static content configuration for nginx server

[![Build Status](https://travis-ci.org/vbenji/static-content-configuration-nginx.svg?branch=master)](https://travis-ci.org/vbenji/static-content-configuration-nginx)

Nginx configuration example to use native environment variable in static content

## Why

To find a relatively beautiful way to configuration front-end application served by Nginx server loaded client-side through OS environment variables on client-side.

The idea is to have a way of configuring projects by respecting best practices and to have an easy integration with the container world.

## How

By using a nginx module: ngx_http_perl_module.

This module is not included by default in the mainline docker image. you have to use the perl version of the docker image.

```Dockerfile
FROM nginx:1.14-alpine-perl
```

To configure nginx, you have to load the module:

```Nginx
load_module modules/ngx_http_perl_module.so;
```

Then you have to specify which environment variables you want to make available as nginx variables:

```Nginx
env NGINX_ENV_BACK_URL;
```

You define a perl variable for each of your environment variable:

```Nginx
perl_set $back_url 'sub { return $ENV{"NGINX_ENV_BACK_URL"}; }';
```

Next, you have to define an filter using the perl variable previously defined.

```Nginx
sub_filter '{{backUrl}}'  $back_url;
```

At last, you just have to use the new variable in your source code which will be substitute by the nginx server.

```html
<p>NGINX_ENV_BACK_URL environment variable : {{backUrl}}</p>
```

## Building and starting

__Requirements:__

- docker 17.09 or above
- docker-compose 1.17.1 or above

You can build the example like this:

```shell
docker-compose build
```

To start the example project:

```shell
docker-compose up
```

## Feedback

Feel free to contact me to share your own way to configure your static content.