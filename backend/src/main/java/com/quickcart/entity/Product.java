package com.quickcart.entity;
import jakarta.persistence.*; import lombok.*;
@Entity @Table(name="products") @Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Product { @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id; @Column(nullable=false) private String name; @Column(length=2000) private String description; private String brand; @ManyToOne(fetch=FetchType.EAGER,optional=false) private Category category; private double mrp; private double sellingPrice; private double discountPercentage; private String unit; private String weight; private String size; private boolean available=true; private int stockQuantity; private String deliveryType; private String imageAsset; }
