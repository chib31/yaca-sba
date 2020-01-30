package com.cbradbury.yaca.mvc;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectReader;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ClassPathResource;

import java.io.IOException;
import java.io.InputStream;
import java.util.Collections;
import java.util.Map;

public class ReleaseFrontendAssetManifestProvider {

  //This must correspond to where Webpack writes the manifest file
  private static final String MANIFEST_LOCATION = "static/dist/manifest.json";

  private final Map<String, String> assetNameToPathMap;

  public static ReleaseFrontendAssetManifestProvider create() {
    return create(MANIFEST_LOCATION);
  }

  static ReleaseFrontendAssetManifestProvider create(String manifestLocation) {
    ObjectReader reader = new ObjectMapper().readerFor(new TypeReference<Map<String, String>>() {});
    try {
      InputStream inputStream = new ClassPathResource(manifestLocation).getInputStream();
      return new ReleaseFrontendAssetManifestProvider(Collections.unmodifiableMap(reader.readValue(inputStream)));
    } catch (IOException e) {
      throw new RuntimeException("Failed to read asset manifest. Ensure frontend assets have been built.", e);
    }
  }

  private ReleaseFrontendAssetManifestProvider(Map<String, String> assetNameToPathMap) {
    this.assetNameToPathMap = assetNameToPathMap;
  }

  Map<String, String> getAssetNameToPathMap() {
    return assetNameToPathMap;
  }

  @Bean
  public ReleaseFrontendAssetManifestProvider releaseFrontendAssetManifestProvider() {
    return ReleaseFrontendAssetManifestProvider.create();
  }
}
