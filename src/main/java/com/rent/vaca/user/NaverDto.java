package com.rent.vaca.user;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class NaverDto {
	
	String resultCode;
	String message;
	@JsonProperty("response")
	NaverResponse response;
	
	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public NaverResponse getResponse() {
		return response;
	}

	public void setResponse(NaverResponse response) {
		this.response = response;
	}


	public static class NaverResponse{
		@JsonProperty("id")
		private String id;
		
		@JsonProperty("email")
		private String email;
		
		@JsonProperty("name")
		private String name;
		
		@JsonProperty("nickname")
		private String nickname;
		
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getNickname() {
			return nickname;
		}
		public void setNickname(String nickname) {
			this.nickname = nickname;
		}
		@Override
		public String toString() {
			return "NaverResponse [id=" + id + ", email=" + email + ", name=" + name + ", nickname=" + nickname + "]";
		}
	}

	@Override
	public String toString() {
		return "NaverDto [resultCode=" + resultCode + ", message=" + message + ", response=" + response + "]";
	}
}
