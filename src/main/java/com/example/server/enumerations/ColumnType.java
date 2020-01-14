package com.example.server.enumerations;

public enum ColumnType {
  DB_COLUMN_RAW, // exists as a column in the database, no modification required
  DB_COLUMN_MODIFIED, // exists as a column in the database, requires modification
  DERIVED_IN_APP, // derived in the application
  NO_DATA // empty - used by the front end (e.g. index)
}
