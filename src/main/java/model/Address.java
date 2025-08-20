package model;

public class Address {
	private int id;
	private int userId;
	private String recipientName;
	private String phone;
	private String addressLine;
	private boolean isDefault;

	public Address() {}

	public Address(int id, int userId, String recipientName, String phone, String addressLine, boolean isDefault) {
		this.id = id;
		this.userId = userId;
		this.recipientName = recipientName;
		this.phone = phone;
		this.addressLine = addressLine;
		this.isDefault = isDefault;
	}

	public int getId() { return id; }
	public void setId(int id) { this.id = id; }

	public int getUserId() { return userId; }
	public void setUserId(int userId) { this.userId = userId; }

	public String getRecipientName() { return recipientName; }
	public void setRecipientName(String recipientName) { this.recipientName = recipientName; }

	public String getPhone() { return phone; }
	public void setPhone(String phone) { this.phone = phone; }

	public String getAddressLine() { return addressLine; }
	public void setAddressLine(String addressLine) { this.addressLine = addressLine; }

	public boolean isDefault() { return isDefault; }
	public void setDefault(boolean aDefault) { isDefault = aDefault; }
}
