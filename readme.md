# PHP 7.3 Laravel environment
Docker environment required to run Laravel 5.8 behind nginx and php-fpm, tested on Windows 10.

[Source code](https://github.com/dimadeush/docker-nginx-php-laravel.git)

## Tested on 
* Windows Desktop
* Docker engine version 19.03
* Docker compose version 1.24
* Windows 10

## Components:
1. Ubuntu 18.04
1. nginx/1.14.0 (Ubuntu)
2. PHP 7.3 fpm
3. MariaDB 10.2
4. Laravel 5.8
4. Node:latest

## Setting up DEV environment
1. Build images and start containers/networks/volumes from your terminal:
    ```
    ./develop start
    ```
2. Set key for application:
    ```
    ./develop art key:generate
    ```
3. Make sure that you have installed migrations/seeds:
    ```
    ./develop art migrate -seed
    ```
4. Run Composer:
    ```
    ./develop composer install
    ```
4. Run node and laravel mix:
    ```
    ./develop npm i && npm run prod
    ```
5. Run tests:
    ```
    ./develop test
    ```

## Additional main command available:
    ```
    ./develop stop
    ./develop gulp
    ./develop yarn
    ./develop bash

    ```
    


