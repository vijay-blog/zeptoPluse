package com.quickcart.entity;
import jakarta.persistence.*; import lombok.*; import java.time.LocalDateTime;
@Entity @Table(name="customers") @Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Customer { @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id; private String name; private String mobile; private String email; private LocalDateTime createdAt; private LocalDateTime updatedAt; @PrePersist void pre(){createdAt=LocalDateTime.now();updatedAt=createdAt;} @PreUpdate void upd(){updatedAt=LocalDateTime.now();} }
