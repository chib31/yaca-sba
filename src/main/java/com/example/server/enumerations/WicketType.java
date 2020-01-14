package com.example.server.enumerations;

public enum WicketType {

    DNB("dnb", "Did Not Bat"),
    NOT_OUT("not_out", "Not Out"),
    RETIRED("retired", "Retired"),
    BOWLED("bowled", "Bowled"),
    CAUGHT("caught", "Caught"),
    HIT_TWICE("hit_twice", "Hit Ball Twice"),
    HIT_WICKET("hit_wicket", "Hit Wicket"),
    LBW("lbw", "LBW"),
    OBSTRUCTING("obstructing", "Obstructing The Field"),
    RUN_OUT("run_out", "Run Out"),
    STUMPED("stumped", "Stumped"),
    TIMED_OUT("timed_out", "Timed Out"),
    OTHER("other", "Other");

    private String sqlType;
    private String type;

    WicketType(String sqlType, String type) {
      this.sqlType = sqlType;
      this.type = type;
    }

    public String getSqlType() {
      return sqlType;
    }

    @Override
    public String toString() {
        return this.type;
    }
}