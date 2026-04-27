package com.rent.vaca.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.rent.vaca.acco.AccoPhotoVO;
import com.rent.vaca.acco.AccoVO;
import com.rent.vaca.reserv.ReservVO;
import com.rent.vaca.room.RoomVO;

@Repository
public class BizRepository {
	private final SqlSession template;

	@Autowired
	public BizRepository(SqlSession template) {
		this.template = template;
	}
	
	// 회원가입
	public Integer insertBizOne(BizVO vo) {
		return template.insert("bizMapper.insertBizOne", vo);
	}
	
	// 로그인
	public BizVO selectBizOne(BizVO vo) {
		return template.selectOne("bizMapper.selectBizOne", vo);
	}
	
	// 이메일 찾기
	public String selectEmailFind(String name, String phone,
			String certificateNo) {
		
		Map<String, Object> param = new HashMap<>();
		param.put("name", name);
		param.put("phone", phone);
		param.put("certificateNo", certificateNo);
		
		return template.selectOne("bizMapper.selectEmailFind", param);
	}
	
	// 비밀번호 찾기
	public int selectPasswordFind(String email, String name, String phone, String certificateNo) {
		
		Map<String, Object> param = new HashMap<>();
		param.put("email", email);
		param.put("name", name);
		param.put("phone", phone);
		param.put("certificateNo", certificateNo);
		
		return template.selectOne("bizMapper.selectPasswordFind", param);
	
	}
	
	// 랜덤 비밀번호 생성 후 저장
	public int passwordRandom(String email, String pw) {
		Map<String, Object> param = new HashMap<>();
		
		param.put("email", email);
		param.put("pw", pw);
		
		return template.update("bizMapper.passwordRandom", param);
	}
	
	// 비밀번호 변경 처리 확인용 email확인
	public BizVO selectBizByEmail(String email) {
		return template.selectOne("bizMapper.selectBizByEmail", email);
	}
	
	// 비밀번호 변경
	public int bizPwChange(String email, String pw) {
		Map<String, Object> param = new HashMap<>();
		param.put("email", email);
		param.put("pw", pw);
		
		return template.update("bizMapper.bizPwChange", param);
	}
	
	// 이메일 중복확인
	public Integer selectBizCntByEmail(String email) {
		return template.selectOne("bizMapper.selectBizCntByEmail", email);
	}
	
	// 사업자 정보 수정
	public int updateBizInfo(BizVO vo) {
		return template.update("bizMapper.updateBizInfo", vo);
	}
	
	// 사업자등록증 사진 삭제
	public int updateCertificateDeleted(int id) {
		return template.delete("bizMapper.updateCertificateDeleted", id);
	}
	
	// 숙소 1건 등록
	public Integer insertAccoOne(AccoVO vo) {
		return template.insert("accoMapper.insertAccoOne", vo);
	}
	
	// 숙소 사진 등록
	public Integer insertAccoPhoto(AccoPhotoVO vo) {
		return template.insert("accoMapper.insertAccoPhoto", vo);
	}
	
	// 숙소 정보 업데이트
	public int updateAccoInfo(AccoVO vo) {
		return template.update("accoMapper.updateAccoInfo", vo);
	}
	
	// 숙소 1건 조회
	public AccoVO selectBizAccoOne(int bizId) {
		return template.selectOne("accoMapper.selectBizAccoOne", bizId);
	}
	
	// 숙소 삭제 여부 조회
	public int existsAccoByBizIdAndDelyn(int bizId, String delyn) {
		
		Map<String, Object> params = new HashMap<>();
		params.put("bizId", bizId);
		params.put("delyn", delyn);

		return template.selectOne("accoMapper.existsAccoByBizIdAndDelyn", params);
	}
	
	// 숙소 등록한 사진 조회
	public List<AccoPhotoVO> getPhotosByBizId(int accoNo){
		return template.selectList("accoPhotoMapper.getPhotosByBizId", accoNo);
	}
	
	// 등록한 객실 사진 조회
	public List<AccoPhotoVO> getPhotosByBizIdAndRoomNo(int accoNo, int roomNo){
		Map<String, Object> params = new HashMap<>();
		params.put("accoNo", accoNo);
		params.put("roomNo", roomNo);		
		return template.selectList("accoPhotoMapper.getPhotosByBizIdAndRoomNo", params);
	}
	
	// 숙소 1건 삭제
	public Integer deleteAccoDelyn(int accoNo) {
		return template.delete("accoMapper.deleteAccoDelyn", accoNo);
	}
	
	// 숙소 삭제 시 해당 숙소 예약 여부 조회
	public int reservAccoCount(int accoNo) {
		return template.selectOne("accoMapper.reservAccoCount", accoNo);
	}
	
	// 숙소 사진 삭제
	public int deleteAccoPhotoByAccoNo(int accoNo) {
		return template.delete("accoPhotoMapper.deleteAccoPhotoByAccoNo", accoNo);
	}
	
	// 객실 1건 등록
	public Integer insertRoomOne(RoomVO vo) {
		return template.insert("roomMapper.insertRoomOne", vo);
	}
	
	// 객실 사진 등록
	public Integer insertRoomPhoto(AccoPhotoVO vo) {
		return template.insert("roomMapper.insertRoomPhoto", vo);
	}
	
	public int getPhotosByAccoNo(int roomNo) {
		return template.delete("roomMapper.deleteAccoPhotoByRoomNo", roomNo);
	}
	
	// 숙소내 객실 전체 조회
	public List<RoomVO> selectRoomsByAccoNo(int accoNo) {
		return template.selectList("roomMapper.selectRoomsByAccoNo", accoNo);
	}
	
	public List<AccoPhotoVO> getPhotosByBizIdAndRoomNo(int roomNo){
		return template.selectList("accoPhotoMapper.getPhotosByBizIdAndRoomNo", roomNo);
	}
	
	// 객실 1건 조회
	public RoomVO selectAccoRoomOne(int accoNo) {
		return template.selectOne("roomMapper.selectAccoRoomOne", accoNo);
	}
	
	// 객실 1건 삭제
	public void updateRoomDelYn(int accoNo, int roomNo) {
		Map<String, Object> params = new HashMap<>();
        params.put("accoNo", accoNo);
        params.put("roomNo", roomNo);

        template.update("roomMapper.updateRoomDelYn", params);
	}
	// 객실 1건 사진 삭제
	public void deleteAccoPhotoByRoomNo(int roomNo) {
		template.delete("accoPhotoMapper.deleteAccoPhotoByRoomNo", roomNo);
    }
	
	// 객실 삭제 시 해당 객실 예약 여부 조회
	public int reservRoomCount(int roomNo) {
		return template.selectOne("roomMapper.reservRoomCount", roomNo);
	}
	
	public List<ReservVO> selectReservList(int bizId, String startDate, String endDate){
		
		Map<String, Object> params = new HashMap<>();
		params.put("bizId", bizId);
		params.put("startDate", startDate);
		params.put("endDate", endDate);
		
		return template.selectList("bizMapper.selectReservList", params);
	}
	
	public void bizTermSave(BizTermsVO bizTerm) {
		
		template.insert("bizMapper.bizTermSave", bizTerm);
		
	}
	
}
