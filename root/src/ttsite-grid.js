$(function(){ 
  $("#list").jqGrid({
    url:"/recipe/list",
    datatype:'json',
    mtype:'GET',
    colNames:['Name', 'Description', 'Picture', 'By' ],
    colModel :[ 
      {name:'name', index:'inv_id', width:100, editable:true, editoptions:{size:10}}, 
      {name:'description', index:'client_id', width:200, editable:true, editoptions:{size:10}},
      {name:'picture_url', index:'amount', width:100, align:'center', editable:true, editoptions:{size:10}}, 
      {name:'by', index:'amount', width:110, editable:true, editoptions:{size:10}}, 
    ],
    pager:'#pager',
    rowNum:10,
    rowList:[10,20,30],
    sortname:'name',
    sortorder:'desc',
    viewrecords:true,
    gridview:true,
    caption:'CookBloks',
    editurl:"[% c.uri_for("postrow") %]" 
  }); 

  jQuery("#list").jqGrid('navGrid','#pager',
    {}, //options
    {height:280,reloadAfterSubmit:false}, // edit options
    {height:280,reloadAfterSubmit:false}, // add options
    {reloadAfterSubmit:false}, // del options
    {} // search options
  ); 

});

