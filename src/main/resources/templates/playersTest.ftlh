<#import "/spring.ftl" as spring>
<#include "common.ftlh">


Contents of child template
<@fullPage>
  <div id="app">
    <navbar :teamName="teamName" :navOptions="navOptions" v-on:navRequest="setStatType"></navbar>
  </div>
</@fullPage>