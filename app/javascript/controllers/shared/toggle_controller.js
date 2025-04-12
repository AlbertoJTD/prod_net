import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shared--toggle"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.dismiss();
    }, 5000);
  }

  dismiss() {
    this.element.remove();
  }

  close() {
    this.dismiss();
  }
}
