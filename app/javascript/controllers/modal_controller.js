import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal" defined in application.html.erb
export default class extends Controller {

  static targets = ["modal"]
  connect() {

  }

  close(event) {


    if (event.target == this.modalTarget || event.key == "Escape") {

      console.log('It\'s a match')

      this.element.removeAttribute('src')
      this.modalTarget.remove()
    }

  }
}
