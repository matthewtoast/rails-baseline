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
# --- Fill in all the missing values in the .env file ---
$ rails db:setup
$ rails db:migrate
$ rails test
$ rails s
# --- Don't forget to update your favicon ---
```

## Google Cloud

The `.env` file has entries for credentials for Google OAuth. To get these, go to the Google Cloud Platform console. Create a new project. Use the top-left navigation menu to find "APIs & Services". Go to "OAuth consent screen" and fill in an application name and authorized domains. Go to "Credentials" to create an OAuth client ID. Under "Authorized JavaScript origins" add your domains (don't forget `http://localhost:3000`). Under "Authorized redirect URIs" add the full callback URIs (don't forget `http://localhost:3000/users/auth/google_oauth2/callback`). Hit save. Grab the client ID and client secret and assign them in the `.env` file.

## License

Copyright 2019 Matthew Trost

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
