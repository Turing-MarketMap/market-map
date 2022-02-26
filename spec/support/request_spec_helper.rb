module RequestSpecHelper 
  def parse_json 
    JSON.parse(response.body, symbolize_names: true)
  end
end