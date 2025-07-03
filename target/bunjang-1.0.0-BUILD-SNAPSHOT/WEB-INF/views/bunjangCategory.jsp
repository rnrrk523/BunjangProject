<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page pageEncoding="UTF-8"%>

<html>
<head>
<title>번개장터</title>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/search.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/category.css">
<script>
	$(function() {
		/*TOP버튼 클릭 시 스트롤0 설정*/
		$("#scroll_topBtn").click(function() {
			$(window).scrollTop(0);
		})
		/*카테고리 리스트 버튼에 hover*/
		$("#main_categoryListBtn")
				.hover(
						function() {
							if (!$("#category_big").length) {
								$
										.ajax({
											type : "POST",
											url : "ajaxCategory1",
											success : function(data) {
												console.log(data);
												let item = '<div id="category_big">'
														+ '<div class="category_header"><span style="font-weight: bold;">전체카테고리</span><img src="${pageContext.request.contextPath}/resources/images/category_arrow.png"/></div>'
														+ '<ul id="category_ul_first" class="category_ul">';
												for (let i = 0; i < data.length; i++) {
													item += '<li class="allCategoryLi" data-idx="'+data[i].categoryIdx+'">'
															+ data[i].categoryName
															+ '</li>';
												}
												item += '</ul>' + '</div>';
												$("#categoryList_Wrap").append(
														item);
											},
											error : function(r, s, e) {
												console.log(r.status);
												console.log(r.responseText);
												console.log(e);
											}
										})
							}
						}, function() {
						});
		/*카테고리 리스트 닫기(카테고리창에서 커서 탈출 시)*/
		$("#main_head_Bar_In2").mouseleave(function() {
			// 마우스가 #main_categoryListBtn 요소에서 벗어났을 때 실행할 코드
			$("#categoryList_Wrap").empty();
		});
		/*전체 카테고리 li에 hover했을때*/
		$(document)
				.on(
						'mouseenter',
						'#category_ul_first li',
						function() {
							// #dynamicElement 요소에 마우스를 올렸을 때 실행할 코드
							let categoryName = $(this).text();
							let id = $(this).data("idx");
							$
									.ajax({
										type : "POST",
										url : "ajaxCategory2",
										data : {
											"id" : id
										},
										success : function(data) {
											console.log(data);
											$("#category_middle").remove();
											$("#category_small").remove();
											if (data.length != 0) {
												console.log(data);
												let item = '<div id="category_middle">'
														+ '<div class="category_header"><span id="categoryName2">'
														+ categoryName
														+ '</span><img src="${pageContext.request.contextPath}/resources/images/category_arrow.png"/></div>'
														+ '<ul id="category_ul_second" class="category_ul">';
												for (let i = 0; i < data.length; i++) {
													item += '<li class="middleCategoryLi" data-idx="'+data[i].categoryIdx+'">'
															+ data[i].categoryName
															+ '</li>';
												}
												item += '</ul>' + '</div>';
												$("#categoryList_Wrap").append(
														item);
											}
										},
										error : function(r, s, e) {
											console.log(r.status);
											console.log(r.responseText);
											console.log(e);
										}
									})
						});
		/*두번째 카테고리 li에 hover했을때*/
		$(document)
				.on(
						'mouseenter',
						'#category_ul_second li',
						function() {
							// #dynamicElement 요소에 마우스를 올렸을 때 실행할 코드
							let categoryName = $(this).text();
							let id = $(this).data("idx");
							$
									.ajax({
										type : "POST",
										url : "ajaxCategory3",
										data : {
											"id" : id
										},
										success : function(data) {
											console.log(data);
											$("#category_small").remove();
											if (data.length != 0) {
												console.log(data);
												let item = '<div id="category_small">'
														+ '<div class="category_header"><span id="categoryName3">'
														+ categoryName
														+ '</span><span></span></div>'
														+ '<ul id="category_ul_third" class="category_ul">';
												for (let i = 0; i < data.length; i++) {
													item += '<li class="subCategoryLi" data-idx="'+data[i].categoryIdx+'">'
															+ data[i].categoryName
															+ '</li>';
												}
												item += '</ul>' + '</div>';
												$("#categoryList_Wrap").append(
														item);
											}
										},
										error : function(r, s, e) {
											console.log(r.status);
											console.log(r.responseText);
											console.log(e);
										}
									})
						});
		/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
		/*main body안에 카테고리div hover시*/
		$("#allCategoryDiv").hover(function() {
			$("#allCategoryContentShow").css("display", "block");
		}, function() {
			$("#allCategoryContentShow").css("display", "none");
		});
		$("#middleCategoryDiv").hover(function() {
			$("#middleCategoryContentShow").css("display", "block");
		}, function() {
			$("#middleCategoryContentShow").css("display", "none");
		});
		$("#subCategoryDiv").hover(function() {
			$("#subCategoryContentShow").css("display", "block");
		}, function() {
			$("#subCategoryContentShow").css("display", "none");
		});
		/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
		/*로그인 버튼 클릭*/
		$("#login_and_join").click(function() {
			location.href = "auth/kakao-login"; // 내부 백엔드 경로
		})
		/*리스트 페이징넘버 처리*/
		$(".pagenation_A").click(function() {
			if (!$(this).hasClass("on")) {
				let pageNum = $(this).text();
				let sort = $(".searchList_sort.on").text();
				$.ajax({
					type : "POST",
					url : "ajaxPageNation",
					data : {
						"sort" : sort,
						"str" : "${str}",
						"pageNum" : pageNum
					},
					success : function(data) {
						console.log(data);
						$("#searchList_itemList_wrap").empty();
						for(let i = 0; i < data.length; i++) {
							let item = '<div class="searchList_item">'
									+ '<a data-idx="'
									+ data[i].productIdx
									+ '" href="productInfo?productIdx="'+data[i].productIdx+'" class="searchList_item_A">'
									+ '<div class="searchList_item_imgDiv"><img src="'+data[i].productImg+'" width="194" height="194" alt="상품 이미지"/></div>'
									+ '<div class="searchList_item_infoDiv">'
									+ '<div class="searchList_item_titleInfoContent">'
									+ data[i].productName
									+ '</div>'
									+ '<div class="searchList_item_priceInfoContentWrap">'
									+ '<div class="searchList_item_priceInfoContent">'
									+ Number(data[i].price).toLocaleString()
									+ '</div>'
									+ '<div class="searchList_item_date_div"><span>'
									+ data[i].elapsedDate
									+ '</span></div>'
									+ '</div>'
									+ '</div>'
									+ '</a>'
									+ '</div>';
							$("#searchList_itemList_wrap").append(item);
						}
					},
					error : function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			}
			$(".pagenation_A").removeClass("on");
			$(this).addClass("on");
		})
		/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
		/*카테고리 li 클릭 시*/
		$(document)
				.on(
						'click',
						'.allCategoryLi',
						function() {
							let categoryIdx = $(this).data("idx");
							location.href = "${pageContext.request.contextPath}/category?categoryIdx="
									+ categoryIdx + "&categoryLevel=all";
						})
		$(document)
				.on(
						'click',
						'.middleCategoryLi',
						function() {
							let categoryIdx = $(this).data("idx");
							location.href = "${pageContext.request.contextPath}/category?categoryIdx="
									+ categoryIdx + "&categoryLevel=middle";
						})
		$(document)
				.on(
						'click',
						'.subCategoryLi',
						function() {
							let categoryIdx = $(this).data("idx");
							location.href = "${pageContext.request.contextPath}/category?categoryIdx="
									+ categoryIdx + "&categoryLevel=sub";
						})
		/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
		/*검색창 버튼 클릭 시*/
		$("#search_input_submitBtn")
				.click(
						function() {
							let sarchStr = $("#search_input").val();
							location.href = "${pageContext.request.contextPath}/search?str="
									+ sarchStr;
						})
		/*검색창 엔터 시*/
		$('#search_input')
				.on(
						'keydown',
						function(e) {
							if (e.key === 'Enter') {
								let sarchStr = $("#search_input").val();
								location.href = "${pageContext.request.contextPath}/search?str="
										+ sarchStr;
							}
						});
		/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
		/*로그인 버튼 클릭*/
		$("#login_and_join").click(function(e) {
			e.preventDefault();

			const returnUrl = encodeURIComponent(window.location.href);
			location.href = "auth/kakao-login?returnUrl=" + returnUrl; // 내부 백엔드 경로
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
		$("#my_shop").hover(function() {
			$("#my_shop_in_list").css("display", "block");
		}, function() {
			$("#my_shop_in_list").css("display", "none");
		});
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
			if (res) {
				$.ajax({
					type : "POST",
					url : "ajaxSecession",
					data : {
						"storeIdx" : "${sessionScope.storeIdx}"
					},
					success : function() {
						alert("회원 탈퇴되었습니다.");
						window.location.href = "/bunjang/kakaoLogout";
					},
					error : function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			} else {
				$("#secession_bg").css("display", "none");
				$('html, body').css('overflow', 'visible');
			}
		})
		/*판매하기, 내상점 클릭 시 페이지 이동*/
		$(".main_menuBtn")
				.click(
						function() {
							let storeIdx = "${storeIdx}";
							if (storeIdx != 0) {
								let btnName = $(this).text();
								if (btnName == "판매하기") {
									location.href = "${pageContext.request.contextPath}/new";
								} else if (btnName == "내 상점") {
									location.href = "${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${sessionScope.storeIdx}";
								}
							} else {
								alert("로그인이 필요합니다.");
							}
						})
		/*오른쪽 사이드 찜버튼 클릭 시*/
		$("#a3")
				.click(
						function() {
							if ($(this).hasClass("on")) {
								location.href = "${pageContext.request.contextPath}/Storejjim?viewStoreIdx=${storeIdx}";
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
				<div id="secession_InfoDiv">계정의 모든 정보는 삭제되며 복구되지 않습니다.</div>
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
								<a id="my_shop_a"
									href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${storeIdx}">내
									상점</a>
								<div id="my_shop_in_list">
									<a
										href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${storeIdx}">내
										상품</a> <a
										href="${pageContext.request.contextPath}/Storejjim?viewStoreIdx=${storeIdx}">찜한상품</a>
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
				<a id="bunjang_logo" href="${pageContext.request.contextPath}"><img
					src="${pageContext.request.contextPath}/resources/images/bunjang_logo.png"
					width="136" height="40" alt="번개장터 로고" /></a>
				<div id="main_search_wrap">
					<input type="text" value="${str}" placeholder="상품명, 지역명, @상점명 입력"
						maxlength="40" id="search_input" /> <a id="search_input_submitBtn"><img
						src="${pageContext.request.contextPath}/resources/images/bunjang_searchBtn.png"
						width="16" height="16" alt="검색 버튼 아이콘" /></a>
				</div>
				<div id="main_menu_wrap">
					<a class="main_menuBtn"
						href="${pageContext.request.contextPath}/new"><img
						src="${pageContext.request.contextPath}/resources/images/bunjang_sell.png"
						width="23" height="26" alt="판매하기버튼 이미지" />판매하기</a> <a
						class="main_menuBtn"
						href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${storeIdx}"><img
						src="${pageContext.request.contextPath}/resources/images/bunjang_myShop.png"
						width="23" height="24" alt="내상점버튼 이미지" />내 상점</a>
				</div>
			</div>
			<div id="main_head_Bar_In2">
				<div id="main_categoryListBtn" class="category_hover">
					<img
						src="${pageContext.request.contextPath}/resources/images/bunjang_listBtn.png"
						width="20" height="16" alt="메뉴 버튼 아이콘" id="category_listBtn1" /> <img
						src="${pageContext.request.contextPath}/resources/images/bunjang_listBtn_hover.png"
						width="20" height="16" alt="메뉴 버튼 아이콘" id="category_listBtn2"
						style="display: none;" />
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
								<a id="a3" class="on"
									href="${pageContext.request.contextPath}/Storejjim?viewStoreIdx=${storeIdx}"><img
									src="https://m.bunjang.co.kr/pc-static/resource/f23127455135173fd3e9.png"
									width="12" height="12" alt="찜 아이콘" style="margin-right: 5px;" /><span
									id="favorites_cnt">${jjimCnt}</span></a>
							</c:when>
							<c:otherwise>
								<a id="a3"><img
									src="${pageContext.request.contextPath}/resources/images/bunjang_favorites.png"
									width="12" height="12" alt="찜 아이콘" style="margin-right: 5px;" /><span
									id="favorites_cnt">0</span></a>
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
		<div id="main_body_in">
			<div id="categoryHeaderWrap">
				<div id="categoryHeader1">
					<img
						src="https://m.bunjang.co.kr/pc-static/resource/f1f8a93028f0f6305a87.png"
						width="15" height="15" alt="카테고리 네비게이션 아이콘" /> 홈
				</div>
				<div id="categoryHeader2">
					<img
						src="https://m.bunjang.co.kr/pc-static/resource/c5ce9d5a172b0744e630.png"
						width="6" height="10" alt="카테고리 선택글부 아이콘" />
					<div id="allCategoryDiv">
						<div id="allCategoryDivIn">
							<div id="allCAtegoryContent">
								${allCategoryName} <img
									src="https://m.bunjang.co.kr/pc-static/resource/9b606ef2e7d57fafa657.png"
									width="10" height="6" alt="카테고리 화살표 아이콘" />
							</div>
							<div id="allCategoryContentShow">
								<c:forEach var="category" items="${allCategoryList}">
									<c:choose>
										<c:when test="${allCategoryIdx == category.categoryIdx}">
											<a class="allCategoryA on"
												href="${pageContext.request.contextPath}/category?categoryIdx=${category.categoryIdx}&categoryLevel=all"
												data-idx="${category.categoryIdx}">${category.categoryName}</a>
										</c:when>
										<c:otherwise>
											<a class="allCategoryA"
												href="${pageContext.request.contextPath}/category?categoryIdx=${category.categoryIdx}&categoryLevel=all"
												data-idx="${category.categoryIdx}">${category.categoryName}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<c:choose>
					<c:when test="${!(categoryLevel eq 'all')}">
						<div id="categoryHeader3">
							<img
								src="https://m.bunjang.co.kr/pc-static/resource/c5ce9d5a172b0744e630.png"
								width="6" height="10" alt="카테고리 선택그룹 아이콘" />
							<div id="middleCategoryDiv">
								<div id="middleCategoryDivIn">
									<div id="middleCategoryContent">
										${middleCategoryName} <img
											src="https://m.bunjang.co.kr/pc-static/resource/9b606ef2e7d57fafa657.png"
											width="10" height="6" alt="카테고리 화살표 아이콘" />
									</div>
									<div id="middleCategoryContentShow">
										<c:forEach var="category" items="${middleCategoryList}">
											<c:choose>
												<c:when test="${middleCategoryIdx == category.categoryIdx}">
													<a class="middleCategoryA on"
														href="${pageContext.request.contextPath}/category?categoryIdx=${category.categoryIdx}&categoryLevel=middle"
														data-idx="${category.categoryIdx}">${category.categoryName}</a>
												</c:when>
												<c:otherwise>
													<a class="middleCategoryA"
														href="${pageContext.request.contextPath}/category?categoryIdx=${category.categoryIdx}&categoryLevel=middle"
														data-idx="${category.categoryIdx}">${category.categoryName}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
						<c:choose>
							<c:when test="${categoryLevel eq 'sub'}">
								<div id="categoryHeader4">
									<img
										src="https://m.bunjang.co.kr/pc-static/resource/c5ce9d5a172b0744e630.png"
										width="6" height="10" alt="카테고리 선택그룹 아이콘" />
									<div id="subCategoryDiv">
										<div id="subCategoryDivIn">
											<div id="subCategoryContent">
												${subCategoryName} <img
													src="https://m.bunjang.co.kr/pc-static/resource/9b606ef2e7d57fafa657.png"
													width="10" height="6" alt="카테고리 화살표 아이콘" />
											</div>
											<div id="subCategoryContentShow">
												<c:forEach var="category" items="${subCategoryList}">
													<c:choose>
														<c:when test="${subCategoryIdx == category.categoryIdx}">
															<a class="subCategoryA on"
																href="${pageContext.request.contextPath}/category?categoryIdx=${category.categoryIdx}&categoryLevel=sub"
																data-idx="${category.categoryIdx}">${category.categoryName}</a>
														</c:when>
														<c:otherwise>
															<a class="subCategoryA"
																href="${pageContext.request.contextPath}/category?categoryIdx=${category.categoryIdx}&categoryLevel=sub"
																data-idx="${category.categoryIdx}">${category.categoryName}</a>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>
							</c:when>
						</c:choose>
					</c:when>
				</c:choose>
			</div>
			<div id="main_body_in_div3">
				<div id="searchList_title">
					<div id="searchList_title_left">
						<span style="color: rgb(247, 0, 0);">${selectCategoryName}</span>
						의 추천상품
					</div>
					<div id="searchList_title_right"></div>
				</div>
			</div>
			<div id="main_body_in_div4">
				<div id="searchList_itemList_wrap">
					<c:forEach var="item" items="${searchProductList}">
						<div class="searchList_item">
							<a data-idx="${item.productIdx}"
								href="${pageContext.request.contextPath}/productInfo?productIdx=${item.productIdx}"
								class="searchList_item_A">
								<div class="searchList_item_imgDiv">
									<img src="${item.productImg}" width="194" height="194"
										alt="상품 이미지" />
								</div>
								<div class="searchList_item_infoDiv">
									<div class="searchList_item_titleInfoContent">${item.productName}</div>
									<div class="searchList_item_priceInfoContentWrap">
										<div class="searchList_item_priceInfoContent">
											<fmt:formatNumber value="${item.price}" type="number"
												groupingUsed="true" />
										</div>
										<div class="searchList_item_date_div">
											<span>${item.elapsedDate}</span>
										</div>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
				</div>
			</div>
			<div id="main_body_in_div5">
				<div style="display: flex;">
					<c:choose>
						<c:when test="${searchProductListSize == 0}">
							검색결과가 없음
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${pageNum > 10}">
									<a class="pagenation_A"><img
										src="${pageContext.request.contextPath}/resources/images/pagenation_left_arrow.png"
										width="12" height="12" alt="페이징 아이콘" /></a>
								</c:when>
								<c:otherwise>
									<a class="pagenation_A off"><img
										src="${pageContext.request.contextPath}/resources/images/pagenation_left_arrow.png"
										width="12" height="12" alt="페이징 아이콘" /></a>
								</c:otherwise>
							</c:choose>
							<c:forEach var="i" begin="${startPageNum}" end="${endPageNum}">
								<c:choose>
									<c:when test="${i != pageNum}">
										<a class="pagenation_A">${i}</a>
									</c:when>
									<c:otherwise>
										<a class="pagenation_A on">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:choose>
								<c:when test="${pageNum != lastPageNum}">
									<a class="pagenation_A"><img
										src="${pageContext.request.contextPath}/resources/images/pagenation_right_arrow.png"
										width="12" height="12" alt="페이징 아이콘" /></a>
								</c:when>
								<c:otherwise>
									<a class="pagenation_A off"><img
										src="${pageContext.request.contextPath}/resources/images/pagenation_right_arrow.png"
										width="12" height="12" alt="페이징 아이콘" /></a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	<div id="main_footer">
		<div id="footer1">
			<div id="footer_btn_wrap">
				<a href="#" class="footer_btn">회사소개</a> <a href="#"
					class="footer_btn">이용약관</a> <a href="#" class="footer_btn">운영정책</a>
				<a href="#" class="footer_btn">개인정보처리방침</a> <a href="#"
					class="footer_btn">청소년보호정책</a> <a href="#" class="footer_btn">광고제휴</a>
			</div>
		</div>
		<div id="footer2">
			<img
				src="${pageContext.request.contextPath}/resources/images/bunjang_footer.png"
				width="1028" height="415" />
		</div>
	</div>
</body>
</html>
