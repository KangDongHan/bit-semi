<%@page import="java.util.List"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Liquor Store - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css2?family=Spectral:ital,wght@0,200;0,300;0,400;0,500;0,700;0,800;1,200;1,300;1,400;1,500;1,700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" href="css/animate.css">
    
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.min.css">
    
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
  <style type="text/css">
  #fonts,#fontss,#fontss2,#fontss3{
  font-size: 1.5em;
  color: black;
  }
  </style>
  <script type="text/javascript">
  $(function() {
	  $(document).on("change","#fontss2",function() {

 		var writer2 = "";
		writer2=$(this).val();
		/* alert(writer2);	 */	
		$("#tex1").html(writer2);
	});
});
  $(function() {
	  $(document).on("change","#fontss3",function() {

 		var writer2 = "";
		writer2=$(this).val();
		/* alert(writer2);	 */	
		$("#tex2").html(writer2);
	});
});
  </script>
  </head>
  <%	
	String email = (String)session.getAttribute("myid");
	LoginDao dao = new LoginDao();
	LoginDto dto = dao.getUserInfo(2, email);
	System.out.println(dto.getEmail());
	
	
	ProductDao pdao = new ProductDao();
/* 	String writer = request.getParameter("writer"); */

	List<ProductDto> list = pdao.getAllDatas();
	
	
	
%>
  <body>


    <section class="ftco-section">
    	<div class="container">
    		<div class="row justify-content-center">
          <div class="col-xl-10 ftco-animate">
						<form action="#" class="billing-form">
							<h3 class="mb-4 billing-heading">Reservation</h3>
	          	<div class="row align-items-end">
	          		<div class="col-md-6">
	                <div class="form-group">
	                	<label for="firstname">Name</label>
	                  <input type="text" class="form-control" id="fonts"
	                   placeholder="이름을 입력하세요" value="<%=dto.getName() %>">
	                </div>
	              </div>
	              
<!--                 <div class="w-100"></div>
		            <div class="col-md-12">
		            	<div class="form-group">
		            		<label for="country">Model</label>
		            		<div class="select-wrap">
		                  <div class="icon"><span class="ion-ios-arrow-down" ></span></div>
		                  <select name="" class="form-control" id="fontss" name="writer3">
		                  	<option value="ev">ev</option>
		                  	<option value="seungyong">승용</option>
		                  	<option value="rv">rv</option>
		                  	<option value="sangyong">상용/택시/버스</option>

		                  </select>
		                </div>
		            	</div>
		            </div>
		             -->
                <div class="w-100"></div>
		            <div class="col-md-12">
		            	<div class="form-group">
		            		<label for="country">Car Name</label>
		            		<div class="select-wrap">
		                  <div class="icon"><span class="ion-ios-arrow-down" ></span></div>
		                  <select name="" class="form-control" id="fontss2">
		                  <%for(ProductDto pdto:list){%>
		                  	<option value="<%=pdto.getSubject()%>"><%=pdto.getSubject()%></option>
						 <%} %>
		                  </select>
		                </div>
		            	</div>
		            </div>

		            <div class="w-100"></div>
		            <div class="col-md-6">
		            	<div class="form-group">
	                	<label for="streetaddress">Street Address</label>
	                  <input type="text" class="form-control" value="<%=dto.getAddr1() %>"
	                  placeholder="House number and street name" id="fonts"
	                  style="color: black;">
	                </div>
		            </div>
