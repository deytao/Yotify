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
end
