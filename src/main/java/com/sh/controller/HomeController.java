package com.sh.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sh.dto.BuySellDto;
import com.sh.dto.CategoryDto;
import com.sh.dto.CategoryListDto;
import com.sh.dto.FollowingStoreDto;
import com.sh.dto.InsertProductDto;
import com.sh.dto.JjimDto;
import com.sh.dto.ManagerDto;
import com.sh.dto.ProductDto;
import com.sh.dto.ProductInfoDto;
import com.sh.dto.ProductSearchListDto;
import com.sh.dto.ReviewsDto;
import com.sh.dto.StoreDto;
import com.sh.dto.StoreReviewDto;
import com.sh.service.BuyHistoryService;
import com.sh.service.CategoryService;
import com.sh.service.CategoryService2;
import com.sh.service.FollowService;
import com.sh.service.FollowerService;
import com.sh.service.FollowingService;
import com.sh.service.JJimService;
import com.sh.service.JjimService2;
import com.sh.service.LoginService;
import com.sh.service.ManagerService;
import com.sh.service.PayService;
import com.sh.service.ProductCreateService;
import com.sh.service.ProductService;
import com.sh.service.ProductService2;
import com.sh.service.ReviewsService;
import com.sh.service.SecessionService;
import com.sh.service.SellHistoryService;
import com.sh.service.StoreService;
import com.sh.service.StoreService2;

@Controller
public class HomeController {
	
	@Autowired
	ProductService svcProduct;
	@Autowired
	CategoryService svcCategory;
	@Autowired
	StoreService svcStore;
	@Autowired
	JJimService svcJJim;
	@Autowired
	FollowService svcFollow;
	@Autowired
	LoginService svcLogin;
	@Autowired
	SecessionService svcSecession;
	@Autowired
	PayService svcPay;
	
	// 받은 svc ------------------------------------------
	@Autowired
	StoreService2 storeService;
	@Autowired
    FollowerService followerService;
	@Autowired
	FollowingService followingService;
	@Autowired
	JjimService2 jjimService;
	@Autowired
	ReviewsService reviewsService;
	@Autowired
    ProductService2 productService;
	@Autowired
	ManagerService managerService;
	@Autowired
	BuyHistoryService buyHistoryService;
	@Autowired
	SellHistoryService sellHistoryService;
	@Autowired
	CategoryService2 categoryService;
	@Autowired
	ProductCreateService productCreateService;
	
	// 메인 홈페이지
	@RequestMapping("/")
	public String bunjangHome(HttpSession session, Model model) {
		int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
		model.addAttribute("storeIdx", storeIdx);
		model.addAttribute("homeProductList", svcProduct.getProductList(1));
		model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
		return "bunjangHome";
	}
	
	// 메인 검색페이지
	@RequestMapping("/search")
	public String bunjangSearch(HttpSession session, Integer pageNum, String sort, String str, Model model) {
		if(sort == null) sort = "최신순";
		model.addAttribute("sort", sort);
		
		int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
		model.addAttribute("storeIdx", storeIdx);
		model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
		
		if(pageNum == null) pageNum = 1;
		model.addAttribute("str", str);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("searchProductList", svcProduct.getProductSearchList(pageNum, str));
		int productSize = svcProduct.getProductSearchList(pageNum, str).size();
		model.addAttribute("searchProductListSize", productSize);
		
		int lastPageNum = productSize/10 + (productSize%10!=0 ? 1 : 0);
		int startPageNum = (pageNum / 10 * 10 - (pageNum % 10 == 0 ? 10 : 0)) + 1;
		int endPageNum = startPageNum + 9;
		if (endPageNum > lastPageNum) {
		    endPageNum = lastPageNum;
		}
		model.addAttribute("lastPageNum", lastPageNum);
		model.addAttribute("startPageNum", startPageNum);
		model.addAttribute("endPageNum", endPageNum);

		return "bunjangSearch";
	}
	
