<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/product_buySellHistory.css">
<meta charset="UTF-8">
<title>번개장터</title>
</head>
<script>
	$(function(){
		$('.HeaderBtn').click(function() {
		    if ($(this).hasClass('off')) {
		        $(this).addClass('on').removeClass('off');
		        $('.HeaderBtn').not(this).removeClass('on').addClass('off');

		        if (this.id === 'Headersell') {
		            $('#sell').css('display', 'block');
		            $('#buy').css('display', 'none');
		            $('.SearchTagBtn.btn-ui-2').find('.Btn-tab-label').text('판매완료');
		        } else if (this.id === 'Headerbuy') {
		            $('#buy').css('display', 'block');
		            $('#sell').css('display', 'none');
		            $('.SearchTagBtn.btn-ui-2').find('.Btn-tab-label').text('구매완료');
		        }
		    }
		});
		$('.SearchTagBtn').click(function(){
		    $('.SearchTagBtn').removeClass('on');
		    $(this).addClass('on');
		    
		    let cate = $(this).find('.Btn-tab-label').text().trim();
		    
		    if(cate === "전체") {
		        $('.mainContentitem').show();
		    } else if(cate === "구매완료" || cate === "판매완료") {
		        $('.mainContentitem').each(function(){
		            let itemCate = $(this).data('cate');
		            if(itemCate === "구매완료"){
		                $(this).show();
		            } else {
		                $(this).hide();
		            }
		        });
		    } else {
		        $('.mainContentitem').each(function(){
		            if($(this).data('cate') === cate){
		                $(this).show();
		            } else {
		                $(this).hide();
		            }
		        });
		    }
		});
		$('.returnBtn').click(function() {
		    const ref = document.referrer;
		    const isInternal = ref.includes(location.hostname);

		    if (isInternal) {
		        window.history.back();
		    } else if (ref) {
		        window.location.href = ref;
		    } else {
		        // referrer가 없으면 (예: 직접 주소 입력) 기본 페이지로 이동하거나 처리
		        window.location.href = '/bunjang/';
		    }
		});
		// 구매내역
		$(document).on('click', '.buyComplete, .buyCancle', function() {
		    let $item = $(this).closest('.mainContentitem');
		    let productIdx = $item.data('pno');
		    let status = $(this).hasClass('buyComplete') ? '구매완료' : '취소/환불';
		    let historyIdx = $item.data('history');

		    $.ajax({
		        type: 'POST',
		        url: '${pageContext.request.contextPath}/updateStatus',
		        data: {
		            productIdx: productIdx,
		            status: status,
		            historyIdx : historyIdx
		        },
		        success: function(response) {
		            $item.data('cate', status);
		            $item.find('.mainSectionText').text(status);
		            $item.find('.buyBtn').remove();
		            alert(status);
		            if(status == '구매완료') {
                     let text = '<section class="buyBtn buy"><button class="buyReivews" style="width:100%">리뷰 작성</button><section>';
                     $item.find('.ProductItemValue').after(text);
                  }
		        },
		        error: function(xhr) {
		            alert('에러 발생: ' + xhr.responseText);
		        }
		    });
		});
		// 리뷰작성 및 변경/수정
		$(document).on('click', '.buyReivews', function() {
		    let text = $(this).text().trim();
			$(this).parents('.buyBtn.buy').hide();
		    let productItem = $(this).closest('.buyBtn').siblings('.ProductItemValue');
			let textarea = "";
		    if(text == '리뷰 작성') {
			    textarea = $(
		    	        '<div class="star-rating" style="margin-bottom: 3px; margin-top : 5px;">' +
		    	        	'별점 :  '+
		    	            '<img src="${pageContext.request.contextPath}/resources/images/star_off.png" width="18" height="17" style = "cursor:pointer;" class="star" data-index="1">' +
		    	            '<img src="${pageContext.request.contextPath}/resources/images/star_off.png" width="18" height="17" style = "cursor:pointer;" class="star" data-index="2">' +
		    	            '<img src="${pageContext.request.contextPath}/resources/images/star_off.png" width="18" height="17" style = "cursor:pointer;" class="star" data-index="3">' +
		    	            '<img src="${pageContext.request.contextPath}/resources/images/star_off.png" width="18" height="17" style = "cursor:pointer;" class="star" data-index="4">' +
		    	            '<img src="${pageContext.request.contextPath}/resources/images/star_off.png" width="18" height="17" style = "cursor:pointer;" class="star" data-index="5">' +
		    	        '</div>' +
			    	    '<div class="buyBtn reviews" style="margin-top:20px;">' +
			    	        '<textarea class="review-textarea" placeholder="후기를 입력하세요." ' +
			    	        'style="width: 100%; height: 100px; box-sizing: border-box; resize: vertical; font-size: 16px;"></textarea>' +
			    	        '<button class="submitReviewBtn" style="margin-top: 5px; width:10%; height: 100px;">등록</button>' +
			    	    '</div>'
		    	);
			    productItem.after(textarea);
		    } else if (text == '리뷰 변경') {
		    	 let $item = $(this).closest('.mainContentitem');
		    	 let productIdx = $item.data('pno');
		         $.ajax({
		             url: '${pageContext.request.contextPath}/ReviewsView',
		             method: 'POST',
		             data: {
		                 writerIdx: ${storeIdx},
		                 productIdx : productIdx
		             },
		             success: function (response) {
		            	 let review = response[0];
		                 let starCnt = review.startCnt;
		                 let reviewText = review.reviewText;

		                 let starsHtml = '';
		                 for (let i = 1; i <= 5; i++) {
		                     let starImg = i <= starCnt ? 'star_on.png' : 'star_off.png';
		                     starsHtml += '<img src="${pageContext.request.contextPath}/resources/images/'+ starImg +'" width="18" height="17" style="cursor:pointer;" class="star" data-index="' + i + '">';
		                 }

		                 textarea = $(
		                		    '<div class="star-rating" style="margin-bottom: 3px; margin-top : 5px;">' +
		                		    '별점 : ' + starsHtml +
		                		    '</div>' +
		                		    '<div class="buyBtn reviews" style="margin-top:20px;">' +
		                		    '<textarea class="review-textarea" placeholder="후기를 입력하세요." style="width: 100%; height: 100px; box-sizing: border-box; resize: vertical; font-size: 16px;">' + reviewText + '</textarea>' +
		                		    '<button class="submitReviewBtn" style="margin-top: 5px; width:10%; height: 100px;">수정</button>' +
		                		    '</div>'
		                		);
					     productItem.after(textarea);
		             },
		             error: function () {
		                 alert('리뷰 정보를 불러오는데 실패했습니다.');
		             }
		         });
		    }

		});
		$(document).on('click', '.star', function() {
		    let offSrc = '${pageContext.request.contextPath}/resources/images/star_off.png';
		    let onSrc = '${pageContext.request.contextPath}/resources/images/star_on.png';
		    let clickedIndex = Number($(this).data('index'));

		    let $container = $(this).closest('.mainContentitem');

		    $container.find('.star-rating .star').each(function(i){
		        const starIndex = i + 1;
		        if (starIndex <= clickedIndex) {
		          $(this).attr('src', onSrc); 
		        } else {
		          $(this).attr('src', offSrc); 
		        }
		    });
		});
		$(document).on('click', '.submitReviewBtn', function() {
		    let $container = $(this).closest('.mainContentitem');
		    let starCount = $container.find('.star-rating .star').filter(function() {
		        return $(this).attr('src').includes('star_on.png');
		    }).length;
		    let text = $container.find('.review-textarea').val();
		    let storeIdx = $container.data('seller');
		    let productIdx = $container.data('pno');
		    let headertext = $container.find('.buyReivews').text();
		    if(headertext == '리뷰 작성') {
		    	if(starCount == 0) {
		    		alert('별점을 입력하시오');
		    		return;
		    	}
			    $.ajax({
			        type: 'POST',
			        url: '${pageContext.request.contextPath}/InsertReviews',
			        contentType: 'application/json; charset=utf-8',
			        data: JSON.stringify({
			            targetStoreIdx: storeIdx,
			            productIdx: productIdx,
			            writerIdx: ${storeIdx},
			            startCnt: starCount,
			            reviewText: text
			        }),
			        success: function(response) {
			            alert("리뷰가 등록되었습니다!");
			            $container.find('.buyBtn.buy').show();
			            $container.find('.buyBtn.buy').find('.buyReivews').text('리뷰 변경');
			            $container.find('.star-rating').remove();
			            $container.find('.buyBtn.reviews').remove();
			        },
			        error: function(xhr, status, error) {
			            console.log("XHR status: " + xhr.status);         // ex. 400, 500
			            console.log("XHR responseText: " + xhr.responseText); // 서버 에러 메시지
			            console.log("JS error: " + error);                 // JS 오류 메시지
			        }
			    });
		    } else if(headertext == '리뷰 변경') {
		    	$.ajax({
		    		type: 'POST',
	    		    url: '${pageContext.request.contextPath}/UpdateReviews',
	    		    data: {
	    		        productIdx: productIdx,
	    		        writerIdx: ${storeIdx},
	    		        startCnt: starCount,
	    		        reviewText: text
	    		    },
			        success: function(response) {
			            alert("리뷰가 변경되었습니다!");
			            $container.find('.buyBtn.buy').show();
			            $container.find('.buyBtn.buy').find('.buyReivews').text('리뷰 변경');
			            $container.find('.star-rating').remove();
			            $container.find('.buyBtn.reviews').remove();
			        },
			        error: function(xhr, status, error) {
			            console.error(error);
			            alert("리뷰 등록 중 오류가 발생했습니다.");
			        }
			    });
		    }
		});
	});
