<template>
  <div class="card">
    <div class="card-body">
      <h6 class="card-title">
        {{ player.name }}
      </h6>
      <div class="card-text">
        {{ player.description }}
      </div>
    </div>
  </div>
</template>
<script>
  export default {
    props: ['player'],
  }
</script>