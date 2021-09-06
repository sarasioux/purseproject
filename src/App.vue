<template>
    <div class="container">
        <nav class="navbar is-transparent" role="navigation" aria-label="main navigation">
            <div class="navbar-brand">
                <a class="navbar-item" href="https://purseproject.io">
                    <h1 class="title has-text-white is-4 cursive">
                        Purse
                    </h1>
                </a>
            </div>
            <div id="navbarBasicExample" class="navbar-menu">
                <div class="navbar-start">
                </div>

                <div class="navbar-end">
                    <div class="navbar-item">
                        <button class="button is-primary" @click="connectWeb3" v-if="!isConnected">Connect</button>
                        <button class="button is-primary" @click="claimPurse" v-if="isConnected">Claim</button>
                    </div>
                </div>
            </div>
        </nav>

        <div class="is-hidden-table has-text-centered">
            <button class="button is-primary is-hidden-tablet" @click="connectWeb3" v-if="!isConnected">Connect</button>
            <button class="button is-primary is-hidden-tablet" @click="claimPurse" v-if="isConnected">Claim</button>
        </div>

        <router-view
            :account="account"
            :contract="contract"
            :isConnected="isConnected"
        ></router-view>
    </div>

</template>

<script>

  import PurseContract from '../build/contracts/Purse.json'
  import TruffleContract from '@truffle/contract'

  export default {
    name: 'App',
    components: {
    },
    data: function() {
      return {
        connectionInProgress: false,
        isConnected: false,
        contract: {},
        account: '',
      }
    },
    methods: {
      connectWeb3: async function() {
        this.connectionInProgress = true;
        try {
          // Request account access
          let accounts = await this.$web3.currentProvider.send('eth_requestAccounts');
          this.account = accounts.result[0];
          let networkId = await this.$web3.eth.net.getId();
          switch (networkId) {
            case 1:
              await this.initContracts();
              this.connectionInProgress = false;
              this.isConnected = true;
              break;
            default:
              alert('Please connect to mainnet and make sure your web3 browser is working.');
          }
        } catch (error) {
          console.log('error', error);
        }
      },
      initContracts: async function() {
        let contract = TruffleContract(PurseContract);
        contract.setProvider(this.$web3.currentProvider);
        contract.defaults({
          from: this.account
        });
        this.contract = await contract.deployed();
      },

      claimPurse: async function() {
        this.contract.mint();
      }
    }
  }
</script>

<style>
    .is-huge {
        font-size: 6.0em;
    }
</style>
