<template>
    <div class="container">
        <nav class="navbar is-transparent" role="navigation" aria-label="main navigation">
            <div class="navbar-brand">
                <a class="navbar-item" href="https://purse.art">
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
        showHelp: false,
        purse1: {},
        purse2: {},
        purse3: {}
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

        this.loadData();
      },
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
