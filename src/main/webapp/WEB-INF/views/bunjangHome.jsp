<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page pageEncoding="UTF-8" %>

<html>
<head>
	<title>번개장터</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/home.css">
	<script>
		$(function() {
			/*TOP버튼 클릭 시 스트롤0 설정*/
			$("#scroll_topBtn").click(function() {
				$(window).scrollTop(0);
			})
			/*카테고리 리스트 버튼에 hover*/	/* main_categoryListBtn */
			$("#category_listBtn1").hover(
				function() {
					if(!$("#category_big").length) {
						$.ajax({
							type: "POST",
							url: "ajaxCategory1",
							success: function(data) {
								console.log(data);
								let item = '<div id="category_big">' +
												'<div class="category_header"><span style="font-weight: bold;">전체카테고리</span><img src="${pageContext.request.contextPath}/resources/images/category_arrow.png"/></div>' +
												'<ul id="category_ul_first" class="category_ul">';
								for(let i=0; i<data.length; i++) {
											item += '<li class="allCategoryLi" data-idx="'+data[i].categoryIdx+'">'+data[i].categoryName+'</li>';
								}
										item += '</ul>' +
											'</div>';
							    $("#categoryList_Wrap").append(item);
							},
							error: function(r, s, e) {
								console.log(r.status);
								console.log(r.responseText);
								console.log(e);
							}
						})
					}
				},		
				function() {
					
				}		
			);
			/*카테고리 리스트 닫기(카테고리창에서 커서 탈출 시)*/
			$("#main_head_Bar_In2").mouseleave(function() {
			    // 마우스가 #main_categoryListBtn 요소에서 벗어났을 때 실행할 코드
			    $("#categoryList_Wrap").empty();
			});
			/*전체 카테고리 li에 hover했을때*/
			$(document).on('mouseenter', '#category_ul_first li', function() {
			    // #dynamicElement 요소에 마우스를 올렸을 때 실행할 코드
			    let categoryName = $(this).text();
			    let id = $(this).data("idx");
			    $.ajax({
					type: "POST",
					url: "ajaxCategory2",
					data: { "id":id },
					success: function(data) {
						console.log(data);
						$("#category_middle").remove();
						$("#category_small").remove();
						if(data.length != 0) {
							console.log(data);
							 let item = '<div id="category_middle">' +
											'<div class="category_header"><span id="categoryName2">'+categoryName+'</span><img src="${pageContext.request.contextPath}/resources/images/category_arrow.png"/></div>' +
											'<ul id="category_ul_second" class="category_ul">';
									for(let i=0; i<data.length; i++) {
												item += '<li class="middleCategoryLi" data-idx="'+data[i].categoryIdx+'">'+data[i].categoryName+'</li>';
									}
									item += '</ul>' +
										'</div>';
						    $("#categoryList_Wrap").append(item);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			});
			/*두번째 카테고리 li에 hover했을때*/
			$(document).on('mouseenter', '#category_ul_second li', function() {
			    // #dynamicElement 요소에 마우스를 올렸을 때 실행할 코드
			    let categoryName = $(this).text();
			    let id = $(this).data("idx");
			    $.ajax({
					type: "POST",
					url: "ajaxCategory3",
					data: { "id":id },
					success: function(data) {
						console.log(data);
						$("#category_small").remove();
						if(data.length != 0) {
							console.log(data);
							let item = '<div id="category_small">' +
											'<div class="category_header"><span id="categoryName3">'+categoryName+'</span><span></span></div>' +
											'<ul id="category_ul_third" class="category_ul">';
										for(let i=0; i<data.length; i++) {
										item += '<li class="subCategoryLi" data-idx="'+data[i].categoryIdx+'">'+data[i].categoryName+'</li>';
										}
									item += '</ul>' +
										'</div>';
						    $("#categoryList_Wrap").append(item);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			});
			/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
			/*카테고리 li 클릭 시*/
			$(document).on('click', '.allCategoryLi', function() {
				let categoryIdx = $(this).data("idx");
				location.href = "${pageContext.request.contextPath}/category?categoryIdx="+categoryIdx+"&categoryLevel=all";
			})
			$(document).on('click', '.middleCategoryLi', function() {
				let categoryIdx = $(this).data("idx");
				location.href = "${pageContext.request.contextPath}/category?categoryIdx="+categoryIdx+"&categoryLevel=middle";
			})
			$(document).on('click', '.subCategoryLi', function() {
				let categoryIdx = $(this).data("idx");
				location.href = "${pageContext.request.contextPath}/category?categoryIdx="+categoryIdx+"&categoryLevel=sub";
			})
			/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
			/*검색창 버튼 클릭 시*/
			$("#search_input_submitBtn").click(function() {
				let sarchStr = $("#search_input").val();
				location.href = "${pageContext.request.contextPath}/search?str="+sarchStr;
			})
			/*검색창 엔터 시*/
			$('#search_input').on('keydown', function(e) {
			  if (e.key === 'Enter') {
				let sarchStr = $("#search_input").val();
				location.href = "${pageContext.request.contextPath}/search?str="+sarchStr;
			  }
			});
			/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
			/*로그인 버튼 클릭*/
			$("#login_and_join").click(function(e) {
			    e.preventDefault();
			
			    const returnUrl = window.location.href;  // 인코딩은 서버에서 처리해도 OK
			
			    // 동적으로 form 생성
			    const form = $('<form>', {
			        method: 'POST',
			        action: 'auth/kakao-login'
			    });
			
			    // returnUrl을 hidden input으로 추가
			    form.append($('<input>', {
			        type: 'hidden',
			        name: 'returnUrl',
			        value: returnUrl
			    }));
			
			    // CSRF 토큰 사용하는 경우 아래 주석 해제 후 설정
			    /*
			    form.append($('<input>', {
			        type: 'hidden',
			        name: '_csrf',
			        value: $('meta[name="_csrf"]').attr('content')
			    }));
			    */
			
			    // form을 body에 추가 후 제출
			    $('body').append(form);
			    form.submit();
			});

			/*로그아웃 버튼 클릭*/
			$("#logoutBtn").click(function() {
				$("#logout_bg").css("display", "flex");
				$('html, body').css('overflow', 'hidden');
			})
			/*로그아웃창에서 취소버튼 클릭*/
			$("#logoutCancleBtn").click(function() {
				$("#logout_bg").css("display", "none");
				$('html, body').css('overflow', 'visible');
			})
			/*로그아웃창에서 확인버튼 클릭*/
			$("#logoutCheckBtn").click(function(e) {
			    e.preventDefault();
			    const form = $('<form>', {
			        method: 'POST',
			        action: '/BunjangProject/kakaoLogout'
			    });
			    // CSRF 토큰이 필요하면 여기에 추가
			    $('body').append(form);
			    form.submit();
			});
			/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
			/*내 상점버튼에 hover 시*/
			$("#my_shop").hover(
				function() {
					$("#my_shop_in_list").css("display", "block");
				},
				function() {
					$("#my_shop_in_list").css("display", "none");
				}
			);
			/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
			/*탈퇴버튼 클릭 시*/
			$("#secession_Btn").click(function() {
				$("#secession_bg").css("display", "flex");
				$('html, body').css('overflow', 'hidden');
			})
			/*탈퇴창에서 아니요 클릭 시*/
			$("#secession_noBtn").click(function() {
				$("#secession_bg").css("display", "none");
				$('html, body').css('overflow', 'visible');
			})
			/*탈퇴창에서 네 클릭 시*/
			$("#secession_yesBtn").click(function() {
				let Q = confirm("정말로 탈퇴하시겠습니까?");
				if(Q) {
					$.ajax({
						  type: "POST",
						  url: "ajaxSecession",
						  success: function (res) {
						    alert("회원 탈퇴가 되었습니다.");
						    window.location.href = res.redirect;  // 여기서 이동
						  },
						  error: function (r, s, e) {
						    console.log(r.status);
						    console.log(r.responseText);
						    console.log(e);
						  }
						});

				}else {
					$("#secession_bg").css("display", "none");
					$('html, body').css('overflow', 'visible');
				}
			})
			/*판매하기, 내상점 클릭 시 페이지 이동*/
			$(".main_menuBtn").click(function() {
				let storeIdx = "${storeIdx}";
				if(storeIdx != 0) {
					let btnName = $(this).text();
					if(btnName == "판매하기") {
						location.href = "${pageContext.request.contextPath}/new";
					}else if(btnName == "내 상점") {
						location.href = "${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${sessionScope.storeIdx}";
					}
				}else {
					alert("로그인이 필요합니다.");
				}
			})
			/*오른쪽 사이드 찜버튼 클릭 시*/
			$("#a3").click(function() {
				if($(this).hasClass("on")) {
					location.href="${pageContext.request.contextPath}/Storejjim?viewStoreIdx=${storeIdx}";
				}
			})
		})
	</script>
	<c:if test="${not empty message}">
		<script>
		    alert("${message}");
		</script>
	</c:if>
</head>
<body>
	<div id="logout_bg">
		<div id="logout_window">
			<h2>로그아웃</h2>
			<p>로그아웃 하시겠습니까?</p>
			<div>
				<button type="button" id="logoutCheckBtn">확인</button>
				<button type="button" id="logoutCancleBtn">취소</button>
			</div>
		</div>
	</div>
	<div id="secession_bg">
		<div id="secession_window">
			<div id="secession_in_top">
				<h1 id="secession_h1">정말 탈퇴하시겠습니까?</h1>
				<div id="secession_InfoDiv">계정의 모든 정보는 삭제되며
복구되지 않습니다.</div>
			</div>
			<div id="secession_in_bottom">
				<button id="secession_noBtn">아니요</button>
				<button id="secession_yesBtn">네</button>
			</div>
		</div>
	</div>
	<div id="topBar">
		<div id="topBar_In">
			<div id="topBar_In_left"></div>
			<div id="topBar_In_right">
				<c:choose>
					<c:when test="${sessionScope.storeIdx != null}">
						<button id="logoutBtn">로그아웃</button>
						<div id="my_shop">
							<div id="my_shop_in">
								<a id="my_shop_a" href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${sessionScope.storeIdx}">내 상점</a>
								<div id="my_shop_in_list">
									<a href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${sessionScope.storeIdx}">내 상품</a>
									<a href="${pageContext.request.contextPath}/Storejjim?viewStoreIdx=${sessionScope.storeIdx}">찜한상품</a>
									<a id="secession_Btn">탈퇴</a>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<button id="login_and_join">로그인/회원가입</button>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div id="main_head">
		<div id="main_head_Bar">
			<div id="main_head_Bar_In1">
				<a id="bunjang_logo" href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/resources/images/bunjang_logo.png" width="136" height="40" alt="번개장터 로고"/></a>
				<div id="main_search_wrap">
					<input type="text" placeholder="상품명, 지역명, @상점명 입력" maxlength="40" id="search_input"/>
					<a id="search_input_submitBtn"><img src="${pageContext.request.contextPath}/resources/images/bunjang_searchBtn.png" width="16" height="16" alt="검색 버튼 아이콘"/></a>
				</div>
				<div id="main_menu_wrap">
					<a class="main_menuBtn"><img src="${pageContext.request.contextPath}/resources/images/bunjang_sell.png" width="23" height="26" alt="판매하기버튼 이미지"/>판매하기</a>
					<a class="main_menuBtn"><img src="${pageContext.request.contextPath}/resources/images/bunjang_myShop.png" width="23" height="24" alt="내상점버튼 이미지"/>내 상점</a>
				</div>
			</div>
			<div id="main_head_Bar_In2">
				<div id="main_categoryListBtn" class="category_hover">
					<img src="${pageContext.request.contextPath}/resources/images/bunjang_listBtn.png" width="20" height="16" alt="메뉴 버튼 아이콘" id="category_listBtn1"/>
					<img src="${pageContext.request.contextPath}/resources/images/bunjang_listBtn_hover.png" width="20" height="16" alt="메뉴 버튼 아이콘" id="category_listBtn2" style="display: none;"/>
				</div>
				<div id="categoryInfo" class="category_hover">카테고리</div>
				<div id="categoryList_Wrap"></div>
			</div>
		</div>
		<div id="main_head_rightSide">
			<div id="rightSide_listWrap">
				<div class="rightSide_boxs">
					<div id="a1">찜한상품</div>
					<div id="a2">
						<c:choose>
							<c:when test="${jjimCnt > 0}">
								<a id="a3" class="on"><img src="https://m.bunjang.co.kr/pc-static/resource/f23127455135173fd3e9.png" width="12" height="12" alt="찜 아이콘" style="margin-right: 5px;"/><span id="favorites_cnt">${jjimCnt}</span></a>
							</c:when>
							<c:otherwise>
								<a id="a3"><img src="${pageContext.request.contextPath}/resources/images/bunjang_favorites.png" width="12" height="12" alt="찜 아이콘" style="margin-right: 5px;"/><span id="favorites_cnt">0</span></a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<%-- <div class="rightSide_boxs">
					<div id="b1">최근본상품</div>
					<div id="b2">
						<div id="b22"></div>
					</div>
					<div id="b3">
						<img src="${pageContext.request.contextPath}/resources/images/recently_viewed_products.png" width="56" height="32" alt="빈 최근본상품 아이콘" style="margin-bottom: 5px;"/>
						<div>최근 본 상품이<br/>없습니다.</div>
					</div>
				</div> --%>
				<div class="rightSide_boxs">
					<button id="scroll_topBtn">TOP</button>
				</div>
			</div>
		</div>
	</div>
	<div id="main_body">
		<div id="banner1_wrap">
			<img src="${pageContext.request.contextPath}/resources/images/banner_img1.png" width="1024" height="299"/>
		</div>
		<div id="banner2_wrap">
			<img src="${pageContext.request.contextPath}/resources/images/banner_img2.png" width="1024" height="200"/>
		</div>
		<div id="section_product">
			<h2 id="product_list_title_h2">오늘의 상품 추천</h2>
			<div id="product_list_wrap">
				<c:forEach var="item" items="${homeProductList}">
					<div class="product_items">
						<a data-pid="${item.productIdx}" href="${pageContext.request.contextPath}/productInfo?productIdx=${item.productIdx}">
							<div class="product_img_div">
								<img src="${item.productImg}" width="194" height="194" alt="상품 이미지"/>
							</div>
							<div class="product_info_div">
								<div class="product_name">${item.productName}</div>
								<div class="product_price_and_date">
									<div class="product_price"><fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/></div>
									<div class="product_date"><span>${item.elapsedDate}</span></div>
								</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div id="main_footer">
		<div id="footer1">
			<div id="footer_btn_wrap">
				<a href="#" class="footer_btn">회사소개</a>
				<a href="#" class="footer_btn">이용약관</a>
				<a href="#" class="footer_btn">운영정책</a>
				<a href="#" class="footer_btn">개인정보처리방침</a>
				<a href="#" class="footer_btn">청소년보호정책</a>
				<a href="#" class="footer_btn">광고제휴</a>
			</div>
		</div>
		<div id="footer2">
			<img src="${pageContext.request.contextPath}/resources/images/bunjang_footer.png" width="1028" height="415"/>
		</div>
	</div>
</body>
</html>
