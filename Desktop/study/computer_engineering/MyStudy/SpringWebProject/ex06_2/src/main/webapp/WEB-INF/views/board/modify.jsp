<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Board Modify Page</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
					
						<div class="panel-heading">Board Modify Page</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
						
						<form role="form" action="/board/modify" method="post">
						
								<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }" />'>
								<input type='hidden' name='amount' value='<c:out value="${cri.amount }" />'>
								<input type='hidden' name='type' value='<c:out value="${cri.type }" />'>
								<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }" />'>
								
								<input type='hidden' name="${_csrf.parameterName}" value="${_csrf.token}" />
								

								<div class="form-group">
									<label>Bno</label> 
									<input class="form-control" name="bno" value='<c:out value="${board.bno}" />' readonly="readonly">
								</div>
								
								<div class="form-group">
									<label>Title</label> 
									<input class="form-control" name="title" value='<c:out value="${board.title}" />'>
								</div>
								
								<div class="form-group">
									<label>Text area</label>
									<textarea class="form-control" rows="3" name="content"><c:out value="${board.content }" /></textarea>
								</div>
								
								<div class="form-group">
									<label>Writer</label> 
									<input class="form-control" name="writer" value='<c:out value="${board.writer}" />' readonly="readonly">
								</div>
								
								<div class="form-group">
									<label>RegDate</label>
									<input class="form-control" name="regData" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}" />' readonly="readonly">
								</div>
								
								<div class="form-group">
									<label>Update Date</label>
									<input class="form-control" name="updateData" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}" />' readonly="readonly">
								</div>
							
								<sec:authentication property="principal" var="pinfo" />
								
								<sec:authorize access="isAuthenticated()">
								
								<c:if test="${pinfo.username eq board.writer}">
																	
									<button type="submit" data-oper="modify" class="btn btn-default">
										Modify
									</button>
									<button type="submit" data-oper="remove" class="btn btn-default">
										Remove
									</button>
								
								</c:if>
								
								</sec:authorize>
															
								
								<button type="submit" data-oper="list" class="btn btn-default">
									List
								</button>
								
								<%-- <button data-oper="modify" class="btn btn-default">
									<a href="/board/modify?bno=<c:out value="${board.bno}" />">Modify</a>
								</button>
								<button data-oper="list" class="btn btn-info">
									<a href="/board/list">List</a>
								</button> --%>
							
						</form>
						
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-6 -->
			</div>
			<!-- /.row -->
			
			
<script type="text/javascript">

	$(document).ready(function() {
		
		var formObj = $("form");
		
		$('button').on("click", function(e){
			
			e.preventDefault();
			
			var operation = $(this).data("oper");
			alert(operation);
			
			console.log(operation);
			
			if (operation === 'remove') {
				formObj.attr("action", "/board/remove");
				
			} else if (operation === 'list') {
				//move to list
				//self.location = "/board/list";
				//return;
				formObj.attr("action", "/board/list").attr("method", "get");
				
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				
				/* alert("pageNumTag: " + $("input[name='pageNum']").val() +", amountTag: "+ $("input[name='amountTag']").val()); */
				
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
				
			}
			formObj.submit();
			
		});
	});

	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";

	$("input[type='file']").change(function(e){
		
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		for (var i = 0; i < files.length; i++) {
			
			if (!checkExtension(files[i],name, files[i].size)) {
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
		
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data: formData,
			type: 'POST',
			dataType: 'json',
				succes: function(result) {
					console.log(result);
					showUploadResult(result);
				}
			
		}); // $.ajax
		
	});
	
	
</script>


<%@include file="../includes/footer.jsp" %>