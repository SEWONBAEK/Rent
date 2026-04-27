package com.rent.vaca.user;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.rent.vaca.acco.AccoPhotoVO;
import com.rent.vaca.acco.AccoVO;
import com.rent.vaca.notice.NoticeVO;
import com.rent.vaca.notice.QuestionAttachVO;
import com.rent.vaca.reserv.ReservVO;
import com.rent.vaca.room.RoomVO;

@Service
@Transactional
public class BizServiceImpl implements BizService{

	private final BizRepository repository;
	private final PasswordEncoder passwordEncoder;
	private final JavaMailSender mailSender;
	
	private static final String data = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	
	// application.properties 또는 yaml에 설정
	@Value("${file.upload-dir}") 
    private String uploadDir;
	
	@Autowired
	public BizServiceImpl(BizRepository repository,
			PasswordEncoder passwordEncoder,
			JavaMailSender mailSender) {
		this.repository = repository;
		this.passwordEncoder = passwordEncoder;
		this.mailSender = mailSender;
	}
	
	// 회원가입
	@Override
	public Integer insertBizOne(BizVO vo) {
		
		// 이메일 중복확인
		int count = repository.selectBizCntByEmail(vo.getEmail());
		if (count > 0) {
			throw new IllegalArgumentException("이미 등록된 이메일입니다.");
		}
		// 비밀번호 암호화 후 인서트
		String encPw = passwordEncoder.encode(vo.getPw());
		vo.setPw(encPw);
		return repository.insertBizOne(vo);
	}

	// 로그인
	@Override
	public BizVO selectBizOne(BizVO vo) {
		BizVO biz = repository.selectBizOne(vo);
		
		if(biz == null) {
			return null;
		}else {
			// db에 저장된 비밀번호랑 사용자가 입력한 비밀번호가 일치하는지 확인
			boolean match =  passwordEncoder.matches(vo.getPw(), biz.getPw());
			if(match == true) {
				return biz;
			}else {
				return null;
			}
		}
		
	}
	
	// 이메일 찾기
	@Override
	public String selectEmailFind(String name, String phone,
			String certificateNo) {
		return repository.selectEmailFind(name, phone, certificateNo);
	}
	
	// 비밀번호 찾기
	@Override
	public int selectPasswordFind(String email, String name, String phone,
			String certificateNo) {
		return repository.selectPasswordFind(email, name, phone, certificateNo);
	}
	
	// 임시 비밀번호 생성 후 DB 저장
	@Override
	public String passwordRandom(String email) {
		
		// 임시 비밀번호 생성
		String tempPw = generateRandomPassword(12);
		
		// 암호화
		String encPw = passwordEncoder.encode(tempPw);
		
		// DB 업데이트
		repository.passwordRandom(email, encPw);
		
		sendTempPasswordMail(email, tempPw);
		
		return tempPw;
		
	}
	
	// 랜덤 비밀번호 생성
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
	
	// 비밀번호 변경 처리
	@Override
	public boolean bizPwChange(String email, BizPwChangeVO vo) {
		
		BizVO biz = repository.selectBizByEmail(email);

	    if (biz == null) {
	    	return false;
	    }

	    // 현재 비밀번호 확인
	    if (!passwordEncoder.matches(vo.getCurrentPw(), biz.getPw())) {
	        return false;
	    }

	    // 새 비밀번호 = 확인 비밀번호 검증
	    if (!vo.getNewPw().equals(vo.getConfirmPw())) {
	        return false;
	    }

	    // 새 비밀번호 암호화 후 업데이트
	    String encPw = passwordEncoder.encode(vo.getNewPw());
	    repository.bizPwChange(email, encPw);

	    return true;
	}

	// 이메일 중복 확인
	@Override
	public Integer selectBizCntByEmail(String email) {
		return repository.selectBizCntByEmail(email);
	}

	// 사업자 정보 수정
	@Override
	public int updateBizInfo(BizVO vo) {
		return repository.updateBizInfo(vo);		
	}
	
	// 사업자등록증 사진 삭제
	public void updateCertificateDeleted(int id) {
	    repository.updateCertificateDeleted(id);
	}
	
