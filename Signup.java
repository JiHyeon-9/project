package project;

public class Signup {
	
	private String id;
	private String password;
	private String nickname;
	private String message;
	private String photo;
	
	public Signup() {
		
	}
	
	public Signup(String id, String password, String nickname, String message, String photo) {
		this.id = id;
		this.password = password;
		this.nickname = nickname;
		this.message = message;
		this.photo = photo;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	
	
	
}
