# app

## Setup

```

$ \curl -sSL https://get.rvm.io | bash -s stable
$ rvm install 2.6.4` (install Ruby 2.6.4)
$ rvm use 2.6.4
# => Using /Users/you/.rvm/gems/ruby-2.6.4
$ ruby -v
# => ruby 2.6.4
$ gem -v
# => 3.0.6
$ bundle -v
# => Bundler version 1.17.3
$ gem install rails -v 6.0.0
$ brew install postgres # 11.5_1
$ bundle
$ brew services start postgres
$ rails db:setup
$ rails db:migrate
$ RAILS_ENV=production bundle exec rails assets:precompile
$ rails s
$ yarn verify
```

## Deployment

```
$ heroku login
$ heroku git:remote --remote staging -a app-staging
$ heroku git:remote --remote production -a app-production
$ git push staging master
$ heroku ps --remote staging
$ heroku open --remote staging
$ heroku logs --tail --remote staging
```

### OAuth

Configure via the [Google Developers Console](https://console.developers.google.com/).
