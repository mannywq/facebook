import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal" defined in application.html.erb
export default class extends Controller {

  static targets = ["modal"]
  connect() {

    let body = document.body

    body.classList.add('pointer-events-none')

    this.modalTarget.classList.add('pointer-events-auto')

    console.log(this.modalTarget)

  }

  close(event) {


    if (event.target == this.modalTarget || event.key == "Escape") {

      console.log('It\'s a match')

      document.body.classList.remove('pointer-events-none')

      this.element.removeAttribute('src')
      this.modalTarget.remove()
    }

  }
}
