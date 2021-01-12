namespace :portfolios do
  desc "Compute TWR for each portfolio that needs it"
  task :twr, [:date] => :environment do |t, args|
    puts 'TWR run #%s' % args[:date]
    run_date = Date.parse(args[:date])
    puts run_date
    portfolios = Portfolio.all
    #portfolios.each do |portfolio|
    portfolio = portfolios.first
      puts '#### Start TWR for Portfolio'
      puts '## Name: %s' % portfolio.name
      puts '## Owner: %s' % portfolio.customer.name

      positions = Position.where(portfolio_id: portfolio.id)
      puts '## Nb of positions: %s' % positions.count()

      #companies = []
      #positions.each do |position|
        #company_id = position.delete("company_id")
        #unless companies.key?(company_id)
          #url = '%scompanies/%%s' % Rails.configuration.api_client["url"]
          #response = http_auth.get(url % company_id)
          #company = JSON.parse response.body
          #company["weight"] = position["weight"].to_f
          #companies << company
        #end
      #end

      weighted_rates = []
      positions.each do |position|
        sleep 15
        puts '## Fetching series for: %s' % position.company.name
        url = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=%s&apikey=%s' % [
          position.company.ticker,
          Rails.configuration.x.alphavantage_token,
        ]
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
        rate_of_return = daily_rates_of_return.reduce(:*) - 1
        weighted_rates << (rate_of_return * position.weight)
      end
      puts '# Data: %s' % weighted_rates.to_s
      puts 'TWR %s' % values.reducs(:+)
    #end
  end

end
