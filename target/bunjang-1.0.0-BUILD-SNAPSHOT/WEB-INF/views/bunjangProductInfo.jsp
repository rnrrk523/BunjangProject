<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page pageEncoding="UTF-8" %>
<html>
<head>
	<title>번개장터</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/product_info.css">
	<script>
		$(function() {
			/*TOP버튼 클릭 시 스트롤0 설정*/
			$("#scroll_topBtn").click(function() {
				$(window).scrollTop(0);
			})
			/*카테고리 리스트 버튼에 hover*/
			$("#main_categoryListBtn").hover(
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
			/*-------------------------------------------------------------------------------------------------------------------------*/
			/*이미지 변경 버튼 클릭 시*/
			$("#productImg1").click(function() {
				$(".product_img_select_btn").prop("disabled", false);
				$(".product_img_select_btn").removeClass("select");
				$(this).prop("disabled", true);
				$(this).addClass("select");
				
				$("#product_img1").css("display", "inline");
				$("#product_img2").css("display", "none");
				$("#product_img3").css("display", "none");
			})
			$("#productImg2").click(function() {
				$(".product_img_select_btn").prop("disabled", false);
				$(".product_img_select_btn").removeClass("select");
				$(this).prop("disabled", true);
				$(this).addClass("select");
				
				$("#product_img1").css("display", "none");
				$("#product_img2").css("display", "inline");
				$("#product_img3").css("display", "none");
			})
			$("#productImg3").click(function() {
				$(".product_img_select_btn").prop("disabled", false);
				$(".product_img_select_btn").removeClass("select");
				$(this).prop("disabled", true);
				$(this).addClass("select");
				
				$("#product_img1").css("display", "none");
				$("#product_img2").css("display", "none");
				$("#product_img3").css("display", "inline");
			})
			
			/*-------------------------------------------------------카테고리(header X)------------------------------------------------------------------*/
			/*카테고리 hover시*/
			$(document).on('mouseenter', '#category_channel_div3', function() {
			    // #dynamicElement 요소에 마우스를 올렸을 때 실행할 코드
			   $("#category_channel_div5").css('display', 'block');
			});
			/*카테고리 hover해제 시*/
			$(document).on('mouseleave', '#category_channel_div3', function() {
			    // #dynamicElement 요소에 마우스를 올렸을 때 실행할 코드
			   $("#category_channel_div5").css('display', 'none');
			});
			/*카테고리 hover시*/
			$(document).on('mouseenter', '#category_channel_div7', function() {
			    // #dynamicElement 요소에 마우스를 올렸을 때 실행할 코드
			   $("#category_channel_div9").css('display', 'block');
			});
			/*카테고리 hover해제 시*/
			$(document).on('mouseleave', '#category_channel_div7', function() {
			    // #dynamicElement 요소에 마우스를 올렸을 때 실행할 코드
			   $("#category_channel_div9").css('display', 'none');
			});
			/*카테고리 hover시*/
			$(document).on('mouseenter', '#category_channel_div11', function() {
			    // #dynamicElement 요소에 마우스를 올렸을 때 실행할 코드
			   $("#category_channel_div13").css('display', 'block');
			});
			/*카테고리 hover해제 시*/
			$(document).on('mouseleave', '#category_channel_div11', function() {
			    // #dynamicElement 요소에 마우스를 올렸을 때 실행할 코드
			   $("#category_channel_div13").css('display', 'none');
			});
			/*----------------------------------------------------------------------------------------------------------------------------------------------*/
			/*바로 구매 버튼 클릭*/
			$("#product_payment_btn").click(function() {
				let storeIdx = "${sessionScope.storeIdx}";
				if(storeIdx != "") {
					window.open('<c:url value="/pay" />?storeIdx=${sessionScope.storeIdx}&productIdx=${param.productIdx}&sellerIdx=${sellerIdx}');
				}else {
					alert("로그인이 필요합니다");
				}
			})
			/*----------------------------------------------------------------------------------------------------------------------------------------------*/
			/*찜 버튼 클릭 시*/
			$(".product_jjim_btn").click(function() {
				let storeIdx = "${sessionScope.storeIdx}";
				if(storeIdx != "") {
					if($(this).hasClass("on")) {
						// 찜 해제 ajax
						$.ajax({
							type: "POST",
							url: "jjimOff",
							data: {
								"storeIdx": "${sessionScope.storeIdx}",
								"productIdx": "${param.productIdx}"
							},
							success: function() {
								alert("찜이 해제되었습니다!");
								location.reload();
							},
							error: function(r, s, e) {
								console.log(r.status);
								console.log(r.responseText);
								console.log(e);
							}
						})
					}else {
						// 찜 등록 ajax
						$.ajax({
							type: "POST",
							url: "jjimOn",
							data: {
								"storeIdx": "${sessionScope.storeIdx}",
								"productIdx": "${param.productIdx}"
							},
							success: function() {
								alert("찜이 등록되었습니다!");
								location.reload();
							},
							error: function(r, s, e) {
								console.log(r.status);
								console.log(r.responseText);
								console.log(e);
							}
						})
					}
				}else {
					alert("로그인이 필요합니다");
				}
			})
			/*----------------------------------------------------------------------------------------------------------------------------------------------*/
			/*팔로우버튼 클릭 시*/
			$(".store_floow_btn").click(function() {
				let storeIdx = "${sessionScope.storeIdx}";
				if(storeIdx != "") {
					if($(this).hasClass("on")) {
						$.ajax({
							type: "POST",
							url: "followOff",
							data: {
								"storeIdx": "${sessionScope.storeIdx}",
								"productIdx": "${param.productIdx}"
							},
							success: function() {
								alert("팔로우를 해제하였습니다!");
								location.reload();
							},
							error: function(r, s, e) {
								console.log(r.status);
								console.log(r.responseText);
								console.log(e);
							}
						})
					}else {
						$.ajax({
							type: "POST",
							url: "followOn",
							data: {
								"storeIdx": "${sessionScope.storeIdx}",
								"productIdx": "${param.productIdx}"
							},
							success: function() {
								alert("팔로우를 등록했습니다!");
								location.reload();
							},
							error: function(r, s, e) {
								console.log(r.status);
								console.log(r.responseText);
								console.log(e);
							}
						})
					}
				}else {
					alert("로그인이 필요합니다");
				}
			})
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
			/*카테고리(bottom) 클릭 시*/
			$("#bottomCategoryBtn1").click(function() {
				let categoryIdx = $(".all_category_a.select").data("idx");
				location.href="${pageContext.request.contextPath}/category?categoryIdx="+categoryIdx+"&categoryLevel=all";
			})
			$("#bottomCategoryBtn2").click(function() {
				let categoryIdx = $(".middle_category_a.select").data("idx");
				location.href="${pageContext.request.contextPath}/category?categoryIdx="+categoryIdx+"&categoryLevel=middle";
			})
			$("#bottomCategoryBtn3").click(function() {
				let categoryIdx = $(".sub_category_a.select").data("idx");
				location.href="${pageContext.request.contextPath}/category?categoryIdx="+categoryIdx+"&categoryLevel=sub";
			})
			/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
			/*로그인 버튼 클릭*/
			$("#login_and_join").click(function(e) {
				e.preventDefault();
				
				const returnUrl = encodeURIComponent(window.location.href);
				console.log(returnUrl);
				location.href = "auth/kakao-login?returnUrl="+returnUrl;  // 내부 백엔드 경로
			})
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
			$("#logoutCheckBtn").click(function() {
				window.location.href = "/bunjang/kakaoLogout";
			})
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
				let res = confirm("정말로 탈퇴하시겠습니까?");
				if(res) {
					$.ajax({
					    type: "POST",
					    url: "ajaxSecession",
					    data: {
					    	"storeIdx":"${sessionScope.storeIdx}"
					    },
					    success: function() {
					        alert("회원 탈퇴되었습니다.");
					        window.location.href = "/bunjang/kakaoLogout";
					    },
					    error: function(r, s, e) {
					    	console.log(r.status);
							console.log(r.responseText);
							console.log(e);
					    }
					})
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
								<a id="my_shop_a" href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${storeIdx}">내 상점</a>
								<div id="my_shop_in_list">
									<a href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${storeIdx}">내 상품</a>
									<a href="${pageContext.request.contextPath}/Storejjim?viewStoreIdx=${storeIdx}">찜한상품</a>
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
					<a class="main_menuBtn" href="${pageContext.request.contextPath}/new"><img src="${pageContext.request.contextPath}/resources/images/bunjang_sell.png" width="23" height="26" alt="판매하기버튼 이미지"/>판매하기</a>
					<a class="main_menuBtn" href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${storeIdx}"><img src="${pageContext.request.contextPath}/resources/images/bunjang_myShop.png" width="23" height="24" alt="내상점버튼 이미지"/>내 상점</a>
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
								<a id="a3" class="on" href="${pageContext.request.contextPath}/Storejjim?viewStoreIdx=${storeIdx}"><img src="https://m.bunjang.co.kr/pc-static/resource/f23127455135173fd3e9.png" width="12" height="12" alt="찜 아이콘" style="margin-right: 5px;"/><span id="favorites_cnt">${jjimCnt}</span></a>
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
		<div id="center_body">
			<div id="category_channel_div">
				<div id="category_channel_wrap">
					<div id="category_channel_div1">
						<img src="https://m.bunjang.co.kr/pc-static/resource/f1f8a93028f0f6305a87.png" width="15" height="15" alt="홈 아이콘"/>
						홈
					</div>
					<div id="category_channel_div2">
						<img src="https://m.bunjang.co.kr/pc-static/resource/c5ce9d5a172b0744e630.png" width="6" height="10" alt="카테고리 선택 아이콘"/>
						<div style="width: 154px;">
							<div id="category_channel_div3">
								<div id="category_channel_div4">
									${AllCategoryName}
									<img src="https://m.bunjang.co.kr/pc-static/resource/9b606ef2e7d57fafa657.png" width="10" height="6" alt="카테고리 화살표 아이콘"/>
								</div>
								<div id="category_channel_div5">
									<c:forEach var="category" items="${categorylist1}">
										<c:choose>
											<c:when test="${category.categoryName eq AllCategoryName}">
												<a class="all_category_a select" href="${pageContext.request.contextPath}/category?categoryIdx=${category.categoryIdx}&categoryLevel=all" data-idx="${category.categoryIdx}">${category.categoryName}</a>
											</c:when>
											<c:otherwise>
												<a class="all_category_a" href="${pageContext.request.contextPath}/category?categoryIdx=${category.categoryIdx}&categoryLevel=all" data-idx="${category.categoryIdx}">${category.categoryName}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
					<div id="category_channel_div6">
						<img src="https://m.bunjang.co.kr/pc-static/resource/c5ce9d5a172b0744e630.png" width="6" height="10" alt="카태고리 선택 아이콘"/>
						<div style="width: 154px;">
							<div id="category_channel_div7">
								<div id="category_channel_div8">
									${MiddleCategoryName}
									<img src="https://m.bunjang.co.kr/pc-static/resource/9b606ef2e7d57fafa657.png" width="10" height="6" alt="카테고리 화살표 아이콘"/>
								</div>
								<div id="category_channel_div9">
									<c:forEach var="category" items="${categorylist2}">
										<c:choose>
											<c:when test="${category.categoryName eq MiddleCategoryName}">
												<a class="middle_category_a select" href="${pageContext.request.contextPath}/category?categoryIdx=${category.categoryIdx}&categoryLevel=middle" data-idx="${category.categoryIdx}">${category.categoryName}</a>
											</c:when>
											<c:otherwise>
												<a class="middle_category_a" href="${pageContext.request.contextPath}/category?categoryIdx=${category.categoryIdx}&categoryLevel=middle" data-idx="${category.categoryIdx}">${category.categoryName}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
					<div id="category_channel_div10">
						<img src="https://m.bunjang.co.kr/pc-static/resource/c5ce9d5a172b0744e630.png" width="6" height="10" alt="카태고리 선택 아이콘"/>
						<div style="width: 154px;">
							<div id="category_channel_div11">
								<div id="category_channel_div12">
									${SubCategoryName}
									<img src="https://m.bunjang.co.kr/pc-static/resource/9b606ef2e7d57fafa657.png" width="10" height="6" alt="카테고리 화살표 아이콘"/>
								</div>
								<div id="category_channel_div13">
									<c:forEach var="category" items="${categorylist3}">
										<c:choose>
											<c:when test="${category.categoryName eq SubCategoryName}">
												<a class="sub_category_a select" href="${pageContext.request.contextPath}/category?categoryIdx=${category.categoryIdx}&categoryLevel=sub" data-idx="${category.categoryIdx}">${category.categoryName}</a>
											</c:when>
											<c:otherwise>
												<a class="sub_category_a" href="${pageContext.request.contextPath}/category?categoryIdx=${category.categoryIdx}&categoryLevel=sub" data-idx="${category.categoryIdx}">${category.categoryName}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="product_info_wrap">
				<div id="product_info_div1">
					<div id="product_info_div2">
						<div id="product_info_div3">
							<div style="width: 100%; height: 100%; position: relative;">
								<div id="imgList_wrap">
									<img src="${productInfo.productImg1}" width="428" height="428" id="product_img1"/>
									<c:choose>
										<c:when test="${productInfo.productImg2 != null}">
											<img src="${productInfo.productImg2}" width="428" height="428" id="product_img2" style="display: none;"/>
										</c:when>
									</c:choose>
									<c:choose>
										<c:when test="${productInfo.productImg3 != null}">
											<img src="${productInfo.productImg3}" width="428" height="428" id="product_img3" style="display: none;"/>
										</c:when>
									</c:choose>
								</div>
							</div>
							<div id="product_info_div4"></div>
							<div id="product_img_select_div">
								<button disabled class="product_img_select_btn select" id="productImg1"></button>
								<c:choose>
									<c:when test="${productInfo.productImg2 != null}">
										<button class="product_img_select_btn" id="productImg2"></button>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${productInfo.productImg3 != null}">
										<button class="product_img_select_btn" id="productImg3"></button>
									</c:when>
								</c:choose>
							</div>
						</div>
					</div>
					<div id="product_info_right_wrap">
						<div id="product_info_right_div1">
							<div>
								<div style="border-bottom: 1px solid rgb(238, 238, 238); width: 100%;">
									<div id="product_name">${productInfo.productName}</div>
									<div id="product_price_wrap">
										<div id="product_price_div">
											<fmt:formatNumber value="${productInfo.price}" type="number" groupingUsed="true"/>
											<span>원</span>
										</div>
									</div>
								</div>
								<div>
									<div id="product_info_right_cnt_wrap">
										<div id="product_info_right_cnt_div">
											<div id="product_jjim_cnt_div">
												<img src="https://m.bunjang.co.kr/pc-static/resource/e92ccca1b575780c7cb4.png" width="16" height="16" alt="상품 상태 아이콘"/>
												<div>${productInfo.jjimCnt}</div>
											</div>
											<div id="product_view_cnt_div">
												<img src="https://m.bunjang.co.kr/pc-static/resource/95ccf1c901ac09d733ec.png" width="21" height="13" alt="상품 상태 아이콘"/>
												${productInfo.checkCnt}
											</div>
											<div id="product_writer_date_div">
												<img src="https://m.bunjang.co.kr/pc-static/resource/f5ac734eb33eb0faa3b4.png" width="16" height="16" alt="상품 상태 아이콘"/>
												${productInfo.elapsedDate}
											</div>
										</div>
									</div>
									<div>
										<div class="product_info_right_content">
											<div id="product_info_state_before">
												<div id="state_before_div">
													<span>•</span>
													<span>상품상태</span>
												</div>
											</div>
											<div id="product_info_state">${productInfo.productState}</div>
										</div>
										<div class="product_info_right_content">
											<div id="product_info_delivery_left">
												<div id="delivery_left_div">
													<div id="delivery_left_div_in">
														<span>•</span>
														<span>배송비</span>
													</div>
												</div>
											</div>
											<div id="product_info_delivery">
												<div id="product_info_delivery_in">
													<span>3,000원</span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div id="product_info_right_div2">
								<c:choose>
									<c:when test="${storeInfo.storeIdx == storeIdx}">
									</c:when>
									<c:otherwise>
										<div id="product_jjim_div">
											<c:choose>
												<c:when test="${productInfo.jjimYN eq \"N\"}">
													<button class="product_jjim_btn">
														<img src="${pageContext.request.contextPath}/resources/images/bunjang_jjim_icon.png" width="16" height="16" alt="찜 아이콘"/>
														<span>찜</span>
														<span>${productInfo.jjimCnt}</span>
													</button>
												</c:when>
												<c:otherwise>
													<button class="product_jjim_btn on">
														<img src="${pageContext.request.contextPath}/resources/images/bunjang_jjim_icon_on.png" width="16" height="16" alt="찜 아이콘"/>
														<span>찜</span>
														<span>${productInfo.jjimCnt}</span>
													</button>
												</c:otherwise>
											</c:choose>
										</div>
										<div id="product_payment_div">
											<button type="button" id="product_payment_btn">바로구매</button>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div style="height: 50px; border-bottom: 1px solid rgb(33, 33, 33);"></div>
			<div id="productInfo_and_storeInfo_wrap">
				<div id="productInfo_wrap">
					<div id="productInfo_wrap_in">
						<div>
							<div id="productInfo_title">상품정보</div>
							<div>
								<div id="productInfo_content1">
									<p style="width: 663px;">${productInfo.productInfo}</p>
								</div>
								<div id="productInfo_content2">
									<div class="productInfo_content_in">
										<div id="productInfo_content_location1">
											<img src="https://m.bunjang.co.kr/pc-static/resource/5dcce33ad99f3020a4ab.png" width="16" height="18" alt="거래지역 아이콘"/>
											직거래지역
										</div>
										<div id="productInfo_content_location2">
											<div><span>-</span></div>
										</div>
									</div>
									<div class="productInfo_content_in">
										<div id="productInfo_content_category1">
											<img src="https://m.bunjang.co.kr/pc-static/resource/055518937849b5394e04.png" width="16" height="18" alt="카테고리 아이콘"/>
											카테고리
										</div>
										<div id="productInfo_content_category2">
											<div id="productInfo_content_category2_in">
												<a id="bottomCategoryBtn1">${AllCategoryName}</a>
												<span>></span>
												<a id="bottomCategoryBtn2">${MiddleCategoryName}</a>
												<span>></span>
												<a id="bottomCategoryBtn3">${SubCategoryName}</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="storeInfo_wrap">
					<div id="storeInfo_div">
						<div>
							<div id="store_title" data-idx="${productInfo.storeIdx}">상점정보</div>
							<div style="padding: 0 10px;">
								<div id="store_Info_content_wrap">
									<a href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${storeInfo.storeIdx}" id="store_prof_a"><img src="${pageContext.request.contextPath}/resources/images/bunjang_store_prof_nothing.png" width="48" height="48" alt="판매자 프로필 이미지"/></a>
									<div>
										<a href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${storeInfo.storeIdx}" id="store_name_a" data-idx="${storeInfo.storeIdx}">${storeInfo.storeName}</a>
										<div style="display: flex;">
											<a href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${storeInfo.storeIdx}" class="store_info_a">상품<span id="storeInfo_productCnt_span">${storeInfo.productCnt}</span></a>
											<a href="${pageContext.request.contextPath}/StoreFollower?viewStoreIdx=${storeInfo.storeIdx}" class="store_info_a">팔로워<span id="storeInfo_followCnt_span">${storeInfo.followCnt}</span></a>
										</div>
									</div>
								</div>
								<c:choose>
									<c:when test="${storeInfo.storeIdx == storeIdx}">
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${followYN eq \"N\"}">
												<button class="store_floow_btn">
													<img src="https://m.bunjang.co.kr/pc-static/resource/226de467653c15366c94.png" width="20" height="14" alt="화이트 테마 언팔로우 버튼 아이콘"/>
													팔로우
												</button>
											</c:when>
											<c:otherwise>
												<button class="store_floow_btn on">
													<img src="https://m.bunjang.co.kr/pc-static/resource/14e4b3096fb186e93644.png" width="20" height="14" alt="화이트 테마 언팔로우 버튼 아이콘"/>
													팔로잉
												</button>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								<div id="store_review_title_div">
									상점후기
									<c:choose>
										<c:when test="${storeReviewCnt > 0}">
											<span id="reviewsCntSpan">${storeReviewCnt}</span>
										</c:when>
									</c:choose>
								</div>
								<div id="storeReviewWrapDiv">
									<c:forEach var="item" items="${storeReviews}">
										<div class="reviewItems" data-idx="${item.storeIdx}">
											<a class="reviewItemImgA" href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${item.storeIdx}">
												<div><img src="${pageContext.request.contextPath}/resources/images/reviewStoreProfImg.png" width="32" height="32" alt="리뷰쓴 사람 프로필 이미지"/></div>
											</a>
											<div class="reviewItemContentWrap">
												<div class="reviewStoreName">
													<a class="reviewStoreNameA" href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${item.storeIdx}">${item.writerName}</a>
													<div class="rivewDate">${item.elapsedDate}</div>
												</div>
												<div class="reviewItemStar">
													<div style="display: flex;">
														<c:forEach var="i" begin="1" end="5">
															<c:choose>
																<c:when test="${i <= item.startCnt}">
																	<img src="https://m.bunjang.co.kr/pc-static/resource/44c1240e63c64f221877.png" width="15" height="14" alt="리뷰 2점 별점 이미지"/>
																</c:when>
																<c:otherwise>
																	<img src="https://m.bunjang.co.kr/pc-static/resource/982587b0e24b8bccea13.png" width="15" height="14" alt="리뷰 0점 별점 이미지"/>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</div>
												</div>
												<div class="reviewItemContent">${item.reviewText}</div>
											</div>
										</div>
									</c:forEach>
								</div>
								<div id="review_see_more">
									<a id="review_see_more_A" href="${pageContext.request.contextPath}/Storereviews?viewStoreIdx=${storeInfo.storeIdx}">상점후기 더보기</a>
								</div>
								<c:choose>
									<c:when test="${storeReviewCnt == 0}">
										<div id="store_review_content_div">
											<div id="store_review_content">
												등록된 후기가 없습니다.
												<br/>
												첫 후기를 등록해보세요!
											</div>
											<a href="${pageContext.request.contextPath}/Storereviews?viewStoreIdx=${productInfo.storeIdx}" id="store_review_write_btn">후기작성</a>
										</div>
									</c:when>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
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
