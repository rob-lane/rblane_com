class Settings
  constructor: ->
    @self = this;
    @form = $("ul.settings-form-group")
    self = @
    @form.find(".image-setting").each (index) ->
      $(this).find("input[type='file']").on 'change', self.preview_image

  preview_image: (preview_event)->
    new_img = this.files[0]
    img_container = $(preview_event.target).parents '.image-setting'
    reader = new FileReader
    reader.onload = (render_event)->
      img_container.find('img').attr 'src', event.target.result
    reader.readAsDataURL(new_img)

ready = ->
  window.settings = new Settings

$(document).ready(ready)
$(document).on('page:load', ready)