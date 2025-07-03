<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>번개장터</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/payment.css">
	<script>
		$(function() {
			/*창 닫기 & 뒤로가기*/
			$("#back_btn, #page_cancle_btn").click(function() {
				$("#black_bg").css('display', 'block');
				$("#payment_cancle_window").css('display', 'block');
			})
			/*창 닫기 & 뒤로가기 알림창 아니오 클릭 시*/
			$("#payment_cancleBtn_no").click(function() {
				$("#black_bg").css('display', 'none');
				$("#payment_cancle_window").css('display', 'none');
			})
			/*창 닫기 & 뒤로가기 알림창 예 클릭 시*/
			$("#payment_cancleBtn_yes").click(function() {
				window.close();
			})
			
			/*결제버튼 클릭 시*/
			$("#payment_submitBtn").click(function() {
				/*배송지 입력 확인*/
				let deliveryLocation = $("#delivery_address_input").val();
				if(deliveryLocation == "") {
					$("#black_bg").css('display', 'block');
					$("#delivery_location_nothing_window").css('display', 'block');
				}else {
					/*동의 checkbox 모두 체크 되어있는지 확인*/
					let checkAll = $(".payment_agree_checkBtn_sub:checked").length;
					if(checkAll == 3) {
	/*-------------------------------------결제 시작------------------------------*/
						// 배송지 : deliveryLocation
						
						/* 요청사항 */
						let request = $("#delivery_request_textarea").val();
						
						$.ajax({
							type: "POST",
							url: "ajaxPay",
							data: {
								"sellerIdx":"${param.sellerIdx}",
								"buyerIdx":"${sessionScope.storeIdx}",
								"productIdx":"${param.productIdx}",
								"stateStr":"진행중",
								"requestStr":request
							},
							success: function() {
								alert("구매완료.");
								location.href="${pageContext.request.contextPath}/";
							},
							error: function(r, s, e) {
								console.log(r.status);
								console.log(r.responseText);
								console.log(e);
							}
						})
					}else {
						alert("필수 항목에 동의해 주세요.");
						$('html, body').animate({ scrollTop: $(document).height() }, 500);
					}
				}
			})
			/*배송지 입력 알림창 닫기*/
			$("#delivery_location_nothing_window_checkBtn").click(function() {
				$("#black_bg").css('display', 'none');
				$("#delivery_location_nothing_window").css('display', 'none');
				
				const input = $('#delivery_address_input')[0]; // DOM 요소로 변환
				input.scrollIntoView({ behavior: 'smooth', block: 'center' });
				setTimeout(() => input.focus(), 300); // 포커스 약간 지연

			})
			/*상위동의 체크박스 클릭 시*/
			$("#payment_agree_label").change(function() {
				let input = $(this).children('input');
				if(input.prop('checked')) {
					$("#payment_agree_checkbox").children('img').attr('src', '${pageContext.request.contextPath}/resources/images/payment_agree_checkBtn_on.png');
					
					$(".payment_agree_checkBtn_sub").each(function() {
						$(this).parent().find('img').attr('src', '${pageContext.request.contextPath}/resources/images/payment_agree_checkBtn_sub_on.png');
						$(this).prop('checked', true);
					});
				}else {
					$("#payment_agree_checkbox").children('img').attr('src', '${pageContext.request.contextPath}/resources/images/payment_agree_checkBtn_off.png');
					
					$(".payment_agree_checkBtn_sub").each(function() {
						$(this).parent().find('img').attr('src', '${pageContext.request.contextPath}/resources/images/payment_agree_checkBtn_sub_off.png');
						$(this).prop('checked', false);
					});
				}
			})
			/*하위동의 체크박스 클릭 시*/
			$(".ol_label").change(function() {
				let input = $(this).children('input');
				if(input.prop('checked')) {
					$(this).find('img').attr('src', '${pageContext.request.contextPath}/resources/images/payment_agree_checkBtn_sub_on.png');
				}else {
					$(this).find('img').attr('src', '${pageContext.request.contextPath}/resources/images/payment_agree_checkBtn_sub_off.png');
				}
				/*하위동의 체크박스가 모두cheked상태일 때*/
				let cnt = $(".payment_agree_checkBtn_sub:checked").length;
				if(cnt == 3) {
					$("#payment_agree_checkbox").children('img').attr('src', '${pageContext.request.contextPath}/resources/images/payment_agree_checkBtn_on.png');
					$("#payment_agree_label").children('input[type="checkbox"]').prop('checked', true);
				}else {
					$("#payment_agree_checkbox").children('img').attr('src', '${pageContext.request.contextPath}/resources/images/payment_agree_checkBtn_off.png');
					$("#payment_agree_label").children('input[type="checkbox"]').prop('checked', false);
				}
			})
			
			$()
			
		})
	</script>
