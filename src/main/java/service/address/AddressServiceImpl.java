package service.address;

import model.Address;
import repository.address.AddressRepository;
import repository.address.AddressRepositoryImpl;
import java.util.List;

public class AddressServiceImpl implements AddressService {
	private final AddressRepository addressRepository;

	public AddressServiceImpl() {
		this.addressRepository = new AddressRepositoryImpl();
	}

	@Override
	public List<Address> getAddressesByUser(int userId) {
		return addressRepository.getAddressesByUser(userId);
	}

	@Override
	public Address getAddressById(int addressId) {
		return addressRepository.getAddressById(addressId);
	}

	@Override
	public Address getDefaultAddress(int userId) {
		return addressRepository.getDefaultAddress(userId);
	}

	@Override
	public boolean createAddress(Address address) {
		return addressRepository.createAddress(address);
	}

	@Override
	public boolean updateAddress(Address address) {
		return addressRepository.updateAddress(address);
	}

	@Override
	public boolean deleteAddress(int addressId) {
		return addressRepository.deleteAddress(addressId);
	}

	@Override
	public boolean setDefaultAddress(int userId, int addressId) {
		return addressRepository.setDefaultAddress(userId, addressId);
	}

	@Override
	public boolean removeDefaultAddress(int userId) {
		return addressRepository.removeDefaultAddress(userId);
	}
}

