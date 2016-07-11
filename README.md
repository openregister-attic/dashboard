# Dashboard

## Deployment

To setup fresh heroku deployment:

```sh
heroku create --region eu --org <org>

heroku apps:rename <name>

heroku addons:create mongolab:sandbox

heroku addons:destroy heroku-postgresql --confirm <name>

heroku config:set USER=<user> PASS=<pass>

git push heroku master

heroku open
