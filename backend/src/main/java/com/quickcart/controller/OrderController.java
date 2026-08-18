package com.quickcart.controller;

import com.quickcart.dto.OrderRequestDto;
import com.quickcart.dto.OrderResponseDto;
import com.quickcart.entity.Order;
import com.quickcart.service.OrderService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/orders")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    @PostMapping
    public ResponseEntity<OrderResponseDto> createOrder(@Valid @RequestBody OrderRequestDto requestDto) {
        OrderResponseDto response = orderService.createOrder(requestDto);
        return ResponseEntity.ok(response);
    }

    @GetMapping
    public ResponseEntity<List<OrderResponseDto>> getOrders(@RequestParam(required = false) Long customerId) {
        if (customerId == null) {
            customerId = 1L; // Default guest customer ID
        }
        List<OrderResponseDto> orders = orderService.getOrdersByCustomer(customerId);
        return ResponseEntity.ok(orders);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderResponseDto> getOrderById(@PathVariable Long id) {
        OrderResponseDto response = orderService.getOrderById(id);
        return ResponseEntity.ok(response);
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<OrderResponseDto> updateOrderStatus(@PathVariable Long id, @RequestParam Order.OrderStatus status) {
        OrderResponseDto response = orderService.updateOrderStatus(id, status);
        return ResponseEntity.ok(response);
    }
}
