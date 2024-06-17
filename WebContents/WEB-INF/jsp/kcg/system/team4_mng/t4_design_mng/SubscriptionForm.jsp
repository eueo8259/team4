<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp" flush="false" />
	<!-- Imported styles on this page -->
	<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">
	<link rel="stylesheet" href="/static_resources/system/js/datatables/promion.css">

	<!-- Bilboard Chart(https://naver.github.io/billboard.js) -->
	<script src="https://d3js.org/d3.v6.min.js"></script>
	<script src="/static_resources/system/js/datatables/billboard.js"></script>

<!-- 	<!-- axios CDN 추가 --> -->
<!-- 	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script> -->
<!-- 	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->

<link rel="stylesheet"
    href="/static_resources/system/js/datatables/billboard.css">

<title>상품가입</title>
</head>
<body class="page-body">

	<div class="page-container">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp"
			flush="false" />

		<div class="main-content">

			<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp"
				flush="false" />

			<ol class="breadcrumb bc-3">
				<li><a href="#none" onclick="cf_movePage('/system')"><i
						class="fa fa-home"></i>Home</a></li>
				<li class="active"><strong>상품가입</strong></li>
			</ol>

			<h2>상품가입 양식</h2>
			<br />
			<div id=subFrom>
	<!-- 			상품선택 -->
				<div class="form-group" style="justify-content: left">
					<label>상품ID:</label>
					 <input class="form-control" id="product_id"
						v-model="pro.product_id" readonly  /> 
				</div>
				<div class="form-group" style="justify-content: left">
					<label>상품명:</label>	
						<input class="form-control"
						id="product_name" v-model="pro.product_name" readonly  />	
					<button type="button" class="btn" @click="popupProd()">
						<i class="fa fa-search"></i>
					</button>				
				</div>
				
	<!-- 			고객선택 -->
				<div class="form-group" style="justify-content: left">
					<label>고객ID:</label> 
					<input class="form-control" id="customer_id"
						v-model="cus.customer_id"  readonly  /> 
				</div>

				<div class="form-group" style="justify-content: left">
					<label>고객명:</label>
					<input class="form-control"
						id="customer_name" v-model="cus.customer_name" readonly  />
					<button type="button" class="btn" @click="popupCust()">
						<i class="fa fa-search"></i>
					</button>				
				</div>
				<!-- 		예금, 적금, 대출 일 때 나눠서 저장하기 위함 -->
			    <div v-if="pro.product_type === '예금'">
			    	<label>예치 금액:</label>
			        <input type="text" id="start_money">
			        <span>원</span>
			    </div>
			    <div v-else-if="pro.product_type === '적금'">
			    	<label>납입 금액:</label>
			        <input type="text" id="cycle_money">
			        <span>원</span>
			    </div>
			    <div v-else-if="pro.product_type === '대출'">
			    	<label>대출 금액:</label>
			        <input type="text" id="loan">
			    	<span>원</span>       
			    </div>
			    <div v-else>
    			</div>
    			<br>
			    <label>이자율 :</label> 	    
				<input type="text" id="pro_interest_rate">
				<span>(%)</span>
				 <br><br>
			    <label>만기 날짜:</label> 
				<input type="text" id="sub_end_date"> 
				<br><br>
				<form @submit.prevent="handleSubmit">
					<input type="submit" value="등록" id="submit">
				</form>
				
			</div>

			<!-- 상품팝업 -->
			<div class="modal fade" id="pop_prod">
				<template>
					<div class="modal-dialog" style="width: 500px;">
						<div class="modal-content">
							<div class="modal-body">
								<div class="dataTables_wrapper">
									<div class="dt-buttons">
											<label>상품명:</label>
											<input type="search" id="pop_product_name" style="width: 200px;"
												v-model="pop_product_name">
											<button type="button" class="btn btn-red"
												style="margin-left: 5px;" @click="getList">검색</button>
									</div>
								</div>
								<div style="height: 400px; overflow: auto;"
									class="dataTables_wrapper">
									<table class="table table-bordered datatable dataTable">
										<thead style="position: sticky; top: 0px;">
											<tr>
												<th class="center" style="width: 25%;">상품ID</th>
												<th class="center" style="width: 50%;">상품명</th>
												<th class="center" style="width: 25%;">상품 유형</th>
											</tr>
										</thead>
										<tbody>
											<tr v-for="item in dataList" @click="selProd(item.product_id)"
												style="cursor: pointer;">
												<td class="center">{{item.product_id}}</td>
												<td class="left">{{item.product_name}}</td>
												<td class="left">{{item.product_type}}</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</template>
			</div>

			<!-- 고객팝업 -->
			<div class="modal fade" id="pop_cust">
				<template>
					<div class="modal-dialog" style="width: 500px;">
						<div class="modal-content">
							<div class="modal-body">
								<div class="dataTables_wrapper">
									<div class="dt-buttons">
										<div>
											<label>고객명:</label> <input type="search" id="pop_customer_name"
												style="width: 250px;" v-model="pop_customer_name">
											<button type="button" class="btn btn-red"
												style="margin-left: 5px;" @click="getList">검색</button>
										</div>
									</div>
								</div>
								<div style="height: 400px; overflow: auto;"
									class="dataTables_wrapper">
									<table class="table table-bordered datatable dataTable">
										<thead style="position: sticky; top: 0px;">
											<tr>
												<th class="center" style="width: 25%;">고객ID</th>											
												<th class="center" style="width: 25%;">고객명</th>
												<th class="center" style="width: 20%;">생년월일</th>
											</tr>
										</thead>
										<tbody>
											<tr v-for="item in dataList" @click="selCust(item.customer_id)"
												style="cursor: pointer;">
												<td class="center">{{item.customer_id}}</td>
												<td class="center">{{item.customer_name}}</td>
												<td class="center">{{item.customer_brdt}}</td>
											</tr>
										</tbody>
									</table>
									<div class="dataTables_paginate paging_simple_numbers"
										id="div_paginate"></div>
								</div>
							</div>
						</div>
					</div>
				</template>
			</div>
</body>
<script>

var vueapp = new Vue({
    el: "#subFrom",
    data: {
        pro: {
            product_id: "",
            product_name: "",
            product_type: ""
        },
        cus: {
            customer_id: "",
            customer_name: ""
        }
    },
    methods: {
        popupProd: function() {
        	console.log("실행되었습니다.")
            $("#pop_prod").modal("show");
        },
        popupCust: function() {
            $("#pop_cust").modal("show");
        },
        getProdInfo: function() {
            // 상품 정보를 가져오는 로직
            console.log("1. 정상작동 하였습니다.")

			var params = {
			product_id : this.pro.product_id
			}
            
            axios.get('/team4/proSelectOne', {params : params})
            	.then(response => {
    				console.log("2. 정상작동 하였습니다.")
    				this.pro = response.data				            		
            	})
            	.catch(error => {
            	    console.error("Error:", error);
            	});
        },
        getCustInfo: function() {
            // 고객 정보를 가져오는 로직
            console.log("1. 정상작동 하였습니다.")

			var params = {
			customer_id : this.cus.customer_id
			}
            
            axios.get('/team4/cusSelectOne', {params : params})
            	.then(response => {
    				console.log("2. 정상작동 하였습니다.")
    				this.cus = response.data	
    				console.log(this.cus)

            	})
            	.catch(error => {
            	    console.error("Error:", error);
            	});

        },
        handleSubmit: function(event) {
            console.log("submit함수가 실행되었습니다.");
            
            // 필수 입력 필드 값 확인
            var productID = $("#product_id").val() ? $("#product_id").val().trim() : '';
            var customerID = $("#customer_id").val() ? $("#customer_id").val().trim() : '';
            var proInterestRate = $("#pro_interest_rate").val() ? $("#pro_interest_rate").val().trim() : '';
            var subEndDate = $("#sub_end_date").val() ? $("#sub_end_date").val().trim() : '';
            var startMoney = $("#start_money").val() ? $("#start_money").val().trim() : '0';
            var cycleMoney = $("#cycle_money").val() ? $("#cycle_money").val().trim() : '0';
            var loan = $("#loan").val() ? $("#loan").val().trim() : '0';

            // 예금, 적금, 대출에 따른 추가 필드 값 확인
            var additionalField;
            if (this.pro.product_type === '예금') {
                additionalField = startMoney;
            } else if (this.pro.product_type === '적금') {
                additionalField = cycleMoney;
            } else if (this.pro.product_type === '대출') {
                additionalField = loan;
            }

            // 유효성 검사
            function isValidInterestRate(rate) {
                return /^\d+(\.\d{1})?$/.test(rate);
            }

            function isValidDate(date) {
                return /^\d{4}-\d{2}-\d{2}$/.test(date);
            }

            function isNumeric(value) {
                return /^\d+$/.test(value);
            }

            if (!productID || !customerID || !proInterestRate || !subEndDate || !additionalField) {
                alert('모든 필수 입력 항목을 작성해주세요.');
                return;
            }

            if (!isValidInterestRate(proInterestRate)) {
                alert('이자율은 소수점 한 자리까지 입력 가능합니다. 예: 1.5, 10.0');
                return;
            }

            if (!isValidDate(subEndDate)) {
                alert('날짜는 yyyy-mm-dd 형식으로 입력해주세요.');
                return;
            }

            if (!isNumeric(additionalField)) {
                alert('예금, 적금, 대출 금액은 숫자만 입력 가능합니다.');
                return;
            }

            // 모든 유효성 검사 통과 시 데이터 전송
            var params = {
                product_id: productID,
                customer_id: customerID,
                pro_interest_rate: proInterestRate,
                start_money: startMoney,
                cycle_money: cycleMoney,
                loan: loan,
                sub_end_date: subEndDate
            };
			console.log(params);
            axios.post('/team4/subscription', {params : params})
                .then(response => {
                    alert("정상적으로 등록되었습니다.");
                    // 등록 성공 후 추가 작업을 수행할 수 있습니다.
                    window.location.href = "/team4/subscriptionList";

                })
                .catch(error => {
                    console.error("Error:", error);
                    alert("잘못된 양식입니다. 다시 제출해주세요.");
                });
        }
        },
});


var pop_prod = new Vue({
	el : "#pop_prod",
	data : {
		dataList : [],
		pop_product_name: "",
		pop_product_type: "",
		pop_product_id:""
	},
	methods : {
		getList : function(){
			this.dataList = [];
			var params = {
				product_name : this.pop_product_name
			}
			console.log(params);
			cf_ajax("/team4/productList", params, function(proList){
				pop_prod.dataList = proList;
			});
		},
		selProd : function(product_id){
			vueapp.pro.product_id = product_id;
			$("#pop_prod").modal("hide");
			vueapp.getProdInfo();	

		},
	},
});

var pop_cust = new Vue({
	el : "#pop_cust",
	data : {
		dataList : [],
		pop_customer_name  : "",
		pop_customer_id : "",
		pop_customer_brdt: "",
	},
	methods : {
		getList : function(){
			var params = {
				customer_name : this.pop_customer_name,
			}
			console.log(params);
			cf_ajax("/team4/customerList", params, function(data){
				pop_cust.dataList = data;
			});
		},
		selCust : function(customer_id){
			vueapp.cus.customer_id = customer_id;			
			$("#pop_cust").modal("hide");
			vueapp.getCustInfo();

		},
	},
});

</script>

<script>
    function numberFormat(num) {
		num = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return num;
	}
    
    function getToday() {
    	const today = new Date(); 
    	const year = today.getFullYear(); 	// 년도
    	const month = (today.getMonth() + 1).toString().padStart(2, '0');  	// 월
    	const day = today.getDate().toString().padStart(2, '0'); 	// 일
    	
    	return year + "-" + month + "-" + day;
    }
    
</script>
</html>