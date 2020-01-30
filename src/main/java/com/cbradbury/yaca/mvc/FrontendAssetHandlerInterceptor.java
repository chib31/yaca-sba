package com.cbradbury.yaca.mvc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import static java.util.Comparator.comparing;
import static java.util.stream.Collectors.toMap;

@Component
public class FrontendAssetHandlerInterceptor implements HandlerInterceptor {

  private final ReleaseFrontendAssetManifestProvider releaseFrontendAssetManifestProvider;

  @Autowired
  public FrontendAssetHandlerInterceptor(ReleaseFrontendAssetManifestProvider releaseFrontendAssetManifestProvider) {
    this.releaseFrontendAssetManifestProvider = releaseFrontendAssetManifestProvider;
  }

  @Override
  public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                         ModelAndView modelAndView) {
    //Core JS contains polyfills, so it must be the first script referenced in the page
    Map<String, String> jsAssetPathMap = releaseFrontendAssetManifestProvider.getAssetNameToPathMap().entrySet().stream()
        .filter(e -> e.getKey().endsWith(".js"))
        .sorted(comparing(Map.Entry::getKey,
            comparing((String key) -> !"core.js".equals(key))
                .thenComparing(key ->  !"vendors~core.js".equals(key))
                .thenComparing(key -> key)))
        .collect(toLinkedHashMap(Map.Entry::getKey, Map.Entry::getValue));

    Map<String, String> cssAssetPathMap = releaseFrontendAssetManifestProvider.getAssetNameToPathMap().entrySet().stream()
        .filter(e -> e.getKey().endsWith(".css"))
        .collect(toMap(Map.Entry::getKey, Map.Entry::getValue));

    if (modelAndView != null) {
      //Don't add the attribute to redirect views - otherwise Spring adds a query parameter containing the attribute
      boolean isRedirectView = modelAndView.getView() instanceof RedirectView;
      boolean viewNameStartsWithRedirect = modelAndView.getViewName() != null
          && modelAndView.getViewName().startsWith(UrlBasedViewResolver.REDIRECT_URL_PREFIX);

      if (!isRedirectView && !viewNameStartsWithRedirect) {
        modelAndView.addObject("jsAssetPathMap", jsAssetPathMap);
        modelAndView.addObject("cssAssetPathMap", cssAssetPathMap);
      }
    }
  }

  private <T, K, U> Collector<T, ?, Map<K, U>> toLinkedHashMap(Function<? super T, ? extends K> keyMapper,
                                                               Function<? super T, ? extends U> valueMapper) {
    return Collectors.toMap(
        keyMapper,
        valueMapper,
        (u, v) -> {
          throw new IllegalStateException(String.format("Duplicate key %s", u));
        },
        LinkedHashMap::new
    );
  }
}
