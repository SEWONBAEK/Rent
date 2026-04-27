package com.rent.vaca.user;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class Profile {
	
	@JsonProperty("nickname")
	private String nickname;

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
}

