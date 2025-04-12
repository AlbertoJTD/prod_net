import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['submitButton', 'spinner', 'submitText', 'cancelButton'];
  static values = {
    loadingText: { type: String, default: 'Processing...' },
    submitText: { type: String, default: 'Submit' }
  }

  connect() {
    this.element.addEventListener('turbo:submit-start', this.showLoading.bind(this));
    this.element.addEventListener('turbo:submit-end', this.hideLoading.bind(this));
  }

  disconnect() {
    this.element.removeEventListener('turbo:submit-start', this.showLoading.bind(this));
    this.element.removeEventListener('turbo:submit-end', this.hideLoading.bind(this));
  }

  showLoading() {
    this.submitButtonTarget.disabled = true;
    this.cancelButtonTarget.disabled = true;
    this.spinnerTarget.classList.remove('hidden');
    this.submitTextTarget.textContent = this.loadingTextValue;
  }

  hideLoading() {
    this.submitButtonTarget.disabled = false;
    this.cancelButtonTarget.disabled = false;
    this.spinnerTarget.classList.add('hidden');
    this.submitTextTarget.textContent = this.submitTextValue;
  }
} 