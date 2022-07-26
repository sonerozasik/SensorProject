import { createRouter, createWebHistory } from 'vue-router'
import LoginForm from '../views/LoginForm.vue'
import SignUpForm from '../views/SignUpForm.vue'
import DashBoardForm from '../views/DashboardForm.vue'
import SettingsForm from '../views/SettingsForm.vue'
import ChangePasswordForm from '../views/ChangePassword.vue'
import ChangeUsernameForm from '../views/ChangeUsername.vue'
import AddDeviceForm from '../views/AddDeviceForm.vue'
import DeleteDeviceForm from '../views/DeleteDeviceForm.vue'
const routes = [
  {
    path: '/',
    name: 'login',
    component: LoginForm
  },
  {
    path: '/signup',
    name: 'signup',
    component : SignUpForm
  },
  {
    path: '/dashboard',
    name: 'dashboard',
    component : DashBoardForm
  },
  {
    path: '/settings',
    name: 'settings',
    component : SettingsForm
  },
  {
    path: '/changepassword',
    name: 'changepassword',
    component : ChangePasswordForm
  },
  {
    path: '/changeusername',
    name: 'changeusername',
    component : ChangeUsernameForm
  },
  {
    path: '/adddevice',
    name: 'addDevice',
    component: AddDeviceForm
  },
  {
    path: '/deletedevice',
    name: 'deleteDevice',
    component: DeleteDeviceForm
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
