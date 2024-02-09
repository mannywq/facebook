import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload"
export default class extends Controller {

  static targets = ['preview']
  connect() {

    console.log(this.element)
  }

  change(event) {


    let files = event.target.files


    for (let i = 0; i < files.length; i++) {
      console.log('Added ', i, ' images')
      this.element.insertAdjacentHTML('afterbegin', '<img src="#" data-upload-target="preview" hidden>')
    }

    let elements = this.previewTargets

    console.log(elements)

    elements.forEach((el, idx) => {

      console.log(el.hidden)

      if (event.target.files && event.target.files[idx]) {

        el.src = URL.createObjectURL(event.target.files[idx])


        el.hidden = !el.hidden
      }

    })
    //    el.hidden = !el.hidden

    //  this.previewTarget.src = URL.createObjectURL(event.target.files[0])
  }
}
