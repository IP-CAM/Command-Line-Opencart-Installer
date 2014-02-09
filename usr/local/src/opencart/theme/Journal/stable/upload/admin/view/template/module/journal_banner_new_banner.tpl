<?php echo $header; ?>

<div id="content">
      <!-- <div class="loader"> <p>Loading...</p></div> -->
    <div class="heading">
      <h1> <?php echo $doc_title; ?></h1>
      <div class="links">
          <a href="http://journal.digital-atelier.com/" class="demo-link" target="_blank">Journal Demo</a> &nbsp; | &nbsp;
          <a href="http://journal.digital-atelier.com/docs" class="docs-link" target="_blank">Documentation</a>
      </div>
      <div class="buttons"><a onclick="$('#form').submit();" class="btn btn-success"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-danger"><?php echo $button_cancel; ?></a></div>
    </div>
    <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">

    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form new-banner">
          <tr>
            <td><?php echo $entry_name; ?></td>
            <td>
              <input style="width:88px"  type="text" name="banner_options[name]" value="<?php echo $options['name']; ?>" size="100" />
              <?php if ($error_name) { ?>
              <span class="error"><?php echo $error_name; ?></span>
              <?php }?>
            </td>
          </tr>
        </table>
        <table id="images" class="list">
          <thead>
            <tr>
              <td class="left"><?php echo $entry_image; ?></td>
              <td class="left"><?php echo $entry_link; ?></td>
              <td class="left"><?php echo $entry_new_window; ?></td>
              <td class="left">Remove</td>
            </tr>
          </thead>
          <?php $image_row = 0; ?>
          <?php foreach ($banner_images as $banner_image) { ?>
          <tbody id="image-row<?php echo $image_row; ?>">
            <tr>

              <td class="left"><div class="image"><img src="<?php echo $banner_image['thumb']; ?>" alt="" id="thumb<?php echo $image_row; ?>" />
                  <input type="hidden" name="banner_image[<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['image']; ?>" id="image<?php echo $image_row; ?>"  />
                  <br />
                  <a onclick="image_upload('image<?php echo $image_row; ?>', 'thumb<?php echo $image_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;;&nbsp;;&nbsp;;&nbsp;;<a onclick="$('#thumb<?php echo $image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $image_row; ?>').attr('value', '');"><?php echo $text_clear; ?></a></div></td>

              <td class="left"><input type="text" name="banner_image[<?php echo $image_row; ?>][link]" value="<?php echo $banner_image['link']; ?>" /></td>
              <td class="left">
                <select class="yes_no" name="banner_image[<?php echo $image_row; ?>][new_window]">
                  <?php $selected1 = $banner_image['new_window'] ? 'selected="selected"' : ''; ?>
                  <?php $selected0 = !$banner_image['new_window'] ? 'selected="selected"' : ''; ?>
                  <option value="1" <?php echo $selected1; ?>><?php echo $text_yes; ?></option>
                  <option value="0" <?php echo $selected0; ?>><?php echo $text_no; ?></option>
                </select>
              </td>
              <td class="left"><a onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="btn"><?php echo $button_remove; ?></a></td>
            </tr>
          </tbody>
          <?php $image_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="3"></td>
              <td class="left" style="text-align: right; padding-right: 15px;"><a onclick="addImage();" class="btn btn-primary"><?php echo $button_add_image; ?></a></td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>

<script type="text/javascript"><!--

var image_row = <?php echo $image_row + 1; ?>;

function addImage() {
    html  = '<tbody id="image-row' + image_row + '">';
  html += '<tr>';
  html += '<td class="left"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + image_row + '" /><input type="hidden" name="banner_image[' + image_row + '][image]" value="" id="image' + image_row + '" /><br /><a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;;&nbsp;;&nbsp;;&nbsp;;<a onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';
  html += '<td class="left"><input type="text" name="banner_image[' + image_row + '][link]" value="" /></td>';
  html += '<td class="left"><select class="yes_no" name="banner_image[' + image_row + '][new_window]">';
  html += '<option value="1"><?php echo $text_yes; ?></option>';
  html += '<option value="0" selected="selected"><?php echo $text_no; ?></option>';
  html += '</select></td>';
  html += '<td class="left"><a onclick="$(\'#image-row' + image_row  + '\').remove();" class="btn"><?php echo $button_remove; ?></a></td>';
  html += '</tr>';
  html += '</tbody>';

  $('#images tfoot').before(html);

  image_row++;
}
//--></script>
<script type="text/javascript"><!--
function image_upload(field, thumb) {
  $('#dialog').remove();

  $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

  $('#dialog').dialog({
    title: '<?php echo $text_image_manager; ?>',
    close: function (event, ui) {
      if ($('#' + field).attr('value')) {
        $.ajax({
          url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
          dataType: 'text',
          success: function(data) {
            $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
          }
        });
      }
    },
    bgiframe: false,
    width: 700,
    height: 400,
    resizable: false,
    modal: false
  });
};

//--></script>
<?php echo $footer; ?>