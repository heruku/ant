defmodule World do
  @team_name "uku"
  @endpoint "127.0.0.1:8888"

  def join do
    HTTPotion.get("#{@endpoint}/join/#{@team_name}")
  end

  def spawn(nest_id) do
    %{body: body} = HTTPotion.get("#{@endpoint}/#{nest_id}/spawn")
    {:ok, response} = Eden.decode(body)
    response[:stat][:id]
  end

  def look(ant_id) do
    HTTPotion.get("#{@endpoint}/#{ant_id}/look")
  end

  def go(ant_id, direction) do
    %{body: body} = HTTPotion.get("#{@endpoint}/#{ant_id}/go/#{direction}")
    {:ok, response} = Eden.decode(body)

    [new_x, new_y] = Array.to_list(response[:stat][:location])
    got_food       = response[:stat][:"got-food"]
    %{location: {new_x, new_y}, got_food: got_food}
  end

  def stat(id) do
    HTTPotion.get("#{@endpoint}/#{id}/stat")
  end
end
