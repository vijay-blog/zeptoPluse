package com.quickcart.service;

import com.quickcart.dto.OrderRequestDto;
import com.quickcart.dto.OrderResponseDto;
import com.quickcart.entity.*;
import com.quickcart.exception.ResourceNotFoundException;
import com.quickcart.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final CustomerRepository customerRepository;
    private final AddressRepository addressRepository;
    private final ProductRepository productRepository;

    @Value("${quickcart.delivery.threshold:499.0}")
    private double deliveryThreshold;

    @Value("${quickcart.delivery.fee:39.0}")
    private double standardDeliveryFee;

    @Transactional
    public OrderResponseDto createOrder(OrderRequestDto requestDto) {
        Customer customer = customerRepository.findById(requestDto.getCustomerId())
                .orElseThrow(() -> new ResourceNotFoundException("Customer not found with id: " + requestDto.getCustomerId()));

        Address address;
        if (requestDto.getAddressId() != null) {
            address = addressRepository.findById(requestDto.getAddressId())
                    .orElseThrow(() -> new ResourceNotFoundException("Address not found with id: " + requestDto.getAddressId()));
        } else if (requestDto.getAddress() != null) {
            var addrDto = requestDto.getAddress();
            address = Address.builder()
                    .customer(customer)
                    .fullName(addrDto.getFullName())
                    .mobile(addrDto.getMobile())
                    .house(addrDto.getHouse())
                    .street(addrDto.getStreet())
                    .area(addrDto.getArea())
                    .city(addrDto.getCity())
                    .state(addrDto.getState())
                    .pincode(addrDto.getPincode())
                    .isDefault(false)
                    .build();
            address = addressRepository.save(address);
        } else {
            throw new IllegalArgumentException("Delivery address is required");
        }

        String addressSnapshot = String.format("%s, %s, %s, %s, %s - %s (Phone: %s)",
                address.getFullName(), address.getHouse(), address.getStreet(),
                address.getArea(), address.getCity(), address.getPincode(), address.getMobile());

        BigDecimal subtotal = BigDecimal.ZERO;
        List<OrderItem> orderItems = new ArrayList<>();

        Order order = Order.builder()
                .orderNumber("QC" + UUID.randomUUID().toString().substring(0, 8).toUpperCase())
                .customer(customer)
                .paymentMethod(Order.PaymentMethod.COD)
                .paymentStatus(Order.PaymentStatus.PENDING)
                .orderStatus(Order.OrderStatus.CREATED)
                .deliveryAddressSnapshot(addressSnapshot)
                .discount(BigDecimal.ZERO)
                .build();

        // Save order first to generate ID for items
        order = orderRepository.save(order);

        for (var itemDto : requestDto.getItems()) {
            Product product = productRepository.findById(itemDto.getProductId())
                    .orElseThrow(() -> new ResourceNotFoundException("Product not found with id: " + itemDto.getProductId()));

            if (!product.isAvailable() || product.getStockQuantity() < itemDto.getQuantity()) {
                throw new IllegalStateException("Product '" + product.name + "' is out of stock or unavailable.");
            }

            // Deduct stock
            product.setStockQuantity(product.getStockQuantity() - itemDto.getQuantity());
            if (product.getStockQuantity() == 0) {
                product.setAvailable(false);
            }
            productRepository.save(product);

            BigDecimal unitPrice = product.getSellingPrice();
            BigDecimal totalPrice = unitPrice.multiply(BigDecimal.valueOf(itemDto.getQuantity()));
            subtotal = subtotal.add(totalPrice);

            OrderItem orderItem = OrderItem.builder()
                    .order(order)
                    .productId(product.getId())
                    .productNameSnapshot(product.getName())
                    .unitPrice(unitPrice)
                    .quantity(itemDto.getQuantity())
                    .totalPrice(totalPrice)
                    .build();
            orderItems.add(orderItem);
        }

        BigDecimal deliveryFee = subtotal.compareTo(BigDecimal.valueOf(deliveryThreshold)) >= 0
                ? BigDecimal.ZERO
                : BigDecimal.valueOf(standardDeliveryFee);

        BigDecimal totalAmount = subtotal.add(deliveryFee);

        order.setSubtotal(subtotal);
        order.setDeliveryFee(deliveryFee);
        order.setTotalAmount(totalAmount);
        order.setOrderItems(orderItems);

        order = orderRepository.save(order);
        return OrderResponseDto.fromEntity(order);
    }

    public List<OrderResponseDto> getOrdersByCustomer(Long customerId) {
        return orderRepository.findByCustomerIdOrderByCreatedAtDesc(customerId)
                .stream().map(OrderResponseDto::fromEntity).toList();
    }

    public OrderResponseDto getOrderById(Long id) {
        Order order = orderRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found with id: " + id));
        return OrderResponseDto.fromEntity(order);
    }

    @Transactional
    public OrderResponseDto updateOrderStatus(Long id, Order.OrderStatus status) {
        Order order = orderRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found with id: " + id));
        order.setOrderStatus(status);
        order = orderRepository.save(order);
        return OrderResponseDto.fromEntity(order);
    }
}
