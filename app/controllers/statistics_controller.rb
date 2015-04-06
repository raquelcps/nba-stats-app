class StatisticsController < ApplicationController

  def index
    #Xmlstats authentication
    # Xmlstats.api_key      = "9bd338e1-89ac-4748-9767-4e83051726e6"
    # Xmlstats.contact_info = "rodriguez.reads@gmail.com"

    # @PtsLeaders = Xmlstats.nba_leaders(:points_per_game)

    # @Teams = Xmlstats.nba_teams
    # @Team_rosters =[]
    # @Teams.each do |team|
    #   hash = team.team_id
    #   @Team_rosters << hash
    # end 
# Deleted from index view
    # <% @Teams.each do |team| %>
    # <li><%= team.full_name %></li>
    # <% end %>

   #  @Rosters = Xmlstats.nba_roster("atlanta-hawks")
   # @Rosters.each do |roster|
   #  roster.display_name
   # end

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
      end
    end
#League leaders (players)
    leaders_all = Unirest.get("http://stats.nba.com/stats/homepagev2?GameScope=Season&LeagueID=00&PlayerOrTeam=Player&PlayerScope=All+Players&Season=2014-15&SeasonType=Regular+Season&StatType=Traditional")

    a = leaders_all.body
    b = a["resultSets"]
    p "RESULT SETS"
    p b
    #Points first in array
    c = b[0] 
    p c
    d = c["headers"]
    e = c["rowSet"] 
    #Rebounds
    f = b[1]
    g = f["headers"]
    h = f["rowSet"]
    #Assists
    i = b[2]
    j = i["headers"]
    k = i["rowSet"]
    #Steals
    l = b[3]
    m = l["headers"]
    n = l["rowSet"]
    #Blocks
    o = b[7]
    p = o["headers"]
    q = o["rowSet"]
   
    @Pointsdata = []
     "ZIPPING!!"
    e.each do |row|
     hash = Hash[*d.zip(row).flatten]
     @Pointsdata << hash 
    end
    p "Points DATA:"
    p @Pointsdata

    name_array = []
    points_array = []
    teamid_array = []
    playerid_array = []
    @Pointsdata.each do |row|
      name_array << row["PLAYER"]
      points_array << row["PTS"]
      playerid_array << row["PLAYER_ID"]
      teamid_array << row["TEAM_ID"]
    end

    @pts_bar = LazyHighCharts::HighChart.new('pts_leader_chart') do |f|
     
      f.series(:name=>'Points',:data=>points_array )     
      f.title({ :text=>"Points Per Game - Player"})
      f.legend({
         enabled: false
       }) 
       f.xAxis({
         allowDecimals: false,
         categories: name_array
       }) 
       f.tooltip({
         pointFormat: '{series.name}: <b style="color:{series.color}">{point.y}</b><br/>',
         shared: true
       })
        #  Options for Bar
         f.options[:chart][:defaultSeriesType] = "column"
      end #Points

    @Reboundsdata = []
     "ZIPPING!!"
    h.each do |row|
     hash = Hash[*g.zip(row).flatten]
     @Reboundsdata << hash 
    end

    name_array = []
    rebounds_array = []
    teamid_array = []
    playerid_array = []
    @Reboundsdata.each do |row|
      name_array << row["PLAYER"]
      rebounds_array << row["REB"]
      playerid_array << row["PLAYER_ID"]
      teamid_array << row["TEAM_ID"]
    end

    @reb_bar = LazyHighCharts::HighChart.new('reb_leader_chart') do |f|
     
      f.series(:name=>'Rebounds',:data=>rebounds_array )     
      f.title({ :text=>"Rebounds Per Game-Player"})
      f.legend({
         enabled: false
       }) 
       f.xAxis({
         allowDecimals: false,
         categories: name_array
       }) 
       f.tooltip({
         pointFormat: '{series.name}: <b style="color:{series.color}">{point.y}</b><br/>',
         shared: true
       })
        #  Options for Bar
         f.options[:chart][:defaultSeriesType] = "column"
      end   #Rebounds

    @Assistsdata = []
     "ZIPPING!!"
    k.each do |row|
     hash = Hash[*j.zip(row).flatten]
     @Assistsdata << hash 
    end

    name_array = []
    assists_array = []
    teamid_array = []
    playerid_array = []
    @Assistsdata.each do |row|
      name_array << row["PLAYER"]
      assists_array << row["AST"]
      playerid_array << row["PLAYER_ID"]
      teamid_array << row["TEAM_ID"]
    end

    @ast_bar = LazyHighCharts::HighChart.new('ast_leader_chart') do |f|
     
      f.series(:name=>'Assists',:data=>assists_array)     
      f.title({ :text=>"Assists"})
      f.legend({
         enabled: false
       }) 
       f.xAxis({
         allowDecimals: false,
         categories: name_array
       }) 
       # f.plot_options({:column=>{:stacking=>"normal"}})
     
       f.tooltip({
         pointFormat: '{series.name}: <b style="color:{series.color}">{point.y}</b><br/>',
         shared: true
       })
        #  Options for Bar
         f.options[:chart][:defaultSeriesType] = "column"
      end   #Assists

    @Stealsdata = []
     "ZIPPING!!"
    n.each do |row|
     hash = Hash[*m.zip(row).flatten]
     @Stealsdata << hash 
    end

    name_array = []
    steals_array = []
    teamid_array = []
    playerid_array = []
    @Stealsdata.each do |row|
      name_array << row["PLAYER"]
      steals_array << row["STL"]
      playerid_array << row["PLAYER_ID"]
      teamid_array << row["TEAM_ID"]
    end
