package com.quickcart.dto;

import com.quickcart.entity.Order;
import lombok.Builder;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Data
@Builder
public class OrderResponseDto {
    private Long id;
    private String orderNumber;
    private Long customerId;
    private BigDecimal subtotal;
    private BigDecimal deliveryFee;
    private BigDecimal discount;
    private BigDecimal totalAmount;
    private String paymentMethod;
    private String paymentStatus;
    private String orderStatus;
    private String deliveryAddressSnapshot;
    private List<OrderItemResponseDto> items;
    private LocalDateTime createdAt;

    @Data
    @Builder
    public static class OrderItemResponseDto {
        private Long id;
        private Long productId;
        private String productNameSnapshot;
        private BigDecimal unitPrice;
        private int quantity;
        private BigDecimal totalPrice;
    }

    public static OrderResponseDto fromEntity(Order order) {
        List<OrderItemResponseDto> itemDtos = null;
        if (order.getOrderItems() != null) {
            itemDtos = order.getOrderItems().stream().map(item -> OrderItemResponseDto.builder()
                    .id(item.getId())
                    .productId(item.getProductId())
                    .productNameSnapshot(item.getProductNameSnapshot())
                    .unitPrice(item.getUnitPrice())
                    .quantity(item.getQuantity())
                    .totalPrice(item.getTotalPrice())
                    .build()).collect(Collectors.toList());
        }

        return OrderResponseDto.builder()
                .id(order.getId())
                .orderNumber(order.getOrderNumber())
                .customerId(order.getCustomer() != null ? order.getCustomer().getId() : null)
                .subtotal(order.getSubtotal())
                .deliveryFee(order.getDeliveryFee())
                .discount(order.getDiscount())
                .totalAmount(order.getTotalAmount())
                .paymentMethod(order.getPaymentMethod().name())
                .paymentStatus(order.getPaymentStatus().name())
                .orderStatus(order.getOrderStatus().name())
                .deliveryAddressSnapshot(order.getDeliveryAddressSnapshot())
                .items(itemDtos)
                .createdAt(order.getCreatedAt())
                .build();
    }
}
