<template>

    <div>
        <div class="section has-text-centered" v-if="isConnected">
            <h1 class="title is-huge has-text-white cursive has-text-primary">{{purse.name}}</h1>

            <div class="columns">
                <div class="column is-4">
                    <h2 class="title has-text-white cursive">Purse</h2>
                    <figure class="image is-square" v-if="purse.image">
                        <img :src="purse.image">
                    </figure>
                    <a class="help">{{contract.address}}</a>
                </div>
                <div class="column is-4">
                    <h2 class="title has-text-white cursive">Ability Score</h2>
                    <figure class="image is-square" v-if="ability.image">
                        <img :src="ability.image">
                    </figure>
                    <a class="help">{{abilityContract.address}}</a>
                </div>
                <div class="column is-4">
                    <h2 class="title has-text-white cursive">Combined Ability</h2>
                </div>
            </div>

        </div>

    </div>

</template>

<script>

  import AbilityContract from '../../build/contracts/AbilityScore.json'
  import TruffleContract from '@truffle/contract'

  export default {
    name: 'Map',
    components: {
    },
    data: function() {
      return {
        id: '',
        purse: {},
        ability: {},

        abilityContract: {}
      }
    },
    props: {
      contract: Object,
      account: String,
      isConnected: Boolean,
    },
    watch: {
      isConnected: function() {
        this.loadData();
      }
    },
    mounted: function() {
      this.id = this.$route.params.id;
      if(this.isConnected) {
        this.loadData();
      }
    },
    methods: {
      loadData: async function() {

        let dataURI = await this.contract.tokenURI.call(this.id);
        let json = atob(dataURI.substring(29));
        this.purse = JSON.parse(json);

        let contract = TruffleContract({
          abi: AbilityContract
        });
        contract.setProvider(this.$web3.currentProvider);
        contract.defaults({
          from: this.account
        });
        this.abilityContract = await contract.at('0x42a87e04f87a038774fb39c0a61681e7e859937b');
        dataURI = await this.abilityContract.tokenURI.call(this.id + 1000000);
        json = atob(dataURI.substring(29));
        this.ability = JSON.parse(json);
        console.log('ability', this.ability);
      },
    }
  }
</script>

<style>
    .is-huge {
        font-size: 6.0em;
    }
</style>
