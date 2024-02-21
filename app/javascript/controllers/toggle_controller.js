import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {

  static targets = ['toggle', 'post']

  connect() {

    console.log('Toggle loaded')

    this.toggleTarget.hidden = true
    console.log(this.toggleTarget.hidden)


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

    console.log('Clicked on ', e.target)

    let el = this.toggleTarget

    console.log('toggle showhide')
    el.hidden = !el.hidden
    console.log(this.toggleTargets)
  }
}
