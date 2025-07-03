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
						<div class = "mainContentitem" data-pno="${buy.productIdx}" data-cate="${buy.saleStatus}">
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