package com.quickcart.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "categories")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String name;

    private String description;
    
    @Column(name = "image_url")
    private String imageUrl;

    @Builder.Default
    private boolean active = true;

    @Column(name = "display_order")
    private int displayOrder;
}
