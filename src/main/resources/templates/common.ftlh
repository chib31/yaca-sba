<#-- @ftlvariable name="jsAssetPathMap" type="java.util.Map<String, String>" -->

<#import "/spring.ftl" as spring>

<#function coreAssetSrc asset>
    <#local url>
        <@spring.url '/assets/core/' + asset/>
    </#local>
    <#return url>
</#function>

<#function springUrl url>
    <#local springUrl>
        <@spring.url url/>
    </#local>
    <#return springUrl>
</#function>

<#macro fullPage>
  <!DOCTYPE html>
  <html lang="en-GB">
    <head>
      <title>CharlieTitle</title>
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta charset="UTF-8">
    </head>
    <body>
    <div id="app">
      <navbar :teamName="teamName" :navOptions="navOptions" v-on:navRequest="setStatType"></navbar>
      Common contents
    </div>

    <#-- Need to capture the full asset route for Webpack's public path -->
    <script type="text/javascript">
      (function (global) {
        'use strict';

        var ECASE = global.ECASE || {};
        ECASE.AssetRoot = "<@spring.url '/assets/dist/'/>";
        ECASE.BaseUrl = "<@spring.url ''/>";
        ECASE.CsrfToken = "${(_csrf.token)!''}";

        global.ECASE = ECASE;
      })(window);
    </script>

    <#-- This map should be ordered so JS containing polyfills comes first - see FrontendAssetHandlerInterceptor -->
    <#-- Need all chunks with "core" in the name, as vendor libraries are used by different sets of entry points -->
    <#list jsAssetPathMap as name, path>
        <#if ["styles.js", "runtime.js"]?seq_contains(name)>
          <script src="<@spring.url '/assets/dist/${path}'/>"></script>
        </#if>
    </#list>
    </body>
  </html>
</#macro>