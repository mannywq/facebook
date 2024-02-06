import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {

  static classes = ['active', 'text-blue-600', 'border-b-2', 'border-blue-600']
  static targets = ['btn', 'tab']
  static values = { defaultTab: String }

  connect() {

    console.log('Tabs loaded')

    this.tabTargets.map(tab => tab.hidden = true)

    let selectedTab = this.tabTargets.find(el => el.id == this.defaultTabValue)
    selectedTab.hidden = false

    let selectedBtn = this.btnTargets.find(el => el.id == this.defaultTabValue)
    selectedBtn.classList.add(...this.activeClasses)

    console.log(this.activeClasses)
  }

  select(event) {

    console.log(event.currentTarget)

    let selectedTab = this.tabTargets.find(el => el.id == event.currentTarget.id)

    if (selectedTab.hidden) {
      this.tabTargets.map(el => el.hidden = true)
      this.btnTargets.map(el => el.classList.remove(...this.activeClasses))
    }

    selectedTab.hidden = false
    console.log(selectedTab.hidden)

    event.currentTarget.classList.add(...this.activeClasses)

  }
}
