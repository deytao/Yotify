FROM ruby:2.7

WORKDIR /app
ADD Gemfile* ./
RUN gem install bundler
RUN bundle install

ADD . ./

CMD ["bundle","exec","rails server"]
