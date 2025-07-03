<%@ page session="false" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>번개장터</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/product_new.css">
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
						let item = '<div id="category_big">' +
										'<div class="category_header"><span style="font-weight: bold;">전체카테고리</span><img src="${pageContext.request.contextPath}/resources/images/category_arrow.png"/></div>' +
										'<ul id="category_ul_first" class="category_ul">' +
											'<li>여성의류</li>' +
											'<li>남성의류</li>' +
											'<li>신발</li>' +
											'<li>가방/지갑</li>' +
											'<li>시계</li>' +
											'<li>쥬얼리</li>' +
											'<li>패션 액세서리</li>' +
											'<li>디지털</li>' +
											'<li>가전제품</li>' +
											'<li>스포츠/레저</li>' +
											'<li>차량/오토바이</li>' +
											'<li>스타굿즈</li>' +
											'<li>키덜트</li>' +
											'<li>예술/희귀/수집품</li>' +
											'<li>음반/악기</li>' +
											'<li>도서/티켓/문구</li>' +
											'<li>뷰티/미용</li>' +
											'<li>가구/인테리어</li>' +
											'<li>생활/주방용품</li>' +
											'<li>공구/산업용품</li>' +
											'<li>식품</li>' +
											'<li>유아동/출산</li>' +
											'<li>반려동물용품</li>' +
											'<li>기타</li>' +
											'<li>재능</li>' +
										'</ul>' +
									'</div>';
					    $("#categoryList_Wrap").append(item);
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
			    if(!$("#category_middle").length) {
				    let item = '<div id="category_middle">' +
									'<div class="category_header"><span id="categoryName2">'+categoryName+'</span><img src="${pageContext.request.contextPath}/resources/images/category_arrow.png"/></div>' +
									'<ul id="category_ul_second" class="category_ul">' +
										'<li>아우터</li>' +
										'<li>상의</li>' +
										'<li>바지</li>' +
										'<li>치마</li>' +
										'<li>원피스</li>' +
										'<li>점프수트</li>' +
										'<li>셋업/세트</li>' +
										'<li>언더웨어/홈웨어</li>' +
										'<li>테마/이벤트</li>' +
									'</ul>' +
								'</div>';
				    $("#categoryList_Wrap").append(item);
			    }else {
			    	$("#categoryName2").text(categoryName);
			    }
			});
			/*두번째 카테고리 li에 hover했을때*/
			$(document).on('mouseenter', '#category_ul_second li', function() {
			    // #dynamicElement 요소에 마우스를 올렸을 때 실행할 코드
			    let categoryName = $(this).text();
			    if(!$("#category_small").length) {
				    let item = '<div id="category_small">' +
									'<div class="category_header"><span id="categoryName3">'+categoryName+'</span><span></span></div>' +
									'<ul id="category_ul_third" class="category_ul">' +
										'<li>패딩</li>' +
										'<li>점퍼</li>' +
										'<li>코트</li>' +
										'<li>자켓</li>' +
										'<li>가디건</li>' +
										'<li>조끼/베스트</li>' +
									'</ul>' +
								'</div>';
				    $("#categoryList_Wrap").append(item);
			    }else {
			    	$("#categoryName3").text(categoryName);
			    }
			});
			/*상품관리*/
			let contextPath = '${pageContext.request.contextPath}';
			$(document).ready(function() {
				let $pageBox = $('.page-box');
				let $pagingImage = $('.paging-image');
				let $pageLayer = $('.page-layer');
				$pageBox.click(function(event) {
					event.stopPropagation(); // 문서 클릭 이벤트 막기
					if ($(this).hasClass('on')) {
						$(this).removeClass('on');
						$pagingImage.css('background-image', 'url(' + contextPath + '/resources/images/page-image.svg)');
						$pageLayer.css('display', 'none');
					} else {
						$(this).addClass('on');
						$pagingImage.css('background-image', 'url(' + contextPath + '/resources/images/page-image-up.svg)');
						$pageLayer.css('display', 'block');
					}
				});
				$(document).click(function() {
					if ($pageBox.hasClass('on')) {
						$pageBox.removeClass('on');
						$pagingImage.css('background-image', 'url(' + contextPath + '/resources/images/page-image.svg)');
						$pageLayer.css('display', 'none');
					}
				});
				$pageLayer.click(function(event) {
					event.stopPropagation();
				});
			});
			$(document).ready(function() {
			    let $statusBox = $('.product-status-box');
			    let $statusImage = $('.product-status-image');
			    let $statusLayer = $('.product-status-layer');

			    $statusBox.click(function(event) {
			        event.stopPropagation(); // 문서 클릭 이벤트 막기
			        if ($(this).hasClass('on')) {
			            $(this).removeClass('on');
			            $statusImage.css('background-image', 'url(' + contextPath + '/resources/images/page-image.svg)');
			            $statusLayer.css('display', 'none');
			        } else {
			            $(this).addClass('on');
			            $statusImage.css('background-image', 'url(' + contextPath + '/resources/images/page-image-up.svg)');
			            $statusLayer.css('display', 'block');
			        }
			    });

			    $(document).click(function() {
			        if ($statusBox.hasClass('on')) {
			            $statusBox.removeClass('on');
			            $statusImage.css('background-image', 'url(' + contextPath + '/resources/images/page-image.svg)');
			            $statusLayer.css('display', 'none');
			        }
			    });

			    $statusLayer.click(function(event) {
			        event.stopPropagation();
			    });
			});
			$(document).on('click', '.DeleteBtn', function() {
				let yn = confirm("정말 삭제하시겠습니다?");
				if(yn) {
					let pno = $(this).closest('tr').data('pno');
					$.ajax({
				        type: 'POST',
				        url: '${pageContext.request.contextPath}/deleteProduct',
				        data: {
				            productIdx: pno
				        },
				        success: function(response) {
				            alert('삭제가 완료되었습니다.');
				            location.reload();
				        },
				        error: function(xhr, status, error) {
				        	console.error("Error:", error);
				            console.error("Response Text:", xhr.responseText);
				            alert('삭제 중 오류가 발생했습니다.');
				        }
				    });
				}
			});
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
			/*오른쪽 사이드 찜버튼 클릭 시*/
			$("#a3").click(function() {
				if($(this).hasClass("on")) {
					location.href="${pageContext.request.contextPath}/Storejjim?viewStoreIdx=${storeIdx}";
				}
			})
		})
	</script>
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
					<c:when test="${sessionScope.storeIdx != null || storeIdx != 0}">
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
				<div id="categoryList_Wrap">
					<%-- <div id="category_big">
						<div class="category_header"><span style="font-weight: bold;">전체카테고리</span><img src="${pageContext.request.contextPath}/resources/images/category_arrow.png"/></div>
						<ul id="category_ul_first" class="category_ul">
							<li>여성의류</li>
							<li>남성의류</li>
							<li>신발</li>
							<li>가방/지갑</li>
							<li>시계</li>
							<li>쥬얼리</li>
							<li>패션 액세서리</li>
							<li>디지털</li>
							<li>가전제품</li>
							<li>스포츠/레저</li>
							<li>차량/오토바이</li>
							<li>스타굿즈</li>
							<li>키덜트</li>
							<li>예술/희귀/수집품</li>
							<li>음반/악기</li>
							<li>도서/티켓/문구</li>
							<li>뷰티/미용</li>
							<li>가구/인테리어</li>
							<li>생활/주방용품</li>
							<li>공구/산업용품</li>
							<li>식품</li>
							<li>유아동/출산</li>
							<li>반려동물용품</li>
							<li>기타</li>
							<li>재능</li>
						</ul>
					</div> --%>
					<%-- <div id="category_middle">
						<div class="category_header"><span id="categoryName2">여성의류</span><img src="${pageContext.request.contextPath}/resources/images/category_arrow.png"/></div>
						<ul id="category_ul_second" class="category_ul">
							<li>아우터</li>
							<li>상의</li>
							<li>바지</li>
							<li>치마</li>
							<li>원피스</li>
							<li>점프수트</li>
							<li>셋업/세트</li>
							<li>언더웨어/홈웨어</li>
							<li>테마/이벤트</li>
						</ul>
					</div> --%>
					<!-- <div id="category_small">
						<div class="category_header"><span id="categoryName3">아우터</span><span></span></div>
						<ul id="category_ul_third" class="category_ul">
							<li>패딩</li>
							<li>점퍼</li>
							<li>코트</li>
							<li>자켓</li>
							<li>가디건</li>
							<li>조끼/베스트</li>
						</ul>
					</div> -->
				</div>
			</div>
		</div>
		<div id="main_head_rightSide">
			<div id="rightSide_listWrap">
				<div class="rightSide_boxs">
					<div id="a1">찜한상품</div>
					<div id="a2">
						<c:choose>
							<c:when test="${jjimCnt > 0}">
								<a id="a3" class="on" href="${pageContext.request.contextPath}/Storejjim"><img src="https://m.bunjang.co.kr/pc-static/resource/f23127455135173fd3e9.png" width="12" height="12" alt="찜 아이콘" style="margin-right: 5px;"/><span id="favorites_cnt">${jjimCnt}</span></a>
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
		<div id="main_tab">
			<nav id="main_tab_nav">
				<div class="main_tab_items"><a href="new">상품등록</a></div>
				<div class="main_tab_items"><a href="manager" style="color: rgb(216, 12, 24);">상품관리</a></div>
				<div class="main_tab_items"><a href="BuySell">구매/판매 내역</a></div>
			</nav>
		</div>
		<div id="my_product_content_wrap">
			<main id="my_product_main_content">
				<section>
					<header id = "my_product_main_header">
						<form class = "my_product_serch_box" style="margin-right: 1rem;">
							<input type = "text" name = "search" placeholder="상품명을 입력해주세요" value="${search}">
							<input type="hidden" name="storeIdx" value="${param.storeIdx}">
    						<input type="hidden" name="str" value="${str}">
    						<input type="hidden" name="endRow" value="${endRow}">
							<button type = "submit" class = "search-submit"></button>
						</form>
						<div class = "page-box">
							<div class = "page-container">
								<div class = "page-box-main">
									<div class = "page-value-box">
										<div class="page-value">${param.endRow != null ? param.endRow : 10}개씩</div>
									</div>
									<div class = "paging-image"></div>
									<ul class = "page-layer" style = "display:none">
										<li class="page-value ${param.endRow == '10' || empty param.endRow ? 'on' : ''}">
										  <a href="${pageContext.request.contextPath}/manager?storeIdx=${param.storeIdx}&str=${param.str}&endRow=10">10개씩</a>
										</li>
										<li class="page-value ${param.endRow == '20' ? 'on' : ''}">
										  <a href="${pageContext.request.contextPath}/manager?storeIdx=${param.storeIdx}&str=${param.str}&endRow=20">20개씩</a>
										</li>
										<li class="page-value ${param.endRow == '30' ? 'on' : ''}">
										  <a href="${pageContext.request.contextPath}/manager?storeIdx=${param.storeIdx}&str=${param.str}&endRow=30">30개씩</a>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<div class = "search-nav">
							<div class = "search-select-1">
								<div class = "search-option-list">
									<a href="${pageContext.request.contextPath}/manager?storeIdx=${param.storeIdx}&str=전체&endRow=${param.endRow}" 
									   class="search-option-value ${param.str == '전체' ? 'on' : ''}">전체</a>
									<a href="${pageContext.request.contextPath}/manager?storeIdx=${param.storeIdx}&str=판매중&endRow=${param.endRow}" 
									   class="search-option-value ${param.str == '판매중' ? 'on' : ''}">판매중</a>
									<a href="${pageContext.request.contextPath}/manager?storeIdx=${param.storeIdx}&str=판매완료&endRow=${param.endRow}" 
									   class="search-option-value ${param.str == '판매완료' ? 'on' : ''}">판매완료</a>
								</div>
							</div>
						</div>
					</header>
					<table class = "product-table">
						<thead>
							<tr>
								<th style = "width:10.5rem">사진</th>
								<th style = "width:218px">상품명</th>
								<th style = "width:10rem">가격</th>
								<th style = "width:4.5rem">찜</th>
								<th style = "width:7.5rem">등록일</th>
								<th style = "width:5.875rem">기능</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="manager" items="${managerList}">
							<tr data-pno="${manager.productIdx}">
								<td>
									<a href="${pageContext.request.contextPath}/productInfo?productIdx=${manager.productIdx}">
										<div class = "product-image-box">
											<c:choose>
										      <c:when test="${empty manager.productImg1}">
										        <img
										          src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgdmlld0JveD0iMCAwIDEwMCAxMDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgICA8ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgICAgIDxjaXJjbGUgZmlsbD0iI0ZBRkFGQSIgY3g9IjUwIiBjeT0iNTAiIHI9IjUwIi8+CiAgICAgICAgPHBhdGggZD0iTTM2LjIxNiA0MS42ODNjLjI0OC0xLjkzMS40OTgtMy44NjIuNzUtNS43OTRoNi43OWwtLjI4MyA1LjUzN2MwIC4wMTcuMDA3LjAzNC4wMDcuMDUxLS4wMDIuMDEtLjAwMi4wMi0uMDAyLjAzLS4wOTggMS44NzYtMS44OTcgMy4zOTItNC4wMzUgMy4zOTItMS4wNjYgMC0yLjAxOC0uMzktMi42MTUtMS4wNzItLjUxLS41ODUtLjcyMi0xLjMyNS0uNjEyLTIuMTQ0em04Ljg4OCA0LjA3OGMxLjIyNCAxLjI4OSAzLjAwOSAyLjAyOCA0Ljg5IDIuMDI4IDEuODkgMCAzLjY3NC0uNzQgNC45LTIuMDMzLjEwNy0uMTEyLjIwNy0uMjI4LjMwNC0uMzQ1IDEuMjggMS40NDcgMy4yMTcgMi4zNzggNS4zNSAyLjM3OC4xMTIgMCAuMjE2LS4wMjcuMzI4LS4wMzJWNjMuNkgzOS4xMTVWNDcuNzU3Yy4xMTIuMDA1LjIxNS4wMzIuMzI4LjAzMiAyLjEzMyAwIDQuMDcxLS45MzEgNS4zNTEtMi4zOC4wOTkuMTIxLjIuMjM4LjMxLjM1MnptMS41NDUtOS44NzJoNi42OThsLjI4MiA1LjYxOWMwIC4wMTUtLjAwNy4wMjctLjAwNy4wNGwuMDA0LjA4NmEyLjkzOSAyLjkzOSAwIDAgMS0uODI2IDIuMTMyYy0xLjM2NyAxLjQ0LTQuMjMzIDEuNDQxLTUuNjA0LjAwM2EyLjk1IDIuOTUgMCAwIDEtLjgzLTIuMTQybC4wMDQtLjA3OGMwLS4wMTYtLjAwOC0uMDMtLjAwOC0uMDQ4bC4yODctNS42MTJ6bTE2LjM3NiAwYy4yNTIgMS45MzMuNTAyIDMuODY1Ljc1MyA1LjgwNC4xMDkuODEtLjEwNCAxLjU0Ny0uNjE0IDIuMTMyLS41OTYuNjgzLTEuNTUgMS4wNzQtMi42MTYgMS4wNzQtMi4xMzcgMC0zLjkzMi0xLjUxNC00LjAzNC0zLjM4OGEuMzU5LjM1OSAwIDAgMC0uMDAzLS4wNDRjMC0uMDE1LjAwNi0uMDI3LjAwNi0uMDRsLS4yNzgtNS41MzhoNi43ODZ6TTM2LjIyNiA0Ni45NDZ2MTguMDk4YzAgLjc5OC42NDYgMS40NDUgMS40NDQgMS40NDVoMjQuNjVjLjc5OSAwIDEuNDQ1LS42NDcgMS40NDUtMS40NDVWNDYuOTQ2Yy41OS0uMzI4IDEuMTM3LS43MTkgMS41NzUtMS4yMiAxLjA2MS0xLjIxNCAxLjUyMi0yLjc4NSAxLjMwMS00LjQxLS4zLTIuMzU1LS42MDctNC43MDctLjkxOC03LjA2YTEuNDQzIDEuNDQzIDAgMCAwLTEuNDMxLTEuMjU3SDM1LjY5OWMtLjcyNCAwLTEuMzM4LjUzOC0xLjQzMSAxLjI1Ny0uMzExIDIuMzU0LS42MTcgNC43MDctLjkxNiA3LjA1LS4yMjEgMS42MzcuMjQgMy4yMDggMS4zIDQuNDIxLjQzOS41MDIuOTg0Ljg5MyAxLjU3NCAxLjIyeiIgZmlsbD0iI0NDQyIvPgogICAgPC9nPgo8L3N2Zz4K"
										          width="100" height="200"
										          alt="상점 프로필 이미지"
										          class="Store_Profile_img" />
										      </c:when>
										      <c:otherwise>
										        <img src="${manager.productImg1}"
										             width="100" height="200"
										             class="Store_Profile_img" />
										      </c:otherwise>
										    </c:choose>
										</div>
									</a>
								</td>
								<td>
									<a href = "${pageContext.request.contextPath}/productInfo?productIdx=${manager.productIdx}">
									${manager.productName}
									</a>
								</td>
								<td>${manager.price}원</td>
								<td>${manager.jjimCount}</td>
								<td>${manager.saleStartDate}</td>
								<td>
									<button class = "DeleteBtn morebtn" style="color: rgb(2, 122, 255); margin-bottom: 0.5rem;">
										삭제
									</button>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:if test="${totalCount == 0}">
						<div class = "ProductNull">
							등록된 상품이 없습니다.
						</div>
					</c:if>
				</section>
			</main>
			<footer class = "ProductPage">
				<div class="ProductPageArea">
				  <c:if test="${prevGroupStartPage != -1}">
				    <a href="?storeIdx=${storeIdx}&str=${str}&endRow=${endRow}&page=${prevGroupStartPage}" class="ProductPageBtns">
				      <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxMiIgdmlld0JveD0iMCAwIDEyIDEyIj4KICAgIDxwYXRoIGZpbGw9IiM5Qjk5QTkiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZD0iTTMuNiAxMmEuNTk2LjU5NiAwIDAgMCAuNDQ5LS4yMDJsNC44LTUuNGEuNi42IDAgMCAwIDAtLjc5N2wtNC44LTUuNGEuNi42IDAgMSAwLS44OTcuNzk3TDcuNTk4IDYgMy4xNTIgMTFBLjYuNiAwIDAgMCAzLjYgMTIiLz4KPC9zdmc+Cg==" width="12" height="12" alt="이전 페이지 그룹" class="BtnLeft">
				    </a>
				  </c:if>
				  <c:forEach var="i" begin="${startPage}" end="${endPage}">
				    <a href="?storeIdx=${storeIdx}&str=${str}&endRow=${endRow}&page=${i}" class="ProductPageBtn ${i == page ? 'on' : ''}">${i}</a>
				  </c:forEach>
				  <c:if test="${nextGroupStartPage != -1}">
				    <a href="?storeIdx=${storeIdx}&str=${str}&endRow=${endRow}&page=${nextGroupStartPage}" class="ProductPageBtns">
				      <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxMiIgdmlld0JveD0iMCAwIDEyIDEyIj4KICAgIDxwYXRoIGZpbGw9IiM5Qjk5QTkiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZD0iTjguNCAwYS41OTYuNTk2IDAgMCAxLS40NDkuMjAybC00LjggNS40YS42LjYgMCAwIDEgMCAuNzk3bDQuOCA1LjRhLjYuNiAwIDAgMSAuODk3LS43OTdMNC40MDIgNiA4Ljg0IDFBLjYuNiAwIDAgMSA4LjQgMCIvPgo8L3N2Zz4K" width="12" height="12" alt="다음 페이지 그룹" class="BtnRight">
				    </a>
				  </c:if>
				</div>
			</footer>
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