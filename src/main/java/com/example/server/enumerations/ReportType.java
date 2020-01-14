package com.example.server.enumerations;

import java.util.List;

import static com.example.server.enumerations.Column.*;

public enum ReportType {
    BATTING(
        "player_batting_innings_details",
        List.of(INDEX, PLAYER_NAME, OPPOSITION, POSITION, RUNS, DELIVERIES, FOURS, SIXES, WICKET_TYPE,
            STRIKE_RATE_BAT, TEAM_TOTAL, PERCENT_TOTAL_VALUE, PERCENT_TOTAL_DISPLAY),
        List.of(RUNS, STRIKE_RATE_BAT),
        List.of(INDEX, GROUP_TERM, INNINGS, DELIVERIES, RUNS, FOURS, SIXES, WICKETS_BATTING, AVERAGE_BAT_VALUE,
            AVERAGE_BAT_DISPLAY),
        List.of(RUNS, STRIKE_RATE_BAT)
    ),
    BOWLING(
        "player_bowling_innings_details",
        List.of(INDEX, PLAYER_NAME, OPPOSITION, RUNS, DELIVERIES, WICKETS_BOWLING, ECONOMY,
            AVERAGE_BOWL_VALUE, AVERAGE_BOWL_DISPLAY, STRIKE_RATE_BOWL, WIDES, NO_BALLS),
        List.of(WICKETS_BOWLING, ECONOMY),
        List.of(INDEX, GROUP_TERM, INNINGS, DELIVERIES, WICKETS_BOWLING, ECONOMY, RUNS, MAIDENS, AVERAGE_BOWL_VALUE,
            AVERAGE_BOWL_DISPLAY, STRIKE_RATE_BOWL, WIDES, NO_BALLS),
        List.of(WICKETS_BOWLING, ECONOMY)
    ),
  ;

  public final String dbTableName;
  public final List<Column> columns;
  public final List<Column> orderColumns;
  public final List<Column> groupColumns;
  public final List<Column> groupOrderColumns;

  ReportType(String dbTableName, List<Column> columns, List<Column> orderColumns, List<Column> groupColumns,
             List<Column> groupOrderColumns) {
    this.dbTableName = dbTableName;
    this.columns = columns;
    this.orderColumns = orderColumns;
    this.groupColumns = groupColumns;
    this.groupOrderColumns = groupOrderColumns;
  }
}
