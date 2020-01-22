package com.cbradbury.yaca.controllers;

import com.cbradbury.yaca.enumerations.Column;
import com.cbradbury.yaca.entities.Report;
import com.cbradbury.yaca.enumerations.ReportType;
import com.cbradbury.yaca.services.ReportService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController()
@CrossOrigin(maxAge = 3600)
@RequestMapping("/api")
public class StatsRestController {

  private final ReportService reportService;

  public StatsRestController(ReportService reportService) {
    this.reportService = reportService;
  }

  @RequestMapping(path = "/reports")
  @CrossOrigin
  public @ResponseBody
  Report fetchReport(@RequestParam ReportType reportType, @RequestParam(required = false) List<Column> groupBy) {
    return reportService.fetchReport(reportType, groupBy);
  }
}