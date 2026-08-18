package com.quickcart.controller;

import com.quickcart.dto.ProductDto;
import com.quickcart.entity.Product;
import com.quickcart.exception.ResourceNotFoundException;
import com.quickcart.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/products")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class ProductController {

    private final ProductRepository productRepository;

    @GetMapping
    public ResponseEntity<List<ProductDto>> getAllProducts(
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) String search,
            @RequestParam(required = false, defaultValue = "1") int page,
            @RequestParam(required = false, defaultValue = "50") int pageSize) {
        List<Product> products;
        if (search != null && !search.trim().isEmpty()) {
            products = productRepository.searchProducts(search.trim());
        } else if (categoryId != null) {
            products = productRepository.findByCategoryId(categoryId);
        } else {
            products = productRepository.findAll();
        }
        List<ProductDto> dtos = products.stream().map(ProductDto::fromEntity).toList();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductDto> getProductById(@PathVariable Long id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with id: " + id));
        return ResponseEntity.ok(ProductDto.fromEntity(product));
    }

    @GetMapping("/category/{categoryId}")
    public ResponseEntity<ProductDto>> getProductsByCategory(@PathVariable Long categoryId) {
        List<Product> products = productRepository.findByCategoryId(categoryId);
        List<ProductDto> dtos = products.stream().map(ProductDto::fromEntity).toList();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/search")
    public ResponseEntity<List<ProductDto>> searchProducts(@RequestParam("query") String query) {
        List<Product> products = productRepository.searchProducts(query);
        List<ProductDto> dtos = products.stream().map(ProductDto::fromEntity).toList();
        return ResponseEntity.ok(dtos);
    }
}
