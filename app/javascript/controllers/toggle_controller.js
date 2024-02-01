import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {

  static targets = ['toggle', 'post']

  connect() {

    console.log('Toggle loaded')


  }

  frameUpdate(event) {

    console.log(event)
  }

  comments() {

    console.log(this.postTarget)

    let el = this.postTarget

    el.hidden = !el.hidden

    console.log(el.hidden)




  }

  hideModal(e) {

    console.log(e)
    console.log(this.element.parentElement)

  }



  showhide(e) {

    console.log(e)

    console.log('toggle clicked')
    this.toggleTarget.classList.toggle("hidden")
  }
}
