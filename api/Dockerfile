FROM ruby:2.7

ENV TZ=Europe/Zurich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /app
ADD Gemfile* ./
RUN gem install bundler
RUN bundle install

ADD . ./

CMD ["bundle","exec","rails","server","-p","3000"]
