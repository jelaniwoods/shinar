import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bridge--notification-token"
export default class extends Controller {
  static component = "notification-token"

  connect() {
    super.connect()
    this.send("connect")
  }
}
