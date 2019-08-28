<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Board Register</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
					
						<div class="panel-heading">Board Register</div>
						<!-- /.panel-heading -->
						<div class="panel-body">

							<form role="form" action="/board/register" method="post">
							
								<div class="form-group">
									<label>Title</label> <input class="form-control" name='title'>
								</div>
								
								<div class="form-group">
									<label>Text area</label>
									<textarea class="form-control" rows="3" name="content"></textarea>
								</div>
								
								<!-- <div class="form-group">
									<label>Writer</label> <input class="form-control" name="writer">
								</div> -->
								<div class="form-group">
									<label>Writer</label>
									<input class="form-control" name="writer" value='<sec:authentication property="principal.username" />' readonly="readonly">									
								</div>
							
								<button type="submit" class="btn btn-default">Submit Button</button>
								<button type="reset" class="btn btn-default">Reset Button</button>
								
								<input type="hidden" name="${_csrf.parameterName}" vaule="${_csrf.token}">
										
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
	
	
	$(".uploadResult").on("click", "button", function(e){
		
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type:type},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			
			dataType: 'text',
			type: 'POST',
				success: function() {
					alert(result);
					
					targetLi.remove();
				}
			
		}); // $.ajax
		
	});

</script>


<%@include file="../includes/footer.jsp" %>