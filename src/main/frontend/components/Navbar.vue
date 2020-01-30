<template>
  <div>
    <b-navbar toggleable="lg" type="dark" variant="dark">
      <b-navbar-brand>
        <img alt="Team logo" src="../assets/PlasticsLogoText.png" width="50">
        {{ teamName }}
      </b-navbar-brand>
      <b-navbar-nav variant="dark" type="dark">
        <div v-for="navOption in navOptions" :key="navOption.value">
          <b-nav-item v-if="!navOption.hasOwnProperty('subOptions')" v-on:click="navChange(navOption)">
            <font-awesome-icon :icon="[navOption.icon.style, navOption.icon.name]"/> {{ navOption.display }}
          </b-nav-item>
          <b-nav-item-dropdown v-if="navOption.hasOwnProperty('subOptions')">
            <template slot="button-content">
              <font-awesome-icon :icon="[navOption.icon.style, navOption.icon.name]"/> {{ navOption.display }}
            </template>
            <b-dropdown-item v-for="subOption in navOption.subOptions" :key="subOption.value" v-on:click="navChange(subOption)">
              {{ subOption.display }}
            </b-dropdown-item>
          </b-nav-item-dropdown>
        </div>
      </b-navbar-nav>
    </b-navbar>
  </div>
</template>
<script>
  export default {
    props: {
      teamName: String,
      navOptions: Array,
    },
    methods: {
      navChange(request) {
        this.$emit('navRequest', request)
      }
    }
  }
</script>