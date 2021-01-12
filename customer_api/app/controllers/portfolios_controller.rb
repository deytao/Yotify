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

    url = '%sportfolios/%%s/positions' % Rails.configuration.api_client["url"]
    response = http_auth.get(url % params[:id])
    positions = JSON.parse response.body
    companies = {}
    positions.each do |position|
      position.delete("protfolio_id")
      company_id = position.delete("company_id")
      unless companies.key?(company_id)
        url = '%scompanies/%%s' % Rails.configuration.api_client["url"]
        response = http_auth.get(url % company_id)
        companies[company_id] = JSON.parse response.body
      end
      company = companies[company_id]
      position["company"] = {
        name: company["name"],
        ticker: company["ticker"],
      }
    end
    render json: positions, status: response.status
  end

  # GET /portfolios/1/twr
  def twr
    url = '%sportfolios/%%s/positions' % Rails.configuration.api_client["url"]
    response = http_auth.get(url % params[:id])
    positions = JSON.parse response.body

    companies = []
    positions.each do |position|
      company_id = position.delete("company_id")
      unless companies.key?(company_id)
        url = '%scompanies/%%s' % Rails.configuration.api_client["url"]
        response = http_auth.get(url % company_id)
        company = JSON.parse response.body
        company["weight"] = position["weight"].to_f
        companies << company
      end
    end

    companies.each do |company_id, company|
      url = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=%s&apikey=%s' % [
        company["ticker"],
        Rails.configuration.x.alphavantage_token,
      ]
      data = JSON.parse HTTP.get(url).body.to_s
      series = data["Time Series (Daily)"]
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
      company["weighted_return"] = company["rate_of_return"] * company["weight"]
      sleep 12
    end

    values = []
    companies.each do |company|
      values << company["weighted_return"]
    end

    render plain: values.reduce(:+).to_s
  end
end
