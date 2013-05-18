<%@include file="../init.jsp"%>


<aui:layout cssClass="mainLayout">
	<div id='<portlet:namespace/>gists'>
		<ul id='<portlet:namespace/>gistlist' style="display:none">
		
		
		</ul>
	
	</div>
</aui:layout>

<aui:script >
console.log("Entering my gists");

AUI().ready(

	'aui-base','aui-io-request',
function(A){

	var gistlist = A.one('#<portlet:namespace/>gistlist');

	function log(value) {
		console.log(value);
	}
		
	YUI.AUI.namespace('defaults.io').uriFormatter = function(v) {
		// set a default formatter for the URI parameter
		return v;
	};
		
	var io = A.io.request(
		'https://api.github.com/users/davidecavaliere/gists',
		{
			autoLoad: true,
			dataType: 'json',
			method: 'get',
				on: {
					start: function(event, id) {
						log('-');
						log(this.get('uri'));
						log('start');
						// console.log('start', arguments);
						// event.halt();
					},
					success: function(event, id, xhr) {
						var data = this.get('responseData');
						log(data);
						log(data.length)
						
						for (var i=0; i < data.length; i++) {
							var gistId = data[i].id;
							var gistURL = data[i].html_url;
							var gistDesc = data[i].description;
							
							if (gistDesc === '') {
								gistDesc = 'gist:'+gistId;
							}
							
							var gist = A.Node.create('<li id="'+gistId+'" class="gist"><a href="'+ gistURL+'" target="_blank">'+gistDesc+'</a></li>');
							gistlist.appendChild(gist);
						}
						
					},
					complete: function(event, id, xhr) {
						log('complete');
						gistlist.setStyle('display', 'block');
					},
					failure: function(event, id, xhr) {
						log('failure');
					},
					end: function(event, id) {
						log('end');
					}
				},
				after: {
					start: function() {
						log('after start');
					}
				}
		});

});


</aui:script>


