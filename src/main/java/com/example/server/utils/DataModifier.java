package com.example.server.utils;

import com.fasterxml.jackson.databind.node.ObjectNode;

import static com.example.server.enumerations.Column.*;
import static com.example.server.utils.Utils.*;

public class DataModifier {

  public static ObjectNode addWicketDisplayData(ObjectNode on, String key) {
    String oldValue = on.get(key).textValue();
    String newValue = getWicketTypeFromSql(oldValue).toString();
    return on.put(key, newValue);
  }

  public static ObjectNode addStrikeRateBatData(ObjectNode on, String key) {
    int runs = on.get(RUNS.key).asInt();
    int deliveries = on.get(DELIVERIES.key).asInt();
    double newValue = Utils.calculateBattingStrikeRate(runs, deliveries);
    return on.put(key, newValue);
  }

  public static ObjectNode addStrikeRateBowlData(ObjectNode on, String key) {
    int wickets = on.get(WICKETS_BOWLING.key).asInt();
    int deliveries = on.get(DELIVERIES.key).asInt();
    double newValue = Utils.calculateBowlingStrikeRate(deliveries, wickets);
    return on.put(key, newValue);
  }

  public static ObjectNode addPercentTotalDisplayData(ObjectNode on, String key) {
    int runs = on.get(RUNS.key).asInt();
    int team_runs = on.get(TEAM_TOTAL.key).asInt();
    String value = getPercentOfTotalDisplay(calculatePercentOfTotal(runs, team_runs));
    return on.put(key, value);
  }

  public static ObjectNode addPercentTotalValueData(ObjectNode on, String key) {
    int runs = on.get(RUNS.key).asInt();
    int team_runs = on.get(TEAM_TOTAL.key).asInt();
    Double value = calculatePercentOfTotal(runs, team_runs);
    return on.put(key, value);
  }

  public static ObjectNode addEconomyData(ObjectNode on, String key) {
    int runs = on.get(RUNS.key).asInt();
    int deliveries = on.get(DELIVERIES.key).asInt();
    Double value = calculateEconomy(runs, deliveries);
    return on.put(key, value);
  }

  public static ObjectNode addAverageBatValueData(ObjectNode on, String key) {
    int runs = on.get(RUNS.key).asInt();
    int wickets = on.get(WICKETS_BATTING.key).asInt();
    double value = getAverageValue(calculateAverage(runs, wickets));
    return on.put(key, value);
  }

  public static ObjectNode addAverageBatDisplayData(ObjectNode on, String key) {
    int runs = on.get(RUNS.key).asInt();
    int wickets = on.get(WICKETS_BATTING.key).asInt();
    String value = getAverageDisplay(calculateAverage(runs, wickets));
    return on.put(key, value);
  }

  public static ObjectNode addAverageBowlValueData(ObjectNode on, String key) {
    int runs = on.get(RUNS.key).asInt();
    int wickets = on.get(WICKETS_BOWLING.key).asInt();
    Double value = calculateAverage(runs, wickets);
    return on.put(key, value);
  }

  public static ObjectNode addAverageBowlDisplayData(ObjectNode on, String key) {
    int runs = on.get(RUNS.key).asInt();
    int wickets = on.get(WICKETS_BOWLING.key).asInt();
    String value = getAverageDisplay(calculateAverage(runs, wickets));
    return on.put(key, value);
  }
}
