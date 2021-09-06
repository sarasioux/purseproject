import { createRouter, createWebHistory } from "vue-router";
import Home from "../pages/Home";
import Map from "../pages/Map";

const routes = [
  {
    // mode: 'history',
    path: "/",
    name: "Home",
    component: Home
  },
  {
    // mode: 'history',
    path: "/map/:id",
    name: "Map",
    component: Map
  }

];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
});

export default router;
