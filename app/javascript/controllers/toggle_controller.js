import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {

  static targets = ['toggle']

  connect() {


  }

  frameUpdate(event) {

    console.log(event)
  }



  showhide() {

    console.log('toggle clicked')
    this.toggleTarget.classList.toggle("hidden")
  }
}
