package com.cbradbury.yaca.mvc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

  private final FrontendAssetHandlerInterceptor frontendAssetHandlerInterceptor;

  @Autowired
  public WebMvcConfig(FrontendAssetHandlerInterceptor frontendAssetHandlerInterceptor) {
    this.frontendAssetHandlerInterceptor = frontendAssetHandlerInterceptor;
  }

  @Override
  public void addInterceptors(InterceptorRegistry registry) {
    registry.addInterceptor(frontendAssetHandlerInterceptor)
        .excludePathPatterns("/assets/**", "/**/rest/**");
  }
}
