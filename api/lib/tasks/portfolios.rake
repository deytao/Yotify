namespace :portfolios do
  desc "Compute TWR for each portfolio that needs it"
  task :twr, [:date] => :environment do |t, args|
    run_date = args[:date] ? Date.parse(args[:date]) : Date.today
    puts 'TWR run #%s' % run_date

    message = Message.new do |m|
      m.subject = "New TWR for your portfolios"
      m.body = "Your portfolios have been updated with a new TWR, comme and see!"
      m.user = User.find_by(email: "yobot@yova.ch")
    end

    companies_rates = {}
    portfolios = Portfolio.where('last_twr_run_at < ?', run_date).or(Portfolio.where(last_twr_run_at: nil))
    portfolios.each do |portfolio|
      if message.new_record?
        message.save
      end
      puts '#### Start TWR for Portfolio'
      puts '## Name: %s' % portfolio.name
      puts '## Owner: %s' % portfolio.customer.name

      positions = Position.where(portfolio_id: portfolio.id)
      puts '## Nb of positions: %s' % positions.count()

      weighted_rates = []
      positions.each do |position|
        puts '## Fetching series for: %s' % position.company.name
        company_ticker = position.company.ticker
        unless companies_rates.key?(company_ticker)
          url = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=%s&apikey=%s' % [
            company_ticker,
            Rails.configuration.x.alphavantage_token,
          ]
          puts '# url: %s' % url
          data = JSON.parse HTTP.get(url).body.to_s
          series = data["Time Series (Daily)"]
          daily_rates_of_return = []
          ((run_date - 30)..(run_date - 1)).each do |day|
            serie = series[day.to_s]
            unless serie
              next
            end
            open_value = serie["1. open"].to_f
            close_value = serie["4. close"].to_f
            rate = (close_value - open_value) / open_value
            daily_rates_of_return << 1 + rate
          end
          puts '# reduce daily_rates: %s' % daily_rates_of_return.reduce(:*)
          rate_of_return = daily_rates_of_return.reduce(:*) - 1
          puts '# rate of return: %s' % (rate_of_return * position.weight)
          companies_rates[company_ticker] = rate_of_return
          sleep 15
        end
        rate_of_return = companies_rates[company_ticker]
        weighted_rates << (rate_of_return * position.weight)
      end

      portfolio.last_twr_run_at = run_date
      portfolio.current_twr = weighted_rates.reduce(:+)
      portfolio.save
      puts '# Data: %s' % weighted_rates.to_s
      puts 'TWR %s' % portfolio.current_twr

      Notification.create(
        message_id: message.id,
        customer_id: portfolio.customer.id,
        sent_at: DateTime.current,
      )
    end
  end

end
