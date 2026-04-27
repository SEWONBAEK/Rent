package com.rent.vaca.user;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import javax.security.auth.login.LoginException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponents
;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.google.api.client.http.HttpHeaders;
import com.google.api.client.json.JsonObjectParser;
import com.google.common.net.MediaType;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.rent.vaca.notice.NoticeVO;
import com.rent.vaca.user.Response;
import com.rent.vaca.user.UserService;
import com.rent.vaca.user.UserVO;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("")
public class UserController {
	
	private final UserService userService;
	
	@Autowired
	public UserController(UserService userService) {
		this.userService = userService;
	}
	
	// 약관동의 페이지
	@RequestMapping(value="/user/join/agree", method = RequestMethod.GET)
	public String agree() {
		return "/user/join/agree";
	}
	
	// 약관동의 처리
	@PostMapping("/user/join/agree")
	public String agree(HttpSession session,
			@RequestParam("terms") List<Integer> terms) {
		
		session.setAttribute("agreedTerms", terms);
		
		return "redirect:/user/join/form";
		
	}
	
	// 회원가입 페이지
	@RequestMapping(value="/user/join/form", method = RequestMethod.GET)
	public String join(Model model, HttpSession session) {
		
		model.addAttribute("UserVO", new UserVO());
		
		List<Integer> agreedTerms = (List<Integer>) session.getAttribute("agreedTerms");
		
		if(agreedTerms == null || !agreedTerms.containsAll(Arrays.asList(1, 2, 3))) {
			return "redirect:/user/join/agree";
		}
		
		return "/user/join/form";
		
	}
	
	// 회원가입 처리 페이지
	@RequestMapping(value="/user/join/form", method = RequestMethod.POST) 
	public String join(UserVO vo, HttpSession session) {
	
		List<Integer> agreedTerms = (List<Integer>) session.getAttribute("agreedTerms");
		
		userService.join(vo, agreedTerms);
		
		session.removeAttribute("agreedTerms");
		
		return "redirect:/user/join/finish";
	}
	
	// 이메일 중복확인 처리
	@RequestMapping(value="user/join/form/emailCheck", method = RequestMethod.GET) 
	@ResponseBody
	public boolean emailCheck(@RequestParam(value="email") String email) {
		
		int cnt = userService.emailCheck(email);
		
		return cnt == 0;
	}
	
	// 회원가입 완료 페이지
	@RequestMapping(value="/user/join/finish", method = RequestMethod.GET) 
	public String finish() {
		return "/user/join/finish";
	}
	
	// 이메일 찾기 페이지
	@RequestMapping(value="/user/find/email", method = RequestMethod.GET) 
	public String findEmail() {
		return "/user/find/email";
	}
	
	// 이메일 찾기 처리
	@RequestMapping(value="/user/find/email", method = RequestMethod.POST) 
	public String findEmail(UserVO vo, Model model){
		
		UserVO user = userService.findEmail(vo);
		
		if(user != null) {
			model.addAttribute("email", user.getEmail());
		}else {
			model.addAttribute("msg", "입력하신 정보와 일치하는 이메일이 없습니다.");
			
		}
		return "/user/find/email";
	}
	
	// 비밀번호 찾기 페이지
	@RequestMapping(value="/user/find/pw", method = RequestMethod.GET) 
	public String findPw() {
		return "/user/find/pw";
	}
	
	// 비밀번호 찾기 처리
	@PostMapping("/user/find/pw")
	public String findPw(RedirectAttributes redirectAttributes,
			@RequestParam("email") String email,
			@RequestParam("name") String name,
			@RequestParam("phone") String phone) throws Exception {
		
		String phoneOnly = phone.replace("-", "");
		

		// 회원정보 존재 유무 확인 ( 존재 O = true, 존재 X = false )
		boolean userExists = userService.findPw(email, name, phoneOnly) > 0;

		if(userExists) {

			userService.pwauto(email);

			redirectAttributes.addFlashAttribute("email", email);

			redirectAttributes.addFlashAttribute("message", "임시 비밀번호가 이메일로 발송되었습니다.");
			
			return "redirect:/user/find/pw";
			
		} else {
			
			redirectAttributes.addFlashAttribute("errorMessage", "일치하는 회원이 없습니다.");
			return "redirect:/user/find/pw";
			
		}
		
	}
	
