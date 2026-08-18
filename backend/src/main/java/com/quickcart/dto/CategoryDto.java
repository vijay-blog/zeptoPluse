package com.quickcart.dto;

import com.quickcart.entity.Category;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CategoryDto {
    private Long id;
    private String name;
    private String description;
    private String imageUrl;
    private boolean active;
    private int displayOrder;

    public static CategoryDto fromEntity(Category category) {
        return CategoryDto.builder()
                .id(category.getId())
                .name(category.getName())
                .description(category.getDescription())
                .imageUrl(category.getImageUrl() != null ? category.getImageUrl() : getEmojiForCategory(category.getName()))
                .active(category.isActive())
                .displayOrder(category.getDisplayOrder())
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
