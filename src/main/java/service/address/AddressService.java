package service.address;

import model.Address;
import java.util.List;

public interface AddressService {
    List<Address> getAddressesByUser(int userId);
    Address getAddressById(int addressId);
    Address getDefaultAddress(int userId);
    boolean createAddress(Address address);
    boolean updateAddress(Address address);
    boolean deleteAddress(int addressId);
    boolean setDefaultAddress(int userId, int addressId);
    boolean removeDefaultAddress(int userId);
}