	// 숙소 등록
	@Override
	public void insertAccoOne(AccoVO vo) {
		repository.insertAccoOne(vo);
	}
	
	// 숙소 사진 등록
	@Override
	public void insertAccoPhoto(AccoPhotoVO vo) {
		repository.insertAccoPhoto(vo);
	}

	// 숙소 정보 업데이트
	@Override
	public void updateAccoInfo(AccoVO vo) {
		repository.updateAccoInfo(vo);
	}
	
	// 숙소 조회
	@Override
	public AccoVO selectBizAccoOne(int bizId) {		
		return repository.selectBizAccoOne(bizId);
	}

	// 숙소 삭제여부 조회
	@Override
	public int existsAccoByBizIdAndDelyn(int bizId, String delyn) {
		return repository.existsAccoByBizIdAndDelyn(bizId, delyn);
	}
	
	// 숙소 삭제(delyn만 변경)
	@Override
	public void deleteAccoDelyn(int accoNo) {
		repository.deleteAccoDelyn(accoNo);
	}
	
	// 숙소 삭제 시 해당 숙소 예약 여부 조회
	@Override
	public int reservAccoCount(int accoNo) {
		return repository.reservAccoCount(accoNo);
	}
	
	// 숙소 사진 삭제
	@Override
	public int deleteAccoPhotoByAccoNo(int accoNo) {
		return repository.deleteAccoPhotoByAccoNo(accoNo);
	}
	
	// 내 숙소 등록한 사진 조회
	@Override
	public List<AccoPhotoVO> getPhotosByBizId(int accoNo) {
		return repository.getPhotosByBizId(accoNo);
	}
	
	@Override
	public List<AccoPhotoVO> getPhotosByBizIdAndRoomNo(int accoNo, int roomNo){
		return repository.getPhotosByBizIdAndRoomNo(accoNo, roomNo);
	}
	
	// 객실 등록
	@Override
	public void insertRoomOne(RoomVO vo) {
		repository.insertRoomOne(vo);
	}
	
	// 객실 사진 등록
	@Override
	public void insertRoomPhoto(AccoPhotoVO vo) {
		repository.insertRoomPhoto(vo);
	}
	
	// 객실 1건 삭제
	@Override
	public void deleteRoomByAccoNo(int accoNo, int roomNo) {
		
		repository.deleteAccoPhotoByRoomNo(roomNo);
		
		repository.updateRoomDelYn(accoNo, roomNo);
	
	}
	
	// 객실 삭제 시 해당 객실 예약 여부 조회
	@Override
	public int reservRoomCount(int roomNo) {
		return repository.reservRoomCount(roomNo);
	}

	@Override
	public void updateRoom(RoomVO vo) {
		// TODO Auto-generated method stub
		
	}
	
	// 숙소내 객실 전체 조회
	@Override
	public List<RoomVO> selectRoomsByAccoNo(int accoNo) {
		List<RoomVO> rooms = repository.selectRoomsByAccoNo(accoNo);
		for(RoomVO room : rooms) {
			List<AccoPhotoVO> photos = repository.getPhotosByBizIdAndRoomNo(room.getRoomNo());
			room.setPhotoList(photos);
		}
		return rooms;
	}
	
	// 객실 한건 조회
	@Override
	public RoomVO selectAccoRoomOne(int accoNo) {
		return repository.selectAccoRoomOne(accoNo);
	}
	
	

	@Override
	public List<ReservVO> reservList(BizVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateReservStatus(ReservVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void adminQna(QuestionAttachVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<NoticeVO> myQnaList(NoticeVO vo) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<ReservVO> selectReservList(int bizId, String startDate, String endDate){
		return repository.selectReservList(bizId, startDate, endDate);
	}

	@Override
	public void bizTermSave(List<Integer> termIds, int bizId) {
		
		for(Integer termId : termIds) {
			
			BizTermsVO bizTerm = new BizTermsVO();
			bizTerm.setBizId(bizId);
			bizTerm.setTermId(termId);
			bizTerm.setAgreed(1);
			
			repository.bizTermSave(bizTerm);
			
		}
		
	}

}