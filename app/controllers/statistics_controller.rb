class StatisticsController < ApplicationController

  def index
    #Xmlstats authentication
    Xmlstats.api_key      = "cb66fd12-cead-4759-92d3-d3af7cff2de8"
    Xmlstats.contact_info = "rodriguez.reads@gmail.com"

    @Leaders = Xmlstats.nba_leaders(:points_per_game)

    #nba_stats
    client = NbaStats::Client.new
    my_resource = client.box_score("0021401000")
    my_result_set = my_resource.player_track
    @my_row =  my_result_set[0]
    # @my_item = @my_row[:spd]
    @my_speed = @my_row[:spd]
    @my_touches = @my_row[:tchs]
    @my_pass = @my_row[:pass]
    @my_assist = @my_row[:ast]

    @my_row.each do |row|
       row.each do |item|
         p item
      end
    end

    # p @my_row

    #NBA.com passes 

    player_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=101108&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    p player_passes

     a = player_passes.body
     # p a

     b = a["resultSets"]
     # p b

     c = b[0] #gets all PassesMade between playerA and teammates
     p c

     d = c["headers"]
     p d

     e = c["rowSet"]
     p  "e"
     p e

     g = e.each do |row|
      row.each do |item| 
         p item
      end
     end
    
    
  

     @f = Hash[*d.zip(e[0]).flatten]
     p @f
      # p @f["PLAYER_NAME_LAST_FIRST"]
      # p @f["PASS_TYPE"]
      # p @f["PASS_TO"]

     @h = Hash[*d.zip(e[1]).flatten] 
     p @h

      # g = Hash[*c["headers"].zip(c["rowSet"]).flatten]
      # p g

      # var nodes = [
      #   {id: 1, label: 'Paul,Chris'},
      #   {id: 2, label: 'Griffin, Blake'},
      #   {id: 3, label: 'Reddick, JJ'},
      #   {id: 4, label: 'Barnes, Matt'},
      #   {id: 5, label: 'Jordan, DeAndre'},
      #   {id: 6, label: 'Crawford, Jamal'},
      #   {id: 7, label: 'Hawes, Spencer'},
      #   {id: 8, label: 'Davis, Glen'},
      #   {id: 9, label: 'Rivers, Austin'},
      #   {id: 10, label: 'Turkoglu, Hedo'},
      #   {id: 11, label: 'Bullock, Reggie'},
      #   {id: 12, label: 'Farmar, Jordan'},
      #   {id: 13, label: 'Hamilton, Jordan'},
      #   {id: 14, label: 'Robinson, Nate'},
      #   {id: 15, label: 'Jones, Dahntay'},
      #   {id: 16, label: 'Douglas-Roberts, Chris'}
      # ];





   


  end

end