	// 카테고리 상품페이지
	@RequestMapping("/category")
	public String bunjangSearch(HttpSession session, String categoryLevel, Integer categoryIdx, Integer pageNum, Model model) {
		int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
		model.addAttribute("storeIdx", storeIdx);
		model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
		
		if(pageNum == null) pageNum = 1;
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("searchProductList", svcProduct.getProductCategoryList(pageNum, categoryLevel, categoryIdx));
		int productSize = svcProduct.getProductCategoryList(pageNum, categoryLevel, categoryIdx).size();
		model.addAttribute("searchProductListSize", productSize);
		
		int lastPageNum = productSize/10 + (productSize%10!=0 ? 1 : 0);
		int startPageNum = (pageNum / 10 * 10 - (pageNum % 10 == 0 ? 10 : 0)) + 1;
		int endPageNum = startPageNum + 9;
		if (endPageNum > lastPageNum) {
			endPageNum = lastPageNum;
		}
		model.addAttribute("lastPageNum", lastPageNum);
		model.addAttribute("startPageNum", startPageNum);
		model.addAttribute("endPageNum", endPageNum);
		
		// category
		model.addAttribute("categoryLevel", categoryLevel);
		model.addAttribute("allCategoryList", svcCategory.getCategoryList1());
		if(categoryLevel.equals("all")) {
			model.addAttribute("allCategoryIdx", categoryIdx);
			model.addAttribute("allCategoryName", svcCategory.getAllCategoryName(categoryIdx));
			model.addAttribute("selectCategoryName", svcCategory.getAllCategoryName(categoryIdx));
		}else if(categoryLevel.equals("middle")) {
			model.addAttribute("allCategoryIdx", svcCategory.getMiddleCategoryParentId(categoryIdx));
			model.addAttribute("allCategoryName", svcCategory.getAllCategoryName(svcCategory.getMiddleCategoryParentId(categoryIdx)));
			model.addAttribute("middleCategoryIdx", categoryIdx);
			model.addAttribute("middleCategoryName", svcCategory.getMiddleCategoryName(categoryIdx));
			model.addAttribute("middleCategoryList", svcCategory.getCategoryList2(svcCategory.getMiddleCategoryParentId(categoryIdx)));
			model.addAttribute("selectCategoryName", svcCategory.getMiddleCategoryName(categoryIdx));
		}else if(categoryLevel.equals("sub")) {
			model.addAttribute("allCategoryIdx", svcCategory.getMiddleCategoryParentId(svcCategory.getSubCategoryParentId(categoryIdx)));
			model.addAttribute("allCategoryName", svcCategory.getAllCategoryName(svcCategory.getMiddleCategoryParentId(svcCategory.getSubCategoryParentId(categoryIdx))));
			model.addAttribute("middleCategoryIdx", svcCategory.getSubCategoryParentId(categoryIdx));
			model.addAttribute("middleCategoryName", svcCategory.getMiddleCategoryName(svcCategory.getSubCategoryParentId(categoryIdx)));
			model.addAttribute("middleCategoryList", svcCategory.getCategoryList2(svcCategory.getMiddleCategoryParentId(svcCategory.getSubCategoryParentId(categoryIdx))));
			model.addAttribute("subCategoryIdx", categoryIdx);
			model.addAttribute("subCategoryName", svcCategory.getSubCategoryName(categoryIdx));
			model.addAttribute("subCategoryList", svcCategory.getCategoryList3(svcCategory.getSubCategoryParentId(categoryIdx)));
			model.addAttribute("selectCategoryName", svcCategory.getSubCategoryName(categoryIdx));
		}
		
		
		return "bunjangCategory";
	}
	
	// 상품 등록페이지
//	@RequestMapping("/new")
//	public String bunjangProductNew(HttpSession session, Model model) {
//		int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
//		model.addAttribute("storeIdx", storeIdx);
//		model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
//		return "bunjangProductNew";
//	}
	
	// 상품 페이지
	@RequestMapping("/productInfo")
	public String bunjangProductInfo(HttpSession session, int productIdx, Model model) {
		int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
		model.addAttribute("storeIdx", storeIdx);
		model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
		
		ProductInfoDto productInfo = svcProduct.getProductInfo(storeIdx, productIdx);
		model.addAttribute("productInfo", productInfo);
		model.addAttribute("AllCategoryName", svcCategory.getAllCategoryName(productInfo.getAllCategoryIdx()));
		model.addAttribute("MiddleCategoryName", svcCategory.getMiddleCategoryName(productInfo.getMiddleCategoryIdx()));
		model.addAttribute("SubCategoryName", svcCategory.getSubCategoryName(productInfo.getSubCategoryIdx()));
		
		ArrayList<CategoryListDto> categorylist1 = svcCategory.getCategoryList1();
		ArrayList<CategoryListDto> categorylist2 = svcCategory.getCategoryList2(productInfo.getAllCategoryIdx());
		ArrayList<CategoryListDto> categorylist3 = svcCategory.getCategoryList3(productInfo.getMiddleCategoryIdx());
		model.addAttribute("categorylist1", categorylist1);
		model.addAttribute("categorylist2", categorylist2);
		model.addAttribute("categorylist3", categorylist3);
		
		model.addAttribute("categorylist2Size", categorylist2.size());
		model.addAttribute("categorylist3Size", categorylist3.size());
		
		model.addAttribute("storeInfo", svcStore.getStoreInfo(productInfo.getStoreIdx()));
		model.addAttribute("sellerIdx", productInfo.getStoreIdx());
		model.addAttribute("followYN", svcStore.getFollowYN(storeIdx, productInfo.getStoreIdx()));
		
		model.addAttribute("storeReviews", svcStore.getStoreReview(productInfo.getStoreIdx()));
		/*
		 * for(StoreReviewDto dto : svcStore.getStoreReview(productInfo.getStoreIdx()))
		 * { System.out.println("storeIdx : " + dto.getStoreIdx());
		 * System.out.println("writerName : " + dto.getWriterName()); }
		 */
		model.addAttribute("storeReviewCnt", svcStore.getStoreReviewCnt(productInfo.getStoreIdx()));
		svcProduct.setProductCheck(productIdx, storeIdx);
		return "bunjangProductInfo";
	}
	
