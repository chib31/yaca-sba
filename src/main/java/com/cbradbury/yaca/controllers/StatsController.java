package com.cbradbury.yaca.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StatsController {

  @GetMapping({"/", "/players"})
  public ModelAndView renderStatsPage() {
    var modelAndView = new ModelAndView("playersTest");
    modelAndView.addObject("teamName", "PlasticsXI");
    return modelAndView;
  }
}
