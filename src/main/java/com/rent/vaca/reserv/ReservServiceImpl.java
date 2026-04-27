package com.rent.vaca.reserv;

import org.apache.catalina.startup.ClassLoaderFactory.Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.rent.vaca.user.BizRepository;

@Service
public class ReservServiceImpl implements ReservService{

	private final ReservRepository repository;
	
	@Autowired
	public ReservServiceImpl(ReservRepository repository) {
		this.repository = repository;
	}
	
	@Override
	public int saveMyReserv(ReservVO vo) {
		return repository.saveMyReserv(vo);
	}

	@Override
	public boolean existsByReservCode(String reservCode) {
		return repository.existByReservCode(reservCode);
	}
	
}
