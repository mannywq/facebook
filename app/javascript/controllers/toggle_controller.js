import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {

  static targets = ['toggle', 'post']

  connect() {

    this.toggleTarget.hidden = true


  }

  comments() {

    console.log(this.postTarget)

    let el = this.postTarget

    el.hidden = !el.hidden

    console.log(el.hidden)

  }


  showhide(e) {

    console.log('Clicked on ', e.target)

    let el = this.toggleTarget

    console.log('toggle showhide')
    el.hidden = !el.hidden
    console.log(this.toggleTargets)
  }
}
