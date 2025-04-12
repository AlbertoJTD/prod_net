import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shared--modal"
export default class extends Controller {
  static targets = ['modal'];

  open() {
    this.element.classList.remove('hidden')
  }

  close() {
    this.element.classList.add('hidden')
  }

  hideModal() {
    this.element.parentElement.removeAttribute('src');
    this.element.remove();
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal();
    }
  }

  // closeBackgroud(e) {
  //   console.log('I am here');
  //   debugger;
  //   let containsValue = this.modalTarget.contains(e.target);
  //   console.log('containsValue', containsValue);
  //   if (e && this.modalTarget.contains(e.target)) {
  //     return;
  //   }

  //   this.hideModal();
  // }
}