<!-- 		            <div class="col-md-6">
		            	<div class="form-group">
	                  <input type="text" class="form-control" placeholder="Appartment, suite, unit etc: (optional)">
	                </div>
		            </div> -->
		            <div class="w-100"></div>
		            <div class="col-md-6">
		            	<div class="form-group">
	                	<label for="towncity">Town / City</label>
	                  <input type="text" class="form-control" value="<%=dto.getAddr2() %>"
	                  placeholder="" id="fonts">
	                </div>
		            </div>
		            <div class="col-md-6">
		            	<div class="form-group">
		            		<label for="postcodezip">Postcode / ZIP *</label>
	                  <input type="text" class="form-control" value="<%=dto.getPostcode() %>"
	                  placeholder="" id="fonts">
	                </div>
		            </div>
		            <div class="w-100"></div>
		            <div class="col-md-6">
	                <div class="form-group">
	                	<label for="phone">Phone</label>
	                  <input type="text" class="form-control" value="<%=dto.getMobile1()%>-<%=dto.getMobile2()%>-<%=dto.getMobile3()%>"
	                   placeholder="" id="fonts">
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="form-group">
	                	<label for="emailaddress">Email Address</label>
	                  <input type="text" class="form-control" value ="<%=dto.getEmail()%>"
	                   placeholder="" id="fonts">
	                </div>
                </div>
                <div class="w-100"></div>
		            <div class="col-md-12">
		            	<div class="form-group">
		            		<label for="country">Date</label>
		            		<div class="select-wrap">
		                  <div class="icon"><span class="ion-ios-arrow-down" ></span></div>
		                  <select name="" class="form-control" id="fontss3">	                  
		                  	<option value="">YYYY-DD-MM</option>
		                  </select>
		                </div>
		            	</div>
		            </div>
                <div class="w-100"></div>
    <!--             <div class="col-md-12">
                	<div class="form-group mt-4">
										<div class="radio">
										  <label class="mr-3"><input type="radio" name="optradio"> Create an Account? </label>
										  <label><input type="radio" name="optradio"> Ship to different address</label>
										</div>
									</div>
                </div> -->
	            </div>
	          </form><!-- END -->



	          <div class="row mt-5 pt-3 d-flex">
	          	<div class="col-md-6 d-flex">
	          		<div class="cart-detail cart-total p-3 p-md-4">
	          			<h3 class="billing-heading mb-4">Total</h3>
	          			<p class="d-flex">
		    						<span>Model</span>
		    						<span id="tex1"> </span>
		    					</p>
		    					<p class="d-flex">
		    						<span>Date</span>
		    						<span id="tex2">yyyy-MM-hh</span>
		    					</p>
		    					<hr>
		    					<p class="d-flex total-price">
		    						<span>예약하시겠습니까?</span>
		    						<span> </span>
		    					</p>
								<p><a href="#"class="btn btn-primary py-3 px-4">Make An Appointment</a></p>
								</div>
	          	</div>
	<!--           	<div class="col-md-6">
	          		<div class="cart-detail p-3 p-md-4">
	          			<h3 class="billing-heading mb-4">Payment Method</h3>
									<div class="form-group">
										<div class="col-md-12">
											<div class="radio">
											   <label><input type="radio" name="optradio" class="mr-2"> Direct Bank Tranfer</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-12">
											<div class="radio">
											   <label><input type="radio" name="optradio" class="mr-2"> Check Payment</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-12">
											<div class="radio">
											   <label><input type="radio" name="optradio" class="mr-2"> Paypal</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-md-12">
											<div class="checkbox">
											   <label><input type="checkbox" value="" class="mr-2"> I have read and accept the terms and conditions</label>
											</div>
										</div>
									</div>
									<p><a href="#"class="btn btn-primary py-3 px-4">Place an order</a></p>
								</div>
	          	</div> -->
	          </div>
          </div> <!-- .col-md-8 -->
        </div>
    	</div>
    </section>

 

  <script src="js/jquery.min.js"></script>
  <script src="js/jquery-migrate-3.0.1.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/jquery.easing.1.3.js"></script>
  <script src="js/jquery.waypoints.min.js"></script>
  <script src="js/jquery.stellar.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/jquery.magnific-popup.min.js"></script>
  <script src="js/jquery.animateNumber.min.js"></script>
  <script src="js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="js/google-map.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script>
  <script src="js/main.js"></script>
    
  </body>
</html>