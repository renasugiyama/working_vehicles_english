// Require Rails UJS for handling method: :delete in link_to helpers
import Rails from "@rails/ujs"
Rails.start()

// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// Import the new JavaScript file
import "./menu"
import "./mypage"
