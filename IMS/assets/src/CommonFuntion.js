function DisableOnSave(curr,validationName)
{
    debugger;
    if (Page_ClientValidate(validationName))        
    {
        curr.disabled = 'true';
        curr.value = 'Processing...'
    }
   
}

function cleartextboxes() {
    $("input:text").val("");

}
