package repository.wishlist;

import model.WishlistItem;
import java.util.List;

public interface WishlistRepository {
    List<WishlistItem> getWishlistByUser(int userId);
    boolean addToWishlist(int userId, int plantId);
    boolean removeFromWishlist(int userId, int plantId);
    boolean isInWishlist(int userId, int plantId);
    int getWishlistCount(int userId);
}
