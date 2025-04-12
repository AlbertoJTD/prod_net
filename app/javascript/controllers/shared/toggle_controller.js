import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shared--toggle"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.remove('opacity-0', 'translate-y-2');
    }, 50)

    setTimeout(() => {
      this.dismiss();
    }, 5000);
  }

  dismiss() {
    this.element.classList.add('opacity-0', 'translate-y-2');

    setTimeout(() => {
      this.element.remove()
    }, 300)
  }
}
