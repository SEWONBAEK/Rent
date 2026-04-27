package com.rent.vaca.reserv;


public interface ReservService {
	
	// 사용자 예약한 내용 DB저장
	public int saveMyReserv(ReservVO vo);
	
	// 예약코드 중복 여부 확인
	public boolean existsByReservCode(String reservCode);
	
}
