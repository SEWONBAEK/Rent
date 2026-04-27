package com.rent.vaca.user;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.rent.vaca.notice.NoticeVO;
import com.rent.vaca.reserv.ReservVO;
import com.rent.vaca.user.UserVO;

import lombok.RequiredArgsConstructor;

public interface UserService {

	void join(UserVO vo, List<Integer> termIds);
	
	UserVO login(UserVO vo);
	
	int emailCheck(String email);
	
	int phoneCheck(String phone);
	
	UserVO findEmail(UserVO vo);
	
	String pwauto(String email) throws Exception;
	
	int findPw(String email, String name, String phone);
	
	int kakaoJoin(UserVO vo);
	
	UserVO kakaoLogin(String accesstoken);
	
	int naverJoin(UserVO vo);
	
	UserVO naverLogin(String accesstoken);
	
	UserVO useraccountupdate(UserVO vo);
	
	List<Object> getPostsByUserId(int userId);
	
	List<Object> getReservByUserId(int userId);
	
	UserVO useraccount(UserVO vo);
	
	UserVO useraccountchange(UserVO vo);
	
	UserVO useraccountsocial(UserVO vo);
	
	UserVO selectUserOne(UserVO vo);
	
	boolean userPwChange(String email, UserPwChangeVO vo);
	
	boolean userInfoChange(String email, UserVO vo);
	
	boolean cancelReserv(String reservCode);
	
	int selectInterestOne(InterestVO inter);
	
	List<InterestVO> selectInterestList(int userId);
	
	List<NoticeVO> selectQuestionList();
	
	List<Member> selectMemberList();
	
	Member selectMemberById(int memberId);
	
	void updateBanyn(int memberId, String banyn, String banReason);
	
	void updateAccoDelyn(int memberId, String delyn);
	
	// 카카오 토큰 요청
	String getAccessToken (String code); 
	
	// 카카오 사용자 정보 요청
	KakaoDto getUserInfo(String accessToken);
	
	// 네이버 토큰 요청
	String getNaverAccessToken (String code, String state); 
	
	// 네이버 사용자 정보 요청
	NaverDto getNaverUserInfo(String accessToken);
	
	// 네이버 로그인 URL로 이동
	String getRequestLoginUrl(HttpSession session) throws UnsupportedEncodingException;

	
}


