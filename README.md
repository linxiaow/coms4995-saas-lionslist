# coms4995-saas-lionslist
COMS4995 Software As a Service project to design a platform to share information of second hand furniture and sublease

# Run

## Run locally
First, we need to install ruby environment

### check ruby version
```sh
# check your ruby version
# if it is not >= 2.6.6, < 2.7.0, please go to install ruby version sesion
ruby -v
```

### install ruby version to use bundle
```sh
# list the available Ruby versions.
rbenv install -l


# rbenv install --verbose 2.6.6 to install a specific version (2.6.6 in this example).
rbenv install --verbose 2.6.6

# Use rbenv global 2.6.6 to set the default Ruby version for your environment.
rbenv global 2.6.6

# Use ruby -v to verify that it is installed correctly.
ruby -v

```
if ruby global does not work, check the following link
- https://stackoverflow.com/questions/24736204/rbenv-cant-change-global-ruby-version/24736330

### Install Gem
Run `bundle install --without production` to make sure all gems are properly installed. NOTE: If Bundler complains that the wrong Ruby version is installed, verify that `rvm` is installed (for example, `rvm --version`) and say `rvm list` to see which Ruby versions are available and rvm useversion to make a particular version active. If no versions satisfying the Gemfile dependency are installed, you can say `rvm install` version to install a new version, then `rvm use` version to use it. Then you can try `bundle install` again.

### Create the initial database schema:

```shell
bundle exec rake db:migrate
bundle exec rake db:test:prepare
```

- You can optionally add some seed data in `db/seeds.rb` and run `rake db:seed` to add it.

## Start server
`rails server -b 0.0.0.0`

## Google OAuth
Refer to [user manual](manual/google-oauth/README.md)


## Use in Horeku
https://aqueous-plains-80871.herokuapp.com/posts


# How to run user story
User story resides in [features](https://github.com/linxiaow/coms4995-saas-lionslist/tree/main/features) folder

```sh
rake cucumber
```

# How to run rspec
User story resides in [spec](https://github.com/linxiaow/coms4995-saas-lionslist/tree/main/spec) folder

```sh
rake spec
```

# Github link
https://github.com/linxiaow/coms4995-saas-lionslist

# reference
- http://www.cs.columbia.edu/~junfeng/21fa-w4995/assignments.html#hw-setup

# Contributors ✨
Thanks goes to these wonderful people 

- Haoran Zhu (hz2712)
- Wujie Duan (wd2339)
- Oliva Zhang (xz2997)
- Linxiao Wu (lw2944)

<!-- Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)): -->

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<!-- <table>
  <tr>
    <td align="center"><a href="https://www.linkedin.com/in/ericacwei/"><img src="https://avatars0.githubusercontent.com/u/32824389?v=4" width="100px;" alt=""/><br /><sub><b>Chenchen(Erica) Wei</b></sub></a><br /><a href="https://github.com/gzhami/research_lab/commits?author=EricaWei053" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/jialiaz3"><img src="https://avatars1.githubusercontent.com/u/39682327?v=4" width="100px;" alt=""/><br /><sub><b>Jialiaz3</b></sub></a><br /><a href="#ideas-jialiaz3" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/linxiaow"><img src="https://avatars3.githubusercontent.com/u/43714531?v=4" width="100px;" alt=""/><br /><sub><b>Linxiao Wu</b></sub></a><br /><a href="https://github.com/gzhami/research_lab/issues?q=author%3Alinxiaow" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://www.linkedin.com/in/zihan-guo/"><img src="https://avatars1.githubusercontent.com/u/22876277?v=4" width="100px;" alt=""/><br /><sub><b>Zihan Guo</b></sub></a><br /><a href="https://github.com/gzhami/research_lab/commits?author=gzhami" title="Code">💻</a></td>
  </tr>
</table> -->

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->
