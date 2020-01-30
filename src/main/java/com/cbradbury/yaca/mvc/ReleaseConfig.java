package com.cbradbury.yaca.mvc;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ReleaseConfig {

  @Bean
  public ReleaseFrontendAssetManifestProvider releaseFrontendAssetManifestProvider() {
    return ReleaseFrontendAssetManifestProvider.create();
  }
}
