package com.rent.vaca.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rent.vaca.notice.NoticeVO;

@Repository
public class UserRepository {
	
	private final SqlSession template;

	@Autowired
	public UserRepository(SqlSession template) {
		this.template = template;
	}
	
	public int join(UserVO vo){
		return template.insert("userMapper.join", vo);
	}
	
	public void userTermSave(UserTermsVO userTerm) {
		
		template.insert("userMapper.userTermSave", userTerm);
		
	}
	
	public UserVO login(UserVO vo){
		return template.selectOne("userMapper.login", vo);
	}
	
	public int emailCheck(String email){
		return template.selectOne("userMapper.emailCheck", email);
	}
	
	public int phoneCheck(String phone){
		return template.selectOne("userMapper.phoneCheck", phone);
	}
	
	public UserVO findEmail(UserVO vo) {
		return template.selectOne("userMapper.findEmail",vo);
	}
	
	public int pwauto(String email, String pw) {
		Map<String, Object> param = new HashMap<>();
		
		param.put("email", email);
		param.put("pw", pw);
		
		return template.update("userMapper.pwauto", param);
	}
	
	public int findPw(String email, String name, String phone) {
		Map<String, Object> param = new HashMap<>();
		param.put("email", email);
		param.put("name", name);
		param.put("phone", phone);
		
		return template.selectOne("userMapper.findPw", param);
	}
	
	public int kakaoJoin(UserVO vo){
		return template.insert("userMapper.kakaoJoin", vo);
	}	
		
	public UserVO kakaoLogin(String accesstoken){
		return template.selectOne("userMapper.kakaoLogin", accesstoken);
	}	
	
	public int naverJoin(UserVO vo){
		return template.insert("userMapper.naverJoin", vo);
	}	
			
	public UserVO naverLogin(String accesstoken){
		return template.selectOne("userMapper.naverLogin", accesstoken);
	}		
	
	public UserVO useraccountupdate(UserVO vo) {
		return template.selectOne("userMapper.useraccountupdate",vo);
	}

	public List<Object> getPostsByUserId(int userId) {
		return template.selectList("userMapper.getPostsByUserId",userId);
	}
	
	public List<Object> getReservByUserId(int userId) {
		return template.selectList("userMapper.getReservByUserId",userId);
	}
	
	public UserVO useraccount(UserVO vo) {
		return template.selectOne("userMapper.useraccount",vo);
	}
	
	public UserVO useraccountchange(UserVO vo) {
		return template.selectOne("userMapper.useraccountchange",vo);
	}
	
	public UserVO useraccountsocial(UserVO vo) {
		return template.selectOne("userMapper.useraccount",vo);
	}
	
	// 비밀번호 변경 처리 확인용 email확인
	public UserVO selectUserByEmail(String email) {
		return template.selectOne("userMapper.selectUserByEmail", email);
	}
	
	// 개인 회원 비밀번호 변경
	public int userPwChange(String email, String pw) {
		Map<String, Object> param = new HashMap<>();
		param.put("email", email);
		param.put("pw", pw);
		
		return template.update("userMapper.userPwChange", param);
	}
	
	// 예약 취소
	public int cancelReserv(String reservCode) {
		return template.update("userMapper.cancelReserv", reservCode);
	}
	
	// 개인, 비즈니스 회원 전체 조회
	public List<Member> selectMemberList(){
		return template.selectList("userMapper.selectMemberList");
	}
	
	public Member selectMemberById(int memberId) {
		return template.selectOne("userMapper.selectMemberById", memberId);
	}

	// 관리자가 일반회원 및 비즈니스회원 차단
	public void updateBanyn(int memberId, String banyn,String banReason) {
	
		Map<String, Object> param = Map.of(
				"memberId", memberId,
				"banyn", banyn,
				"banReason", banReason
		);
		
		template.update("userMapper.updateUserBanyn", param);
		template.update("userMapper.updateBizBanyn", param);
	
	}
	
	// 관리자가 비즈니스회원 차단 시 숙소 비활성화 
	public void updateAccoDelyn(int memberId, String delyn) {
		Map<String, Object> param = Map.of(
				"memberId", memberId,
				"delyn", delyn
		);
		template.update("userMapper.updateAccoDelyn", param);
	}
	
}