	// 임시비밀번호 발송 페이지
	@RequestMapping(value="/user/find/mailsend", method = RequestMethod.GET) 
	public String mailSend() {
		return "/user/find/mailsend";
	}

	// 카카오톡 소셜 로그인
	@RequestMapping(value="/login/kakaocallback", method=RequestMethod.GET)
	public String kakaoLogin(HttpSession session, UserVO vo, Model model,
			@RequestParam("code") String code) {
		
		// 토큰 요청
		String accessToken = userService.getAccessToken(code);

		// 사용자 정보 요청
		KakaoDto userInfo = userService.getUserInfo(accessToken);

		String socialId = String.valueOf(userInfo.getId());
		String email = userInfo.getKakaoAccount().getEmail();
		String nickname = userInfo.getKakaoAccount().getProfile().getNickname();
		
			try {
				
				UserVO user = userService.kakaoLogin(socialId);
				
				if(user != null) {
				
					if("Y".equals(user.getBanyn())) {
						String banReason = user.getBanReason();
						String encodeBanReason = banReason == null ? "" : URLEncoder.encode(banReason, "UTF-8");
						return "redirect:/login/login_ban?banReason="+ encodeBanReason;
					} else {
						session.setAttribute("user", user); 
						return "redirect:/";
					}
				} else {
					// 신규 카카오 회원가입
					UserVO newUser = new UserVO();
					newUser.setSocialId(socialId);
					newUser.setEmail(email);
					newUser.setNickname(nickname);
					newUser.setSocial("Y");
					
					userService.kakaoJoin(newUser);
					
					user = userService.kakaoLogin(socialId);
					
					session.setAttribute("user", user); 
					
					return "redirect:/";
				}
				
			}catch(Exception e) {
				System.out.println("카카오 로그인 중 오류 발생!");
				e.printStackTrace();
				return "redirect:/login/main";
			}
	}
		
	// 네이버 소셜 로그인
    @GetMapping("/login/naver")
    public void naverLogin(HttpServletResponse response,
    		HttpServletRequest request, HttpSession session){
        
        try {
        	
        	String loginUrl = userService.getRequestLoginUrl(session);
        	response.sendRedirect(loginUrl);
        
        } catch (IOException e) {
        	e.printStackTrace();
        	System.out.println("URL 호출 중 오류 발생");
        }
    }
	    
    @GetMapping("/login/navercallback")
    public String requestAccessCallback(UserVO vo,
    		@RequestParam("code") String code, 
            @RequestParam("state") String state, HttpSession session) {

    	try {
    		
    		// access token 받기
    		String accessToken = userService.getNaverAccessToken(code, state);
    		System.out.println("accessToken : "+accessToken);
    		// 사용자 정보 조회
    		NaverDto userInfo = userService.getNaverUserInfo(accessToken);
    		
    		String socialId = String.valueOf(userInfo.getResponse().getId());
    		String email = userInfo.getResponse().getEmail();
    		String name = userInfo.getResponse().getName();
    		String nickname = userInfo.getResponse().getNickname();
    		
    		
    		
    		UserVO user = userService.naverLogin(socialId);
    		
    		if(user != null) {
    			// 이미 회원가입한 유저
    			if("Y".equals(user.getBanyn())) {
    				// 소셜 로그인 회원이 밴당한 경우
    				String banReason = user.getBanReason();
    				String encodeBanReason = banReason == null ? "" : URLEncoder.encode(banReason, "UTF-8");
    				return "redirect:/login/login_ban?banReason="+ encodeBanReason;
    			} else {
    				session.setAttribute("user", user);
    				return "redirect:/";
    			}
    		} else {
    			// 신규 네이버 회원가입
    			UserVO newUser = new UserVO();
    			newUser.setSocialId(socialId);
    			newUser.setEmail(email);
    			if(name == null || name.isEmpty()) {
    			    name = (nickname == null || nickname.isEmpty()) ? "네이버유저" : nickname;
    			}
    			
    			// nickname이 없으면 name으로 대체
    			if(nickname == null || nickname.isEmpty()) {
    			    nickname = name;
    			}
    			
    			newUser.setName(name);
    			newUser.setNickname(nickname);
    			newUser.setSocial("Y");
    			
    			userService.naverJoin(newUser);
    			
    			user = userService.naverLogin(socialId);
    			
    			session.setAttribute("user", user);
    			
    			return "redirect:/";
    			
    		}
    		
    	}catch(Exception e) {
    		System.out.println("네이버 요청 콜백 중 오류 발생");
    		e.printStackTrace();
    		return "redirect:/login/main";
    	}
    }
    
