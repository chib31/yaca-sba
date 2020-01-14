package com.example.server.enumerations;

import com.example.server.utils.Utils;
import com.fasterxml.jackson.databind.node.ObjectNode;

import static com.example.server.enumerations.AggregateType.*;
import static com.example.server.enumerations.ColumnType.*;
import static com.example.server.enumerations.DisplayType.*;
import static com.example.server.enumerations.FilterType.*;
import static com.example.server.enumerations.SortType.*;
import static com.example.server.utils.DataModifier.*;

public enum Column {
  PLAYER_NAME(
      "scorecard_name",
      "Name",
      AGG_GROUPABLE,
      ALWAYS_SHOW,
      TEXT_FILTER,
      ASC
  ),
  RUNS(
      AGG_SUM,
      OPTIONAL_SHOW,
      NUM_FILTER,
      DESC
  ),
  DELIVERIES(
      AGG_SUM,
      OPTIONAL_SHOW,
      NUM_FILTER,
      DESC
  ),
  INNINGS(
      AGG_COUNT_ALL,
      OPTIONAL_SHOW,
      NUM_FILTER,
      DESC
  ),
  FOURS(
      AGG_SUM,
      OPTIONAL_SHOW,
      NUM_FILTER,
      DESC
  ),
  SIXES(
      AGG_SUM,
      OPTIONAL_SHOW,
      NUM_FILTER,
      DESC
  ),
  WICKET_TYPE(
      "wicket_type",
      "Wicket",
      DB_COLUMN_MODIFIED,
      AGG_GROUPABLE,
      OPTIONAL_SHOW,
      TEXT_FILTER,
      NO_SORT
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return addWicketDisplayData(on, this.key);
    }
  },
  STRIKE_RATE_BAT(
      "strike_rate_bat",
      "Strike Rate",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_SHOW,
      NUM_FILTER,
      DESC
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return addStrikeRateBatData(on, this.key);
    }
  },
  STRIKE_RATE_BOWL(
      "strike_rate_bowl",
      "Strike Rate",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_SHOW,
      NUM_FILTER,
      DESC
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return addStrikeRateBowlData(on, this.key);
    }
  },
  TEAM_TOTAL(
      AGG_SUM,
      ALWAYS_HIDE,
      NO_FILTER,
      NO_SORT
  ),
  PERCENT_TOTAL_VALUE(
      "percent_total_value",
      DERIVED_IN_APP,
      DESC
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return addPercentTotalValueData(on, this.key);
    }
  },
  PERCENT_TOTAL_DISPLAY(
      "percent_total_display",
      "% of Total",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_HIDE,
      NUM_FILTER,
      DESC,
      "percent_total_value"
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return addPercentTotalDisplayData(on, this.key);
    }
  },
  POSITION(
      NO_AGG,
      OPTIONAL_HIDE,
      NUM_FILTER,
      ASC
  ),
  DATE(
      "date",
      "Date",
      NO_AGG,
      ALWAYS_HIDE,
      NO_FILTER,
      NO_SORT
  ),
  OPPOSITION(
      AGG_GROUPABLE,
      ALWAYS_HIDE,
      TEXT_FILTER,
      NO_SORT
  ),
  FIXTURE(
      "fixture",
      "Fixture",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_HIDE,
      NO_FILTER,
      ASC
  ),
  OVERS(
      "overs",
      "Overs",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_SHOW,
      NO_FILTER,
      DESC
  ),
  MAIDENS(
      AGG_SUM,
      OPTIONAL_HIDE,
      NUM_FILTER,
      DESC
  ),
  WICKETS_BATTING(
      "wicket",
      "Wickets",
      AGG_SUM,
      OPTIONAL_SHOW,
      NUM_FILTER,
      DESC
  ),
  WICKETS_BOWLING(
      "wickets",
      "Wickets",
      AGG_SUM,
      OPTIONAL_SHOW,
      NUM_FILTER,
      DESC
  ),
  WIDES(
      AGG_SUM,
      OPTIONAL_HIDE,
      NUM_FILTER,
      DESC
  ),
  NO_BALLS(
      AGG_SUM,
      OPTIONAL_HIDE,
      NUM_FILTER,
      DESC
  ),
  ECONOMY(
      "economy",
      "Economy",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_SHOW,
      NUM_FILTER,
      ASC
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return addEconomyData(on, this.key);
    }
  },
  AVERAGE_BAT_VALUE(
      "average_bat_value",
      DERIVED_IN_APP,
      DESC
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return addAverageBatValueData(on, this.key);
    }
  },
  AVERAGE_BAT_DISPLAY(
      "average_bat_display",
      "Average",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_SHOW,
      NUM_FILTER,
      DESC,
      "average_bat_value"
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return addAverageBatDisplayData(on, this.key);
    }
  },
  AVERAGE_BOWL_VALUE(
      "average_bowl_value",
      DERIVED_IN_APP,
      ASC
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return addAverageBowlValueData(on, this.key);
    }
  },
  AVERAGE_BOWL_DISPLAY(
      "average_bowl_display",
      "Average",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_SHOW,
      NUM_FILTER,
      DESC,
      "average_bowl_value"
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return addAverageBowlDisplayData(on, this.key);
    }
  },
  INDEX(
      "index",
      "#",
      NO_DATA,
      NO_AGG,
      ALWAYS_SHOW,
      NO_FILTER,
      NO_SORT
  ),
  GROUP_TERM(
      "group_term",
      "Group Term",
      NO_AGG,
      ALWAYS_SHOW,
      TEXT_FILTER,
      ASC
  );

  public final String key;
  public final String label;
  public final ColumnType columnType;
  public final AggregateType aggregateType;
  public final DisplayType displayType;
  public final FilterType filterType;
  public final SortType sortType;
  public final String valueColumnKey;

  public ObjectNode createData(ObjectNode on) {
    return on;
  }

  Column(String key, String label, ColumnType columnType, AggregateType aggregateType, DisplayType displayType,
         FilterType filterType, SortType sortType, String valueColumnKey) {
    this.key = key;
    this.label = label;
    this.columnType = columnType;
    this.aggregateType = aggregateType;
    this.displayType = displayType;
    this.filterType = filterType;
    this.sortType = sortType;
    this.valueColumnKey = valueColumnKey;
  }

  Column(String key, String label, ColumnType columnType, AggregateType aggregateType, DisplayType displayType,
         FilterType filterType, SortType sortType) {
    this.key = key;
    this.label = label;
    this.columnType = columnType;
    this.aggregateType = aggregateType;
    this.displayType = displayType;
    this.filterType = filterType;
    this.sortType = sortType;
    this.valueColumnKey = null;
  }

  Column(String key, String label, AggregateType aggregateType, DisplayType displayType,
         FilterType filterType, SortType sortType) {
    this.key = key;
    this.label = label;
    this.columnType = DB_COLUMN_RAW;
    this.aggregateType = aggregateType;
    this.displayType = displayType;
    this.filterType = filterType;
    this.sortType = sortType;
    this.valueColumnKey = null;
  }

  Column(AggregateType aggregateType, DisplayType displayType,
         FilterType filterType, SortType sortType) {
    this.key = this.name().toLowerCase();
    this.label = Utils.snakeToCamel(this.name());
    this.columnType = DB_COLUMN_RAW;
    this.aggregateType = aggregateType;
    this.displayType = displayType;
    this.filterType = filterType;
    this.sortType = sortType;
    this.valueColumnKey = null;
  }

  // Value column
  Column(String key, ColumnType columnType, SortType sortType) {
    this.key = key;
    this.label = null;
    this.columnType = columnType;
    this.aggregateType = NO_AGG;
    this.displayType = ALWAYS_HIDE;
    this.filterType = NUM_FILTER;
    this.sortType = sortType;
    this.valueColumnKey = null;
  }
}