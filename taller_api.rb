


parametros = {"inventory_item_ids" => "", "location_ids" => ""}
header = {"Content-Type" => "application/json" , "Accept" => "application/json"}


parametros = {}
url_base = "https://api-guarderia.herokuapp.com/api/"
url_base = url_base + "babies"
response = HTTParty.get("#{url_base}", :query => parametros, :headers =>header)






header = {"Content-Type" => "application/json" , "Accept" => "application/json"}


parametros = {"page"=>2}
baby_id = 5
url_base = "https://api-guarderia.herokuapp.com/api/"
url_base = url_base + "babies/#{baby_id}/activity_logs"
response = HTTParty.get("#{url_base}", :query => parametros, :headers =>header)
response.code
res = JSON.parse response.body
res.size






user = User.last

header = {"Content-Type" => "application/json" , "Accept" => "application/json", "Auth-Token"=> user.token, "User"=> user.nombre}

Time.zone = "Mexico City"
parametros = {"baby_id"=>4, "activity_id"=>2, "assistant_id"=>2, "start_time" => Time.now.in_time_zone}
baby_id = 5
url_base = "https://api-guarderia.herokuapp.com/api/"
url_base = url_base + "activity_logs"
response = HTTParty.post("#{url_base}", :query => parametros, :headers =>header)


response.code
res = JSON.parse response.body
res.size






user = User.last

header = {"Content-Type" => "application/json" , "Accept" => "application/json", "Auth-Token"=> user.token, "User"=> user.nombre}

Time.zone = "Mexico City"
parametros = {"baby_id"=>4, "activity_id"=>2, "assistant_id"=>2, "start_time" => Time.now.in_time_zone}

url_base = "https://api-guarderia.herokuapp.com/api/"
url_base = url_base + "activity_logs/102"
response = HTTParty.post("#{url_base}", :query => parametros, :headers =>header)


response.code
res = JSON.parse response.body
res.size