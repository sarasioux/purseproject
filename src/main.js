import { createApp } from 'vue'
import App from './App.vue'
import VueWeb3 from "./plugins/vue-web3";


createApp(App)
  .use(VueWeb3)
  .mount('#app')
