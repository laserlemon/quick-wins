$ ->
  $checkAll = $("thead :checkbox")
  $checkboxes = $("tbody :checkbox")

  $checkAll.change (event) ->
    $checkboxes.prop("checked", $checkAll.prop("checked"))

  $checkboxes.change (event) ->
    totalCount = $checkboxes.length
    checkedCount = $checkboxes.filter(":checked").length

    if checkedCount == totalCount
      $checkAll.prop("checked", true)
    else
      $checkAll.prop("checked", false)
