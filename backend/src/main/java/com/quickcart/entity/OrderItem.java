package com.quickcart.entity;
import jakarta.persistence.*; import lombok.*;
@Entity @Table(name="order_items") @Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class OrderItem { @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id; @ManyToOne(fetch=FetchType.LAZY) private CustomerOrder order; @ManyToOne(fetch=FetchType.LAZY) private Product product; private String productNameSnapshot; private double unitPrice; private int quantity; private double totalPrice; }
