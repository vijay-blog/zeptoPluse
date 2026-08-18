package com.quickcart.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import java.util.List;

@Data
public class OrderRequestDto {
    @NotNull(message = "Customer ID is required")
    private Long customerId;

    private Long addressId;

    private AddressDto address; // If new address provided inline

    @NotEmpty(message = "Order items cannot be empty")
    private List<OrderItemDto> items;

    @Data
    public static class OrderItemDto {
        @NotNull(message = "Product ID is required")
        private Long productId;

        @NotNull(message = "Quantity is required")
        private Integer quantity;
    }
}