</head>
<body>
	<div id="root">
		<header>
			<aside>
				<button id="back_btn" aria-label="뒤로가기"><img src="${pageContext.request.contextPath}/resources/images/payment_backBtn.png" width="20" height="20"/></button>
				<title id="payment_title">결제</title>
			</aside>
			<aside>
				<button id="page_cancle_btn" aria-label="창닫기"><img src="${pageContext.request.contextPath}/resources/images/payment_closeBtn.png" width="20" height="20"/></button>
			</aside>
		</header>
		<main>
			<div>
				<section id="top_section">안전결제<strong id="section_in_strong">수수료 무제한 무료</strong>혜택 적용됨</section>
				<div id="main_content_div">
					<form id="payment_form">
						<section id="form_section1">
							<div id="trading_method">
								<div id="trading_method_div">거래방법</div>
								<span id="trading-method_span"><span>일반택배 (선불)</span></span>
							</div>
							<section>
								<div id="delivery_address">
									<div id="delivery_address_title"><h4>배송지</h4></div>
									<div>
										<div style="position: relative;">
											<input type="text" id="delivery_address_input" placeholder="배송지를 등록해 주세요"/>
										</div>
									</div>
								</div>
							</section>
							<div id="delivery_request">
								<p id="delivery_request_p">판매자분께 전달할 요청 사항을 적어주세요</p>
								<div id="delivery_request_div">
									<div id="delivery_request_input">
										<div id="delivery_request_input_in">
											<textarea rows="1" placeholder="예) 포장 꼼꼼하게 부탁드려요" id="delivery_request_textarea"></textarea>
										</div>
									</div>
								</div>
							</div>
						</section>
						<hr class="form_hr"/>
						<section id="order_product_section">
							<div id="order_product_div">
								<div id="order_product_title"><h4>주문 상품</h4></div>
								<div>
									<div id="order_product_info_div">
										<div>
											<div id="order_product_info_div_in">
												<img src="https://media.bunjang.co.kr/product/330907467_1_1746014746_w100.jpg" width="40" height="40" id="order_product_img"/>
												<div id="order_product_info_content_wrap">
													<div id="order_product_info_product_price_div">
														<span id="order_product_info_product_price_span"><fmt:formatNumber value="${productInfo.price}" type="number" groupingUsed="true"/></span>
													</div>
													<span id="order_product_info_product_name">${productInfo.productName}</span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</section>
						<hr class="form_hr"/>
						<section id="payment_amount_info_section">
							<div id="payment_amount_info_div">
								<div id="payment_amount_info_title"><h4>결제금액</h4></div>
								<div>
									<section id="payment_amount_info_section2">
										<section id="payment_amount_info_section3">
											<div id="payment_amount_info_section_inDiv1">
												<div id="product_amount_left"><span style="margin-right: 4px;">상품금액</span></div>
												<div id="product_amount_right"><strong><fmt:formatNumber value="${productInfo.price}" type="number" groupingUsed="true"/>원</strong></div>
											</div>
											<div>
												<div id="delivery_amount_div">
													<div id="delivery_amount_left"><span>배송비</span></div>
													<div id="delivery_amount_right">+3,000원</div>
												</div>
											</div>
											<div>
												<div id="safe_payment_top">
													<div id="safe_payment_top_left"><span>안전결제 수수료</span></div>
													<div id="safe_payment_top_right">무료</div>
												</div>
												<div id="safe_payment_bottom">
													사기 걱정 없는 안전결제
													<span style="color: rgb(100, 88, 226);">수수료 무료</span>
												</div>
											</div>
											<div id="coupon_wrap">
												<div id="coupon_left"><span>쿠폰 할인</span></div>
												<div id="coupon_right">0원</div>
											</div>
											<hr class="payment_amount_info_hr"/>
											<div id="total_payment_amount_wrap">
												<div id="total_payment_amount_left">
													<span><strong>총 결제금액</strong></span>
												</div>
												<div id="total_payment_amount_right">
													<strong><fmt:formatNumber value="${productInfo.price + 3000}" type="number" groupingUsed="true"/>원</strong>
												</div>
											</div>
										</section>
									</section>
								</div>
							</div>
						</section>
						<hr class="form_hr"/>
						<section id="payment_agree_wrap">
							<div id="payment_agree_div">
								<div id="payment_agree_div_in">
									<label id="payment_agree_label">
										<input type="checkbox" style="display: none;"/>
										<div id="payment_agree_checkbox"><img src="${pageContext.request.contextPath}/resources/images/payment_agree_checkBtn_off.png" width="20" height="20"/></div>
										아래 내용에 전체 동의해요.
									</label>
									<ol id="payment_agree_ol">
										<li>
											<div>
												<label class="ol_label">
													<input type="checkbox" class="payment_agree_checkBtn_sub" style="display: none;"/>
													<div><img src="${pageContext.request.contextPath}/resources/images/payment_agree_checkBtn_sub_off.png" width="14" height="14"/></div>
													번개장터 서비스 이용약관 동의 (필수)
												</label>
											</div>
										</li>
										<li>
											<div>
												<label class="ol_label">
													<input type="checkbox" class="payment_agree_checkBtn_sub" style="display: none;"/>
													<div><img src="${pageContext.request.contextPath}/resources/images/payment_agree_checkBtn_sub_off.png" width="14" height="14"/></div>
													개인정보 수집 및 이용 동의 (필수)
												</label>
											</div>
										</li>
										<li>
											<div>
												<label class="ol_label">
													<input type="checkbox" class="payment_agree_checkBtn_sub" style="display: none;"/>
													<div><img src="${pageContext.request.contextPath}/resources/images/payment_agree_checkBtn_sub_off.png" width="14" height="14"/></div>
													개인정보 제3자 제공 동의 (필수)
												</label>
											</div>
										</li>
									</ol>
								</div>
							</div>
							<hr class="payment_agree_hr"/>
							<div id="payment_submitBtn_notification">번개장터㈜는 통신판매중개자이며, 통신판매의 당사자가 아닙니다. 전자상거래 등에서의 소비자보호에 관한 법률 등 관련 법령 및 번개장터㈜의 약관에 따라 상품, 상품정보, 거래에 관한 책임은 개별 판매자에게 귀속하고, 번개장터㈜는 원칙적으로 회원간 거래에 대하여 책임을 지지 않습니다. 다만, 번개장터㈜가 직접 판매하는 상품에 대한 책임은 번개장터㈜에게 귀속합니다.</div>
						</section>
					</form>
				</div>
				<div id="payment_submitBtn_div">
					<button id="payment_submitBtn" type="submit" form="payment">
						<span id="payment_submitBtn_inSpan_total_amount"><fmt:formatNumber value="${productInfo.price + 3000}" type="number" groupingUsed="true"/></span>
						<span>원 결제하기</span>
					</button>
				</div>
				<div id="black_bg">
					<!-- 결제취소 시 -->
					<div id="payment_cancle_window">
						<div id="payment_cancle_window_top">
							<h3>결제취소</h3>
							<p>작성하신 내용이 모두 삭제됩니다. 구매를 취소하고 나가시겠어요?</p>
						</div>
						<div id="payment_cancle_window_bottom">
							<button id="payment_cancleBtn_no">아니오</button>
							<button id="payment_cancleBtn_yes">네</button>
						</div>
					</div>
					<!-- 배송지 누락 시 -->
					<div id="delivery_location_nothing_window">
						<div id="delivery_location_nothing_window_in">
							<div id="delivery_location_nothing_window_top">
								<div id="delivery_location_nothing_window_title">
									<h2>배송지 정보를 입력해주세요.</h2>
								</div>
							</div>
							<div id="delivery_location_nothing_window_bottom">
								<button id="delivery_location_nothing_window_checkBtn">확인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>
</body>
</html>