p name_array
    @stl_bar = LazyHighCharts::HighChart.new('stl_leader_chart') do |f|
     
      f.series(:name=>'Steals',:data=>steals_array )     
      f.title({ :text=>"Steals"})
      f.legend({
         enabled: false
       }) 
       f.xAxis({
         allowDecimals: false,
         categories: name_array
       }) 
       f.tooltip({
         pointFormat: '{series.name}: <b style="color:{series.color}">{point.y}</b><br/>',
         shared: true
       })
        #  Options for Bar
         f.options[:chart][:defaultSeriesType] = "column"
      end #Steals

    @Blocksdata = []
     "ZIPPING!!"
    q.each do |row|
     hash = Hash[*p.zip(row).flatten]
     @Blocksdata << hash 
    end

    name_array = []
    blocks_array = []
    teamid_array = []
    playerid_array = []
    @Blocksdata.each do |row|
      name_array << row["PLAYER"]
      blocks_array << row["BLK"]
      playerid_array << row["PLAYER_ID"]
      teamid_array << row["TEAM_ID"]
    end

    @blk_bar = LazyHighCharts::HighChart.new('blk_leader_chart') do |f|
     
      f.series(:name=>'Blocks',:data=>blocks_array, :color=>"#57579C" )     
      f.title({ :text=>"Blocks"})
      f.legend({
         enabled: false
       }) 
       f.xAxis({
         allowDecimals: false,
         categories: name_array
       }) 
       f.tooltip({
         pointFormat: '{series.name}: <b style="color:{series.color}">{point.y}</b><br/>',
         shared: true
       })
        #  Options for Bar
         f.options[:chart][:defaultSeriesType] = "column"
    end #Blocks
  end #index

  def leadersmonthly
    leaders_all = Unirest.get("http://stats.nba.com/stats/homepagev2?GameScope=Season&LeagueID=00&PlayerOrTeam=Player&PlayerScope=All+Players&Season=2014-15&SeasonType=Regular+Season&StatType=Traditional")

    a = leaders_all.body
    b = a["resultSets"]
    p "RESULT SETS"
    p b

    c = b[0]
    p c

    d = c["headers"]
    e = c["rowSet"] 

    @Pointsdata = []
     "ZIPPING!!"
    e.each do |row|
     hash = Hash[*d.zip(row).flatten]
     # keys_to_delete.each do |key|
     #   hash.delete(key)
     # end
     @Pointsdata << hash 
    end
    p "Points DATA:"
    p @Pointsdata

    @name_array = []
    @points_array = []
    @teamid_array = []
    @playerid_array = []
    @Pointsdata.each do |row|
      @name_array << row["PLAYER"]
      @points_array << row["PTS"]
      @playerid_array << row["PLAYER_ID"]
      @teamid_array << row["TEAM_ID"]
    end
    p @teamid_array


     player0_dashboard_month = Unirest.get("http://stats.nba.com/stats/playerdashboardbygeneralsplits?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=#{@playerid_array[0]}&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&VsConference=&VsDivision=")
     
     a = player0_dashboard_month.body
     b = a["resultSets"]
     
     c = b[3] #specific array for month data
     
     d = c["headers"]
     e = c["rowSet"]

     @Player0Monthdata = []
      "ZIPPING!!"
     e.each do |row|
      hash = Hash[*d.zip(row).flatten]
      # keys_to_delete.each do |key|
      #   hash.delete(key)
      # end
      @Player0Monthdata << hash 
     end
     p "Month DATA:"
     p @Player0Monthdata
  #highchart test 2
     player0_pts_array = []
     player0_reb_array = []
     player0_ast_array = []
     player0_stl_array = []
     player0_blk_array = []
     @Player0Monthdata.each do |month|
      player0_pts_array << month["PTS"]
      player0_reb_array << month["REB"]
    end
  p player0_pts_array

     @chart = LazyHighCharts::HighChart.new('pts_line') do |f|
       f.chart({ type: 'line',
                 marginRight: 130,
                 marginBottom: 25 })
       f.title({  text: 'Monthly Average Scoring',
                  x: -20
       })
       # f.data({
       #  table: 'ptstable'
       #  })
       f.xAxis({
          categories: ['Oct', 'Nov', 'Dec','Jan', 'Feb', 'Mar', 'Apr'],
       })
       f.yAxis({
         # title: {
         #   text: 'Temperature (°C)'
         # },
         plotLines: [{
           value: 0,
           width: 1,
           color: '#808080'
         }]
       })
       # f.tooltip({
       #   valueSuffix: '°C'
       # })
       f.legend({
         layout: 'vertical',
         align: 'right',
         verticalAlign: 'top',
         x: -10,
         y: 10,
         borderWidth: 0
       })
       # f.subtitle({
       #   text: 'Source: WorldClimate.com',
       #   x: -20
       # })
       f.series({
         name: "Points",
         data: player0_pts_array
       })
       f.series({
        name: "Rebounds",
        data: player0_reb_array   
        })
     end

  end #end leadersmonthly

  def player
