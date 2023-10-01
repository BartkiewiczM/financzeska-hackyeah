import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  static targets = ["box", "input", "loader", "institutionsDatabaseCheckbox", "smogDatabaseCheckbox"];

  connect() {
    this.scrollToBottom();
  }

  checkForEnter(event) {
    if (event.key === "Enter") {
      event.preventDefault();
      this.sendMessage();
    }
  }

  sendMessage(event) {
    if (event) event.preventDefault();
    console.log("sendMessage function called");

    const userMessageContent = this.inputTarget.value;

    const useInstitutionsDatabase = this.institutionsDatabaseCheckboxTarget.checked;
    const useSmogDatabase = this.smogDatabaseCheckboxTarget.checked;

    this.boxTarget.innerHTML += `<div class="text-right"><span class="inline-block px-4 py-2 rounded-lg bg-blue-500 text-white">${userMessageContent}</span></div>`;
    this.scrollToBottom();

    const typingIndicator = `<div class="text-left typing-indicator"><span class="inline-block px-4 py-2 rounded-lg bg-gray-300">...</span></div>`;
    this.boxTarget.innerHTML += typingIndicator;
    this.scrollToBottom();
    this.inputTarget.value = "";

    fetch("/chat/send_message", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({
        content: userMessageContent,
        useInstitutionsDatabase: useInstitutionsDatabase,
        useSmogDatabase: useSmogDatabase
      })
    })
    .then(response => response.json())
    .then(data => {
      const lastChild = this.boxTarget.lastElementChild;
      if (lastChild && lastChild.classList.contains('typing-indicator')) {
        lastChild.innerHTML = `<span class="inline-block px-4 py-2 rounded-lg bg-gray-300">${data.response}</span>`;
        lastChild.classList.remove('typing-indicator');
      }

      this.scrollToBottom();
    });
  }

  scrollToBottom() {
    this.boxTarget.scrollTop = this.boxTarget.scrollHeight;
  }
}
