import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

import ElementUi from 'element-ui'

import './styles/common.scss'
import 'normalize.css/normalize.css'
import 'element-ui/lib/theme-chalk/index.css'

import './icons'
import './permission'
import * as filters from './filters' // global filters

Vue.config.productionTip = false
Vue.use(ElementUi)

// register global utility filters
Object.keys(filters).forEach(key => {
  Vue.filter(key, filters[key])
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
