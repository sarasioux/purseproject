import Web3 from "web3";

export default {
  install: async function (app) {
      app.config.globalProperties.$web3 = false;
      let provider = window.ethereum;
      if (!provider) {
          return;
      }
      app.config.globalProperties.$web3 = new Web3(window.ethereum);
      app.config.globalProperties.$web3.eth.net
          .isListening()
          .then((result) => {
              app.config.globalProperties.$web3Listening = result;
          })
          .catch(error => {
              console.error("Unable to check if web3 connected: " + error);
          });
  }
};
