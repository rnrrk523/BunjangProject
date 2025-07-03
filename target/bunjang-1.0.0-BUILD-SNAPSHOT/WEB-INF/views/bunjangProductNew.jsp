<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page pageEncoding="UTF-8" %>
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
						$.ajax({
							type: "POST",
							url: "ajaxCategory1",
							success: function(data) {
								console.log(data);
								let item = '<div id="category_big">' +
												'<div class="category_header"><span style="font-weight: bold;">전체카테고리</span><img src="${pageContext.request.contextPath}/resources/images/category_arrow.png"/></div>' +
												'<ul id="category_ul_first" class="category_ul">';
								for(let i=0; i<data.length; i++) {
											item += '<li data-idx="'+data[i].categoryIdx+'">'+data[i].categoryName+'</li>';
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
												item += '<li data-idx="'+data[i].categoryIdx+'">'+data[i].categoryName+'</li>';
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
										item += '<li data-idx="'+data[i].categoryIdx+'">'+data[i].categoryName+'</li>';
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
			/*상품상태에서 label클릭 시*/
			$(".productState_radio_input").click(function() {
				let _this = this;
				$(".productState_radio_input").each(function() {
					if(this != _this) {
						$(this).prop('checked', false);
						$(this).parent().removeClass("select");
					}else {
						$(this).parent().addClass("select");
					}
				})
			})
			/*상품명 input태그에 입력시*/
			$("#productName_input").on('input', function() {
				let cnt = $(this).val().length;
				if(cnt <= 40) {
					let str = cnt + "/40";
					$("#productName_input_right").text(str);
				}else {
					alert("글자 수 제한에 맞춰주세요.");
				}
				if(cnt == 0) {
					$("#productName_input_text_allDelBtn").css("display", "none");
				}else {
					$("#productName_input_text_allDelBtn").css("display", "flex");
				}
			})
			/*상품명 입력칸에 모두지우기버튼 클릭 시*/
			$("#productName_input_text_allDelBtn").click(function() {
				$("#productName_input").val("");
				$("#productName_input_right").text("0/40");
				$("#productName_input_text_allDelBtn").css("display", "none");
				$("#productName_input").focus();
			})
			/*설명란에 text입력 시*/
			$("#product_ex_textarea").on('input', function() {
				/*글자 수 카운트*/
				let cnt = $(this).val().length;
				if(cnt <= 500) {
					let str = cnt + "/500";
					$("#product_ex_textCnt").text(str);
				}else {
					alert("글자 수 제한에 맞춰주세요.");
				}
				
				/*placeholder 지우기*/
				if($(this).val()) {
			        $('#product_ex_placeholder').addClass('hidden');
			    }else {
			        $('#product_ex_placeholder').removeClass('hidden');
			    }
			})
			/*------------------------------------------------사이즈 선택창----------------------------------------------*/
			/*사이즈 선택창 열기*/
			/* $("#productSize_input").click(function() {
				$("#sizeSelect_pop").css("display", "block");
			}) */
			/*사이즈 선택창에서 초기화 버튼 클릭 시*/
			/* $("#sizeSelect_resetBtn").click(function() {
				$("#productSize_input").val("");
				$("#size_hold_label").removeClass("select");
			}) */
			/*사이즈 선택창에서 사이즈버튼 클릭 시*/
			/* $(".sizeSelect_list_input").click(function() {
				let size = $(this).val();
				$("#productSize_input").val(size);
				$("#size_hold_label").removeClass("select");
			}) */
			/*사이즈 선택창에서 기타 버튼 클릭 시*/
			/* $("#size_hold_label").click(function() {
				if(!$(this).hasClass("select")) {
					$(this).addClass("select");
					$("#productSize_input").val("기타 (상품설명에 작성)");
				}
			}) */
			/*사이즈 선택창에서 선택완료 버튼 클릭 시*/
			/*선택한 사이즈 담아놓을 전역변수*/
			/* let sizeSelect = "";
			$("#sizeSelect_saveBtn").click(function() {
				sizeSelect = $("#productSize_input").val();
				 $("#sizeSelect_pop").css("display", "none");
			}) */
			/*사이즈 선택창 저장하지않고 닫기*/
			/* $(document).on('click', function(event) {
			  if (!$(event.target).closest('#sizeSelect_pop, #productSize_input').length) {
			    // 제외한 요소를 클릭한 게 아니면 실행할 코드
			    $("#sizeSelect_pop").css("display", "none");
			    $("#productSize_input").val(sizeSelect);
			  }
			}); */
			/*------------------------------------------------가격 입력----------------------------------------------*/
			/*가격 input에 숫자만 입력받게 하기*/
			$('#price_input').on('input', function() {
			  this.value = this.value.replace(/[^0-9]/g, '');
			});
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
				
				const returnUrl = encodeURIComponent(window.location.href);
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
			/*오른쪽 사이드 찜버튼 클릭 시*/
			$("#a3").click(function() {
				if($(this).hasClass("on")) {
					location.href="${pageContext.request.contextPath}/Storejjim?viewStoreIdx=${storeIdx}";
				}
			})
			/*받은 코드------------------------------------------------------------------------------------------------------------------*/
			let selectedBig = '';
			let selectedMiddle = '';
			let selectedSmall = '';
			$('.categorySelect_bigBtn').click(function () {
			    $('.categorySelect_bigBtn').removeClass('on');
			    $(this).addClass('on');
				
			    let cno = $(this).data('cno');
			    selectedBig = $(this).text();
			    selectedMiddle = '';
			    selectedSmall = '';
			    updateCategoryInfo();
			    $.ajax({
			        url: '${pageContext.request.contextPath}/middleCategory',
			        method: 'POST',
			        data: { pno: cno },
			        success: function (data) {
			            let $container = $('#categorySelect_middle');
			            $container.empty(); // 기존 내용 지우기
			            if (!data || data.length === 0) {
			                // 데이터 없으면 '중분류 선택' 문구 다시 넣기
			                $container.text('중분류 선택');
			                return;
			            }
			            // ul 생성 - class만 지정
			            let $ul = $('<ul>').addClass('categorySelect_ul');

			            // 중분류 버튼들 li > button 형태로 생성
			            $.each(data, function (i, category) {
			                const $li = $('<li>').addClass('categorySelect_li');
			                const $btn = $('<button>')
			                    .attr('type', 'button')
			                    .addClass('categorySelect_MiddleBtn')
			                    .attr('data-cno', category.categoryIdx)
			                    .text(category.categoryName);
			                $li.append($btn);
			                $ul.append($li);
			            });

			            $container.append($ul);
			        },
			        error: function (xhr, status, error) {
			            console.error('중분류 로딩 실패:', error);
			            console.error('Response Text:', xhr.responseText);
			        }
			    });
			});
			$('#categorySelect_middle').on('click', '.categorySelect_MiddleBtn', function() {
				$('.categorySelect_MiddleBtn').removeClass('on');
			    $(this).addClass('on');
			    selectedMiddle = $(this).text();
			    selectedSmall = '';
			    updateCategoryInfo();
			    let cno = $(this).data('cno');
			    $.ajax({
			        url: '${pageContext.request.contextPath}/smallCategory',
			        method: 'POST',
			        data: { pno: cno },
			        success: function (data) {
			            let $container = $('#categorySelect_small');
			            $container.empty(); // 기존 내용 지우기
			            if (!data || data.length === 0) {
			                // 데이터 없으면 '중분류 선택' 문구 다시 넣기
			                $container.text('중분류 선택');
			                return;
			            }
			            // ul 생성 - class만 지정
			            let $ul = $('<ul>').addClass('categorySelect_ul');

			            // 중분류 버튼들 li > button 형태로 생성
			            $.each(data, function (i, category) {
			                const $li = $('<li>').addClass('categorySelect_li');
			                const $btn = $('<button>')
			                    .attr('type', 'button')
			                    .addClass('categorySelect_smallBtn')
			                    .attr('data-cno', category.categoryIdx)
			                    .text(category.categoryName);
			                $li.append($btn);
			                $ul.append($li);
			            });

			            $container.append($ul);
			        },
			        error: function (xhr, status, error) {
			            console.error('중분류 로딩 실패:', error);
			            console.error('Response Text:', xhr.responseText);
			        }
			    });
			});
			$('#categorySelect_small').on('click', '.categorySelect_smallBtn', function() {
				$('.categorySelect_smallBtn').removeClass('on');
			    $(this).addClass('on');
			    selectedSmall = $(this).text();
			    updateCategoryInfo();
			});
			function updateCategoryInfo() {
			    let text = selectedBig;
			    if (selectedMiddle) text += ' > ' + selectedMiddle;
			    if (selectedSmall) text += ' > ' + selectedSmall;
			    $('#categorySelect_info_div').find('b').text(text || '중분류 선택');
			}
			$('#register_btn').click(function(){
			    let $images = $('#product_img_ul .product_img_li_plus img');
			    let Productname = $('#productName_input').val();
			    let productImg1 = $images.length > 0 ? $images.eq(0).attr('src') : null;
			    let productImg2 = $images.length > 1 ? $images.eq(1).attr('src') : null;
			    let productImg3 = $images.length > 2 ? $images.eq(2).attr('src') : null;
			    let allCategory = $('.categorySelect_bigBtn.on').data('cno');
			    let middleCategory = $('.categorySelect_MiddleBtn.on').data('cno');
			    let smallCategory = $('.categorySelect_smallBtn.on').data('cno');
			    let ProductState = $('.productState_radio_input:checked').val();
			    let Size = $('#productSize_input').val();
			    let ProductInfo = $('#product_ex_textarea').val();
			    let price = $('#price_input').val();
			    if (productImg1 === null && productImg2 === null && productImg3 === null) {
			        alert('이미지를 넣어주세요.');
			        return;
			    }
			    if (!Productname || Productname.trim() === '') {
			        alert('상품명 입력해주세요.');
			        return;  // 멈춤
			    }
			    if (!allCategory) {
			        alert('대분류 카테고리를 선택해주세요.');
			        return;
			    }
			    if (!ProductState) {
			        alert('상품 상태를 입력해주세요.');
			        return;
			    }
			    if (!Size || Size.trim() === '') {
			        alert('상품 사이즈를 입력해주세요.');
			        return;
			    }
			    if (!ProductInfo || ProductInfo.trim() === '') {
			        alert('상품 설명을 입력해주세요.');
			        return;
			    }
			    if (!price || isNaN(price) || Number(price) < 500) {
			        alert('유효한 가격을 입력해주세요.');
			        return;
			    }
			    let storeIdx = "${storeIdx}";
			    $.ajax({
			        url: '${pageContext.request.contextPath}/CreateProduct',
			        method: 'POST',
			        data: {
			            storeIdx: storeIdx,
			            productName: Productname,
			            price: price,
			            productImg1: productImg1,
			            productImg2: productImg2,
			            productImg3: productImg3,
			            allCategoryIdx: allCategory,
			            middleCategoryIdx: middleCategory,
			            subCategoryIdx: smallCategory,
			            productSize: Size,
			            productInfo: ProductInfo,
			            productState: ProductState
			        },
			        success: function(response) {
			            alert('상품이 성공적으로 등록되었습니다!');
			            location.href = "${pageContext.request.contextPath}/";
			        },
			        error: function(xhr, status, error) {
			            alert('등록 중 오류가 발생했습니다: ' + error);
			        }
			    });
			});
		})
	</script>
	<script>
		$(function() {
		  const $ul = $('#product_img_ul');
		  const $countSpan = $('#product_img_cnt');

		  $('#imageUpload').on('change', function () {
		    const currentCount = $ul.find('.product_img_li_plus').length;
		    const files = Array.from(this.files);
		    const remaining = 3 - currentCount;

		    if (remaining <= 0) {
		      alert('이미지는 최대 3개까지 등록할 수 있습니다.');
		      $(this).val('');
		      return;
		    }

		    const validFiles = files.slice(0, remaining);

		    validFiles.forEach(file => {
		      const reader = new FileReader();

		      reader.onload = function (e) {
		        const $li = $('<li class="product_img_li product_img_li_plus"></li>');
		        const $img = $('<img>', {
		          src: e.target.result,
		          alt: '상품이미지'
		        });
		        const $btn = $('<button type="button" class="product_img_delBtn"></button>');

		        $btn.on('click', function () {
		          $li.remove();
		          updateRepresentativeTag();
		          updateImageCount();
		        });

		        $li.append($img).append($btn);
		        $ul.append($li);

		        updateRepresentativeTag();
		        updateImageCount();
		      };

		      reader.readAsDataURL(file);
		    });

		    $(this).val('');
		  });

		  function updateRepresentativeTag() {
		    $('.product_img_li_plus > div').remove();
		    const $first = $('.product_img_li_plus').first();
		    if ($first.length) {
		      $first.prepend('<div>대표이미지</div>');
		    }
		  }

		  function updateImageCount() {
		    const count = $ul.find('.product_img_li_plus').length;
		    $countSpan.text(count);
		  }
		  
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
		});
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
					<a class="main_menuBtn" href="${pageContext.request.contextPath}/Storejjim?viewStoreIdx=${storeIdx}"><img src="${pageContext.request.contextPath}/resources/images/bunjang_myShop.png" width="23" height="24" alt="내상점버튼 이미지"/>내 상점</a>
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
				<div class="main_tab_items"><a href="${pageContext.request.contextPath}/new" style="color: rgb(216, 12, 24);">상품등록</a></div>
				<div class="main_tab_items"><a href="${pageContext.request.contextPath}/manager">상품관리</a></div>
				<div class="main_tab_items"><a href="${pageContext.request.contextPath}/BuySell">구매/판매 내역</a></div>
			</nav>
		</div>
		<div id="regist_content_wrap">
			<main id="regist_main_content">
				<section>
					<h2 id="regist_title_h2">상품정보</h2>
					<ul id="regist_content_ul1">
						<li class="ul1_in_li">
							<div class="productImageBox">상품이미지<small>(<span id="product_img_cnt">0</span>/3)</small></div>
							<div id="product_img_div">
								<ul id="product_img_ul">
									<li class="product_img_li">
										이미지 등록
										<input type="file" id="imageUpload"  accept="image/jpg, image/jpeg, image/png" multiple/>
									</li>
									<!-- <li class="product_img_li product_img_li_plus">
										<div>대표이미지</div>
										<img src="https://media.bunjang.co.kr/images/crop/1422430626_w266.jpg" alt="상품이미지"/>
										<button type="button" class="product_img_delBtn"></button>
									</li>
									<li class="product_img_li product_img_li_plus">
										<img src="https://media.bunjang.co.kr/images/crop/1422430703_w266.jpg" alt="상품이미지"/>
										<button type="button" class="product_img_delBtn"></button>
									</li> -->
								</ul>
								<div id="product_img_info_div">상품 이미지는 PC에서는 1:1, 모바일에서는 1:1.23 비율로 보여져요.</div>
							</div>
						</li>
						<li class="ul1_in_li">
							<div id="productName_div">상품명</div>
							<div class="second_div">
								<div class="second_div_in_div">
									<div id="productName_input_left">
										<div style="position: static; width: 100%;">
											<input type="text" autocomplete="off" placeholder="상품명을 입력해주세요." id="productName_input"/>
											<button type="button" id="productName_input_text_allDelBtn"><img src="${pageContext.request.contextPath}/resources/images/input_allDelBtn.png" width="20" height="20"/></button>
										</div>
									</div>
									<div id="productName_input_right">0/40</div>
								</div>
							</div>
						</li>
						<li class="ul1_in_li">
							<div id="categorySelect_title">카테고리</div>
							<div class="second_div">
								<div id="categorySelect_section">
									<div id="categorySelect_big">
										<ul class="categorySelect_ul">
											<c:forEach var="category" items="${categories}">
										        <li class="categorySelect_li">
										            <button type="button" class="categorySelect_bigBtn" data-cno = "${category.categoryIdx}">${category.categoryName}</button>
										        </li>
										    </c:forEach>
										</ul>
									</div>
									<div id="categorySelect_middle">중분류 선택</div>
									<div id="categorySelect_small">소분류 선택</div>
								</div>
								<div id="categorySelect_info_div">
									<h3>선택한 카테고리 : <b></b></h3>
								</div>
							</div>
						</li>
						<li class="ul1_in_li">
							<div id="productState_div">상품상태</div>
							<div class="second_div">
								<section id="productState_label_wrap">
									<label class="productState_label"><input type="radio" value="1" class="productState_radio_input"/>새 상품 (미사용)<span>사용하지 않은 새 상품</span></label>
									<label class="productState_label"><input type="radio" value="2" class="productState_radio_input"/>사용감 없음<span>사용은 사용은 했지만 눈에 띄는 흔적이나 얼룩이 없음</span></label>
									<label class="productState_label"><input type="radio" value="3" class="productState_radio_input"/>사용감 적음<span>눈에 띄는 흔적이나 얼룩이 약간 있음</span></label>
									<label class="productState_label"><input type="radio" value="4" class="productState_radio_input"/>사용감 많음<span>눈에 띄는 흔적이나 얼룩이 많이 있음</span></label>
									<label class="productState_label"><input type="radio" value="5" class="productState_radio_input"/>고장/파손 상품<span>기능 이상이나 외관 손상 등으로 수리/수선 필요</span></label>
								</section>
							</div>
						</li>
						<li class="ul1_in_li">
							<div id="productSize_div">사이즈</div>
							<div class="second_div">
								<div id="sizeSelect_div">
									<input type="text" autocomplete="off" id="productSize_input" placeholder="사이즈를 입력해 주세요"/>
									<%-- <div style="position: absolute; top: 50%; right: 16px; transform: translateY(-50%);">
										<img src="${pageContext.request.contextPath}/resources/images/size_down_arrow.png" width="14" height="14"/>
									</div> --%>
								</div>
								<div id="sizeSelect_pop">
									<div id="sizeSelect_div1">
										<button type="button" id="sizeSelect_resetBtn"><img src="${pageContext.request.contextPath}/resources/images/size_resetBtn.png" width="14" height="14"/><span id="size_reset_btn_span">초기화버튼</span></button>
									</div>
									<hr id="sizeSelect_hr"/>
									<div id="sizeSelect_div2">
										<div id="sizeSelect_list_div">
											<div style="width: 100%; background: #fff; margin-bottom: 4px;"><span style="color: rgb(140, 140, 140); font-size: 12px; font-weight: 500;">한국 사이즈 (mm)</span></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="210" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="215" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="220" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="225" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="230" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="235" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="240" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="245" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="250" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="255" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="260" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="265" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="270" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="275" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="280" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="285" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="290" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="295" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="300" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="305" readonly/></div>
											<div style="position: static; width: auto;"><input type="text" autocomplete="off" class="sizeSelect_list_input" value="310" readonly/></div>
											<div style="width: 100%; background: rgb(255, 255, 255); padding-top: 14px;">
												<div>
													<label id="size_hold_label">
														기타 (상품설명에 작성)
													</label>
												</div>
											</div>
										</div>
									</div>
									<div id="sizeSelect_div3"><button type="button" id="sizeSelect_saveBtn">선택완료</button></div>
								</div>
							</div>
						</li>
						<li class="ul1_in_li">
							<div id="product_ex_div">설명</div>
							<div class="second_div">
								<textarea id="product_ex_textarea" rows="6"></textarea>
								<div id="product_ex_placeholder">
									브랜드, 모델명, 구매 시기, 하자 유무 등 상품 설명을 최대한 자세히 적어주세요.
									<br/>
									전화번호, SNS 계정 등 개인정보 입력은 제한될 수 있어요.
									<br/>
									안전하고 건전한 거래 환경을 위해 과학기술정보통신부, 한국인터넷증흥원과 번개장터(주)가 함께합니다.
								</div>
								<div id="product_ex_textCnt_wrap"><div id="product_ex_textCnt">0/500</div></div>
							</div>
						</li>
					</ul>
					<h2 id="productPrive_h2">가격</h2>
					<ul id="regist_content_ul2">
						<li class="ul2_in_li">
							<div id="price_title_div">가격</div>
							<div class="second_div_wrap">
								<div id="price_input_div">
									<div style="position: static; width: 100%;">
										<input type="text" autocomplete="off" id="price_input" placeholder="가격을 입력해 주세요."/>
									</div>
									<span id="price_input_after_span">원</span>
								</div>
							</div>
						</li>
					</ul>
				</section>
			</main>
			<footer id="regist_footer_wrap">
				<div id="regist_footer_div">
					<button type="button" id="save_btn">임시저장</button>
					<button type="button" id="register_btn">등록하기</button>
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
