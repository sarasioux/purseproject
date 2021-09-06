import { createApp } from 'vue'
import App from './App.vue'
import VueWeb3 from "./plugins/vue-web3";
import router from "./router";

createApp(App)
  .use(VueWeb3)
  .use(router)
  .mount('#app')
