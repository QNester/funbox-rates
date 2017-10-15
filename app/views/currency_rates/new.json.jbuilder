json.last_rate do
  json.rate @last_rate&.rate
  json.expire_date @last_rate&.force_until
end