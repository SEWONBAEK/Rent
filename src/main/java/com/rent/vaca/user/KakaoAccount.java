package com.rent.vaca.user;

import com.fasterxml.jackson.annotation.JsonProperty;

public class KakaoAccount {
	
	@JsonProperty("email")
	private String email;
	 
	@JsonProperty("profile")
	private Profile profile;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Profile getProfile() {
		return profile;
	}

	public void setProfile(Profile profile) {
		this.profile = profile;
	}
	
}
