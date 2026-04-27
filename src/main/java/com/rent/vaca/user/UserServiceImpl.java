package com.rent.vaca.user;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.rent.vaca.notice.NoticeRepository;
import com.rent.vaca.notice.NoticeVO;
import com.rent.vaca.reserv.ReservVO;
import com.rent.vaca.user.UserRepository;
import com.rent.vaca.user.UserService;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
	
	private final UserRepository repository;
	private final NoticeRepository noticeRepository;
	private final PasswordEncoder passwordEncoder;
	private final InterestRepository interestRepository;
	private final JavaMailSender mailSender;
	private final RestTemplate restTemplate;
	
	@Value("${kakao.apiKey}")
	private String kakaoKey;
	
	private static final String data = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	
	@Autowired
	public UserServiceImpl(UserRepository repository,
			NoticeRepository noticeRepository,
			PasswordEncoder passwordEncoder,
			InterestRepository interestRepository,
			JavaMailSender mailSender,
			RestTemplate restTemplate) {
		this.repository = repository;
		this.noticeRepository = noticeRepository;
		this.passwordEncoder = passwordEncoder;
		this.interestRepository = interestRepository;
		this.mailSender = mailSender;
		this.restTemplate = restTemplate;
	}

	@Override
	public void join(UserVO vo, List<Integer> termIds) {
		
		// 이메일 중복확인
		int count = repository.emailCheck(vo.getEmail());
		if (count > 0) {
			throw new IllegalArgumentException("이미 등록된 이메일입니다.");
		}
		
		String encPw = passwordEncoder.encode(vo.getPw());
		vo.setPw(encPw);
		
		repository.join(vo);
		System.out.println("가입 후 사용자 ID: " + vo.getId());
		for(Integer termId : termIds) {
			
			System.out.println("동의 처리하는 termId: " + termId);
			
			UserTermsVO userTerm = new UserTermsVO();
			userTerm.setUserId(vo.getId());
			userTerm.setTermId(termId);
			userTerm.setAgreed(1);
			
			repository.userTermSave(userTerm);
			
		}
		
	}

	@Override
	public UserVO login(UserVO vo) {
		
		UserVO user = repository.login(vo);
		
		if(user == null) {
			return null;
		}else {
			// db에 저장된 비밀번호랑 사용자가 입력한 비밀번호가 일치하는지 확인
			boolean match =  passwordEncoder.matches(vo.getPw(), user.getPw());
			if(match == true) {
				return user;
			}else {
				return null;
			}
		}
		
	}

	@Override
	public int emailCheck(String id) {
		return repository.emailCheck(id);
	}
	
	@Override
	public int phoneCheck(String phone) {
		return repository.emailCheck(phone);
	}

	@Override
	public UserVO findEmail(UserVO vo) {
		return repository.findEmail(vo);
	}
	
	@Override
	public String pwauto(String email) {
		
		// 임시 비밀번호 생성
		String tempPw = generateRandomPassword(12);
		
		// 암호화
		String encPw = passwordEncoder.encode(tempPw);
		
		// DB 업데이트
		repository.pwauto(email, encPw);
		
		sendTempPasswordMail(email, tempPw);
		
		return tempPw;
	}
	
	// 임시비밀번호 생성코드
	private String generateRandomPassword(int length) {
		
		String code = "";
		
		for(int i = 0 ; i < length ; i++) {
			int rnd = ((int)(Math.random() * 10000)) % data.length();
			code += data.charAt(rnd);
		}
		
		return code;
		
	}
	
	// 메일 발송
	private void sendTempPasswordMail(String email, String tempPw) {
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		
			helper.setTo(email);
			helper.setFrom("3whitedog3@gmail.com", "비밀번호 변경 안내");
			helper.setSubject("임시 비밀번호 안내");
			
			String body = "안녕하세요.\n\n" +
					"요청하신 임시 비밀번호는 아래와 같습니다.\n\n" +
					tempPw +
					"\n\n로그인 후 반드시 비밀번호를 변경해주세요.";
			
			helper.setText(body);
		
			mailSender.send(message);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int findPw(String email, String name, String phone) {
		return repository.findPw(email, name, phone);
	}
	
	@Override
	public int kakaoJoin(UserVO vo) {
		return repository.kakaoJoin(vo);
	}

	@Override
	public UserVO kakaoLogin(String accesstoken) {
		return repository.kakaoLogin(accesstoken);
	}
	
	@Override
	public int naverJoin(UserVO vo) {
		return repository.naverJoin(vo);
	}

	@Override
	public UserVO naverLogin(String accesstoken) {
		return repository.naverLogin(accesstoken);
	}
	
	@Override
	public UserVO useraccountupdate(UserVO vo) {
		return repository.useraccountupdate(vo);
	}
	
	@Override
	public List<Object> getPostsByUserId(int userId) {
		return repository.getPostsByUserId(userId);
	}
	
	@Override
	public List<Object> getReservByUserId(int userId) {
		return repository.getReservByUserId(userId);
	}

	@Override
	public UserVO useraccount(UserVO vo) {
		return repository.useraccount(vo);
	}
	
	@Override
	public UserVO useraccountchange(UserVO vo) {
		return repository.useraccountchange(vo);
	}

	@Override
	public UserVO useraccountsocial(UserVO vo) {
		return repository.useraccount(vo);
	}

	@Override
	public List<NoticeVO> selectQuestionList() {
		return noticeRepository.selectQuestionList();
	}
	
	// 비밀번호 변경 처리
	@Override
	public boolean userPwChange(String email, UserPwChangeVO vo) {
		
		UserVO user = repository.selectUserByEmail(email);

	    if (user == null) {
	    	return false;
	    }

	    // 현재 비밀번호 확인
	    if (!passwordEncoder.matches(vo.getCurrentPw(), user.getPw())) {
	        return false;
	    }

	    // 새 비밀번호 = 확인 비밀번호 검증
	    if (!vo.getNewPw().equals(vo.getConfirmPw())) {
	        return false;
	    }

	    // 새 비밀번호 암호화 후 업데이트
	    String encPw = passwordEncoder.encode(vo.getNewPw());
	    repository.userPwChange(email, encPw);

	    return true;

	}

	@Override
	public UserVO selectUserOne(UserVO vo) {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 유저정보 변경
	@Override
	public boolean userInfoChange(String email, UserVO vo) {
		
		UserVO user = repository.selectUserByEmail(email);
		
		if (user == null) {
	    	return false;
	    }
		
		if(user.getNickname().trim() == "" && user.getNickname() == null) {
			return false;
		}
		
		if(user.getPhone().trim() == "" && user.getPhone() == null) {
			return false;
		}
		
		return true;
	}
	
	// 예약 취소
	@Override
	public boolean cancelReserv(String reservCode) {
		return repository.cancelReserv(reservCode) > 0;
	}

	// 찜한 숙소 중 선택한 숙소페이지 이동을 위한 숙소 단건 조회
	@Override
	public int selectInterestOne(InterestVO inter) {
		return interestRepository.selectInterestOne(inter);
	}
	
	// 일반회원 숙소 찜목록 전체 조회
	public List<InterestVO> selectInterestList(int userId){
		return interestRepository.selectInterestList(userId);
	}

	// 회원 관리 페이지 일반회원과 비즈니스회원 전체 리스트 조회
	@Override
	public List<Member> selectMemberList() {
		return repository.selectMemberList();
	}
	
	// 차단할 사용자 일반회원인지 비즈니스회원인지 구분하기 위한 단건 조회
	@Override
	public Member selectMemberById(int memberId) {
		return repository.selectMemberById(memberId);
	}
	
	// 관리자가 일반회원 및 비즈니스회원 차단
	@Override
	public void updateBanyn(int memberId, String banyn, String banReason) {
		repository.updateBanyn(memberId, banyn, banReason);
	}
	
	// 관리자가 비즈니스회원 차단 시 숙소 비활성화
	@Override
	public void updateAccoDelyn(int memberId, String delyn) {
		repository.updateAccoDelyn(memberId, delyn);
	}

	// 카카오 API 호출
	@Override
	public String getAccessToken(String code) {
		
		String url = "https://kauth.kakao.com/oauth/token";
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded; charset=utf-8");
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		
		body.add("grant_type", "authorization_code");
		body.add("client_id", "cb99847ef4ae388bcf934adfac8de141");
		body.add("redirect_uri","http://jjezen.cafe24.com/Rent/login/kakaocallback");
		body.add("code", code);
		
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(body, headers);
		
		try {
			ResponseEntity<Map> response = restTemplate.postForEntity(url, request, Map.class);
			
			Map<String, Object> result = response.getBody();

			return (String) result.get("access_token");
		} catch(Exception e) {
			System.out.println("카카오 API 호출 실패!");
			e.printStackTrace();
			return null;
		}
				
	}
	
	// 카카오 회원 정보 가져오기
	@Override
	public KakaoDto getUserInfo(String accessToken) {		
		
		String url = "https://kapi.kakao.com/v2/user/me";
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + accessToken);
		
		HttpEntity<Void> request = new HttpEntity<>(headers);
		
		try {
			
			ResponseEntity<KakaoDto> response = restTemplate.exchange(
				url, HttpMethod.GET, request, KakaoDto.class);
			
			return response.getBody();
			
		} catch(Exception e) {
			System.out.println("카카오 회원 정보 가져오기 중 오류 발생!");
			e.printStackTrace();
			return null;
		}
	}

	// 네이버 API 호출
	@Override
	public String getNaverAccessToken(String code, String state) {
		String url = "https://nid.naver.com/oauth2.0/token";
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded; charset=utf-8");
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		
		body.add("grant_type", "authorization_code");
		body.add("client_id", "Ka8rPHCq0lLS0EH60uvK");
		body.add("client_secret", "EvCf7xS0dU");
		body.add("code", code);
		body.add("state", state);
		
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(body, headers);
		
		try {
			
			ResponseEntity<Map> response = restTemplate.postForEntity(url, request, Map.class);
			Map<String, Object> result = response.getBody();
			return (String) result.get("access_token");
			
		} catch(Exception e) {
			System.out.println("네이버 API 호출 실패!");
			e.printStackTrace();
			return null;
		}
		
	}

	// 네이버 회원 정보 가져오기
	@Override
	public NaverDto getNaverUserInfo(String accessToken) {
		
		String url = "https://openapi.naver.com/v1/nid/me";
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + accessToken);

		HttpEntity<Void> request = new HttpEntity<>(headers);
		
		try {
			ResponseEntity<NaverDto> response = restTemplate.exchange(
					url, HttpMethod.GET, request, NaverDto.class);
			
			System.out.println(response.getBody());
			
			return response.getBody();
			
		} catch(Exception e) {
			System.out.println("네이버 회원 정보 가져오기 중 오류 발생!");
			e.printStackTrace();
			return null;
		}
		
	}
	
	// 네이버 URL로 이동
	@Override
	public String getRequestLoginUrl(HttpSession session) throws UnsupportedEncodingException {
		
		// 네이버 Client ID
		String clientId = "Ka8rPHCq0lLS0EH60uvK";
		
		String redirectUri = URLEncoder.encode("http://jjezen.cafe24.com/Rent/login/navercallback", "UTF-8");
		
		// 랜덤 state 값 생성
		String state = UUID.randomUUID().toString();     
		
		String scope = "profile, email, phone";
		
		String encodedScope = URLEncoder.encode(scope, "UTF-8");
		
		// 콜백 검증을 위해 세션에 저장
		session.setAttribute("naverState", state);
		
		String naverUrl = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
		        + "&client_id=" + clientId
		        + "&redirect_uri=" + redirectUri
		        + "&state=" + state
		        + "&scope=" + encodedScope;
		
		return naverUrl;
		
	}
	
}

