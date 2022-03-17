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

require("trix")
require("@rails/actiontext")
import "chartkick/chart.js";


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
});