#NBA.com common player data
    player_data = Unirest.get("http://stats.nba.com/stats/commonplayerinfo?LeagueID=00&PlayerID=101108&SeasonType=Regular+Season")

    a = player_data.body
    b = a["resultSets"]
    c = b[0]
    d = c["headers"]
    e = c["rowSet"]

    @playerdata = []
     "ZIPPING!!"
    e.each do |row|
     hash = Hash[*d.zip(row).flatten]
     
     @playerdata << hash 
    end
    p "player DATA:"
    p @playerdata
#NBA.com player dashboard totals
    player_dashboard_totals = Unirest.get("http://stats.nba.com/stats/playerdashboardbygeneralsplits?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlayerID=101108&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&VsConference=&VsDivision=")
    a = player_dashboard_totals.body
    b = a["resultSets"]
    
    c = b[0] #specific array for totals
    
    d = c["headers"]
    e = c["rowSet"]

    @PlayerTotalsdata = []
     "ZIPPING!!"
    e.each do |row|
     hash = Hash[*d.zip(row).flatten]
     # keys_to_delete.each do |key|
     #   hash.delete(key)
     # end
     @PlayerTotalsdata << hash 
    end
    p "totals DATA:"
    p @PlayerTotalsdata
#Player monthly data
      player_dashboard_month = Unirest.get("http://stats.nba.com/stats/playerdashboardbygeneralsplits?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerID=101108&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&VsConference=&VsDivision=")
      a = player_dashboard_month.body
      b = a["resultSets"]

      c = b[3] #specific array for monthly avg

      d = c["headers"]
      e = c["rowSet"]
       @PlayerMonthdata = []
        "ZIPPING!!"
       e.each do |row|
        hash = Hash[*d.zip(row).flatten]
        # keys_to_delete.each do |key|
        #   hash.delete(key)
        # end
        @PlayerMonthdata << hash 
       end
       p "Month DATA:"
       p @PlayerMonthdata
    #highchart test 2
       player_pts_array = []
       player_reb_array = []
       player_ast_array = []
       player_stl_array = []
       player_blk_array = []
       @PlayerMonthdata.each do |month|
        player_pts_array << month["PTS"]
        player_reb_array << month["REB"]
        player_ast_array << month["AST"]
        player_stl_array << month["STL"]
        player_blk_array << month["BLK"]
      end

       @monthchart = LazyHighCharts::HighChart.new('pts_line') do |f|
         f.chart({ type: 'line',
                   marginRight: 130,
                   marginBottom: 25 })
         f.title({  text: 'Monthly Averages',
                    x: -20
         })
         # f.data({
         #  table: 'ptstable'
         #  })
         f.xAxis({
            categories: ['Oct', 'Nov', 'Dec','Jan', 'Feb', 'Mar', 'Apr'],
         })
         f.yAxis({
           # title: {
           #   text: 'Temperature (°C)'
           # },
           plotLines: [{
             value: 0,
             width: 1,
             color: '#808080'
           }]
         })
         # f.tooltip({
         #   valueSuffix: '°C'
         # })
         f.legend({
           layout: 'vertical',
           align: 'right',
           verticalAlign: 'top',
           x: -10,
           y: 10,
           borderWidth: 0
         })
         # f.subtitle({
         #   text: 'Source: WorldClimate.com',
         #   x: -20
         # })
         f.series({
           name: "Points",
           data: player_pts_array
         })
         f.series({
          name: "Rebounds",
          data: player_reb_array   
          })
         f.series({
          name: "Assists",
          data: player_ast_array   
          })
         f.series({
          name: "Steals",
          data: player_stl_array   
          })
         f.series({
          name: "Blocks",
          data: player_blk_array   
          })
       end

