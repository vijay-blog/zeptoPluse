package com.quickcart.controller;

import com.quickcart.dto.AddressDto;
import com.quickcart.entity.Address;
import com.quickcart.entity.Customer;
import com.quickcart.exception.ResourceNotFoundException;
import com.quickcart.repository.AddressRepository;
import com.quickcart.repository.CustomerRepository;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class AddressController {

    private final AddressRepository addressRepository;
    private final CustomerRepository customerRepository;

    @GetMapping("/customers/{customerId}/addresses")
    public ResponseEntity<List<AddressDto>> getAddressesByCustomer(@PathVariable Long customerId) {
        List<Address> addresses = addressRepository.findByCustomerId(customerId);
        return ResponseEntity.ok(addresses.stream().map(AddressDto::fromEntity).toList());
    }

    @PostMapping("/customers/{customerId}/addresses")
    public ResponseEntity<AddressDto> createAddress(@PathVariable Long customerId, @Valid @RequestBody AddressDto dto) {
        Customer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new ResourceNotFoundException("Customer not found with id: " + customerId));

        Address address = Address.builder()
                .customer(customer)
                .fullName(dto.getFullName())
                .mobile(dto.getMobile())
                .house(dto.getHouse())
                .street(dto.getStreet())
                .area(dto.getArea())
                .city(dto.getCity())
                .state(dto.getState())
                .pincode(dto.getPincode())
                .isDefault(dto.isDefault())
                .build();

        Address saved = addressRepository.save(address);
        return ResponseEntity.ok(AddressDto.fromEntity(saved));
    }

    @PutMapping("/addresses/{id}")
    public ResponseEntity<AddressDto> updateAddress(@PathVariable Long id, @Valid @RequestBody AddressDto dto) {
        Address address = addressRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Address not found with id: " + id));

        address.setFullName(dto.getFullName());
        address.setMobile(dto.getMobile());
        address.setHouse(dto.getHouse());
        address.setStreet(dto.getStreet());
        address.setArea(dto.getArea());
        address.setCity(dto.getCity());
        address.setState(dto.getState());
        address.setPincode(dto.getPincode());
        address.setDefault(dto.isDefault());

        Address updated = addressRepository.save(address);
        return ResponseEntity.ok(AddressDto.fromEntity(updated));
    }

    @DeleteMapping("/addresses/{id}")
    public ResponseEntity<Void> deleteAddress(@PathVariable Long id) {
        if (!addressRepository.existsById(id)) {
            throw new ResourceNotFoundException("Address not found with id: " + id);
        }
        addressRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }
}
