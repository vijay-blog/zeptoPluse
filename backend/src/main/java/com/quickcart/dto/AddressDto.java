package com.quickcart.dto;

import com.quickcart.entity.Address;
import jakarta.validation.constraints.NotBlank;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AddressDto {
    private Long id;
    private Long customerId;
    @NotBlank(message = "Full name is required")
    private String fullName;
    @NotBlank(message = "Mobile number is required")
    private String mobile;
    @NotBlank(message = "House/Flat is required")
    private String house;
    private String street;
    @NotBlank(message = "Area is required")
    private String area;
    @NotBlank(message = "City is required")
    private String city;
    @NotBlank(message = "State is required")
    private String state;
    @NotBlank(message = "Pincode is required")
    private String pincode;
    private Double latitude;
    private Double longitude;
    private boolean isDefault;

    public static AddressDto fromEntity(Address address) {
        return AddressDto.builder()
                .id(address.getId())
                .customerId(address.getCustomer() != null ? address.getCustomer().getId() : null)
                .fullName(address.getFullName())
                .mobile(address.getMobile())
                .house(address.getHouse())
                .street(address.getStreet())
                .area(address.getArea())
                .city(address.getCity())
                .state(address.getState())
                .pincode(address.getPincode())
                .latitude(address.getLatitude())
                .longitude(address.getLongitude())
                .isDefault(address.isDefault())
                .build();
    }
}
