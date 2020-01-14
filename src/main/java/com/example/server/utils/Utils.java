package com.example.server.utils;

import com.example.server.enumerations.Column;
import com.example.server.enumerations.Result;
import com.example.server.enumerations.WicketType;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.text.WordUtils;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Arrays;

public class Utils {

  private static final int OVER_LENGTH = 6;

  public static WicketType getWicketTypeFromSql(String sqlType) {
    return Arrays.stream(WicketType.values())
               .filter(e -> e.getSqlType().equals(sqlType))
               .findAny()
               .orElseThrow();
  }

  public static ObjectNode transformWicketType(ObjectNode on) {
    String key = Column.WICKET_TYPE.key;
    String oldValue = on.get(key).textValue();
    String newValue = getWicketTypeFromSql(oldValue).toString();
    return on.put(key, newValue);
  }

  public static Result getResultFromSql(String sqlResult) {
    return Arrays.stream(Result.values())
               .filter(e -> e.getSqlResult().equals(sqlResult))
               .findAny()
               .orElseThrow();
  }

  public static double calculateBattingStrikeRate(int runs, int deliveries) {
    if (deliveries > 0) {
      double dRuns = (double) runs;
      double dDeliveries = (double) deliveries;
      BigDecimal bd = BigDecimal.valueOf((dRuns * 100) / dDeliveries);
      bd = bd.setScale(1, RoundingMode.HALF_UP);
      return bd.doubleValue();
    } else {
      // return -1 so these are sorted
      return 0;
    }
  }

  public static String createStrikeRateString(int runs, int deliveries) {
    if(deliveries > 0) {
      return String.valueOf(calculateBattingStrikeRate(runs, deliveries));
    } else {
      return "n/a";
    }
  }

  public static double calculateBowlingStrikeRate(int deliveries, int wickets) {
    if (wickets > 0) {
      double dDeliveries = (double) deliveries;
      double dWickets = (double) wickets;
      BigDecimal bd = BigDecimal.valueOf(dDeliveries / dWickets);
      bd = bd.setScale(1, RoundingMode.HALF_UP);
      return bd.doubleValue();
    } else {
      return 0;
    }
  }

  public static Double calculateAverage(int runs, int wickets) {
    if (wickets > 0) {
      double dRuns = (double) runs;
      double dWickets = (double) wickets;
      BigDecimal bd = BigDecimal.valueOf(dRuns / dWickets);
      bd = bd.setScale(1, RoundingMode.HALF_UP);
      return bd.doubleValue();
    } else {
      return null;
    }
  }

  public static String getAverageDisplay(Double value) {
    if(value != null) {
      BigDecimal bd = BigDecimal.valueOf(value);
      bd = bd.setScale(1, RoundingMode.HALF_UP);
      return bd.toString();
    } else {
      return "n/a";
    }
  }

  public static double getAverageValue(Double value) {
    return value == null ? 0 : value;
  }

  public static Double calculatePercentOfTotal(int playerRuns, int teamRuns) {
    if (teamRuns > 0) {
      double dPlayerRuns = (double) playerRuns;
      double dTeamRuns = (double) teamRuns;
      BigDecimal bd = BigDecimal.valueOf((dPlayerRuns * 100) / dTeamRuns);
      return bd.doubleValue();
    } else {
      return null;
    }
  }

  public static String getPercentOfTotalDisplay(Double value) {
    if (value != null) {
      BigDecimal bd = BigDecimal.valueOf(value);
      bd = bd.setScale(1, RoundingMode.HALF_UP);
      return bd.toString() + "%";
    } else {
      return "inf";
    }
  }

  public static Double calculateEconomy(int runs, int deliveries) {
    if (deliveries > 0) {
      double dRuns = (double) runs;
      double dDeliveries = (double) deliveries;
      BigDecimal bd = BigDecimal.valueOf((dRuns * OVER_LENGTH) / dDeliveries);
      bd = bd.setScale(2, RoundingMode.HALF_UP);
      return bd.doubleValue();
    } else {
      return null;
    }
  }

//  public static String getEconomyDisplay(Double value) {
//    if (value != null) {
//      BigDecimal bd = BigDecimal.valueOf(value);
//      bd = bd.setScale(2, RoundingMode.HALF_UP);
//      return bd.toString();
//    } else {
//      return "n/a";
//    }
//  }

  public static String calculateOvers(int deliveries, int overLength) {
    int overs = deliveries / overLength;
    int extraDeliveries = deliveries % overLength;
    return overs + "." + extraDeliveries;
  }

  public static String unCamel(String camelString) {
    return StringUtils.capitalize(
        StringUtils.join(StringUtils.splitByCharacterTypeCamelCase(camelString), StringUtils.SPACE)
    );
  }

  public static String upperSnakeToCamel(String capitalised) {
    return WordUtils.capitalizeFully(capitalised, '_').replaceAll("_", "");
  }

  public static String snakeToCamel(String snake) {
    return WordUtils.capitalizeFully(snake).replaceAll("_", " ");
  }

}