<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bunjangStoreProduct.css">
<meta charset="UTF-8">
<title>번개장터</title>
</head>
<script>
	$(document).ready(function() {
		function getStoreIdxFromUrl() {
		    const urlParams = new URLSearchParams(window.location.search);
		    return urlParams.get('viewStoreIdx');
		}
		$('.Store_name_edit').click(function(){
			$('.Store_nameEdit_area').css('display','flex');
			$('.Store_name_box').css('display','none');
		});
		$('.Store_nameEdit_area button[type="button"]').click(function() {
		    $('.Store_nameEdit_area').css('display', 'none');
		    $('.Store_name_box').css('display', 'flex');
		    let inputVal = $(this).siblings('input').val();
		    let storeIdx = getStoreIdxFromUrl();
		    if (inputVal.length < 2 || inputVal.length > 10) {
		        alert('상점명은 최소 2자, 최대 10자까지 입력 가능합니다.');
		        return;
		    }
		    $.ajax({
		        type: "POST",
		        url: '${pageContext.request.contextPath}/UpdateStoreName',
		        data: {
		            storeName: inputVal,
		            storeIdx: storeIdx
		        },
		        success: function(response) {
		        	$(this).siblings('input').val(inputVal);
		            $('.Store_name_box > span').text(inputVal);
		            $('.Store_name').text(inputVal);
		            alert("상점명이 변경되었습니다.");
		        },
		        error: function() {
		        }
		    });
		});
		$('.Store_introduction_input_area textarea').on('keydown', function(e) {
		    let val = $(this).val();

		    const allowedKeys = [8, 37, 38, 39, 40, 46];
		    if (val.length >= 1000 && !allowedKeys.includes(e.keyCode)) {
		        e.preventDefault();
		    }
		});

		$('.Store_introduction_input_area textarea').on('input', function() {
		    let val = $(this).val();
		    if (val.length > 1000) {
		        $(this).val(val.substring(0, 1000));
		        val = $(this).val();
		    }
		    $(this).siblings('span').text(val.length + '/1000');
		});
		$('.Store_introduction_editbtn').click(function(){
			$('.Store_introduction_area').css('display','none');
			$('.Store_introduction_edit_area').css('display','none');
			$('.Store_introduction_input_area').css('display','flex');
		});
		$('.Store_introduction_input_area > button').click(function(){
		    let val = $('.Store_introduction_input_area textarea').val();
		    let storeIdx = getStoreIdxFromUrl();

		    $.ajax({
		        type: "POST",
		        url: '${pageContext.request.contextPath}/UpdateStoreIntroduction',
		        data: {
		            storeInt: val,
		            storeIdx: storeIdx
		        },
		        success: function(response) {
		            $('.Store_introduction_input_area textarea').val(val);
		            $('.Store_introduction_area').text(val);
		            $('.Store_introduction_area').css('display','block');
		            $('.Store_introduction_edit_area').css('display','flex');
		            $('.Store_introduction_input_area').css('display','none');
		            alert("소개글이 수정되었습니다.");
		        },
		        error: function() {
		            alert('소개글 저장 실패. 다시 시도해 주세요.');
		        }
		    });
		});
	});
</script>
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
				let dd = "${sessionScope.storeIdx}";
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
			/*팔로우, 팔로잉 버튼 클릭 시*/
			$(".followBtn").click(function() {
				$.ajax({
					type: "POST",
			        url: 'ajaxFollow',
			        data: {
			            "storeIdx":"${storeIdx}",
			            "viewStoreIdx":"${viewStoreIdx}"
			        },
			        success: function() {
			        	location.reload();
			        },
			        error: function(r, s, e) {
			        	console.log(r.status);
						console.log(r.responseText);
						console.log(e);
			        }
				})
			})
		})
	</script>
<c:if test="${not empty message}">
	<script>
	    alert("${message}");
	</script>
