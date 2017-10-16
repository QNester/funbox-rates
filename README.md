# Funbox - текущий курс доллара

## Зависимости 

Для корректной работы необходимо:
 * Ruby 2.4.1 и bundler
 * PostgreSQL
 * Redis
 
## Установка

1. Необходимо склонировать проект:

    ```
    git clone git@github.com:QNester/funbox-rates.git
    cd funbox-rates
    bundle install
    ```

2. Необходимо создать файлы: `config/database.yml`, `config/secrets.yml`, `.env`. Все файлы можно создать
по их examples: `config/database.yml.example`, `config/secrets.yml.example`, `.env.example`. Файлы необходимо 
заполнить актуальными данными для вашего окружения.


3. Убедившись, что Redis и PostgreSQL запущены и работают, а конфигурации настроены правильно,
небходимо запустить следующие команды:
    ```   
     rails db:migrate
     rails db:seed
     foreman start
    ``` 

4. Зайти на `http://localhost:3000`

## Запуск в Docker
Так же, вы можете запустить приложение в Docker. Для этого вам необходимо:

1. Установить `docker` и `docker-compose`

2. Запустить приложений командой `docker-compose up --build`

3. Зайти на `http://localhost:3000`

ВНИМАНИЕ запуск тестов необходимо запускать НЕ в docker.

## Тесты

Для запуска тестов запустите:

`bundle exec rspec`
