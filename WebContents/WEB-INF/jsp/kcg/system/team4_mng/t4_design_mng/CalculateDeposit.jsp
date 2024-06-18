<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp" flush="false"/>
	<!-- Imported styles on this page -->
	<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">
	<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">
	<link rel="stylesheet" href="/static_resources/system/js/datatables/promion.css">
	
	<!-- Bilboard Chart(https://naver.github.io/billboard.js) -->
	<script src="https://d3js.org/d3.v6.min.js"></script>
	<script src="/static_resources/system/js/datatables/billboard.js"></script>
	<link rel="stylesheet" href="/static_resources/system/js/datatables/billboard.css">
	
	<title>금융계산기</title>
</head>
<body class="page-body">

<div class="page-container">

	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false"/>

	<div class="main-content">

		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header.jsp" flush="false"/>
		
		<ol class="breadcrumb bc-3">
			<li><a href="#none" onclick="cf_movePage('/system')"><i class="fa fa-home"></i>Home</a></li>
			<li class="active"><strong>금융계산기</strong></li>
		</ol>
	
		<h2>프로모션 > 금융계산기 (예금 설계)</h2>
		<br/>
		
		<div class="row">
			<div class="dataTables_wrapper flex" id="vueapp">
			<template>
			
				<div class="left flex-column flex-gap-10 flex-40" v-if="info.simpl_ty_cd == '1'">
                    <label>고객정보:</label>
                    <div class="form-group">
                        <label>성명:</label>
                        <input class="form-control" v-model="custInfo.customer_name" disabled />
                        <button type="button" class="btn" @click="popupCust()">
                             <i class="fa fa-search"></i>
                         </button>
                    </div>
                    <div class="form-group">
                        <label>주민번호:</label>
                        <input class="form-control" v-model="custInfo.customer_id_number" disabled />
                    </div>
                    <div class="form-group">
                        <label>E-mail:</label>
                        <input class="form-control" v-model="custInfo.customer_email" disabled />
                    </div>
                    <div class="form-group">
                        <label>전화번호:</label>
                        <input class="form-control" v-model="custInfo.customer_phone" disabled />
                    </div>
                    <div class="form-group">
                        <label>비상연락처:</label>
                        <input class="form-control" v-model="custInfo.customer_sub_tel" disabled />
                    </div>
                    <div class="form-group">
                        <label>직업:</label>
                        <input class="form-control" v-model="custInfo.customer_job" disabled />
                    </div>
                    <div class="form-group">
                        <label>주소:</label>
                        <input class="form-control" v-model="custInfo.customer_addr" disabled />
                    </div>
                    <div class="form-group">
                        <label>관리담당자:</label>
                        <input class="form-control" v-model="custInfo.userId" disabled />
                    </div>
                    <div class="form-group">
                        <label>부서:</label>
                        <input class="form-control" v-model="custInfo.dept" disabled />
                    </div>
                    <div class="form-group">
                        <label>직위:</label>
                        <input class="form-control" v-model="custInfo.jikgub_nm" disabled />
                    </div>
                </div>
                
				<div class="right flex-column flex-100">
                    <div class="right-top">
                        <ul class="nav">
                            <li class="nav-tab" @click="tabChange(1)">적금 설계</li>
                            <li class="nav-tab" @click="tabChange(2)">목돈마련적금 설계</li>
                            <li class="nav-tab active" @click="tabChange(3)">예금 설계</li>
                            <li class="nav-tab" @click="tabChange(4)">대출 설계</li>
                        </ul>
                        <div class="nav-content flex-column flex-gap-10">
                        	<div class="form-group" style="justify-content: left">
                                <label>설계번호:</label>
                                <input class="form-control" id="design_id" v-model="info.design_id" disabled />
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>상품선택:</label>
                                <input class="form-control" id="prod_cd" v-model="info.product_id" disabled />
                                <input class="form-control" id="prod_nm" v-model="info.product_name" />
                                <button type="button" class="btn" @click="popupProd()">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
<!--                             <div class="form-group" style="justify-content: left"> -->
<!--                                 <label>납입주기:</label> -->
<!--                                 <select class="form-control" id="pay_ty_cd" v-model="info.pay_ty_cd" style="padding-top: 3px;" disabled> -->
<!-- 									<option value="3">일시납</option> -->
<!-- 								</select> -->
<!--                             </div> -->
                            <div class="form-group" style="justify-content: left">
                                <label>예치금액 (원):</label>
                                <input class="form-control flex-50" type="text" id="dpst_amt" v-model="info.dpst_amt" style="width: 700px;"/>
                                <button type="button" class="btn btn-transparent flex-20" @click="setCircleAcmlAmt(10)">+10만원</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="setCircleAcmlAmt(50)">+50만원</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="setCircleAcmlAmt(100)">+100만원</button>
                                <button type="button" class="btn btn-navy flex-20" @click="setCircleAcmlAmt(0)">정정</button>
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label> 기간 (개월):</label>
                                <input class="form-control flex-50" type="text" id="dpst_prd" v-model="info.dpst_prd" style="width: 700px;"/>
                                <button type="button" class="btn btn-transparent flex-20" @click="setGoalPrd(3)">+3개월</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="setGoalPrd(6)">+6개월</button>
                                <button type="button" class="btn btn-transparent flex-20" @click="setGoalPrd(12)">+12개월</button>
                                <button type="button" class="btn btn-navy flex-20" @click="setGoalPrd(0)">정정</button>
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>고정금리 (%):</label>
                                <input class="form-control" type="text" id="aply_rate" v-model="info.f_interest_rate" />
                            </div>
                            <div class="form-group" style="justify-content: left">
                                <label>변동금리 (%):</label>
                                <input class="form-control" type="text" id="aply_rate" v-model="info.v_interest_rate" />
                            </div>
                            
                            <div class="form-group" style="justify-content: left">
                                <label>이자과세:</label>
								<select class="form-control" id="int_tax_ty_cd" v-model="info.tax_rate" style="padding-top: 3px;" disabled>
									<option value="1">일반과세 (15.4%)</option>
									<option value="2">세금우대 (9.5%)</option>
									<option value="3">비과세</option>
								</select>
                            </div>
                        </div>
                    </div>
                    
					<div class="dt-buttons" style="padding-top: 15px;">
						<input id="external" type="radio" v-model="info.simpl_ty_cd" value="1">
						<label class="tab_item" for="external">정상설계</label>
						<input id="internal" type="radio" v-model="info.simpl_ty_cd"  value="0">
						<label class="tab_item" for="internal">간편설계</label>
					</div>
					<div class="dataTables_filter">
						<button type="button" class="btn btn-red btn-small" @click="prcCalc()">
							이자계산
						</button>
						<button type="button" class="btn btn-orange btn-small" @click="save()">
							설계저장
						</button>
						<button type="button" class="btn btn-blue btn-icon btn-small" @click="popupPrint()">
							설계발행 <i class="entypo-print"></i>
						</button>
						<button type="button" class="btn btn-blue btn-icon btn-small" @click="gotoList()">
							목록 <i class="entypo-list"></i>
						</button>
					</div>
					
                    <ul class="nav">
                        <li class="nav-tab active">계산결과</li>
                    </ul>
                    <div class="right-bottom flex-100">
                        <form class="form flex-column" method="POST" action="#">
	                        <table>
	                        	<tr>
	                        		<td class="center" style="width: 40%; vertical-align: top;">
	                        			<div class="form-wrapper flex flex-wrap flex-gap-10">
			                                <div class="form-group">
			                                    <label>예치금액합계:</label>
			                                    <input class="form-control" id="tot_dpst_amt" v-model="info.tot_dpst_amt_fmt" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <label>세전이자:</label>
			                                    <input class="form-control" id="tot_dpst_int" v-model="info.before_tax" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <label>세전수령액:</label>
			                                    <input class="form-control" id="bfo_rcve_amt" v-model="info.rec_before_tax" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <label>이자과세금:</label>
			                                    <input class="form-control" id="int_tax_amt" v-model="info.interest_tax" disabled />
			                                </div>
			                                <div class="form-group">
			                                    <label>세후수령액:</label>
			                                    <input class="form-control" id="atx_rcve_amt" v-model="info.rec_after_tax" disabled />
			                                </div>
			                            </div>	
			                            
			                            <div class="panel-heading">
											<div class="panel-title">계산결과 CHART</div>
										</div>
										<div id="chart" class="bottom-right-bottom flex-100"></div>
	                        		</td>
	                        		<td class="center" style="width: 3%;">
	                        		</td>
	                        		<td class="center" style="width: 57%; vertical-align: top;">
			                            <table class="table table-bordered datatable dataTable" id="grid_app">
											<thead>
												<tr class="replace-inputs">
													<th style="width: 10%;" class="center">회차</th>
													<th style="width: 23%;" class="center">회차예치금액</th>
													<th style="width: 23%;" class="center">누적예치금액</th>
													<th style="width: 21%;" class="center">회차이자</th>
													<th style="width: 23%;" class="center">회차원리금</th>
												</tr>
											</thead>
											<tbody id="grid_tbody">
											</tbody>
										</table>
	                        		</td>
	                        	</tr>
	                        </table>
                        </form>
                    </div>
                </div>
                
                <!-- 프린트 Start -->
               <div border="1"  class="modal fade" id="printArea">
					<span style="font-size: 30px; font-weight: bold">[ {{custInfo.cust_nm}} ]</span> <span style="font-size: 30px;">고객님!! </span>
                    <span style="color: red; font-size: 30px; font-weight: bold">[ {{info.prod_nm}} ]</span> <span style="font-size: 30px;">가입을 제안 드립니다. </span>
				    <table border="1" style="width: 1100px; height: 700px;">
				       <tr>
				       		<td class="center" style="width: 12%;">
				       			<label>상품설계기준</label>
				       		</td>
							<td class="left" style="width: 35%;">
								<label>상품명:</label>
								{{info.prod_nm}}<br>
								<label>납입주기:</label>
								{{info.pay_ty_cd}}<br>
								<label>불입금액:</label>
								{{info.circle_acml_amt_fmt}} 원<br>
								<label>예치기간:</label>
								{{info.dpst_prd}} 개월<br>
								<label>적용금리:</label>
								{{info.aply_rate}} %<br>
								<label>이자과세:</label>
								{{info.int_tax_ty_cd}}<br>
							</td>
							<td rowspan="2" style="width: 53%;">
								<div id="printArea_chart"></div>
							</td>
				       </tr>
				       <tr>
				       		<td class="center">
				       			<label>상품설계산출결과</label>
				       		</td>
							<td class="left">
								<label>원금:</label>
								{{info.tot_dpst_amt_fmt}} 원<br>
								<label>이자:</label>
								{{info.tot_dpst_int_fmt}} 원<br>
								<label>총금액:</label>
								{{info.bfo_rcve_amt_fmt}} 원<br>
								<label>세액공제금액:</label>
								{{info.int_tax_amt_fmt}} 원
							</td>
				       </tr>
				    </table>
				</div>
				<!-- 프린트 End -->
				
			</template>
			</div>
		</div>
		
		<br />
		
		<jsp:include page="/WEB-INF/jsp/kcg/_include/system/footer.jsp" flush="false"/>
		
	</div>
</div>

<!-- 상품팝업 -->
<div class="modal fade" id="pop_prod">
<template>
	<div class="modal-dialog" style="width: 500px;">
		<div class="modal-content">
			<div class="modal-body">
				<div class="dataTables_wrapper">					
					<div class="dt-buttons">
						<div>
							<label>코드:</label>
							<input type="search" id="pop_prod_cd" style="width: 80px;" v-model="pop_prod_cd">
							<label>코드명:</label>
							<input type="search" id="pop_prod_nm" style="width: 200px;" v-model="pop_prod_nm">
							<button type="button" class="btn btn-red" style="margin-left: 5px;" @click="getList">
								검색
							</button>
						</div>
					</div>
				</div>
				<div style="height: 400px;overflow: auto;" class="dataTables_wrapper">		
					<table class="table table-bordered datatable dataTable">
						<thead style="position: sticky;top: 0px;">
							<tr>
								<th class="center" style="width: 25%;">상품코드</th>
								<th class="center" style="width: 50%;">상품명</th>
								<th class="center" style="width: 25%;">가입대상</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="item in dataList" @click="selProd(item.prod_cd)" style="cursor: pointer;">
								<td class="center">{{item.prod_cd}}</td>
								<td class="left">{{item.prod_nm}}</td>
								<td class="left">{{item.sbstg_ty_cd_nm}}</td>
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
	el : "#vueapp",
	data : {
		info : {
			prod_ds_sn : "${prod_ds_sn}",
			cust_mbl_telno : "${cust_mbl_telno}",
			prod_ty_cd : "${prod_ty_cd}",
			simpl_ty_cd : "0",
			wrt_dt : "",
			design_id : "",
			design_date : "",
			product_id : "",
			product_name : "",
			f_interest_rate : "",
			v_interest_rate : "",
			tax_rate : "",
			before_tax : "",
			rec_before_tax : "",
			interest_tax : "",
			rec_after_tax : "",
		},
		custInfo : {
			customer_phone : "",
			customer_name : "",
			customer_id_number : "",
			customer_id : "",
			customer_email : "",
			customer_sub_tel : "",
			customer_job : "",
			customer_addr : "",
			userId : "",
			dept : "",
			jikgub_nm : ""
		},
	},
	mounted : function(){
		
		if(!cf_isEmpty(this.info.cust_mbl_telno)){
			this.getCustInfo();
		}
		if(!cf_isEmpty(this.info.prod_ds_sn)){
			this.getDsgInfo();
		}
	},
	methods : {
		tabChange : function(index) {
			
			if(this.info.prod_ds_sn != "" && this.info.prod_ds_sn != undefined) {
				alert("신규일 경우만 TAB 이동이 가능합니다.");
				return;
			}
			
			var params = {
				cust_mbl_telno : cf_defaultIfEmpty(this.info.cust_mbl_telno, ""),
				prod_ty_cd : index,
			}
			cf_movePage("/promion_mng/dtl", params);
			
		},
		getDsgInfo : function(){
			cf_ajax("/promion_mng/getDsgInfo", this.info, this.getDsgInfoCB);
		},
		getDsgInfoCB : function(data){
			this.info = data;
			this.info.simpl_ty_cd = "1";
			
			this.prcCalc();
		},
		save : function(){
			
			if(this.info.simpl_ty_cd != "1"){
				alert("정상설계만 저장할 수 있습니다.");
				return;
			}else if(cf_isEmpty(this.info.atx_rcve_amt) || this.info.atx_rcve_amt == 0){
				alert("이자계산 후 저장할 수 있습니다.");
				return;
			}else if(cf_isEmpty(this.custInfo.cust_nm)){
				alert("고객정보를 선택하세요.");
				return;
			}
			
			if(!confirm("저장하시겠습니까?")) return;
			
			this.info.cust_mbl_telno = this.custInfo.cust_mbl_telno;
			this.info.int_cty_cd = "1";
			
			cf_ajax("/promion_mng/save", this.info, this.saveCB);
		},
		saveCB : function(data){
			alert("저장되었습니다.");
			cf_movePage('/promion_mng/list');
		},
        getProdInfo: function() {
            // 상품 정보를 가져오는 로직
            console.log("1. 정상작동 하였습니다.")

			var params = {
			product_id : this.info.product_id
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
		getProdInfoCB : function(data){
			this.info = data;
			this.info.wrt_dt = getToday();
		},
        getCustInfo: function() {
            // 고객 정보를 가져오는 로직
            console.log("1. 정상작동 하였습니다.")

			var params = {
			customer_id : this.custInfo.customer_id
			}
            
            axios.get('/team4/designCusInfo', {params : params})
            	.then(response => {
    				console.log("2. 정상작동 하였습니다.")
    				this.custInfo = response.data	
    				console.log(this.cus)

            	})
            	.catch(error => {
            	    console.error("Error:", error);
            	});

        },
		getCustInfoCB : function(data){
			this.custInfo = data;
			this.info.simpl_ty_cd = "1";
		},
		setCircleAcmlAmt : function(nAmt){
			if(nAmt == 0) {
				this.info.dpst_amt = 0;
			}else {
				this.info.dpst_amt = Number(this.info.dpst_amt) + nAmt*10000;
			}
		},
		setGoalPrd : function(nPrd){
			if(nPrd == 0) {
				this.info.dpst_prd = 0;
			}else {
				this.info.dpst_prd = Number(this.info.dpst_prd) + nPrd;
			}
		},
		popupProd : function(){
			pop_prod.getList();
			$("#pop_prod").modal("show");
		},
		popupCust : function(){
			pop_cust.getList();
			$("#pop_cust").modal("show");
		},
		prcCalc : function(){
			
			if(cf_isEmpty(this.info.prod_cd)){
				alert("상품을 선택하세요.");
				return;
			}else if(cf_isEmpty(this.info.dpst_amt) || this.info.dpst_amt == 0){
				alert("예치금액을 입력하세요.");
				return;
			}else if(cf_isEmpty(this.info.dpst_prd) || this.info.dpst_prd == 0){
				alert("예치기간을 입력하세요.");
				return;
			}else if(cf_isEmpty(this.info.aply_rate) || this.info.aply_rate == 0){
				alert("적용금리를 입력하세요.");
				return;
			}
			
			var nRvcy		= Math.round(this.info.pay_ty_cd); // 납입주기
			var nPymAmt		= Math.round(this.info.dpst_amt); // 예치금액
			var nPrd		= Math.round(this.info.dpst_prd); // 예치기간
			var nApplItr	= Math.round(this.info.aply_rate); // 적용금리
				nApplItr	= nApplItr / 12 / 100;
			
			var nScPayAmt	= 0;	// 회차붙입금액
			var nAcmPayAmt	= 0;	// 누적예치금액
			var nScPniAmt	= 0;	// 회차원리금
			var nScInt		= 0;	// 회차이자
			var nAcmInt		= 0;	// 누적이자
			var nTax		= 0;	// 이자과세
			if(this.info.int_tax_ty_cd == "1") {		// 일반과세
				nTax = 15.4 / 100;
			} else if(this.info.int_tax_ty_cd == "2") {	// 세금우대
				nTax = 9.5 / 100;
			} else {									// 비과세
				nTax = 0;
			}
			
			var html = '';
			for(var i=1; i<=nPrd; i++) {
				
				if(nRvcy == 1) {
					nScPayAmt = nPymAmt;
				} else if(i%nRvcy == 1) {
					nScPayAmt = nPymAmt * nRvcy;
				} else {
					nScPayAmt = 0;
				} 
				
				
				nAcmPayAmt += nScPayAmt;
				nScInt = nAcmPayAmt * nApplItr;
				nAcmInt += nScInt;
				nScPniAmt = nScPniAmt + nScPayAmt + nScInt;
				
				html += '<tr>';
				html += '<td class="right" style="text-align: right;">' + i + '</td>';
				html += '<td class="right" style="text-align: right;">' + numberFormat(Math.round(nScPayAmt)) + '</td>';
				html += '<td class="right" style="text-align: right;">' + numberFormat(Math.round(nAcmPayAmt)) + '</td>';
				html += '<td class="right" style="text-align: right;">' + numberFormat(Math.round(nScInt)) + '</td>';
				html += '<td class="right" style="text-align: right;">' + numberFormat(Math.round(nScPniAmt)) + '</td>';
				html += '</tr>';
			}
			
			this.info.circle_acml_amt = (Math.round(nPymAmt));
			this.info.tot_dpst_amt = (Math.round(nAcmPayAmt));
			this.info.tot_dpst_int = (Math.round(nAcmInt));
			this.info.int_tax_amt = (Math.round(nAcmInt * nTax));
			this.info.bfo_rcve_amt = (Math.round(nScPniAmt));
			this.info.atx_rcve_amt = (Math.round(nScPniAmt - this.info.int_tax_amt));
        
			this.info.circle_acml_amt_fmt = this.info.circle_acml_amt.numformat();
			this.info.tot_dpst_amt_fmt = this.info.tot_dpst_amt.numformat();
			this.info.tot_dpst_int_fmt = this.info.tot_dpst_int.numformat();
			this.info.int_tax_amt_fmt = this.info.int_tax_amt.numformat();
			this.info.bfo_rcve_amt_fmt = this.info.bfo_rcve_amt.numformat();
			this.info.atx_rcve_amt_fmt = this.info.atx_rcve_amt.numformat();
			
			
			$("#grid_tbody").html(html);
			
			// 차트
			var chart = bb.generate({
                data: {
                    columns: [
                        ["예치금액합계"	, nAcmPayAmt],
                        ["세전이자"	, nAcmInt],
                        ["세전수령액"	, nScPniAmt],
                        ["이자과세금"	, nTax],
                        ["세후수령액"	, nScPniAmt - nTax],
                    ],
                    type: "bar",
                    groups: [
                        []
                    ],
                    order: null
                },
                bindto: "#chart"
            });
		},
		gotoList : function(){
			cf_movePage('/promion_mng/list');
		},
		popupPrint : function(){
			
			if (!window.confirm("설계발행하시겠습니까?")) {
    			return;
            }
			
			document.getElementById('printArea_chart').innerHTML = document.getElementById('chart').innerHTML;
			
			const printArea = document.getElementById('printArea').innerHTML;
			console.log(printArea);

			win = window.open();
			self.focus();
			win.document.open();

			/*
			1. div 안의 모든 태그들을 innerHTML을 사용하여 매개변수로 받는다.
			2. window.open() 을 사용하여 새 팝업창을 띄운다.
			3. 열린 새 팝업창에 기본 <html><head><body>를 추가한다.
			4. <body> 안에 매개변수로 받은 printArea를 추가한다.
			5. window.print() 로 인쇄
			6. 인쇄 확인이 되면 팝업창은 자동으로 window.close()를 호출하여 닫힘
			 */
			win.document.write('<html><head>');

			win.document.write('<link rel="stylesheet" href="/static_resources/system/js/datatables/datatables.css">');
			win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2-bootstrap.css">');
			win.document.write('<link rel="stylesheet" href="/static_resources/system/js/select2/select2.css">');

			win.document.write('<title></title><style>');
			win.document.write('td.center {text-align: center;}');
			win.document.write('th.center {text-align: center;}');
			win.document.write('body {font-size: 14px;}');
			win.document.write('</style></head><body>');
			win.document.write(printArea);
			win.document.write('</body></html>');
			win.document.close();
			win.print();
			win.close();
		},
	}
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
			console.log("==============================")
			console.log(customer_id)
			vueapp.custInfo.customer_id = customer_id;			
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