<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/jsp/kcg/_include/system/header_meta.jsp"
	flush="false" />
<!-- Imported styles on this page -->
<link rel="stylesheet"
	href="/static_resources/system/js/datatables/datatables.css">
<link rel="stylesheet"
	href="/static_resources/system/js/select2/select2-bootstrap.css">
<link rel="stylesheet"
	href="/static_resources/system/js/select2/select2.css">
</head>
<body class="page-body">

<div class="page-container">

	<jsp:include page="/WEB-INF/jsp/kcg/_include/system/sidebar-menu.jsp" flush="false"/>

	<h2>상품정보관리</h2>
	<br>
	<div class="flex-column flex-gap-10" id="vueapp"
		style="display: flex; justify-items: center;">
		<div class="panel-body flex-100">
			<div class="left-panel flex-66">
				<div class="form-group">
					<label for="product_name" class="fix-width-33">상품명:</label> <input
						type="text" class="form-control" id="product_name"
						v-model="info.product_name" ref="product_name"
						:disabled="info.writer_name!=''&&info.writer_name!=null">
					<button type="button" class="btn btn-orange btn-icon btn-small"
						@click="checkName">
						중복확인 <i class="entypo-check"></i>
					</button>
				</div>
				<div class="form-group">
					<label for="product_id" class="fix-width-33">상품코드:</label> <input
						type="text" class="form-control" id="product_id"
						v-model="info.product_id" ref="product_id"
						placeholder="상품코드는 5자리입니다."
						:disabled="info.writer_name!=''&&info.writer_name!=null">
					<button type="button" class="btn btn-orange btn-icon btn-small"
						@click="checkId">
						중복확인 <i class="entypo-check"></i>
					</button>
				</div>
				<div class="form-group">
					<label for="product_type" class="fix-width-33">상품유형:</label> <select
						class="form-control" id="product_type" v-model="info.product_type"
						ref="product_type"
						:disabled="info.writer_name!=''&&info.writer_name!=null">
						<option value="예금">예금</option>
						<option value="적금">적금</option>
						<option value="대출">대출</option>
						<option value="목돈">목돈마련</option>
					</select>
				</div>
				<div class="form-group">
					<label for="possible_member" class="fix-width-33">가입대상:</label> <select
						class="form-control" id="possible_member" ref="possible_member"
						v-model="info.possible_member"
						:disabled="info.writer_name!=''&&info.writer_name!=null">
						<option value="일반개인">일반개인</option>
						<option value="청년">청년우대</option>
						<option value="장애인">장애인우대</option>
					</select>
				</div>
				<div class="form-group">
					<label for="lowest_money" class="fix-width-33">가입금액:</label>
					<div class="form-control">
						<label>(최소)</label> <input type="text" class="form-control"
							id="lowest_money" ref="lowest_money" v-model="info.lowest_money"
							:disabled="info.writer_name!=''&&info.writer_name!=null">
						<label>원 ~ (최대)</label> <input type="text" class="form-control"
							id="highest_money" ref="highest_money"
							v-model="info.highest_money"
							:disabled="info.writer_name!=''&&info.writer_name!=null">
						<label>원</label>
					</div>
				</div>
				<div class="form-group">
					<label for="lowest_rate" class="fix-width-33">적용이율:</label>
					<div class="form-control">
						<input type="number" id="lowest_rate" ref="lowest_rate"
							v-model="info.lowest_rate"
							:disabled="info.writer_name!=''&&info.writer_name!=null">
						<label>% ~</label> <input type="number" id="highest_rate"
							ref="highest_rate" v-model="info.highest_rate"
							:disabled="info.writer_name!=''&&info.writer_name!=null">
						<label>%</label>
					</div>
				</div>
				<div class="form-group">
					<label for="rate_condition" class="fix-width-33">이율변동조건 :</label>
					<div class="form-control">
						<textarea id="rate_condition" ref="rate_condition"
							v-model="info.rate_condition"
							style="resize: none; width: 100%; height: 80px;"
							:disabled="info.writer_name!=''&&info.writer_name!=null"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label for="pay_type" class="fix-width-33">납입주기:</label> <select
						class="form-control" id="pay_type" ref="pay_type"
						v-model="info.pay_type"
						:disabled="info.writer_name!=''&&info.writer_name!=null">
						<option value="월납">월납</option>
						<option value="연납">연납</option>
						<option value="일시납">일시납</option>
					</select>
				</div>
				<div class="form-group">
					<label for="lowest_date" class="fix-width-33">적용기간:</label>
					<div class="form-control">
						<input type="number" id="lowest_date" ref="lowest_date"
							v-model="info.lowest_date"
							:disabled="info.writer_name!=''&&info.writer_name!=null">
						<label>개월 ~</label> <input type="number" id="highest_date"
							ref="highest_date" v-model="info.highest_date"
							:disabled="info.writer_name!=''&&info.writer_name!=null">
						<label>개월</label>
					</div>
				</div>
				<div class="form-group">
					<label for="taxation" class="fix-width-33">과세구분:</label> <select
						class="form-control" id="taxation" ref="taxation"
						v-model="info.taxation"
						:disabled="info.writer_name!=''&&info.writer_name!=null">
						<option value="일반과세">일반과세</option>
						<option value="세금우대">세금우대</option>
						<option value="비과세">비과세</option>
					</select>
				</div>
				<div class="form-group">
					<label for="product_sale_start_date" class="fix-width-33">판매기간:</label>
					<div class="form-control">
						<input type="date" id="product_sale_start_date"
							ref="product_sale_start_date"
							v-model="info.product_sale_start_date" :disabled="new Date(info.product_sale_start_date) < new Date(currentDate)"> <label> ~</label>
						<input type="date" id="product_sale_end_date"
							ref="product_sale_end_date" v-model="info.product_sale_end_date" :disabled="info.product_status =='9'">
					</div>
				</div>
				<div class="form-group">
					<label for="product_status" class="fix-width-33">판매상태:</label> <select
						class="form-control" id="product_status" ref="product_status"
						v-model="info.product_status" :disabled="info.product_status =='9'">
						<option value="0">정상(판매)</option>
						<option value="1">판매준비</option>
						<option value="2">판매인가</option>
						<option value="9">판매중지</option>
					</select>
				</div>
				<div class="form-group">
					<div>
						<div
							v-if="info.product_status =='9' || new Date(info.product_sale_end_date) < new Date(currentDate)">
							<button type="button" class="btn btn-blue btn-icon btn-small"
								@click="gotoList">
								목록 <i class="entypo-list"></i>
							</button>
						</div>
						<div v-else>
							<button type="button" class="btn btn-green btn-icon btn-small"
								@click="save" v-if="key">
								저장 <i class="entypo-check"></i>
							</button>

							<button type="button" class="btn btn-blue btn-icon btn-small"
								@click="gotoList">
								목록 <i class="entypo-list"></i>
							</button>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		new Vue(
				{
					el : "#vueapp",
					data : {
						jikgub_nm : '${userInfoVO.jikgubNm}',
						key : "",
						info1 : "",
						currentDate : "",
						info : {
							product_id : "${product_id}",
							save_mode : "insert",
							product_sale_end_date : "${product_sale_end_date}",
							product_status : "${product_status}",
						},
					},

					mounted : function() {
						if (this.jikgub_nm === "이사") {
							this.key = true;
						} else {
							this.key = false;
						}
						if (!cf_isEmpty(this.info.product_id)) {
							this.getInfo();
						}
					},

					methods : {
						getInfo : function() {
							cf_ajax("/system/team4/product/getInfo", this.info,
									this.getInfoCB);
						},
						getInfoCB : function(data) {
							// 현재 날짜와 시간을 포함하는 Date 객체 생성
							let currentDate = new Date();

							// 연, 월, 일 정보 가져오기
							let year = currentDate.getFullYear(); // 연도 가져오기 (네 자리 숫자)
							let month = currentDate.getMonth() + 1; // 월 가져오기 (0부터 시작하므로 +1을 해줘야 함)
							let day = currentDate.getDate(); // 일 가져오기

							// 월과 일이 한 자리 수일 경우 두 자리로 만들기 위해 문자열 처리
							if (month < 10) {
								month = '0' + month; // 한 자리 숫자면 앞에 0을 붙임
							}
							if (day < 10) {
								day = '0' + day; // 한 자리 숫자면 앞에 0을 붙임
							}

							// 연-월-일 형식으로 조합하여 표시
							let formattedDate = year + '-' + month + '-' + day;
							this.currentDate = formattedDate;
							console.log(formattedDate); // 예: "2024-06-21"
							this.info = data;
							console.log(this.info.product_status);
							console.log(this.info.product_sale_end_date);
							this.info.save_mode = "update";

						},
						save : function() {
							if ("insert" === this.info.save_mode) {
								if (cf_isEmpty(this.info.product_name)) {
									alert("상품명을 입력하세요.");
									this.$refs.product_name.focus();
									return;
								} else if (cf_isEmpty(this.info.product_id)) {
									alert("상품코드를 입력하세요.");
									this.$refs.product_id.focus();
									return;
								} else if (cf_isEmpty(this.info.product_type)) {
									alert("상품유형을 선택하세요.");
									this.$refs.product_type.focus();
									return;
								} else if (cf_isEmpty(this.info.possible_member)) {
									alert("가입대상을 선택하세요.");
									this.$refs.possible_member.focus();
									return;
								} else if (cf_isEmpty(this.info.lowest_money)) {
									alert("최소가입금액을 입력하세요.");
									this.$refs.lowest_money.focus();
									return;
								} else if (cf_isEmpty(this.info.highest_money)) {
									alert("최대가입금액을 입력하세요.");
									this.$refs.highest_money.focus();
									return;
								} else if (cf_isEmpty(this.info.lowest_rate)) {
									alert("최소적용이율을 입력하세요.");
									this.$refs.lowest_rate.focus();
									return;
								} else if (cf_isEmpty(this.info.highest_rate)) {
									alert("최대적용이율을 입력하세요.");
									this.$refs.highest_rate.focus();
									return;
								} else if (cf_isEmpty(this.info.pay_type)) {
									alert("납입주기를 입력하세요.");
									this.$refs.pay_type();
									return;
								} else if (cf_isEmpty(this.info.lowest_date)) {
									alert("최소적용기간을 입력하세요.");
									this.$refs.lowest_date.focus();
									return;
								} else if (cf_isEmpty(this.info.highest_date)) {
									alert("최대적용기간을 입력하세요.");
									this.$refs.highest_date.focus();
									return;
								} else if (cf_isEmpty(this.info.taxation)) {
									alert("과세구분을 선택하세요.");
									this.$refs.taxation.focus();
									return;
								} else if (cf_isEmpty(this.info.product_sale_start_date)) {
									alert("판매시작일을 선택하세요.");
									this.$refs.product_sale_start_date.focus();
									return;
								} else if (cf_isEmpty(this.info.product_sale_end_date)) {
									alert("판매종료일을 선택하세요.");
									this.$refs.product_sale_end_date.focus();
									return;
								} else if (cf_isEmpty(this.info.product_status)) {
									alert("판매상태를 선택하세요.");
									this.$refs.product_status.focus();
									return;
								}
								var lowestMoney = parseInt(this.info.lowest_money);
								var highestMoney = parseInt(this.info.highest_money);
								var lowestRate = parseInt(this.info.lowest_rate);
								var highestRate = parseInt(this.info.highest_rate);
								if (this.info.product_id.length != 5) {
									alert("상품코드는 5자리입니다.")
									this.$refs.product_id.focus();
									return;
								}
								if (lowestMoney >= highestMoney) {
									alert("최대가입금액은 최소가입금액보다 커야합니다.");
									this.$refs.lowest_money.focus();
									return;
								}
								if (lowestRate >= highestRate) {
									alert("최대적용이율은 최소적용이율보다 커야합니다.");
									this.$refs.lowest_rate.focus();
									return;
								}
								cf_ajax("/system/team4/product/checkName",
										this.info, this.saveNameCB);
							} else if ("update" === this.info.save_mode) {
								if (!confirm("저장하시겠습니까?"))
									return;
								cf_ajax("/system/team4/product/save",
										this.info, this.saveCB)
							} else if ("disable" === this.info.save_mode) {
								alert("판매종료된 상품은 수정이 불가능합니다.")
								return;
							}
						},
						saveCB : function(data) {
							alert("저장되었습니다.");
							this.info.product_id = data.product_id;
							this.gotoList();
						},
						saveNameCB : function(data) {
							this.info1 = data;
							if (cf_isEmpty(this.info1.product_id)) {
								cf_ajax("/system/team4/product/checkId",
										this.info, this.saveIdCB);
							} else {
								alert("이미 존재하는 상품명입니다.");
								this.info.product_name = "";
								return;
							}
						},
						saveIdCB : function(data) {
							this.info1 = data;
							if (cf_isEmpty(this.info1.product_id)) {
								if (!confirm("저장하시겠습니까?"))
									return;
								cf_ajax("/system/team4/product/save",
										this.info, this.saveCB);
							} else {
								alert("이미 존재하는 상품코드입니다.");
								this.info.product_id = "";
								return;
							}
						},
						delInfo : function() {
							if (!confirm("삭제하시겠습니까?"))
								return;
							cf_ajax("/system/team4/product/delete", this.info,
									this.delInfoCB);
						},
						delInfoCB : function() {
							this.gotoList();
						},
						gotoList : function() {
							cf_movePage('/system/team4/product/list');
						},
						checkName : function() {
							if (cf_isEmpty(this.info.product_name)) {
								alert("상품명을 입력하세요.");
								return;
							}
							cf_ajax("/system/team4/product/checkName",
									this.info, this.checkNameCB)
						},
						checkNameCB : function(data) {
							this.info1 = data;
							if (cf_isEmpty(this.info1.product_name)) {
								alert("사용 가능한 상품명입니다.");
								return;
							} else {
								alert("이미 존재하는 상품명입니다.");
								this.info.product_name = "";
								return;
							}
						},
						checkId : function() {
							if (this.info.product_id.length != 5) {
								alert("상품코드는 5자리입니다.")
								return;
							}
							if (cf_isEmpty(this.info.product_id)) {
								alert("상품코드를 입력하세요.");
								return;
							}
							cf_ajax("/system/team4/product/checkId", this.info,
									this.checkIdCB)
						},
						checkIdCB : function(data) {
							this.info1 = data;
							if (cf_isEmpty(this.info1.product_id)) {
								alert("사용 가능한 상품코드입니다.");
								return;
							} else {
								alert("이미 존재하는 상품코드입니다.");
								this.info.product_id = "";
								return;
							}
						},

					}
				})
	</script>
	</div>
</body>
</html>