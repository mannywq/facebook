import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {

  static targets = ["modal"]
  connect() {

    console.log(this.element)
  }

  hideModal(event) {

    console.log(event)

    if (event.target == this.modalTarget) {

      console.log('It\'s a match')

      this.element.removeAttribute('src')
      this.modalTarget.remove()
    }

  }
}
