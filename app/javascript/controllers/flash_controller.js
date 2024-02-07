import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {

    console.log('Flash loaded')
  }

  dismiss(event) {

    this.element.remove()
    console.log('Message closed')

  }
}
