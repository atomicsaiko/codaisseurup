class AddDefaultValueToEvents < ActiveRecord::Migration[5.1]
  def change
    change_column_default :events, :price, from: nil, to: 0
    change_column_default :events, :includes_food, from: nil, to: false
    change_column_default :events, :includes_drinks, from: nil, to: false
    change_column_default :events, :active, from: nil, to: true
  end
end
