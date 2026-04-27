package com.rent.vaca.reserv;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.rent.vaca.user.UserVO;

@Repository
public class ReservRepository {
	private final SqlSession template;

	@Autowired
	public ReservRepository(SqlSession template) {
		this.template = template;
	}
	
	// 특정일, 특정 객실 예약여부 조회
	public boolean checkReservation(ReservVO vo){
		return template.selectOne("reservMapper.checkReservation", vo);
	}
	
	// 마이페이지 예약내역 : 다가오는 예약
	public List<ReservVO> selectReservList(int user){
		return template.selectList("reservMapper.selectReservList", user);
	}
	
	// 마이페이지 예약내역 : 지나간 예약, 취소한 예약
	public List<ReservVO> deprecatedReservList(int user){
		return template.selectList("reservMapper.deprecatedReservList", user);
	}
	
	// 예약정보 예약테이블에 저장
	public int saveMyReserv(ReservVO vo) {
		return template.insert("reservMapper.saveMyReserv", vo);
	}
	
	public boolean existByReservCode(String reservCode) {
		Integer count = template.selectOne("reservMapper.existByReservCode", reservCode);
		return count != null && count > 0;
	}
	
}
