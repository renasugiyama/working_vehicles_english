// app/javascript/application.js
// Require Rails UJS for handling method: :delete in link_to helpers
import Rails from "@rails/ujs"
Rails.start()

// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// Import the new JavaScript file
import "./menu"
import "./mypage"
import "./speak";
import "./toggle_button";
import "./google_login";
import './toggle_register_button';
import './player_video_settings';
import './swiper';