</c:if>
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
	<div class ="main_body">
		<div class = "main_area">
			<div style = "height : 30px;"></div>
			<div class = "Store_Area">
				<div class ="Store_Profile_box">
					<div>
						<div size="310" class = "Store_Profile_Area">
							<div class = "Store_Profile_background">
								<div class = "Store_Profile_background2"></div>
							</div>
							<div class = "Store_Profile_Main">
								<img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgdmlld0JveD0iMCAwIDEwMCAxMDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgICA8ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgICAgIDxjaXJjbGUgZmlsbD0iI0ZBRkFGQSIgY3g9IjUwIiBjeT0iNTAiIHI9IjUwIi8+CiAgICAgICAgPHBhdGggZD0iTTM2LjIxNiA0MS42ODNjLjI0OC0xLjkzMS40OTgtMy44NjIuNzUtNS43OTRoNi43OWwtLjI4MyA1LjUzN2MwIC4wMTcuMDA3LjAzNC4wMDcuMDUxLS4wMDIuMDEtLjAwMi4wMi0uMDAyLjAzLS4wOTggMS44NzYtMS44OTcgMy4zOTItNC4wMzUgMy4zOTItMS4wNjYgMC0yLjAxOC0uMzktMi42MTUtMS4wNzItLjUxLS41ODUtLjcyMi0xLjMyNS0uNjEyLTIuMTQ0em04Ljg4OCA0LjA3OGMxLjIyNCAxLjI4OSAzLjAwOSAyLjAyOCA0Ljg5IDIuMDI4IDEuODkgMCAzLjY3NC0uNzQgNC45LTIuMDMzLjEwNy0uMTEyLjIwNy0uMjI4LjMwNC0uMzQ1IDEuMjggMS40NDcgMy4yMTcgMi4zNzggNS4zNSAyLjM3OC4xMTIgMCAuMjE2LS4wMjcuMzI4LS4wMzJWNjMuNkgzOS4xMTVWNDcuNzU3Yy4xMTIuMDA1LjIxNS4wMzIuMzI4LjAzMiAyLjEzMyAwIDQuMDcxLS45MzEgNS4zNTEtMi4zOC4wOTkuMTIxLjIuMjM4LjMxLjM1MnptMS41NDUtOS44NzJoNi42OThsLjI4MiA1LjYxOWMwIC4wMTUtLjAwNy4wMjctLjAwNy4wNGwuMDA0LjA4NmEyLjkzOSAyLjkzOSAwIDAgMS0uODI2IDIuMTMyYy0xLjM2NyAxLjQ0LTQuMjMzIDEuNDQxLTUuNjA0LjAwM2EyLjk1IDIuOTUgMCAwIDEtLjgzLTIuMTQybC4wMDQtLjA3OGMwLS4wMTYtLjAwOC0uMDMtLjAwOC0uMDQ4bC4yODctNS42MTJ6bTE2LjM3NiAwYy4yNTIgMS45MzMuNTAyIDMuODY1Ljc1MyA1LjgwNC4xMDkuODEtLjEwNCAxLjU0Ny0uNjE0IDIuMTMyLS41OTYuNjgzLTEuNTUgMS4wNzQtMi42MTYgMS4wNzQtMi4xMzcgMC0zLjkzMi0xLjUxNC00LjAzNC0zLjM4OGEuMzU5LjM1OSAwIDAgMC0uMDAzLS4wNDRjMC0uMDE1LjAwNi0uMDI3LjAwNi0uMDRsLS4yNzgtNS41MzhoNi43ODZ6TTM2LjIyNiA0Ni45NDZ2MTguMDk4YzAgLjc5OC42NDYgMS40NDUgMS40NDQgMS40NDVoMjQuNjVjLjc5OSAwIDEuNDQ1LS42NDcgMS40NDUtMS40NDVWNDYuOTQ2Yy41OS0uMzI4IDEuMTM3LS43MTkgMS41NzUtMS4yMiAxLjA2MS0xLjIxNCAxLjUyMi0yLjc4NSAxLjMwMS00LjQxLS4zLTIuMzU1LS42MDctNC43MDctLjkxOC03LjA2YTEuNDQzIDEuNDQzIDAgMCAwLTEuNDMxLTEuMjU3SDM1LjY5OWMtLjcyNCAwLTEuMzM4LjUzOC0xLjQzMSAxLjI1Ny0uMzExIDIuMzU0LS42MTcgNC43MDctLjkxNiA3LjA1LS4yMjEgMS42MzcuMjQgMy4yMDggMS4zIDQuNDIxLjQzOS41MDIuOTg0Ljg5MyAxLjU3NCAxLjIyeiIgZmlsbD0iI0NDQyIvPgogICAgPC9nPgo8L3N2Zz4K" width="100" height="100" alt="상점 프로필 이미지" class="Store_Profile_img">
								<div class = "Store_name">${store.storeName}</div>
								<div class="Store_Star">
									<c:forEach var="i" begin="1" end="5">
									    <c:choose>
									        <c:when test="${i <= store.avgStartIdx}">
									            <img src="${pageContext.request.contextPath}/resources/images/star_on.png" width="15" height="14">
									        </c:when>
									        <c:otherwise>
									            <img src="${pageContext.request.contextPath}/resources/images/star_off.png" width="15" height="14">
									        </c:otherwise>
									    </c:choose>
									</c:forEach>
								</div>
								<c:choose>
									<c:when test="${storeIdx == viewStoreIdx}">
										<div class = "Store_management">
											<a class="Store_management_box" href="${pageContext.request.contextPath}/manager">내 상점 관리</a>
										</div>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${followYN == 0}">
												<div class="followBtnDiv">
													<button class="followBtn">
														<img src="https://m.bunjang.co.kr/pc-static/resource/d368b76c5a0a989a49ee.png" width="20" height="14" alt="화이트 테마 언팔로우 버튼 아이콘"/>
														팔로우
													</button>
												</div>
											</c:when>
											<c:otherwise>
												<div class="followBtnDiv">
													<button class="followBtn">
														<img src="https://m.bunjang.co.kr/pc-static/resource/e73856bca30ca5ab76f0.png" width="20" height="14" alt="화이트 테마 팔로우 버튼 아이콘"/>
														팔로잉
													</button>
												</div>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
				<div class = "Store_Profile_box2">
					<div class = "Store_name_area">
						<div class = "Store_name_box">
							<span>${store.storeName}</span>
							<c:choose>
								<c:when test="${store.storeIdx == sessionScope.storeIdx}">
									<button class = "Store_name_edit">상점명 수정</button>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						</div>
						<div class = "Store_nameEdit_area" style = "display:none">
							<input type= "text" value="${store.storeName}">	
							<button type = "button">확인</button>					
						</div>
					</div>
					<div class = "Store_Date_area">
						<div class = "Store_date_box">
							<img src="${pageContext.request.contextPath}/resources/images/Store_open.png" width="14" height="13" alt="상점오픈일 아이콘">
							상점오픈일 
							<span class = "blackColor">
								${store.openDate}
							</span>
						</div>
						<div class = "Store_date_box">
							<img src="${pageContext.request.contextPath}/resources/images/Store_visit.png" width="14" height="13" alt="상점방문수 아이콘">
							상점방문수 
							<span class = "blackColor">
								${store.visitCount} 명
							</span>
						</div>
						<div class = "Store_date_box">
							<img src="${pageContext.request.contextPath}/resources/images/Store_sell.png" width="14" height="13" alt="상품판매 아이콘">
							상품판매 
							<span class = "blackColor">
								${store.sellCount} 회
							</span>
						</div>
					</div>
					<div class = "Store_introduction_area">${store.introduction}</div>
					<div class = "Store_introduction_input_area" style = "display:none">
						<div>
							<textarea>${store.introduction}</textarea>
							<span></span>
						</div>
						<button type = "button">확인</button>
					</div>
					<div class = "Store_introduction_edit_area">
						<c:choose>
							<c:when test="${store.storeIdx == sessionScope.storeIdx}">
								<button class ="Store_introduction_editbtn">소개글 수정</button>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<div style = "height : 30px;"></div>
			<div>
				<div class = "Store_nav">
					<a class = "Store_nav_category off" href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${viewStoreIdx}">
						상품
						<span class = "Store_number">${store.productCount}</span>
					</a>
					<a class = "Store_nav_category on" href="${pageContext.request.contextPath}/Storereviews?viewStoreIdx=${viewStoreIdx}">
						상점후기
						<span class = "Store_number">${store.reviewCount}</span>
					</a>
					<c:choose>
						<c:when test="${sessionScope.storeIdx == store.storeIdx}">
							<a class = "Store_nav_category off" href="${pageContext.request.contextPath}/Storejjim?viewStoreIdx=${viewStoreIdx}">
								찜
								<span class = "Store_number">${store.jjimCount}</span>
							</a>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
					<a class = "Store_nav_category off" href="${pageContext.request.contextPath}/StoreFollowing?viewStoreIdx=${viewStoreIdx}">
						팔로잉
						<span class = "Store_number">${store.followingCount}</span>
					</a>
					<a class = "Store_nav_category off" href="${pageContext.request.contextPath}/StoreFollower?viewStoreIdx=${viewStoreIdx}">
						팔로워
						<span class = "Store_number">${store.followerCount}</span>
					</a>
				</div>
			</div>
			<div>
				<div>
					<div class = "Store_product_reviews_header">
						<div class = "Store_product_reviews_header2">
							<div>
								상품후기
								<span class = "Product_number">${store.reviewCount}</span>
							</div>
							<c:choose>
							  <c:when test="${store.reviewCount == 0}">
								<div class = "Product_reviews_information_area" style = "display:none">
							  </c:when>
							  <c:otherwise>
								<div class = "Product_reviews_information_area">
							  </c:otherwise>
							</c:choose>
								<div class = "Product_reviews_information_box">
									<div class = "Product_reviews_star_Box">
										<div class = "Product_reviews_count">${store.reviewCount}</div>
										<div class = "Product_reviews_star_area">
											<c:forEach var="i" begin="1" end="5">
											    <c:choose>
											        <c:when test="${i <= store.avgStartIdx}">
											            <img src="${pageContext.request.contextPath}/resources/images/star_on.png" width="15" height="14">
											        </c:when>
											        <c:otherwise>
											            <img src="${pageContext.request.contextPath}/resources/images/star_off.png" width="15" height="14">
											        </c:otherwise>
											    </c:choose>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<c:choose>
					  <c:when test="${store.reviewCount == 0}">
						<div class = "Store_product_null">상품 후기가 없습니다.</div>
					  </c:when>
					  <c:otherwise>
						<div class = "Store_product_reviews_main">
							<c:forEach var="reviews" items="${reviewsList}">
								<div class = "Store_product_reviews_item" data-rno = "${reviews.writerIdx}">
									<a class= "reviewer_profile" href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${reviews.writerIdx}">
										<div class = "profile_img_box">
											<c:choose>
										      <c:when test="${empty reviews.profileImg}">
										        <img
										          src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgdmlld0JveD0iMCAwIDEwMCAxMDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgICA8ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgICAgIDxjaXJjbGUgZmlsbD0iI0ZBRkFGQSIgY3g9IjUwIiBjeT0iNTAiIHI9IjUwIi8+CiAgICAgICAgPHBhdGggZD0iTTM2LjIxNiA0MS42ODNjLjI0OC0xLjkzMS40OTgtMy44NjIuNzUtNS43OTRoNi43OWwtLjI4MyA1LjUzN2MwIC4wMTcuMDA3LjAzNC4wMDcuMDUxLS4wMDIuMDEtLjAwMi4wMi0uMDAyLjAzLS4wOTggMS44NzYtMS44OTcgMy4zOTItNC4wMzUgMy4zOTItMS4wNjYgMC0yLjAxOC0uMzktMi42MTUtMS4wNzItLjUxLS41ODUtLjcyMi0xLjMyNS0uNjEyLTIuMTQ0em04Ljg4OCA0LjA3OGMxLjIyNCAxLjI4OSAzLjAwOSAyLjAyOCA0Ljg5IDIuMDI4IDEuODkgMCAzLjY3NC0uNzQgNC45LTIuMDMzLjEwNy0uMTEyLjIwNy0uMjI4LjMwNC0uMzQ1IDEuMjggMS40NDcgMy4yMTcgMi4zNzggNS4zNSAyLjM3OC4xMTIgMCAuMjE2LS4wMjcuMzI4LS4wMzJWNjMuNkgzOS4xMTVWNDcuNzU3Yy4xMTIuMDA1LjIxNS4wMzIuMzI4LjAzMiAyLjEzMyAwIDQuMDcxLS45MzEgNS4zNTEtMi4zOC4wOTkuMTIxLjIuMjM4LjMxLjM1MnptMS41NDUtOS44NzJoNi42OThsLjI4MiA1LjYxOWMwIC4wMTUtLjAwNy4wMjctLjAwNy4wNGwuMDA0LjA4NmEyLjkzOSAyLjkzOSAwIDAgMS0uODI2IDIuMTMyYy0xLjM2NyAxLjQ0LTQuMjMzIDEuNDQxLTUuNjA0LjAwM2EyLjk1IDIuOTUgMCAwIDEtLjgzLTIuMTQybC4wMDQtLjA3OGMwLS4wMTYtLjAwOC0uMDMtLjAwOC0uMDQ4bC4yODctNS42MTJ6bTE2LjM3NiAwYy4yNTIgMS45MzMuNTAyIDMuODY1Ljc1MyA1LjgwNC4xMDkuODEtLjEwNCAxLjU0Ny0uNjE0IDIuMTMyLS41OTYuNjgzLTEuNTUgMS4wNzQtMi42MTYgMS4wNzQtMi4xMzcgMC0zLjkzMi0xLjUxNC00LjAzNC0zLjM4OGEuMzU5LjM1OSAwIDAgMC0uMDAzLS4wNDRjMC0uMDE1LjAwNi0uMDI3LjAwNi0uMDRsLS4yNzgtNS41MzhoNi43ODZ6TTM2LjIyNiA0Ni45NDZ2MTguMDk4YzAgLjc5OC42NDYgMS40NDUgMS40NDQgMS40NDVoMjQuNjVjLjc5OSAwIDEuNDQ1LS42NDcgMS40NDUtMS40NDVWNDYuOTQ2Yy41OS0uMzI4IDEuMTM3LS43MTkgMS41NzUtMS4yMiAxLjA2MS0xLjIxNCAxLjUyMi0yLjc4NSAxLjMwMS00LjQxLS4zLTIuMzU1LS42MDctNC43MDctLjkxOC03LjA2YTEuNDQzIDEuNDQzIDAgMCAwLTEuNDMxLTEuMjU3SDM1LjY5OWMtLjcyNCAwLTEuMzM4LjUzOC0xLjQzMSAxLjI1Ny0uMzExIDIuMzU0LS42MTcgNC43MDctLjkxNiA3LjA1LS4yMjEgMS42MzcuMjQgMy4yMDggMS4zIDQuNDIxLjQzOS41MDIuOTg0Ljg5MyAxLjU3NCAxLjIyeiIgZmlsbD0iI0NDQyIvPgogICAgPC9nPgo8L3N2Zz4K"
										          width="60" height="60"
										          alt="상점 프로필 이미지"
										          class="Store_Profile_img" />
										      </c:when>
										      <c:otherwise>
										        <img src="${reviews.profileImg}"
										             width="60" height="60"
										             alt="${reviews.writerStoreName} 프로필"
										             class="Store_Profile_img" />
										      </c:otherwise>
										    </c:choose>
										</div>
									</a>
									<div class = "reviews_mainContent_box">
										<div class = "reviewer_nameStar">
											<div class = "reviewer_name_box">
												<a class = "reviewer_profile_name" href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${reviews.writerIdx}">${reviews.writerStoreName}</a>
												<div class = "review_writeDate"> ${reviews.reviewDate}</div>
											</div>
											<div>
												<div class = "reviewer_StarBox">
													<c:forEach var="i" begin="1" end="5">
													    <c:choose>
													        <c:when test="${i <= reviews.startCnt}">
													            <img src="${pageContext.request.contextPath}/resources/images/star_on.png" width="15" height="14">
													        </c:when>
													        <c:otherwise>
													            <img src="${pageContext.request.contextPath}/resources/images/star_off.png" width="15" height="14">
													        </c:otherwise>
													    </c:choose>
													</c:forEach>
												</div>
											</div>
										</div>
										<a class = "review_Product_link_box" data-pno = "${reviews.productIdx}" <%-- href="${pageContext.request.contextPath}/StoreProduct?viewStoreIdx=${reviews.writerIdx}" --%>>
											<button class = "review_Product_link_btn">
												 ${reviews.productName}
												<img src="${pageContext.request.contextPath}/resources/images/category_arrow3.png" width="6" height="10" alt="화살표 아이콘">
											</button>
										</a>
										<div class = "review_content">${reviews.reviewText}</div>
									</div>
								</div>
							</c:forEach>
						</div>
					  </c:otherwise>
					</c:choose>
					<div class = "Store_product_reivews_fotter"></div>
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