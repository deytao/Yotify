class AddTwrColumnsToPortfolios < ActiveRecord::Migration[5.2]
  def change
    add_column :portfolios, :last_twr_run_at, :date
    add_column :portfolios, :current_twr, :float, default: 0
  end
end
