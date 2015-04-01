class StatisticsController < ApplicationController

  def index
    #Xmlstats authentication
    Xmlstats.api_key      = "9bd338e1-89ac-4748-9767-4e83051726e6"
    Xmlstats.contact_info = "rodriguez.reads@gmail.com"

    @Leaders = Xmlstats.nba_leaders(:points_per_game)

    @Teams = Xmlstats.nba_teams
    @Team_rosters =[]
    @Teams.each do |team|
      hash = team.team_id
      @Team_rosters << hash
    end 

    p @Team_rosters

    @Rosters = Xmlstats.nba_roster("atlanta-hawks")
   @Rosters.each do |roster|
    roster.display_name
   end

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
  end #index


  def player

    #NBA.com passes 
    @player_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=101108&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
     @player_passes

     a = @player_passes.body

     b = a["resultSets"]

     c = b[0] #gets all PassesMade from playerA to teammates

     d = c["headers"]

     e = c["rowSet"]

     g = e.each do |row|
      row.each do |item| 
         p item
      end
     end
#How do i do this so that the first row references playerA only, but the following nodes are teammates passed to
     keys_to_delete = ["TEAM_NAME", "TEAM_ID", "PASS_TYPE", "G", "FREQUENCY", "PASS", "FGM", "FGA", "FG_2PCT", "FG2M", "FG2A", "FG2_PCT", "FG3M", "FG3A", "FG3_PCT"]
     @data = []
      "ZIPPING!!"
     e.each do |row|
      hash = Hash[*d.zip(row).flatten]
      keys_to_delete.each do |key|
        hash.delete(key)
      end
      @data << hash 
     end
      "DATA:"
      @data

     #team roster with hardcoded team id
     client = NbaStats::Client.new
     my_resource = client.common_team_roster("1610612746","2014-15")
     my_result_set = my_resource.common_team_roster
     my_row = my_result_set[0]
     
     @rosters = my_result_set
      @rosters.each do |roster|
      roster[:player]
      end

      @player_game_log = Unirest.get("http://stats.nba.com/stats/playergamelog?LeagueID=00&PlayerID=101108&Season=2014-15&SeasonType=Regular+Season")

      a = @player_game_log.body

      b = a["resultSets"]
      p b

      c = b[0]
      p c

      d = c["headers"]

      e = c["rowSet"]

      @player_game_log_data = []
       "ZIPPING!!"
      e.each do |row|
       hash = Hash[*d.zip(row).flatten]
       keys_to_delete.each do |key|
         hash.delete(key)
       end
       @player_game_log_data << hash 
      end
       "DATA:"
       p @player_game_log_data

  end #player

  def team
    paul_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=101108&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    p paul_passes

    ta = paul_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @pauldata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @pauldata << hash
    end
    p "paul data"
    p @pauldata

    griffin_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=201933&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = griffin_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @griffindata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @griffindata << hash
    end
    p "griffin data"
    p @griffindata

    reddick_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=200755&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = reddick_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @reddickdata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @reddickdata << hash
    end
    p "reddick data"
    p @reddickdata

    jordan_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=201599&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = jordan_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @jordandata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @jordandata << hash
    end
    p "jordan data"
    p @jordandata

    barnes_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=2440&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = barnes_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @barnesdata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @barnesdata << hash
    end
    p "barnes data"
    p @barnesdata

    crawford_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=2037&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = crawford_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @crawforddata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @crawforddata << hash
    end
    p "crawford data"
    p @crawforddata

    hawes_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=201150&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = hawes_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @hawesdata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @hawesdata << hash
    end
    p @hawesdata

    davis_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=201175&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = davis_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @davisdata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @davisdata << hash
    end
    p @davisdata

    rivers_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=203085&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = rivers_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @riversdata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @riversdata << hash
    end
    p @riversdata

    turkoglu_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=2045&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = turkoglu_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @turkogludata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @turkogludata << hash
    end
    p @turkogludata

    hamilton_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=202706&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = hamilton_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @hamiltondata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @hamiltondata << hash
    end
    p @hamiltondata

    bullock_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=203493&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = bullock_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @bullockdata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @bullockdata << hash
    end
    p @bullockdata

    farmar_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=200770&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = farmar_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @farmardata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @farmardata << hash
    end
    p @farmardata

    jones_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=2563&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = jones_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @jonesdata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @jonesdata << hash
    end
    p @jonesdata

    robinson_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=101126&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = robinson_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @robinsondata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @robinsondata << hash
    end
    p @robinsondata

    droberts_passes = Unirest.get("http://stats.nba.com/stats/playerdashptpass?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&Month=0&OpponentTeamID=0&Outcome=&PerMode=Totals&Period=0&PlayerID=201604&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=0&VsConference=&VsDivision=")
    ta = droberts_passes.body
    tb = ta["resultSets"]
    p "result sets"
    p tb
    tc = tb[0]
    p "array0"
    p tc
    td= tc["headers"]
    te= tc["rowSet"]

    @drobertsdata =[]
    te.each do |row|
      hash = Hash[*td.zip(row).flatten]
      @drobertsdata << hash
    end
    p @drobertsdata
    # team_data = []
    # tb.each do |array| #Eaches through resultSet, which is two hashes: PassesMade and PassesReceived
    #   p "NEW"
    #   p array 
    #   array.each do |item|
    #     p item
    #   end

    # end
    # p team_data




   end #team
     
  

end #class
