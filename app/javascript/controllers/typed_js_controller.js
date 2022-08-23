import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"
// Connects to data-controller="typed-js"
export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["Our shared vision of belonging is the thread that weaves through every touchpoint on Airbnb."],
      typeSpeed: 100,
      loop: true
    })
  }
}
