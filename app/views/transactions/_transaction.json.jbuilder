json.extract! transaction, :id, :price, :quantity, :holding_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
