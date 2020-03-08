


parametros = {"inventory_item_ids" => "", "location_ids" => ""}
header = {"Content-Type" => "application/json" , "Accept" => "application/json"}


parametros = {}
url_base = "https://api-guarderia.herokuapp.com/api/"
url_base = url_base + "babies"
response = HTTParty.get("#{url_base}", :query => parametros, :headers =>header)





parametros = {"inventory_item_ids" => "", "location_ids" => ""}
header = {"Content-Type" => "application/json" , "Accept" => "application/json"}


parametros = {}
url_base = "https://api-guarderia.herokuapp.com/api/"
url_base = url_base + "activities"
response = HTTParty.get("#{url_base}", :query => parametros, :headers =>header)