import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shared--modal"
export default class extends Controller {
  static targets = ['modal'];

  connect() {
    this.element.classList.remove('hidden')
    // Trigger reflow to ensure transition works
    void this.element.offsetWidth;
    
    // Add classes for the transition
    const overlay = this.element.querySelector('.bg-gray-900');
    const content = this.element.querySelector('.transform');
    
    overlay.classList.add('opacity-50');
    content.classList.remove('scale-95');
  }

  close() {
    const overlay = this.element.querySelector('.bg-gray-900');
    const content = this.element.querySelector('.transform');
    
    // Start the closing animation
    overlay.classList.remove('opacity-50');
    content.classList.add('scale-95');
    
    // Wait for the animation to complete before hiding
    setTimeout(() => {
      this.element.classList.add('hidden');
    }, 300);
  }

  hideModal() {
    this.close();
    setTimeout(() => {
      this.element.parentElement.removeAttribute('src');
      this.element.remove();
    }, 300);
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
