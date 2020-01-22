package com.cbradbury.yaca.enumerations;

import java.util.List;

public enum ReportType {
    BATTING(
        "player_batting_innings_details",
        List.of(Column.INDEX, Column.PLAYER_NAME, Column.OPPOSITION, Column.POSITION, Column.RUNS, Column.DELIVERIES, Column.FOURS, Column.SIXES, Column.WICKET_TYPE,
            Column.STRIKE_RATE_BAT, Column.TEAM_TOTAL, Column.PERCENT_TOTAL_VALUE, Column.PERCENT_TOTAL_DISPLAY),
        List.of(Column.RUNS, Column.STRIKE_RATE_BAT),
        List.of(Column.INDEX, Column.GROUP_TERM, Column.INNINGS, Column.DELIVERIES, Column.RUNS, Column.FOURS, Column.SIXES, Column.WICKETS_BATTING, Column.AVERAGE_BAT_VALUE,
            Column.AVERAGE_BAT_DISPLAY),
        List.of(Column.RUNS, Column.STRIKE_RATE_BAT)
    ),
    BOWLING(
        "player_bowling_innings_details",
        List.of(Column.INDEX, Column.PLAYER_NAME, Column.OPPOSITION, Column.RUNS, Column.DELIVERIES, Column.WICKETS_BOWLING, Column.ECONOMY,
            Column.AVERAGE_BOWL_VALUE, Column.AVERAGE_BOWL_DISPLAY, Column.STRIKE_RATE_BOWL, Column.WIDES, Column.NO_BALLS),
        List.of(Column.WICKETS_BOWLING, Column.ECONOMY),
        List.of(Column.INDEX, Column.GROUP_TERM, Column.INNINGS, Column.DELIVERIES, Column.WICKETS_BOWLING, Column.ECONOMY, Column.RUNS, Column.MAIDENS, Column.AVERAGE_BOWL_VALUE,
            Column.AVERAGE_BOWL_DISPLAY, Column.STRIKE_RATE_BOWL, Column.WIDES, Column.NO_BALLS),
        List.of(Column.WICKETS_BOWLING, Column.ECONOMY)
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
