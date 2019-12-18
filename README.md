# rails-baseline

Files and folders with the initial customizations I always do after generating a fresh Rails 6 app. I could list the differences and assumptions here but it's probably easier just to look at the files. Only files with differences from the default Rails files are included. Lockfiles and build outputs are omitted.

## Usage

You can use rsync to merge files in this project into a target Rails project.

```
$ rsync -iazP /path/to/rails-baseline/baseline/ /path/to/rails/project/
```

Before you run rsync, I **strongly** recommend you `git commit` your target Rails project, so you can roll back.

After running rsync, you must do some housekeeping to ensure the pieces in the Rails project are connected:

```
# --- Check Git diff of Gemfile; ensure latest versions are used ---
$ bundle update
# --- Check Git diff of package.json; ensure latest versions are used ---
$ yarn install
$ yarn lint
$ yarn typecheck
$ yarn test
$ rubocop
# --- Fill in all the missing values (as needed) in the .env file ---
$ rails db:setup
$ rails db:migrate
$ rails test
# --- Don't forget to update your favicon ---
$ rails s
```

## Google Cloud Authentication

The `.env` file has entries for credentials for Google OAuth. To get these, go to the Google Cloud Platform console. Create a new project. Use the top-left navigation menu to find "APIs & Services". Go to "OAuth consent screen" and fill in an application name. Don't forget  to add your authorized domains (the domains you'll host this app on). Go to "Credentials" to create an OAuth client ID. Under "Authorized JavaScript origins" add your domains (don't forget `http://localhost:3000`). Under "Authorized redirect URIs" add the full callback URIs (don't forget `http://localhost:3000/users/auth/google_oauth2/callback`). Hit save. Grab the client ID and client secret and assign them in the `.env` file.

## Heroku Deployment

You will need admin access to a Heroku account. You will also need to [install the Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli#download-and-install). Once you have that, login to Heroku with your admin account credentials (first log in using your web browser, and then in your terminal do `$ heroku login`). Then, add Heroku as a git remote: `$ heroku git:remote --remote staging -a my-heroku-app-staging`. Once this is set up, you will need to ensure all the correct env vars from `.env` are assigned under "Settings > Config Vars" in the Heroku web console. You will also need to provision a Postgres database add-on (note: you shouldn't need to configure anything in the application code; it should "just work"). When you are ready to deploy, run `$ git push staging master`.

## License

Copyright 2019-2020 Matthew Trost

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