	// 결제 페이지
	@RequestMapping("/pay")
	public String bunjangPayment(int storeIdx, int productIdx, Model model) {
		ProductInfoDto productInfo = svcProduct.getProductInfo(storeIdx, productIdx);
		model.addAttribute("productInfo", productInfo);
		return "bunjangPayment";
	}
	
	// 대분류 카테고리리스트 가져오기 Ajax
	@RequestMapping(value = "/ajaxCategory1", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public ArrayList<CategoryListDto> bunjangAjaxCategory1() {
		ArrayList<CategoryListDto> list = svcCategory.getCategoryList1();
		return list;
	}
	
	// 중분류 카테고리리스트 가져오기 Ajax
	@RequestMapping(value = "/ajaxCategory2", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public ArrayList<CategoryListDto> bunjangAjaxCategory2(int id) {
		ArrayList<CategoryListDto> list = svcCategory.getCategoryList2(id);
		return list;
	}
	
	// 소분류 카테고리리스트 가져오기 Ajax
	@RequestMapping(value = "/ajaxCategory3", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public ArrayList<CategoryListDto> bunjangAjaxCategory3(int id) {
		ArrayList<CategoryListDto> list = svcCategory.getCategoryList3(id);
		return list;
	}
	
	// 찜등록 Ajax
	@RequestMapping(value = "/jjimOn", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void bunjangAjaxJJimOn(int storeIdx, int productIdx) {
		svcJJim.JJimOn(storeIdx, productIdx);
	}
	
	// 찜해제 Ajax
	@RequestMapping(value = "/jjimOff", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void bunjangAjaxJJimOff(int storeIdx, int productIdx) {
		svcJJim.JJimOff(storeIdx, productIdx);
	}
	
	// 팔로우등록 Ajax
	@RequestMapping(value = "/followOn", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void bunjangAjaxFollowOn(int storeIdx, int productIdx) {
		ProductInfoDto productInfo = svcProduct.getProductInfo(storeIdx, productIdx);
		svcFollow.followOn(productInfo.getStoreIdx(), storeIdx);// 테스트 필요!
	}
	
	// 팔로우해제 Ajax
	@RequestMapping(value = "/followOff", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void bunjangAjaxFollowOff(int storeIdx, int productIdx) {
		ProductInfoDto productInfo = svcProduct.getProductInfo(storeIdx, productIdx);
		svcFollow.followOff(productInfo.getStoreIdx(), storeIdx);// 테스트 필요!
	}
	
	// 검색리스트 정렬바꾸기 Ajax
	@RequestMapping(value = "/ajaxSort", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public ArrayList<ProductSearchListDto> getProductSearchSortList(String str, String sort) {
		return svcProduct.getProductSearchSortList(sort, str);
	}
	
	// 검색리스트 pagenation처리 Ajax
	@RequestMapping(value = "/ajaxPageNation", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public ArrayList<ProductSearchListDto> getProductSearchPageNumList(Integer pageNum, String str, String sort) {
		return svcProduct.getProductSearchPageNumList(pageNum, sort, str);
	}
	
	// 상품구매 처리 Ajax
	@RequestMapping(value = "/ajaxPay", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void bunjangPay(int sellerIdx, int buyerIdx, int productIdx, String stateStr, String requestStr) {
		svcPay.pay(sellerIdx, buyerIdx, productIdx, stateStr);
	}

	// -----------------------------------회원탈퇴----------------------------------------
	// 회원탈퇴 Ajax
	@RequestMapping(value = "/ajaxSecession", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Map<String, Object> SecessionAjax(HttpSession session, HttpServletRequest request) {
	    Integer storeIdx = (Integer) session.getAttribute("storeIdx");
	    String accessToken = (String) session.getAttribute("kakaoAccessToken");
	    
	    buyHistoryService.updateAllSecession(storeIdx);
	    svcSecession.delStoreSecession(storeIdx);

	    if (accessToken != null) {
	        try {
	            RestTemplate restTemplate = new RestTemplate();
	            HttpHeaders headers = new HttpHeaders();
	            headers.set("Authorization", "Bearer " + accessToken);
	            HttpEntity<String> request2 = new HttpEntity<>(headers);
	            restTemplate.postForObject("https://kapi.kakao.com/v1/user/logout", request2, String.class);
	        } catch (Exception e) {
	            System.out.println("카카오 로그아웃 실패: " + e.getMessage());
	        }
	    }

	    session.invalidate();

	    // ✅ JSON으로 응답
	    Map<String, Object> result = new HashMap<>();
	    result.put("result", "ok");
	    result.put("redirect", "/bunjang/kakaoLogout");
	    return result;
	}

	
	// -----------------------------------카카오 소셜 로그인----------------------------------------
	// 보안문제로 권장되는 방식
	@RequestMapping(value = "/auth/kakao-login", method = RequestMethod.POST)
	public String kakaoLoginRedirect(@RequestParam(required = false) String returnUrl, HttpSession session) {
	    if (returnUrl != null && !returnUrl.isEmpty()) {
	        session.setAttribute("returnUrl", returnUrl); // 세션에 저장
	    }

	    String kakaoAuthUrl = "https://kauth.kakao.com/oauth/authorize"
	        + "?response_type=code"
	        + "&client_id=c52a381ffa8c8336a1ea0e22ba6ece9e"
	        + "&redirect_uri=http://114.207.245.107:9090/BunjangProject/kakaoCallback";

	    return "redirect:" + kakaoAuthUrl;
	}


	// 카카오 로그인 요청
	@RequestMapping("/kakaoCallback")
	public String kakaoCallback(@RequestParam String code, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
	    RestTemplate rt = new RestTemplate();
	    // 1. access token 요청
	    HttpHeaders tokenHeaders = new HttpHeaders();
	    tokenHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

	    MultiValueMap<String, String> tokenParams = new LinkedMultiValueMap<>();
	    tokenParams.add("grant_type", "authorization_code");
	    tokenParams.add("client_id", "c52a381ffa8c8336a1ea0e22ba6ece9e");
	    tokenParams.add("redirect_uri", "http://114.207.245.107:9090/BunjangProject/kakaoCallback");
	    tokenParams.add("code", code);

	    HttpEntity<MultiValueMap<String, String>> tokenRequest = new HttpEntity<>(tokenParams, tokenHeaders);
	    ResponseEntity<String> tokenResponse = rt.postForEntity("https://kauth.kakao.com/oauth/token", tokenRequest, String.class);
	    
	    // 오류 처리
	    if (tokenResponse.getStatusCode() != HttpStatus.OK) {
	        return "errorPage";  // 오류 페이지로 이동
	    }
	    
	    // 2. JSON 파싱
	    ObjectMapper objectMapper = new ObjectMapper();
	    String accessToken = "";
	    try {
	        JsonNode rootNode = objectMapper.readTree(tokenResponse.getBody());
	        accessToken = rootNode.get("access_token").asText();
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "errorPage";
	    }

	    // 3. 사용자 정보 요청
	    HttpHeaders profileHeaders = new HttpHeaders();
	    profileHeaders.set("Authorization", "Bearer " + accessToken);

	    HttpEntity<String> profileRequest = new HttpEntity<>(profileHeaders);
	    ResponseEntity<String> profileResponse = rt.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.GET, profileRequest, String.class);
	    
	    // 사용자 정보 요청 오류 처리
	    if (profileResponse.getStatusCode() != HttpStatus.OK) {
	        return "errorPage";  // 오류 페이지로 이동
	    }
	    
	    
	    // 4. 사용자 정보 파싱
	    try {
	        JsonNode profileNode = objectMapper.readTree(profileResponse.getBody());
//	        System.out.println("json : " + profileResponse.getBody());
	        String kakaoId = profileNode.path("id").asText("");
//	        System.out.println("kakaoId : " + kakaoId);
	        Integer storeIdx = svcLogin.getLoginCheckResult(kakaoId);
	        String name = profileNode.path("properties").path("nickname").asText("");
//	        System.out.println("storeIdx : " + storeIdx);
//	        System.out.println("name : " + name);
	        HttpSession session = request.getSession();
	        System.out.println("sessionId = " + session.getId());
	        
	        Cookie sessionCookie = new Cookie("SESSIONID", session.getId());
	        sessionCookie.setPath("/");
//	        sessionCookie.setHttpOnly(true); // JavaScript에서 접근 못하게
	        sessionCookie.setMaxAge(60 * 60); // 1시간 유지
	        response.addCookie(sessionCookie);

	        if(storeIdx == null) {
	        	// 회원가입(insert) 진행
	        	svcLogin.setStoreInsert(name, kakaoId);
	        	redirectAttributes.addFlashAttribute("message", "회원가입이 완료되었습니다.");
	        }else {
	        	// 여기서 사용자 정보로 로그인/회원가입 처리
	        	session.setAttribute("storeIdx", storeIdx);
	        	redirectAttributes.addFlashAttribute("message", name + "님 환영합니다.");
	        }
	        // ✅ 이전 페이지로 이동
	        String returnUrl = (String) session.getAttribute("returnUrl");
	        session.removeAttribute("returnUrl"); // 일회용이므로 제거

	        if (returnUrl != null) {
	            return "redirect:" + returnUrl;
	        }


	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    // 기본 홈으로 이동
	    System.out.println("뒤가 없음");
	    return "redirect:/";
	}
    // -----------------------------------로그아웃----------------------------------------
    // 로그아웃 Ajax
	@RequestMapping(value = "/kakaoLogout", method = RequestMethod.POST)
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		// 세션 무효화
	    HttpSession session = request.getSession(false);
	    if (session != null) {
	        session.invalidate();
	    }

	    // 쿠키 제거
	    Cookie cookie = new Cookie("SESSIONID", null);
	    cookie.setPath("/");
	    cookie.setMaxAge(0);
	    response.addCookie(cookie);

	    // ✅ 카카오 로그아웃 URL로 리디렉션
	    String clientId = "c52a381ffa8c8336a1ea0e22ba6ece9e";
	    String redirectUri = "http://114.207.245.107:9090/BunjangProject/kakaoLogoutComplete";
	    String kakaoLogoutUrl = "https://kauth.kakao.com/oauth/logout?client_id=" + clientId + "&logout_redirect_uri=" + redirectUri;

	    return "redirect:" + kakaoLogoutUrl;
	}
	@RequestMapping("/kakaoLogoutComplete")
	public String kakaoLogoutComplete() {
	    // 로그아웃 완료 후 보여줄 페이지로 이동 (예: 홈으로)
	    return "redirect:/";
	}

	
	// 받은 코드---------------------------------------------
	
	// 상품 등록페이지
	@RequestMapping("/new")
	public String bunjangProductNew(HttpSession session, Model model) {
		int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
		model.addAttribute("storeIdx", storeIdx);
		model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
		
		// 받은 내용
		List<CategoryDto> categoryList = categoryService.getAllCategoryInfo();
        model.addAttribute("categories", categoryList);
        
		return "bunjangProductNew";
	}
	// 상품 등록페이지 - 중분류카테고리 가져오기ajax
	@PostMapping("/middleCategory")
	@ResponseBody
	public List<CategoryDto> getMiddleCategory(@RequestParam("pno") int pno) {
	    return categoryService.getMiddleCategoryInfo(pno);
	}
	// 상품 등록페이지 - 소분류카테고리 가져오기ajax
	@PostMapping("/smallCategory")
	@ResponseBody
	public List<CategoryDto> getSmallCategory(@RequestParam("pno") int pno) {
		return categoryService.getSmallCategoryInfo(pno);
	}
	// 상품관리페이지
	@RequestMapping("/manager")
	public String bunjangManager(
			HttpSession session,
	        @RequestParam(value = "str", required = false, defaultValue = "전체") String str,
	        @RequestParam(value = "endRow", required = false, defaultValue = "10") int endRow,
	        @RequestParam(value = "page", required = false, defaultValue = "1") int page,
	        @RequestParam(value = "search", required = false, defaultValue = "") String search,
	        Model model) {
		int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
		model.addAttribute("storeIdx", storeIdx);
		model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
		
	    int startRow = (page - 1) * endRow + 1;
	    int lastRow = page * endRow;
	    List<ManagerDto> managerList = managerService.getProductManagerInfo(storeIdx, str, startRow, lastRow, search);
	    int totalCount = managerService.getTotalProductCount(storeIdx, str,search);
	    int pageCount = (int) Math.ceil((double) totalCount / endRow);
	    int pageGroupSize = 10;
	    int startPage = ((page - 1) / pageGroupSize) * pageGroupSize + 1;
	    int endPage = Math.min(startPage + pageGroupSize - 1, pageCount);
	    int prevGroupStartPage = startPage - pageGroupSize >= 1 ? startPage - pageGroupSize : -1;
	    int nextGroupStartPage = endPage + 1 <= pageCount ? endPage + 1 : -1;
	    model.addAttribute("search", search);
	    model.addAttribute("managerList", managerList);
	    model.addAttribute("storeIdx", storeIdx);
	    model.addAttribute("str", str);
	    model.addAttribute("endRow", endRow);
	    model.addAttribute("page", page);
	    model.addAttribute("pageCount", pageCount);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("totalCount", totalCount);
	    model.addAttribute("prevGroupStartPage", prevGroupStartPage);
	    model.addAttribute("nextGroupStartPage", nextGroupStartPage);

	    return "bunjangProductManager";
	}
	// 상품삭제 ajax
	@PostMapping("/deleteProduct")
    public ResponseEntity<String> deleteProduct(@RequestParam("productIdx") int productIdx) {
        boolean deleted = managerService.deleteProduct(productIdx);

        if (deleted) {
            return ResponseEntity.ok("success");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
        }
    }
	// 구매판매내역 페이지
	@RequestMapping("/BuySell")
	public String bunjangButSell(
			HttpSession session,
	        @RequestParam(value = "search", required = false) String search,
	        Model model) {
		int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
		model.addAttribute("storeIdx", storeIdx);
		model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
		
	    List<BuySellDto> buyList = buyHistoryService.getBuyHistoryInfo(storeIdx, search);
	    List<BuySellDto> sellList = sellHistoryService.getSellHistoryInfo(storeIdx, search);

	    model.addAttribute("buyList", buyList);
	    model.addAttribute("sellList", sellList);

	    return "bunjangBuySellHistory";
	}
	@PostMapping("/updateStatus")
	@ResponseBody
	public ResponseEntity<String> updateBuyStatusAjax(
	    @RequestParam int historyIdx,
	    @RequestParam int productIdx,
	    @RequestParam String status) {
	    try {
	        int updatedCount = buyHistoryService.updateSaleStatus(productIdx, historyIdx, status);
	        if (updatedCount > 0) {
	            return ResponseEntity.ok("상태 변경 성공");
	        } else {
	            return ResponseEntity.status(404).body("해당 구매내역을 찾을 수 없습니다.");
	        }
	    } catch (Exception e) {
	        return ResponseEntity.status(500).body("상태 변경 실패: " + e.getMessage());
	    }
	}
	// 상점페이지 - 상품탭
	@RequestMapping("/StoreProduct")
	public String bunjangStoreProduct(HttpSession session,
									int viewStoreIdx,
	                                  @RequestParam(value = "category", required = false, defaultValue = "0") int categoryIdx,
	                                  String str,
	                                  Model model) {
		int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
		model.addAttribute("storeIdx", storeIdx);
		model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
		
		if(str == null || str == "") {
			str = "최신순";
		}
		
	    StoreDto store = storeService.getStoreInfo(viewStoreIdx);

	    List<ProductDto> productList = productService.getStoreProductInfo(viewStoreIdx, categoryIdx, str);

	    int productCount = productService.countProductsByStore(viewStoreIdx, categoryIdx);

	    List<ProductDto> categoryList = productService.selectCategoriesByStore(viewStoreIdx);
	    List<ProductDto> categories = productService.selectCategoriesByStore(viewStoreIdx);
	    model.addAttribute("categoryList", categories);

	    String selectedCategoryName = "전체";
	    for (ProductDto category : categories) {
	        if (category.getCategoryIdx() == categoryIdx) {
	            selectedCategoryName = category.getCategoryName();
	            break;
	        }
	    }
	    model.addAttribute("viewStoreIdx", viewStoreIdx);
	    model.addAttribute("selectedCategoryName", selectedCategoryName);
	    model.addAttribute("store", store);
	    model.addAttribute("productList", productList);
	    model.addAttribute("selectedCategory", categoryIdx);
	    model.addAttribute("productCount", productCount);       // 추가
	    model.addAttribute("categoryList", categoryList);       // 추가
	    model.addAttribute("followYN", svcFollow.followCheck(storeIdx, viewStoreIdx));

	    return "bunjangStoreProduct";
	}
	// 상점페이지 - 후기탭
	@RequestMapping("/Storereviews")
    public String bunjangStorereviews(HttpSession session, int viewStoreIdx, Model model) {
		int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
		model.addAttribute("storeIdx", storeIdx);
		model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
		
        StoreDto store = storeService.getStoreInfo(viewStoreIdx);
        List<ReviewsDto> reviewsList = reviewsService.getStoreReviewsInfo(viewStoreIdx);
        model.addAttribute("reviewsList", reviewsList );
        model.addAttribute("store", store);
        model.addAttribute("viewStoreIdx", viewStoreIdx);
        model.addAttribute("followYN", svcFollow.followCheck(storeIdx, viewStoreIdx));
        
        return "bunjangStorereviews";
    }
	// 상점페이지 - 찜탭
	@RequestMapping("/Storejjim")
    public String bunjangStorejjim(HttpSession session, int viewStoreIdx,
    		@RequestParam(value = "str", required = false, defaultValue = "최신순") String str,
    		Model model) {
		int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
		model.addAttribute("storeIdx", storeIdx);
		model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
		
        StoreDto store = storeService.getStoreInfo(viewStoreIdx);
        List<JjimDto> jjimList = jjimService.getStoreJjimInfo(viewStoreIdx, str);

        model.addAttribute("viewStoreIdx", viewStoreIdx);
        model.addAttribute("jjimList", jjimList);
        model.addAttribute("store", store);
        model.addAttribute("followYN", svcFollow.followCheck(storeIdx, viewStoreIdx));
        
        return "bunjangStorejjim";
    }
	// 찜탭 - 찜 상품삭제
	@PostMapping("/deleteJjimProduct")
    public ResponseEntity<String> deleteJjimProduct(@RequestBody Map<String, Object> payload) {
        try {
            List<?> rawList = (List<?>) payload.get("snoList");
            List<Integer> productIdxList = rawList.stream()
                .map(Object::toString)
                .map(Integer::parseInt)
                .collect(Collectors.toList());

            int storeIdx = Integer.parseInt(payload.get("storeIdx").toString());
            if (productIdxList.isEmpty()) {
                return ResponseEntity.badRequest().body("삭제할 상품을 선택해주세요.");
            }

            jjimService.deleteJjimProduct(productIdxList, storeIdx);
            return ResponseEntity.ok("삭제가 완료되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 처리 중 오류가 발생했습니다.");
        }
    }
	// 상점페이지 - 팔로잉탭
	@RequestMapping("/StoreFollowing")
    public String bunjangStoreFollowing(HttpSession session, int viewStoreIdx, Model model) {
		int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
		model.addAttribute("storeIdx", storeIdx);
		model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
		
        StoreDto store = storeService.getStoreInfo(viewStoreIdx);
        // 팔로워 프로필 리스트 추가
        List<FollowingStoreDto> followingList = followingService.getStoreFollowingInfo(viewStoreIdx, storeIdx);
        model.addAttribute("followingList", followingList);
        model.addAttribute("store", store);
        model.addAttribute("viewStoreIdx", viewStoreIdx);
        model.addAttribute("followYN", svcFollow.followCheck(viewStoreIdx, storeIdx));
        
        return "bunjangStoreFollowing";
    }
	// 상점페이지 - 팔로워탭
	 @RequestMapping("/StoreFollower")
	    public String bunjangStoreFollower(HttpSession session, int viewStoreIdx, Model model) {
		 int storeIdx = session.getAttribute("storeIdx") == null ?  0 : (int) session.getAttribute("storeIdx");
			model.addAttribute("storeIdx", storeIdx);
			model.addAttribute("jjimCnt", svcStore.getJJimCnt(storeIdx));
			
	        StoreDto store = storeService.getStoreInfo(viewStoreIdx);
	        // 팔로워 프로필 리스트 추가
	        List<StoreDto> followerList = followerService.getStoreFollowerInfo(viewStoreIdx);
	        model.addAttribute("followerList", followerList);
	        model.addAttribute("store", store);
	        model.addAttribute("viewStoreIdx", viewStoreIdx);
	        model.addAttribute("followYN", svcFollow.followCheck(storeIdx, viewStoreIdx));
	        
	        return "bunjangStoreFollower";
	    }
	// 상점페이지 - 이름변경ajax
	@PostMapping("/UpdateStoreName")
    @ResponseBody
    public Map<String, Object> updateStoreName(
            @RequestParam("storeIdx") int storeIdx,
            @RequestParam("storeName") String storeName) {

        Map<String, Object> result = new HashMap<>();

        try {
            storeService.updateStoreName(storeIdx, storeName);
            result.put("status", "success");
            result.put("storeName", storeName);
        } catch (Exception e) {
            result.put("status", "fail");
            result.put("message", e.getMessage());
        }

        return result;
    }
	// 상점페이지 - 상태변경ajax
    @PostMapping("/UpdateStoreIntroduction")
    @ResponseBody
    public Map<String, Object> updateStoreIntroduction(
    		@RequestParam("storeIdx") int storeIdx,
    		@RequestParam("storeInt") String storeInt) {
    	
    	Map<String, Object> result = new HashMap<>();
    	
    	try {
    		storeService.updateStoreIntroduction(storeIdx, storeInt);
    		result.put("status", "success");
    		result.put("storeInt", storeInt);
    	} catch (Exception e) {
    		result.put("status", "fail");
    		result.put("message", e.getMessage());
    	}
    	
    	return result;
    }
    // 판매하기 페이지 - 상품등록 ajax
    @PostMapping("/CreateProduct")
    @ResponseBody
    public ResponseEntity<String> createProduct(
            @RequestParam("storeIdx") int storeIdx,
            @RequestParam("productName") String productName,
            @RequestParam("price") int price,
            @RequestParam(value = "productImg1", required = false) String productImg1,
            @RequestParam(value = "productImg2", required = false) String productImg2,
            @RequestParam(value = "productImg3", required = false) String productImg3,
            @RequestParam("allCategoryIdx") int allCategoryIdx,
            @RequestParam(value = "middleCategoryIdx", required = false) Integer middleCategoryIdx,
            @RequestParam(value = "subCategoryIdx", required = false) Integer subCategoryIdx,
            @RequestParam("productSize") String productSize,
            @RequestParam("productInfo") String productInfo,
            @RequestParam("productState") String productState) {
    	switch(productState) {
    	case "1": productState = "새 상품";
    			break;
    	case "2" : productState = "사용감 없음";
    			break;
    	case "3" : productState = "사용감 적음";
    			break;
    	case "4" : productState = "사용감 많음";
    			break;
    	case "5" : productState = "고장/파손 상품";
    			break;
    	}
        try {
            InsertProductDto dto = new InsertProductDto(
                storeIdx,
                productName,
                price,
                productImg1,
                productImg2,
                productImg3,
                allCategoryIdx,
                middleCategoryIdx,
                subCategoryIdx,
                productSize,
                productInfo,
                productState
            );

            int result = productCreateService.addProduct(dto);
            if(result > 0) {
                return ResponseEntity.ok("success");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
        }
    }
    
    // 팔로우 on/off 기능
    @RequestMapping(value = "/ajaxFollow", method = RequestMethod.POST, produces = "text/plain")
	@ResponseBody
	public String bunjangAjaxStoreFollow(int storeIdx, int viewStoreIdx) {
    	// 오른쪽이 왼쪽을 팔로우하고있는지 체크
    	int followYN = svcFollow.followCheck(viewStoreIdx, storeIdx);
    	
    	if(followYN == 1) {
    		// 오른쪽이 왼쪽을 팔로우해제함
    		svcFollow.followOff(viewStoreIdx, storeIdx);
    		return "off";
    	}else {
    		// 오른쪽이 왼쪽을 팔로우등록함
    		svcFollow.followOn(viewStoreIdx, storeIdx);
    		return "on";
    	}
	}
    @PostMapping("/InsertReviews")
	@ResponseBody
	public String insertReviews(@RequestBody ReviewsDto review) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("storeIdx", review.getTargetStoreIdx()); // DTO 필드명과 DB 컬럼명 매핑
	    params.put("writerIdx", review.getWriterIdx());
	    params.put("productIdx", review.getProductIdx());
	    params.put("startCnt", review.getStartCnt());
	    params.put("reviewText", review.getReviewText());

	    int result = reviewsService.insertReview(params);
	    return result > 0 ? "success" : "fail";
	}
	@PostMapping("/ReviewsView")
	@ResponseBody
	public List<ReviewsDto> getReviewDetail(@RequestParam("productIdx") int productIdx,
	                                        @RequestParam("writerIdx") int writerIdx) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("productIdx", productIdx);
	    map.put("writerIdx", writerIdx);

	    return reviewsService.getUpdateReviewsView(map);
	}
	
	@PostMapping("/UpdateReviews")
	@ResponseBody
	public Map<String, Object> updateReviews(
	        @RequestParam("productIdx") int productIdx,
	        @RequestParam("writerIdx") int writerIdx,
	        @RequestParam("startCnt") int startCnt,
	        @RequestParam("reviewText") String reviewText) {

	    Map<String, Object> params = new HashMap<>();
	    params.put("productIdx", productIdx);
	    params.put("writerIdx", writerIdx);
	    params.put("startCnt", startCnt);
	    params.put("reviewText", reviewText);

	    Map<String, Object> result = new HashMap<>();
	    try {
	        int updatedCount = reviewsService.updateReview(params);
	        result.put("status", "success");
	        result.put("updatedCount", updatedCount);
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("status", "error");
	        result.put("message", "리뷰 수정 중 오류가 발생했습니다.");
	    }
	    return result;
	}
}