	// 로그인 메인페이지
	@RequestMapping(value="/login/main", method = RequestMethod.GET) 
	public String main() {
		return "/login/main";
	}

	// 이메일 로그인 페이지
	@RequestMapping(value="/login/email", method = RequestMethod.GET) 
	public String login() {
		return "/login/email";
	}

	// 로그인 처리
	@RequestMapping(value="/login/email", method = RequestMethod.POST) 
	public String login(UserVO vo, HttpSession session,
			RedirectAttributes redirectAttributes){

		UserVO user = userService.login(vo);
	
	    // 로그인 실패
	    if (user == null) {
	        redirectAttributes.addFlashAttribute("errorMessage", "이메일 또는 비밀번호가 일치하지 않습니다.");
	        return "redirect:/login/email"; // 로그인 페이지로 다시 이동
	    }
	    
	    if ("Y".equals(user.getBanyn())) {
	        
	    	String reason = user.getBanReason();
	    	
	    	redirectAttributes.addFlashAttribute("errorMessage", "차단된 사용자입니다. 고객센터에 문의하세요.\n 차단사유 : " + (reason != null ? reason : "사유 없음"));
	        
	    	return "redirect:/login/email";
	    }
		
		// 로그인 성공
		session.setAttribute("user", user); 
		return "redirect:/";
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session){
		session.invalidate();
		return "redirect:/";
	}

	// 메인 페이지
	@RequestMapping(value="main/main", method = RequestMethod.GET) 
	public String main(HttpSession session) {
		session.getAttribute("user");
		return "/main/main";
	}

	// 개인회원 비밀번호변경 페이지
	@RequestMapping(value="/user/mypage/pwchange", method = RequestMethod.GET) 
	public String userpwchange(HttpSession session){
		
		UserVO user = (UserVO) session.getAttribute("user");
		
		if(user == null) {
			return "redirect:/login/email";
		}
		
		return "/user/mypage/pwchange";
		
	}

	// 비밀번호 변경 처리
	@RequestMapping(value="/user/mypage/pwchange", method = RequestMethod.POST) 
	public String userpwchangeFn(UserPwChangeVO vo, HttpSession session) {
		try {

			UserVO user = (UserVO) session.getAttribute("user");
			
			if(user == null) {
				return "redirect:/login/email";
			}
			
			boolean success = userService.userPwChange(user.getEmail(), vo);
			
			if(success) {
				return "redirect:/user/mypage/pwchange?pwChange=success";
			}else {
				return "redirect:/user/mypage/pwchange?pwChange=fail";
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			
		}
		return null;
	}
	
	// 개인회원 개인 정보 조회 
	@RequestMapping(value="/user/mypage/account", method = RequestMethod.GET) 
	public String useraccount(UserVO vo, HttpSession session, 
			HttpServletResponse response) {
		
		try {
			// 세션에서 로그인 사용자 정보 가져오기
			vo = (UserVO) session.getAttribute("user");
			
			// 로그인 여부 확인
			if(vo == null) {
				// 로그인 X
				return "/login/main";		
			}else { 
				// 로그인 O
				return "/user/mypage/account"; 
			}	
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			
		}
		return null;
	}
	
	// 개인정보 변경 처리
	@RequestMapping(value="/user/mypage/account", method = RequestMethod.POST) 
	public String useraccountchange(UserVO vo, HttpSession session,
			HttpServletResponse response, @RequestParam("nickname") String nickname,
			@RequestParam("phone") String phone) {
		UserVO user = (UserVO) session.getAttribute("user");
		
	
		boolean changed = false;
		
		if(nickname != null && !nickname.trim().isEmpty()) {
			user.setNickname(nickname.trim());
			changed = true;
		}	
		
		if(phone != null && !phone.trim().isEmpty()) {
			user.setPhone(phone.trim());
			changed = true;
		}
		
		if(!changed) {
			return "redirect:/user/mypage/account?change=fail";
		}
		
		userService.useraccountchange(user);
		
		
		boolean success = userService.userInfoChange(user.getEmail(), user);
		
		if(success) {
			return "redirect:/user/mypage/account?change=success";
		}else {
			return "redirect:/user/mypage/account?change=fail";
		}

	}
	
	// 내 문의내역 페이지
	@RequestMapping(value="/user/mypage/question", method = RequestMethod.GET) 
	public String userquestion(RedirectAttributes redirectAttributes,
			UserVO vo, Model model, HttpSession session) {
		
		vo = (UserVO) session.getAttribute("user");
		
		// 로그인 여부 확인
		if(vo == null) {
			redirectAttributes.addFlashAttribute("msg", "로그인이 필요합니다.");
			return "redirect:/login/main";
		}
		
		try {
			
			// 사용자 ID로 게시글 조회
			int userId = vo.getId();
			List<Object> myPosts = userService.getPostsByUserId(userId);
			
			//JSP로 전달
			model.addAttribute("myPosts", myPosts);
				
		} catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("msg", "게시글을 불러오는 중 오류가 발생했습니다.");
			return "redirect:/user/mypage/question";
		}
		
		return "/user/mypage/question";
		
	}

