package com.example.server.services;

import com.example.server.entities.Report;
import com.example.server.enumerations.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.Tuple;
import javax.persistence.TupleElement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static com.example.server.enumerations.ColumnType.*;
import static com.example.server.utils.Utils.unCamel;

@Service
public class ReportService {

  private final EntityManager em;

  @Autowired
  public ReportService(EntityManager em) {
    this.em = em;
  }

  public Report fetchReport(ReportType reportType, @Nullable List<Column> groupBy) {

    boolean grouped = groupBy != null && !groupBy.isEmpty();

    List<Column> columns = grouped ? reportType.groupColumns : reportType.columns;
    List<Column> selectColumns = columns.stream()
        .filter(e -> e.columnType == DB_COLUMN_RAW || e.columnType == DB_COLUMN_MODIFIED)
        .collect(Collectors.toList());
    List<Column> derivedColumns = columns.stream()
        .filter(e -> e.columnType == DERIVED_IN_APP || e.columnType == DB_COLUMN_MODIFIED)
        .collect(Collectors.toList());

    StringBuilder sb = new StringBuilder();

    sb.append("SELECT ");
    if (grouped) {
      sb.append("t.");
      sb.append(groupBy.stream().map(e -> e.key).collect(Collectors.joining(" || ' - ' || t.")))
          .append(" AS groupTerm, ");
    }
    List<String> selectFields = new ArrayList<>();
    if (grouped) {
      for (Column column : selectColumns) {
        if (column.aggregateType == AggregateType.AGG_SUM) {
          selectFields.add("SUM(t." + column.key + ") AS " + column.key);
        } else if (column.aggregateType == AggregateType.AGG_COUNT_ALL) {
          selectFields.add("COUNT(*) AS " + column.key);
        }
      }
    } else {
      for (Column column : selectColumns) {
        selectFields.add("t." + column.key + " AS " + column.key);
      }
    }
    sb.append(String.join(", ", selectFields));
    sb.append(" FROM ").append(reportType.dbTableName).append(" t ");
    if (groupBy != null && !groupBy.isEmpty()) {
      sb.append("GROUP BY ").append(groupBy.stream().map(e -> e.key).collect(Collectors.joining(", ")));
    }

    @SuppressWarnings("unchecked")
    List<Tuple> tupleList = em.createNativeQuery(sb.toString(), Tuple.class).getResultList();

    List<ObjectNode> resultList = tupleToObjectNodes(tupleList);

    Stream<ObjectNode> ons = resultList.stream();
    for (Column col : derivedColumns) {
      ons = ons.map(col::createData);
    }
    List<ObjectNode> fullResultList = ons.collect(Collectors.toList());


    return new Report(
        constructReportInfoMap(reportType),
        constructColumnsJson(columns, reportType),
        fullResultList);
  }

  private HashMap<String, Object> constructReportInfoMap(ReportType reportType) {
    HashMap<String, Object> reportInfo = new HashMap<>();

    HashMap<String, Object> groupOptions = new HashMap<>();
    List<Column> groupColumns = reportType.columns.stream()
        .filter(e -> e.aggregateType == AggregateType.AGG_GROUPABLE)
        .collect(Collectors.toList());
    for(Column column : groupColumns) {
      groupOptions.put(column.key, column.label);
    }
    reportInfo.put("group_options", groupOptions);
    return reportInfo;
  }

  private List<Map<String, Object>> constructColumnsJson(List<Column> columns, ReportType reportType) {
    List<Map<String, Object>> columnList = new ArrayList<>();
    for (Column col : columns) {
      Integer initialSortOrder = reportType.orderColumns.contains(col) ? reportType.orderColumns.indexOf(col) + 1 : null;
      columnList.add(createStatColumn(col.key, col.label, col.displayType, col.filterType, col.sortType,
          col.valueColumnKey, initialSortOrder, col.aggregateType));
    }
    return columnList;
  }

  private Map<String, Object> createStatColumn(String key,
                                               String label,
                                               @Nullable DisplayType displayType,
                                               @Nullable FilterType filterType,
                                               @Nullable SortType sortType,
                                               @Nullable String valueColumnKey,
                                               @Nullable Integer initialSortOrder,
                                               @Nullable AggregateType aggregateType) {
    Map<String, Object> map = new HashMap<>();
    map.put("key", key);
    map.put("label", label);
    map.put("displayType", displayType == null ? DisplayType.OPTIONAL_SHOW.toString() : displayType.toString());
    map.put("filterType", filterType == null ? FilterType.NO_FILTER.toString() : filterType.toString());
    if (sortType != null && sortType != SortType.NO_SORT) {
      map.put("sortColumn", true);
      map.put("defaultSortDir", sortType == SortType.ASC ? "Asc" : "Desc");
    }
    if (valueColumnKey != null) {
      map.put("valueColumnKey", valueColumnKey);
    }
    if (initialSortOrder != null) {
      map.put("initialSortOrder", initialSortOrder);
    }
    if (aggregateType == AggregateType.AGG_GROUPABLE) {
      map.put("groupable", true);
    }
    return map;
  }

  private List<ObjectNode> tupleToObjectNodes(List<Tuple> results) {
    List<ObjectNode> json = new ArrayList<>();
    ObjectMapper mapper = new ObjectMapper();
    for (Tuple t : results) {
      List<TupleElement<?>> cols = t.getElements();
      ObjectNode on = mapper.createObjectNode();
      for (TupleElement col : cols) {
        String key = col.getAlias();
        Class c = col.getJavaType();
        if(Integer.class.isAssignableFrom(c)) {
          int value = (int) t.get(key);
          on.put(key, value);
        } else {
          on.put(col.getAlias(), t.get(col.getAlias()).toString());
        }
      }
      json.add(on);
    }
    return json;
  }
}