</script>
<body>
	<div id = "root">
		<article class = "MainBody">
			<header class = "BunjangHeader">
				<aside>
					<button class = "returnBtn">
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" role="img"><path fill="#191919" fill-rule="evenodd" d="M14.265 19.537a.9.9 0 1 0 1.27-1.274l-8.362-8.34 8.365-8.387A.9.9 0 0 0 14.263.264l-9 9.024a.9.9 0 0 0 .002 1.273z"></path></svg>
					</button>
					<section class = "asideSection">거래내역</section>
				</aside>
			</header>
			<main class = "mainSection">
				<div>
					<div class = "mainHeader">
						<div class = "mainHeaderBox">
							<button id = "Headersell" class = "HeaderBtn on" width="33.333333333333336%">
								<span class = "labelText">판매내역</span>
							</button>
							<button id = "Headerbuy" class = "HeaderBtn off" width="33.333333333333336%">
								<span class = "labelText">구매내역</span>
							</button>
						</div>
						<hr class = "bunHeaderLine">
					</div>
					<section class = "mainSearch">
						<div class ="SearchTagBtnBox">
							<button class ="SearchTagBtn btn-ui-0 on">
								<span class = "Btn-tab-label">전체</span>
							</button>
							<button class ="SearchTagBtn btn-ui-1">
								<span class = "Btn-tab-label">진행중</span>
							</button>
							<button class ="SearchTagBtn btn-ui-2">
								<span class = "Btn-tab-label">판매완료</span>
							</button>
							<button class ="SearchTagBtn btn-ui-3">
								<span class = "Btn-tab-label">취소/환불</span>
							</button>
						</div>
						<div class = "mainSearchArea">
							<form method="get" action="${pageContext.request.contextPath}/BuySell">
								<input type="hidden" name="storeIdx" value="${param.storeIdx}">
								<div class = "mainSearchBox">
									<svg width="20" height="20" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" role="img"><path d="M8.99 16.162c-3.955 0-7.172-3.218-7.172-7.172A7.18 7.18 0 0 1 8.99 1.818c3.954 0 7.171 3.217 7.171 7.172 0 3.954-3.217 7.172-7.171 7.172zm6.963-1.494A8.953 8.953 0 0 0 17.98 8.99C17.98 4.032 13.946 0 8.99 0 4.033 0 0 4.032 0 8.99c0 4.957 4.033 8.99 8.99 8.99a8.943 8.943 0 0 0 5.676-2.027l3.781 3.78a.908.908 0 0 0 1.287 0 .909.909 0 0 0 0-1.285l-3.78-3.78z" fill="#b2b2b2" fill-rule="evenodd"></path></svg>
									<input type="text" name="search" placeholder="상품명으로 검색해보세요" class="mainSearchinput" enterkeyhint="search" value="${param.search}">
								</div>
							</form>
						</div>
					</section>
					<section class = "mainContent" id = "sell">
						<c:forEach var="sell" items="${sellList}">
						<div class = "mainContentitem" data-pno="${sell.productIdx}" data-cate="${sell.saleStatus}">
							<article class = "mainContentArea">
								<header class = "mainContentHeader">
									<h3>${sell.saleDate}</h3>
									<svg fill="#7f7f7f" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 20 20" role="img"><path fill="#7f7f7f" fill-rule="evenodd" d="M5.262 19.536a.9.9 0 0 0 1.273 0l9-8.974a.9.9 0 0 0 .265-.636.9.9 0 0 0-.263-.637l-9-9.024a.9.9 0 1 0-1.275 1.27l8.365 8.388-8.363 8.34a.9.9 0 0 0-.002 1.273"></path></svg>
								</header>
								<hr class = "HeaderLine">
								<section>
									<p class = "mainSectionText">${sell.saleStatus}</p>
									<section class = "ProductItemValue">
										 <img src="${sell.productImg}" loading="lazy"/>
										<section>
											<header class="ProductPrice">${sell.price}원</header>
											<p class="ProductName">${sell.productInfo}</p>
											<p class="ProductStoreName">${sell.storeName} / 택배거래</p>
										</section>
									</section>
								</section>
								<footer class="mainContentFooter"></footer>
							</article>
						</div>
						</c:forEach>
						<section class = "mainContentNull" style = "display:none">
							<section>
								<h2>아직 판매 내역이 없어요</h2>
								<p></p>
							</section>
						</section>
					</section>
					<section class = "mainContent" id = "buy" style = "display:none">
						<c:forEach var="buy" items="${buyList}">
						<div class = "mainContentitem" data-pno="${buy.productIdx}" data-cate="${buy.saleStatus}" data-history="${buy.saleHistoryIdx}" data-seller="${buy.storeIdx}">
							<article class = "mainContentArea">
								<header class = "mainContentHeader">
									<h3>${buy.saleDate}</h3>
									<svg fill="#7f7f7f" xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 20 20" role="img"><path fill="#7f7f7f" fill-rule="evenodd" d="M5.262 19.536a.9.9 0 0 0 1.273 0l9-8.974a.9.9 0 0 0 .265-.636.9.9 0 0 0-.263-.637l-9-9.024a.9.9 0 1 0-1.275 1.27l8.365 8.388-8.363 8.34a.9.9 0 0 0-.002 1.273"></path></svg>
								</header>
								<hr class = "HeaderLine">
								<section>
									<p class = "mainSectionText">${buy.saleStatus}</p>
									<section class = "ProductItemValue">
										<img src="${buy.productImg}"  loading="lazy">
										<section>
											<header class="ProductPrice">${buy.price}원</header>
											<p class="ProductName">${buy.productInfo}</p>
											<p class="ProductStoreName">${buy.storeName} / 택배거래</p>
										</section>
									</section>
									<c:choose>
									    <c:when test="${buy.saleStatus eq '진행중'}">
									        <section class="buyBtn buy">
									            <button class="buyComplete">구매완료</button>
									            <button class="buyCancle">취소/환불</button>
									        </section>
									    </c:when>
									    <c:when test="${buy.saleStatus eq '구매완료'}">
									        <section class="buyBtn buy">
									             <c:choose>
										            <c:when test="${buy.reviewExists == 1}">
										                <button class="buyReivews" style="width:100%">리뷰 변경</button>
										            </c:when>
										            <c:otherwise>
										                <button class="buyReivews" style="width:100%">리뷰 작성</button>
										            </c:otherwise>
										        </c:choose>
									        </section>
									    </c:when>
									</c:choose>
								</section>
								<footer class="mainContentFooter"></footer>
							</article>
						</div>
						</c:forEach>
						<section class = "mainContentNull" style = "display:none">
							<section>
								<h2>아직 구매 내역이 없어요</h2>
								<p></p>
							</section>
						</section>
					</section>
				</div>
			</main>
		</article>
	</div>
</body>
</html>