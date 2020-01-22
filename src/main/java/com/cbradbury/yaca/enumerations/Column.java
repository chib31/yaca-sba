package com.cbradbury.yaca.enumerations;

import com.cbradbury.yaca.utils.DataModifier;
import com.cbradbury.yaca.utils.Utils;
import com.fasterxml.jackson.databind.node.ObjectNode;

import static com.cbradbury.yaca.enumerations.AggregateType.*;
import static com.cbradbury.yaca.enumerations.ColumnType.*;
import static com.cbradbury.yaca.enumerations.DisplayType.*;
import static com.cbradbury.yaca.enumerations.FilterType.*;

public enum Column {
  PLAYER_NAME(
      "scorecard_name",
      "Name",
      AGG_GROUPABLE,
      ALWAYS_SHOW,
      TEXT_FILTER,
      SortType.ASC
  ),
  RUNS(
      AGG_SUM,
      OPTIONAL_SHOW,
      NUM_FILTER,
      SortType.DESC
  ),
  DELIVERIES(
      AGG_SUM,
      OPTIONAL_SHOW,
      NUM_FILTER,
      SortType.DESC
  ),
  INNINGS(
      AGG_COUNT_ALL,
      OPTIONAL_SHOW,
      NUM_FILTER,
      SortType.DESC
  ),
  FOURS(
      AGG_SUM,
      OPTIONAL_SHOW,
      NUM_FILTER,
      SortType.DESC
  ),
  SIXES(
      AGG_SUM,
      OPTIONAL_SHOW,
      NUM_FILTER,
      SortType.DESC
  ),
  WICKET_TYPE(
      "wicket_type",
      "Wicket",
      DB_COLUMN_MODIFIED,
      AGG_GROUPABLE,
      OPTIONAL_SHOW,
      TEXT_FILTER,
      SortType.NO_SORT
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return DataModifier.addWicketDisplayData(on, this.key);
    }
  },
  STRIKE_RATE_BAT(
      "strike_rate_bat",
      "Strike Rate",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_SHOW,
      NUM_FILTER,
      SortType.DESC
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return DataModifier.addStrikeRateBatData(on, this.key);
    }
  },
  STRIKE_RATE_BOWL(
      "strike_rate_bowl",
      "Strike Rate",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_SHOW,
      NUM_FILTER,
      SortType.DESC
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return DataModifier.addStrikeRateBowlData(on, this.key);
    }
  },
  TEAM_TOTAL(
      AGG_SUM,
      ALWAYS_HIDE,
      NO_FILTER,
      SortType.NO_SORT
  ),
  PERCENT_TOTAL_VALUE(
      "percent_total_value",
      DERIVED_IN_APP,
      SortType.DESC
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return DataModifier.addPercentTotalValueData(on, this.key);
    }
  },
  PERCENT_TOTAL_DISPLAY(
      "percent_total_display",
      "% of Total",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_HIDE,
      NUM_FILTER,
      SortType.DESC,
      "percent_total_value"
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return DataModifier.addPercentTotalDisplayData(on, this.key);
    }
  },
  POSITION(
      NO_AGG,
      OPTIONAL_HIDE,
      NUM_FILTER,
      SortType.ASC
  ),
  DATE(
      "date",
      "Date",
      NO_AGG,
      ALWAYS_HIDE,
      NO_FILTER,
      SortType.NO_SORT
  ),
  OPPOSITION(
      AGG_GROUPABLE,
      ALWAYS_HIDE,
      TEXT_FILTER,
      SortType.NO_SORT
  ),
  FIXTURE(
      "fixture",
      "Fixture",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_HIDE,
      NO_FILTER,
      SortType.ASC
  ),
  OVERS(
      "overs",
      "Overs",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_SHOW,
      NO_FILTER,
      SortType.DESC
  ),
  MAIDENS(
      AGG_SUM,
      OPTIONAL_HIDE,
      NUM_FILTER,
      SortType.DESC
  ),
  WICKETS_BATTING(
      "wicket",
      "Wickets",
      AGG_SUM,
      OPTIONAL_SHOW,
      NUM_FILTER,
      SortType.DESC
  ),
  WICKETS_BOWLING(
      "wickets",
      "Wickets",
      AGG_SUM,
      OPTIONAL_SHOW,
      NUM_FILTER,
      SortType.DESC
  ),
  WIDES(
      AGG_SUM,
      OPTIONAL_HIDE,
      NUM_FILTER,
      SortType.DESC
  ),
  NO_BALLS(
      AGG_SUM,
      OPTIONAL_HIDE,
      NUM_FILTER,
      SortType.DESC
  ),
  ECONOMY(
      "economy",
      "Economy",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_SHOW,
      NUM_FILTER,
      SortType.ASC
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return DataModifier.addEconomyData(on, this.key);
    }
  },
  AVERAGE_BAT_VALUE(
      "average_bat_value",
      DERIVED_IN_APP,
      SortType.DESC
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return DataModifier.addAverageBatValueData(on, this.key);
    }
  },
  AVERAGE_BAT_DISPLAY(
      "average_bat_display",
      "Average",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_SHOW,
      NUM_FILTER,
      SortType.DESC,
      "average_bat_value"
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return DataModifier.addAverageBatDisplayData(on, this.key);
    }
  },
  AVERAGE_BOWL_VALUE(
      "average_bowl_value",
      DERIVED_IN_APP,
      SortType.ASC
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return DataModifier.addAverageBowlValueData(on, this.key);
    }
  },
  AVERAGE_BOWL_DISPLAY(
      "average_bowl_display",
      "Average",
      DERIVED_IN_APP,
      NO_AGG,
      OPTIONAL_SHOW,
      NUM_FILTER,
      SortType.DESC,
      "average_bowl_value"
  ) {
    @Override
    public ObjectNode createData(ObjectNode on) {
      return DataModifier.addAverageBowlDisplayData(on, this.key);
    }
  },
  INDEX(
      "index",
      "#",
      NO_DATA,
      NO_AGG,
      ALWAYS_SHOW,
      NO_FILTER,
      SortType.NO_SORT
  ),
  GROUP_TERM(
      "group_term",
      "Group Term",
      NO_AGG,
      ALWAYS_SHOW,
      TEXT_FILTER,
      SortType.ASC
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