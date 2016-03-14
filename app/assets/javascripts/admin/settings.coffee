class Settings
  constructor: ->
    @self = this;
    @form = $("ul.settings-form-group")
    self = @
    @form.find(".image-setting").each (index) ->
      $(this).find("input[type='file']").on 'change', self.preview_image
      $(this).find(".file-revert-button").on 'click', self.revert_image

  preview_image: (preview_event)->
    new_img = this.files[0]
    img_container = $(preview_event.target).parents '.image-setting'
    reader = new FileReader
    reader.onload = (render_event)->
      img_container.find('img').attr 'src', event.target.result
    reader.readAsDataURL(new_img)

  revert_image: (click_event)->
    btn_element = $(click_event.target)
    setting_id = parseInt(btn_element.data('setting-id'))
    $.ajax
      url: "/admin/settings/revert",
      method: "POST",
      contentType: 'application/json',
      dataType: 'json',
      data: JSON.stringify({id: setting_id})
      complete: (data, status)->
        window.location.reload();

ready = ->
  window.settings = new Settings

$(document).ready(ready)
$(document).on('page:load', ready)