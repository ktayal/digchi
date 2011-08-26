var MESSAGE_ID="*This is a place to help each other by providing the relevant and righteous information.So please understand it and don't put offensive, irrelevant, vulgar messages and try to keep it clean and helpful to people like us who really can be benefitted from this place.",SIGNATURE_ID=":-a humble request from Digchi";
function init_date_picker(){jQuery(function(){var a=jQuery("#from, #to").datepicker({defaultDate:"+0w",changeMonth:true,numberOfMonths:1,onSelect:function(b){var c=this.id=="from"?"minDate":"maxDate",d=jQuery(this).data("datepicker");date=jQuery.datepicker.parseDate(d.settings.dateFormat||jQuery.datepicker._defaults.dateFormat,b,d.settings);a.not(this).datepicker("option",c,date)}})})}var prev_comp=null;
function fetch_for_company(a,b){if(a==""||a==null){alert("plz select a company first");return false}b.style.backgroundColor="whitesmoke";if(prev_comp!=null)prev_comp.style.backgroundColor="";prev_comp=b;document.getElementById("from").value="";document.getElementById("to").value="";jQuery("#from, #to").datepicker("option",{minDate:null,maxDate:null});jQuery.noConflict();new Ajax.Updater("posts_pane","/post/notices_from_company",{method:"post",evalScripts:true,parameters:{company:a},onLoading:document.getElementById("loading_image_div").innerHTML=
document.getElementById("loading_image").innerHTML});window.history.pushState({company:a},"","/post/index?company="+remove_and(a))}var intervalID=window.setInterval(update_popular,5E4);function update_popular(){jQuery.noConflict();new Ajax.Updater("ad_list_div","/post/update_popular_post",{method:"post",evalScripts:true,onLoading:{},onSuccess:{}})}
function fetch_records(a,b,c,d,e){if(b==""||b==null){document.getElementById("from").focus();alert("select start date")}else if(c==""||c==null){document.getElementById("to").focus();alert("select end date")}else{jQuery.noConflict();new Ajax.Updater("posts_pane","/post/select_for_dates",{method:"post",evalScripts:true,parameters:{company:a,start_date:b,end_date:c,category:d,city:e},onLoading:document.getElementById("loading_image_div").innerHTML=document.getElementById("loading_image").innerHTML,onSuccess:{}})}}
function minus_image(a){a.src="/images/minus.png"}function plus_image(a){a.src="/images/plus.png"}
function show_details(a,b){jQuery.noConflict();if(Element.visible(b)){a.innerHTML='<img src="/images/plus.png" title="view contact details" id="details_btn" onmouseover="this.src=\'/images/minus.png\'" onmouseout="this.src=\'/images/plus.png\'" ></img>';Effect.BlindUp(b,{duration:0.5})}else{a.innerHTML='<img src="/images/minus.png" title="view contact details" id="details_btn" onmouseover="this.src=\'/images/plus.png\'" onmouseout="this.src=\'/images/minus.png\'" ></img>';Effect.BlindDown(b,{duration:0.5})}}
function show_popular_post_details(a,b){jQuery.noConflict();if(Element.visible(b)){a.innerHTML='<img src="/images/plus.png" title="view contact details" style="left:145px;" id="details_btn" onmouseover="this.src=\'/images/minus.png\'" onmouseout="this.src=\'/images/plus.png\'" ></img>';Effect.BlindUp(b,{duration:0.5})}else{a.innerHTML='<img src="/images/minus.png" title="view contact details" style="left:145px;" id="details_btn" onmouseover="this.src=\'/images/plus.png\'" onmouseout="this.src=\'/images/minus.png\'" ></img>';
Effect.BlindDown(b,{duration:0.5})}}function closepopup(){jQuery.noConflict();Element.visible("popper_div")&&Element.hide("popper_div")}
function validate_fields(a,b,c,d,e,f,g,h){if(a==""){document.getElementById("share_name").focus();alert("name can't be null");return false}if(a.length>100){alert("name length can't greater than 100 characters :(");return false}if(b==""||b==null){document.getElementById("share_email").focus();alert("email can't be null");return false}if(validate_email(b)==false){document.getElementById("share_email").value="";document.getElementById("share_email").focus();return false}if(c==""){document.getElementById("share_phone").focus();
alert("phone can't be null");return false}if(validate_phone(c)==false){document.getElementById("share_phone").value="";document.getElementById("share_phone").focus();return false}if(d==""){document.getElementById("share_company").focus();alert("company can't be null");return false}if(d.length>100){alert("company length can't be greater than 100 characters :(");return false}if(e==""){document.getElementById("share_city").focus();alert("city can't be null");return false}if(e.length>100){alert("city length can't be greater than 100 characters :(");
return false}if(f==""){document.getElementById("share_title").focus();alert("title can't be null");return false}if(f.length>500){alert("title length can't be greater than 500 characters :(");return false}if(g==""){document.getElementById("share_message").focus();alert("message can't be null");return false}if(g.length>2500){alert("message length exceeded(max 2500 chars).. try ro keep it short");return false}format_text(g);if(h==-1){document.getElementById("share_category").focus();alert("plz select a category for your notice");
return false}return true}function post_notice(a,b,c,d,e,f,g,h){if(validate_fields(a,b,c,d,e,f,g,h)==true){document.getElementById("share_this_post_form").submit();return true}return false}function validate_phone(a){if(a.length<10||isInteger(a)==false){alert("InValid Phone number");return false}return true}function isInteger(a){var b;for(b=0;b<a.length;b++){var c=a.charAt(b);if(c<"0"||c>"9")return false}return true}
function validate_email(a){var b=a.indexOf("@"),c=a.length;a.indexOf(".");if(a.indexOf("@")==-1){alert("Invalid E-mail ID");return false}if(a.indexOf("@")==-1||a.indexOf("@")==0||a.indexOf("@")==c){alert("Invalid E-mail ID");return false}if(a.indexOf(".")==-1||a.indexOf(".")==0||a.indexOf(".")==c){alert("Invalid E-mail ID");return false}if(a.indexOf("@",b+1)!=-1){alert("Invalid E-mail ID");return false}if(a.substring(b-1,b)=="."||a.substring(b+1,b+2)=="."){alert("Invalid E-mail ID");return false}if(a.indexOf(".",
b+2)==-1){alert("Invalid E-mail ID");return false}if(a.indexOf(" ")!=-1){alert("Invalid E-mail ID");return false}return true}function edit_notice(a,b,c,d,e,f,g,h){if(validate_fields(a,b,c,d,e,f,g,h)==true){document.getElementById("modify_notice").action="/post/save_edit_notice";document.getElementById("modify_notice").submit();return true}return false}
function delete_notice(a,b,c,d,e,f,g,h){if(validate_fields(a,b,c,d,e,f,g,h)==true){document.getElementById("modify_notice").action="/post/delete_notice";document.getElementById("modify_notice").submit();return true}return false}
function edit_notice_id(){ref_id=document.getElementById("s_reference_id").value;if(ref_id==""||ref_id==null)alert("First enter notice id..");else{document.getElementById("search_this_notice").action="/post/edit_notice_id";document.getElementById("search_this_notice").submit()}}
function search_notice_id(){var a=document.getElementById("s_reference_id").value;if(a==""||a==null)alert("First enter notice id..");else{jQuery.noConflict();new Ajax.Updater("posts_pane","/post/search_notice_id",{method:"post",evalScripts:true,parameters:{ref_id:a},onLoading:document.getElementById("loading_image_div").innerHTML=document.getElementById("loading_image").innerHTML})}}function disableEnterKey(a){return(window.event?window.event.keyCode:a.which)==13?false:true}
function fetch_for_categories(a,b,c){if(b==""||b==null){alert("plz select a company first");return false}if(a==""||a==null){alert("plz select a category first");return false}if(c==""||c==null){alert("plz select a city first");return false}document.getElementById("from").value="";document.getElementById("to").value="";jQuery("#from, #to").datepicker("option",{minDate:null,maxDate:null});jQuery.noConflict();new Ajax.Updater("posts_pane","/post/notices_from_category",{method:"post",evalScripts:true,
parameters:{company:b,category:a,city:c},onLoading:document.getElementById("loading_image_div").innerHTML=document.getElementById("loading_image").innerHTML});window.history.pushState({company:b},"","/post/index?company="+remove_and(b)+"&category="+remove_and(a)+"&city="+remove_and(c))};function format_text(text)
    {
    text=text.replace(/\n/g,'<br>');
    text=text.replace(/ /g,'&nbsp');
    document.getElementById('share_message_formatted').value=text;
    }
    
    function re_format_text(text)
    {
    text=text.replace(/<br>/g,'\n');
    text=text.replace(/&nbsp/g,' ');
    document.getElementById('share_message').value=text;
    }

    function Linkify(div_name) 
    {
    var inputText=document.getElementById(div_name).innerHTML;
    //URLs starting with http://, https://, or ftp://
    var replacePattern1 = /(\b(https?|ftp):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/gim;
    var replacedText = inputText.replace(replacePattern1, '<a href="$1" target="_blank">$1</a>');

    //URLs starting with www. (without // before it, or it'd re-link the ones done above)
    var replacePattern2 = /(^|[^\/])(www\.[\S]+(\b|$))/gim;
    var replacedText = replacedText.replace(replacePattern2, '$1<a href="http://$2" target="_blank">$2</a>');

    //Change email addresses to mailto:: links
    var replacePattern3 = /(\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,6})/gim;
    var replacedText = replacedText.replace(replacePattern3, '<a href="mailto:$1">$1</a>');

    document.getElementById(div_name).innerHTML=replacedText;
    // return replacedText
    }
    function remove_and(string)
    {
    return string.replace('&','%26');
    }