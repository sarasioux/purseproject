<template>

    <div>
        <div class="section has-text-centered">
            <h1 class="title is-huge has-text-white cursive has-text-primary">Purse</h1>
            <div class="tabs is-centered is-large is-hidden-mobile">
                <ul>
                    <li><a class="has-text-white cursive is-size-3" href="https://opensea.io/collection/purse" target="_blank">Open Sea</a></li>
                    <li><a class="has-text-white cursive is-size-3" href="https://discord.gg/rGVWGRwApV" target="_blank">Discord</a></li>
                    <li><a class="has-text-white cursive is-size-3" href="https://twitter.com/purse_project" target="_blank">Twitter</a></li>
                    <li><a class="has-text-white cursive is-size-3" href="https://etherscan.io/address/0xdfab2cd7b7efe3cfb6a09235ba8ec895eaedf062" target="_blank">Contract</a></li>
                </ul>
            </div>
            <aside class="menu is-hidden-tablet">
                <ul class="menu-list">
                    <li><a class="has-text-white cursive is-size-3" href="https://opensea.io/collection/purse" target="_blank">Open Sea</a></li>
                    <li><a class="has-text-white cursive is-size-3" href="https://discord.gg/rGVWGRwApV" target="_blank">Discord</a></li>
                    <li><a class="has-text-white cursive is-size-3" href="https://twitter.com/purse_project" target="_blank">Twitter</a></li>
                    <li><a class="has-text-white cursive is-size-3" href="https://etherscan.io/address/0xdfab2cd7b7efe3cfb6a09235ba8ec895eaedf062" target="_blank">Contract</a></li>
                </ul>
            </aside>
            <p class="has-text-grey has-text-weight-medium is-size-5">
                Purse is randomized lady gear generated and stored on chain.<br />
                Stats, images, and other functionality are intentionally omitted for others to interpret.<br />
                Feel free to use Purse in any way you want.  Inspired by <a href="https://www.lootproject.com/" target="_blank">Loot</a>.  Created by <a href="https://twitter.com/altcryp" target="_blank">Sara</a>.
            </p>

            <br /><br />

            <div v-if="isConnected">
                <p class="has-text-grey is-size-5">Example Purses:</p>
                <br />

                <div class="columns">
                    <div class="column">
                        <figure class="image is-square" v-if="purse1.image">
                            <img :src="purse1.image">
                        </figure>
                    </div>
                    <div class="column">
                        <figure class="image is-square" v-if="purse2.image">
                            <img :src="purse2.image">
                        </figure>
                    </div>
                    <div class="column">
                        <figure class="image is-square" v-if="purse3.image">
                            <img :src="purse3.image">
                        </figure>
                    </div>
                </div>
            </div>
        </div>

        <div class="has-text-centered has-text-grey is-size-5">This website is <a href="https://github.com/sarasioux/purseproject" target="_blank">open source</a>.</div>
    </div>

</template>

<script>

  export default {
    name: 'Home',
    components: {
    },
    data: function() {
      return {
        purse1: {},
        purse2: {},
        purse3: {}
      }
    },
    props: {
      contract: Object,
      account: String,
      isConnected: Boolean,
    },
    methods: {
      loadData: async function() {

        let dataURI = await this.contract.tokenURI.call(Math.floor(Math.random() * 100000) % 100);
        let json = atob(dataURI.substring(29));
        this.purse1 = JSON.parse(json);

        dataURI = await this.contract.tokenURI.call(Math.floor(Math.random() * 100000) % 100);
        json = atob(dataURI.substring(29));
        this.purse2 = JSON.parse(json);

        dataURI = await this.contract.tokenURI.call(Math.floor(Math.random() * 100000) % 100);
        json = atob(dataURI.substring(29));
        this.purse3 = JSON.parse(json);
      },
    }
  }
</script>

<style>
    .is-huge {
        font-size: 6.0em;
    }
</style>
