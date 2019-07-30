<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Board Read Page</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
					
						<div class="panel-heading">Board Read Page</div>
						<!-- /.panel-heading -->
						<div class="panel-body">

								<div class="form-group">
									<label>Bno</label> <input class="form-control" name="bno" value='<c:out value="${board.bno}" />' readonly="readonly">
								</div>
								
								<div class="form-group">
									<label>Title</label> <input class="form-control" name="title" value='<c:out value="${board.title}" />' readonly="readonly">
								</div>
								
								<div class="form-group">
									<label>Text area</label>
									<textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content }" /></textarea>
								</div>
								
								<div class="form-group">
									<label>Writer</label> <input class="form-control" name="writer" value='<c:out value="${board.writer}" />' readonly="readonly">
								</div>
							
								<button data-oper="modify" class="btn btn-default"
									onclick="location.href='/board/modify?bno=<c:out value="${board.bno }" />' ">
									<%-- <a href="/board/modify?bno=<c:out value="${board.bno}" />">Modify</a> --%>
									Modify
								</button>
								<button data-oper="list" class="btn btn-info"
									onclick="location.href='/board/list' ">
									<!-- <a href="/board/list">List</a> -->
									List
								</button>
								
								<!-- <button data-oper='modify' class="btn btn-default">Modify</button>
								<button data-oper='list' class="btn btn-info">List</button> -->
							
								<form id="operForm" action="/board/modify" method="get">
									<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno }"/>'>
									<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
									<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
									<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
									<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
								</form>
								
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-6 -->
			</div>
			<!-- /.row -->
			
			<div class="row">
				<div class="col-lg-12">
					
					<!-- /.panel panel-default -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-comments fa-fw"></i> Reply
						</div>

						<!-- /.panel-body -->
						<div class="panel-body">
							
							<ul class="chat">
								
								<li class="left clearfix" data-rno="12">
									<div>
										<div class="header">
											<strong class="primary-font">user00</strong>
											<small class="pull-right text-muted">2018-01-01 13:13</small>
											
											<p>Good job!</p>
										</div>
									</div>
								</li>
							</ul>						
						</div>	
					</div>			
					<!-- /.panel panel-default -->
				</div>
			</div>


<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">

console.log("==============");
console.log("JS TEST");

var bnoValue = '<c:out value="${board.bno}" />';

/* // for replyService add test
replyService.add(
	{reply: "JS Test", replyer: "tester", bno:bnoValue},
	function(result) {
		alert("RESULT: " + result);
	}
);

$(document).ready(function() {
	
	console.log(replyService);
}); */

replyService.getList({bno:bnoValue, page:1}, function(list){
	
	for(var i = 0, len = list.length || 0; i < len; i++) {
		console.log(list[i]);
	}
});


/* replyService.remove(23, function(count) {
	
	console.log(count);
	
	if (count === "success") {
		alert('REMOVED');
	}
	
}, function(err) {
	alert('ERROR');
}); */


/* replyService.update({
	rno : 22,
	bno : bnoValue,
	reply : "Modified Reply...."
}, function(result) {
	alert("修正完了。");
});

replyService.get(10, function(data){
	console.log()
}); */


$(document).ready(function() {
	
	var bnoValue = '<c:out value="${board.bno}" />';
	var replyUL = $(".chat");
	
		showList(1);
	
		function showList(page) {
			
			replyService.getList({bno:bnoValue, page: page || 1}, function(list) {
				
				var str = "";
				if(list == null || list.length == 0) {
					replyUL.html("");					
			
					return;
				}
				
				for (var i = 0, len = list.length || 0; i < len; i++) {
					str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str += "<div><div class='header'><strong class='primary-font'>" +list[i].replyer+ "</strong>";
					str += "<small class='pull-right text-muted'>" + list[i].replyDate + "</small><div>";
					str += "<p>" + list[i].reply + "</p></div></li>"
				}
				replyUL.html(str);
				
			}); // end function
			
		} // end showLIst
	
});


function displayTime(timeValue) {
	
	var today = new Data();
	
	var gap = today.getTime() - timeValue;
	
	var dateObj = new Date(timeValue);
	var str = "";
	
	if (gap < (1000 * 60 * 60 *24)) {
		
		var hh = dateObj.getHours();
		var mi = dateObj.getMinutes();
		var ss = dateObj.getSeconds();
		
		
	}
}


</script>

<script type="text/javascript">

$(document).ready(function() {
	
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action", "/board/modify").submit();		
	});
	
	$("button[data-oper='list']").on("click", function(e){
		alert(operForm.find("input[name='bno']").val());
		alert(operForm.find("input[name='amount']").val());
		
		operForm.find("#bno").remove();
		operForm.attr("action","/board/list")
		operForm.submit();
	});
	
});

</script>

<%@include file="../includes/footer.jsp" %>