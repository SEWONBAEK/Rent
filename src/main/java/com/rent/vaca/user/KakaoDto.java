package com.rent.vaca.user;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class KakaoDto {

	@JsonProperty("id")
	private long id;
	
	@JsonProperty("kakao_account")
	private KakaoAccount kakaoAccount;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public KakaoAccount getKakaoAccount() {
		return kakaoAccount;
	}

	public void setKakaoAccount(KakaoAccount kakaoAccount) {
		this.kakaoAccount = kakaoAccount;
	}
	
}
