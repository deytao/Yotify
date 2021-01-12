require 'http'

class PortfoliosController < ApplicationController
  # GET /portfolios
  def index
    url = '%scustomers/%%s/portfolios' % Rails.configuration.api_client["url"]
    response = http_auth.get(url % current_user["customer_id"])
    data = JSON.parse response.body
    render json: data
  end

  # GET /portfolios/1
  def show
    url = '%sportfolios/%%s' % Rails.configuration.api_client["url"]
    response = http_auth.get(url % params[:id])
    portfolio = JSON.parse response.body

    url = '%sportfolios/%%s/wallet' % Rails.configuration.api_client["url"]
    response = http_auth.get(url % params[:id])
    wallet = JSON.parse response.body
    companies = {}
    wallet.each do |data|
      wallet.delete("protfolio_id")
      company_id = data.delete("company_id")
      data["base_value"] = portfolio["amount"] * data.delete("rate")
      unless companies.key?(company_id)
        url = '%scompanies/%%s' % Rails.configuration.api_client["url"]
        response = http_auth.get(url % company_id)
        companies[company_id] = JSON.parse response.body
      end
      company = companies[company_id]
      data["company"] = {
        name: company["name"],
        ticker: company["ticker"],
      }
    end
    render json: wallet, status: response.status
  end

  # GET /portfolios/1/twr
  def twr
    url = '%sportfolios/%%s/wallet' % Rails.configuration.api_client["url"]
    response = http_auth.get(url % params[:id])
    wallet = JSON.parse response.body

    companies = {}
    wallet.each do |data|
      company_id = data.delete("company_id")
      unless companies.key?(company_id)
        url = '%scompanies/%%s' % Rails.configuration.api_client["url"]
        response = http_auth.get(url % company_id)
        companies[company_id] = JSON.parse response.body
      end
    end

    companies.each do |company_id, company|
      url = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=%s&apikey=%s' % [
        company["ticker"],
        Rails.configuration.x.alphavantage_token,
      ]
      data = JSON.parse HTTP.get(url).body.to_s
      series = data["Time Series (Daily)"]
      unless series
        byebug
      end
      daily_rates_of_return = []
      ((Date.today - 30)..Date.yesterday).each do |day|
        serie = series[day.to_s]
        unless serie
          next
        end
        open_value = serie["1. open"].to_f
        close_value = serie["4. close"].to_f
        rate = (close_value - open_value) / open_value
        daily_rates_of_return << 1 + rate
      end
      company["rate_of_return"] = daily_rates_of_return.reduce(:*) - 1
    end

      render plain: companies[1]["rate_of_return"].to_s
  end
end