#NBA.com player's team data
    player_team_data = Unirest.get("http://stats.nba.com/stats/teamdashboardbygeneralsplits?DateFrom=&DateTo=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Base&Month=0&OpponentTeamID=0&Outcome=&PaceAdjust=N&PerMode=Totals&Period=0&PlusMinus=N&Rank=N&Season=2014-15&SeasonSegment=&SeasonType=Regular+Season&TeamID=#{@playerdata[0]["TEAM_ID"]}&VsConference=&VsDivision=")
    p "TEAM PLAYER DATA"
    p player_team_data
    a = player_team_data.body
    b = a["resultSets"]
    c = b[0] #overall team dashboard
    d = c["headers"]
    e = c["rowSet"]

    @playerteamdata = []
     "ZIPPING!!"
    e.each do |row|
     hash = Hash[*d.zip(row).flatten]
     
     @playerteamdata << hash 
     end
    p "player team DATA:"
    p @playerteamdata

#NBA.com passes made 
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
     keys_to_delete = ["TEAM_NAME", "TEAM_ID", "PASS_TYPE", "G", "FREQUENCY", "PASS"]
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

# player passes received

      recc = b[1] #gets all PassesReceived by playerA from teammates

      recd = recc["headers"]

      rece = recc["rowSet"]

      # g = e.each do |row|
      #  row.each do |item| 
      #     p item
      #  end
      # end

      @ReceivedData = []
       p "ZIPPING!!"
      rece.each do |row|
       hash = Hash[*d.zip(row).flatten]
       # keys_to_delete.each do |key|
       #   hash.delete(key)
       # end
       @ReceivedData << hash 
      end
       p "DATA:"
       p @ReceivedData

#team roster with hardcoded team id
     client = NbaStats::Client.new
     my_resource = client.common_team_roster("1610612746","2014-15")
     my_result_set = my_resource.common_team_roster
     my_row = my_result_set[0]
     
     @rosters = my_result_set
      @rosters.each do |roster|
      roster[:player]
      end
#player game log
      @player_game_log = Unirest.get("http://stats.nba.com/stats/playergamelog?LeagueID=00&PlayerID=101108&Season=2014-15&SeasonType=Regular+Season")

      a = @player_game_log.body

      b = a["resultSets"]
      p b

      c = b[0]
      
      d = c["headers"]

      e = c["rowSet"]

      @player_game_log_data = []
       "ZIPPING!!"
      e.each do |row|
       hash = Hash[*d.zip(row).flatten]
       # keys_to_delete.each do |key|
       #   hash.delete(key)
       # end
       @player_game_log_data << hash 
      end
       "DATA:"
       p @player_game_log_data
# Each thru player game log data to find key and values for highchart series
       pf_array = []
       to_array = []
       blk_array = []
       stl_array = []
       ast_array = []
       reb_array = []
       pts_array =[]
       opp_array = []
       @player_game_log_data.reverse.each do |game|
         pf_array << game["PF"]
         to_array << game["TOV"]
         blk_array << game["BLK"]
         stl_array << game["STL"]
         ast_array << game["AST"]
         reb_array << game["REB"]
         pts_array << game["PTS"]
         opp_array << game["MATCHUP"]
       end    

       #highchart test
       @bar = LazyHighCharts::HighChart.new('column') do |f|
        
         f.series(:name=>'PF',:data=>pf_array )     
         f.series(:name=>'TO',:data=>to_array )
         f.series(:name=>'BLK',:data=>blk_array )     
         f.series(:name=>'STL',:data=> stl_array, color: '#eee')
         f.series(:name=>'AST',:data=> ast_array )
         f.series(:name=>'REB',:data=> reb_array )
         f.series(:name=>'PTS',:data=>pts_array)

         f.title({ :text=>""})
         f.legend({
            align: 'right',
            verticalAlign: 'top',
            # x: -10,
            # y: 50,
            floating: false
          }) 
          f.xAxis({
            allowDecimals: false,
            title: {
              text: 'Games'
            }
            
          }) 
          f.tooltip({
            pointFormat: '{series.name}: <b style="color:{series.color}">{point.y}</b><br/>',
            shared: true
          })

           ## or options for column
           f.options[:chart][:defaultSeriesType] = "column"
           f.plot_options({:column=>{:stacking=>"normal"}})
         end  

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