	// 예약내역 페이지
	@RequestMapping(value="/user/mypage/reserv", method = RequestMethod.GET) 
	public String userreserv(HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		
		UserVO vo = (UserVO) session.getAttribute("user");
		if(vo == null) {
			redirectAttributes.addFlashAttribute("msg", "로그인이 필요합니다.");
			return "redirect:/login/main";
		}
		
		// 예약정보 조회
		int userId = vo.getId();
		List<Object> reserv = userService.getReservByUserId(userId);
		
		// JSP에 데이터 전달
		model.addAttribute("reserv", reserv);
		
		return "/user/mypage/reserv";
	}
	
	// 찜목록 페이지
	@RequestMapping(value="/user/mypage/wishlist", method = RequestMethod.GET) 
	public String userwishlist(RedirectAttributes redirectAttributes,
			HttpSession session, Model model) {
		
		UserVO user = (UserVO) session.getAttribute("user");
		if(user == null) {
			redirectAttributes.addFlashAttribute("msg", "로그인이 필요합니다.");
			return "redirect:/login/main";
		}
		
		int userId = user.getId();
		
		List<InterestVO> interestList = userService.selectInterestList(userId);
		
		model.addAttribute("interestList", interestList);
		
		return "/user/mypage/wishlist";
	}

	// 관리자 문의 내역 페이지
	@GetMapping("/admin/private_question")
	public String questionList(Model model) {
		List<NoticeVO> list = userService.selectQuestionList();
		model.addAttribute("list", list);
		return "/admin/private_question";
	}
	
	// 관리자 회원 관리 페이지
	@GetMapping("/admin/membership_management")
	public String membershipManagement(Model model) {
		List<Member> members = userService.selectMemberList();
		model.addAttribute("members", members);
		return "/admin/membership_management";
	}
	
	// 회원 차단 처리
	@ResponseBody
	@PostMapping("/admin/updateBanyn")
	public String updateBanyn(@RequestParam int memberId,
			@RequestParam String banyn,
			@RequestParam String banReason) {
		
		try {
		
			userService.updateBanyn(memberId, banyn, banReason);
			
			Member member = userService.selectMemberById(memberId);
			
			if(member != null && "BIZ".equals(member.getMemberType())) {
				
				String delyn = "Y".equals(banyn) ? "Y" : "N";
				
				userService.updateAccoDelyn(memberId, "Y");
			}
			
			return "success";
		
		} catch(Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	// 회원가입 페이지
	@GetMapping(value="join")
	public String joinPage() {
		return "/join/main";
	}
		
	// 예약취소 처리
	@PostMapping("/cancelReserv")
	public String cancelReserv(@RequestParam("reservCode")
		String reservCode) {
		try {
			boolean result = userService.cancelReserv(reservCode);
			
			if(result) {
				return "success";
			} else {
				return "fail";
			}
		}catch(Exception e) {
			e.printStackTrace();
			return "error";
		}	
	}
		
}
