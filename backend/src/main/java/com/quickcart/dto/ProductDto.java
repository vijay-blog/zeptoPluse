package com.quickcart.dto;

import com.quickcart.entity.Product;
import lombok.Builder;
import lombok.Data;
import java.math.BigDecimal;

@Data
@Builder
public class ProductDto {
    private Long id;
    private String name;
    private String description;
    private String brand;
    private Long categoryId;
    private String categoryName;
    private BigDecimal mrp;
    private BigDecimal sellingPrice;
    private BigDecimal discountPercentage;
    private String unit;
    private Double weight;
    private boolean available;
    private int stockQuantity;
    private Product.DeliveryType deliveryType;
    private String image; // Primary image emoji/url placeholder

    public static ProductDto fromEntity(Product product) {
        return ProductDto.builder()
                .id(product.getId())
                .name(product.getName())
                .description(product.getDescription())
                .brand(product.getBrand())
                .categoryId(product.getCategory() != null ? product.getCategory().getId() : null)
                .categoryName(product.getCategory() != null ? product.getCategory().getName() : "General")
                .mrp(product.getMrp())
                .sellingPrice(product.getSellingPrice())
                .discountPercentage(product.getDiscountPercentage())
                .unit(product.getUnit())
                .weight(product.getWeight())
                .available(product.isAvailable())
                .stockQuantity(product.getStockQuantity())
                .deliveryType(product.getDeliveryType())
                .image(product.getCategory() != null ? getEmojiForCategory(product.getCategory().getName()) : "📦")
                .build();
    }

    private static String getEmojiForCategory(String category) {
        switch (category.toLowerCase()) {
            case "grocery": return "🛒";
            case "vegetables": return "🥦";
            case "fruits": return "🍎";
            case "meat / non-veg": return "🍗";
            case "dairy": return "🥛";
            case "baby": return "👶";
            case "men": return "👔";
            case "women": return "👗";
            case "boys": return "🧒";
            case "girls": return "👧";
            case "clothing": return "👕";
            case "electronics": return "📱";
            case "mobile": return "📲";
            case "laptop": return "💻";
            case "tv": return "📺";
            case "ac": return "❄️";
            case "refrigerator": return "🧊";
            case "washing machine": return "🫧";
            case "furniture": return "🛋️";
            case "sofa": return "🛋️";
            case "bed": return "🛏️";
            case "home & kitchen": return "🍳";
            case "beauty": return "✨";
            case "medicine": return "💊";
            default: return "📦";
        }
    }
}
