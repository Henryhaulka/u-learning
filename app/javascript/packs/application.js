// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "bootstrap";


//youtube player
import "youtube";

require("trix")
require("@rails/actiontext")
import "chartkick/chart.js";


// cocoon
require("jquery");
require("@nathanvda/cocoon");
//tric editor
import "../trix-editor-override";

//video.js
//run  'yarn add video.js'after adding the line below
import videojs from 'video.js'
import "video.js/dist/video-js.css";

// 'yarn add selectize'



require("selectize");

require("jquery")
require("jquery-ui-dist/jquery-ui");
$(document).on("turbolinks:load", function(){
  $('.lesson-sortable').sortable({
    cursor: "grabbing",
    cursorAt: { left: 4},
    placeholder: "ui-state-highlight",
    update: function (e, ui) {
      let item = ui.item;
      let itemData = item.data();
      let params = { _method: "put" };
      params[itemData.modelName] = { row_order_position: item.index() };
      $.ajax({
        type: "POST",
        url: itemData.updateUrl,
        dataType: "json",
        data: params,
      });
    },
    stop: function (e, ui) {
      console.log("stop called when finish sorting of cards");
    },
  });
  
  if ($(".selectize")) {
    $(".selectize").selectize({
      sortField: "text",
    });
  }
  // selectize with create action
  $(".selectize-tags").selectize({
    create: function (input, callback) {
      $.post("/tags.json", { tag: { name: input } }).done(function (response) {
        console.log(response);
        callback({ value: response.id, text: response.name });
      });
    },
  });

  let videoPlayer = videojs(document.getElementById('my-video'), {
    controls: true,
    playbackRates: [0.5, 1.0, 1.5],
    fluid: true,
    responsive: true,
    loop: false,
    liveui: true
  })
  videoPlayer.addClass('video-js')
  videoPlayer.addClass("vjs-big-play-centered");
});