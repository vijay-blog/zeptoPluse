package com.quickcart.entity;
import jakarta.persistence.*; import lombok.*;
@Entity @Table(name="addresses") @Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Address { @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id; @ManyToOne(fetch=FetchType.LAZY) private Customer customer; private String fullName,mobile,house,street,area,city,state,pincode; private Double latitude,longitude; private boolean isDefault; }
