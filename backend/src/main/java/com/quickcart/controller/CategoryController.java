package com.quickcart.controller;

import com.quickcart.dto.CategoryDto;
import com.quickcart.entity.Category;
import com.quickcart.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/categories")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
public class CategoryController {

    private final CategoryRepository categoryRepository;

    @GetMapping
    public ResponseEntity<List<CategoryDto>> getAllCategories() {
        List<Category> categories = categoryRepository.findByActiveTrueOrderByDisplayOrderAsc();
        List<CategoryDto> dtos = categories.stream().map(CategoryDto::fromEntity).toList();
        return ResponseEntity.ok(dtos);
    }
}
