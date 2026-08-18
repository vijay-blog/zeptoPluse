package com.quickcart.config;

import com.quickcart.entity.Category;
import com.quickcart.entity.Customer;
import com.quickcart.entity.Product;
import com.quickcart.repository.CategoryRepository;
import com.quickcart.repository.CustomerRepository;
import com.quickcart.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;

@Component
@RequiredArgsConstructor
public class DataSeeder implements CommandLineRunner {

    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;
    private final CustomerRepository customerRepository;

    @Override
    public void run(String... args) throws Exception {
        if (customerRepository.findByMobile("9876543210").isEmpty()) {
            Customer guest = Customer.builder()
                    .name("Raghupathi (Guest)")
                    .mobile("9876543210")
                    .email("guest.quickcart@hyderabad.in")
                    .build();
            customerRepository.save(guest);
        }

        if (categoryRepository.count() == 0) {
            seedCategoriesAndProducts();
        }
    }

    private void seedCategoriesAndProducts() {
        var catGrocery = createCategory("Grocery", "Daily grocery essentials", 1);
        var catVeg = createCategory("Vegetables", "Fresh farm vegetables", 2);
        var catFruit = createCategory("Fruits", "Fresh juicy fruits", 3);
        var catDairy = createCategory("Dairy", "Milk, curd, butter & paneer", 4);
        var catMeat = createCategory("Meat / Non-Veg", "Fresh chicken, mutton & fish", 5);
        var catBaby = createCategory("Baby", "Diapers, wipes & baby care", 6);
        var catMen = createCategory("Men", "Apparel & fashion for men", 7);
        var catWomen = createCategory("Women", "Apparel & ethnic wear for women", 8);
        var catBoys = createCategory("Boys", "Kids clothing for boys", 9);
        var catGirls = createCategory("Girls", "Kids clothing for girls", 10);
        var catClothing = createCategory("Clothing", "General apparel", 11);
        var catElec = createCategory("Electronics", "Gadgets & accessories", 12);
        var catMobile = createCategory("Mobile", "Smartphones & tablets", 13);
        var catLaptop = createCategory("Laptop", "Business & gaming laptops", 14);
        var catTv = createCategory("TV", "Smart 4K televisions", 15);
        var catAc = createCategory("AC", "Inverter split air conditioners", 16);
        var catFridge = createCategory("Refrigerator", "Double door & single door fridges", 17);
        var catWashing = createCategory("Washing Machine", "Front load & top load washers", 18);
        var catFurn = createCategory("Furniture", "Sofas, beds & tables", 19);
        var catSofa = createCategory("Sofa", "Living room sofas", 20);
        var catBed = createCategory("Bed", "Comfortable bedroom beds", 21);
        var catHome = createCategory("Home & Kitchen", "Cookware & appliances", 22);
        var catBeauty = createCategory("Beauty", "Skincare & cosmetics", 23);
        var catMed = createCategory("Medicine", "Healthcare & OTC essentials", 24);
        var catOther = createCategory("Other", "Miscellaneous daily use items", 25);

        // Seed 50+ realistic products
        // Grocery
        createProduct("India Gate Basmati Rice 5kg", "Premium long grain basmati rice.", "India Gate", catGrocery, 599, 499, "5 kg", 5.0, 100, Product.DeliveryType.SMALL);
        createProduct("Aashirvaad Chakki Atta 5kg", "100% whole wheat flour.", "Aashirvaad", catGrocery, 320, 285, "5 kg", 5.0, 150, Product.DeliveryType.SMALL);
        createProduct("Fortune Sunlite Sunflower Oil 1L", "Light and healthy cooking oil.", "Fortune", 160, 135, "1 L", 1.0, 200, Product.DeliveryType.SMALL);
        createProduct("Tata Salt 1kg", "Vacuum evaporated iodised salt.", "Tata", 28, 25, "1 kg", 1.0, 300, Product.DeliveryType.SMALL);
        createProduct("Toor Dal 1kg", "Cleaned and sorted split yellow pigeon peas.", "QuickCart Fresh", 150, 125, "1 kg", 1.0, 120, Product.DeliveryType.SMALL);

        // Vegetables
        createProduct("Fresh Hybrid Tomato", "Locally sourced juicy tomatoes.", "FarmFresh", 50, 42, "1 kg", 1.0, 80, Product.DeliveryType.SMALL);
        createProduct("Fresh Potato", "New crop potatoes from local farms.", "FarmFresh", 45, 38, "1 kg", 1.0, 100, Product.DeliveryType.SMALL);
        createProduct("Red Onion", "Fresh crispy onions.", "FarmFresh", 60, 48, "1 kg", 1.0, 90, Product.DeliveryType.SMALL);
        createProduct("Fresh Cauliflower", "Tender white cauliflower.", "FarmFresh", 40, 32, "1 piece", 0.5, 60, Product.DeliveryType.SMALL);
        createProduct("Green Chillies", "Spicy farm-fresh green chillies.", "FarmFresh", 25, 20, "250 g", 0.25, 70, Product.DeliveryType.SMALL);

        // Fruits
        createProduct("Robusta Banana", "Ripe energetic yellow bananas.", "Orchard", 65, 55, "1 dozen", 1.0, 100, Product.DeliveryType.SMALL);
        createProduct("Shimla Apple", "Crisp and sweet red apples.", "Orchard", 180, 149, "1 kg", 1.0, 75, Product.DeliveryType.SMALL);
        createProduct("Nagpur Orange", "Juicy citrus oranges.", "Orchard", 120, 99, "1 kg", 1.0, 60, Product.DeliveryType.SMALL);
        createProduct("Pomegranate", "Fresh ruby red pomegranate arils.", "Orchard", 220, 189, "1 kg", 1.0, 50, Product.DeliveryType.SMALL);

        // Dairy
        createProduct("Amul Fresh Cow Milk 500ml", "Pasteurised fresh milk.", "Amul", 32, 30, "500 ml", 0.5, 200, Product.DeliveryType.SMALL);
        createProduct("Amul Butter 500g", "Delicious table butter.", "Amul", 275, 260, "500 g", 0.5, 90, Product.DeliveryType.SMALL);
        createProduct("Milky Mist Paneer 200g", "Soft and fresh cooking paneer.", "Milky Mist", 130, 115, "200 g", 0.2, 80, Product.DeliveryType.SMALL);
        createProduct("Amul Masti Curd 400g", "Thick and creamy set curd.", "Amul", 45, 40, "400 g", 0.4, 110, Product.DeliveryType.SMALL);

        // Meat / Non-Veg
        createProduct("Chicken Curry Cut 500g", "Antibiotic-free tender chicken pieces.", "FreshToHome", 280, 249, "500 g", 0.5, 50, Product.DeliveryType.SMALL);
        createProduct("Fresh Mutton Bone-In 500g", "Juicy tender mutton chunks.", "FreshToHome", 450, 419, "500 g", 0.5, 30, Product.DeliveryType.SMALL);
        createProduct("Rohu Fish Cleaned 500g", "Fresh river fish steaks.", "FreshToHome", 220, 195, "500 g", 0.5, 40, Product.DeliveryType.SMALL);

        // Baby
        createProduct("Pampers Baby Diaper Pants", "Soft diaper pants with 12hr absorption.", "Pampers", 799, 699, "Pack of 32", 1.2, 60, Product.DeliveryType.SMALL);
        createProduct("Johnson's Baby Wipes", "Gentle cleansing baby wipes with aloe vera.", "Johnson's", 199, 169, "80 wipes", 0.4, 80, Product.DeliveryType.SMALL);
        createProduct("Cerelac Wheat Apple 300g", "Nutritious infant cereal stage 3.", "Nestle", 275, 250, "300 g", 0.3, 70, Product.DeliveryType.SMALL);

        // Men & Women Clothing
        createProduct("Men Solid Cotton T-Shirt", "100% combed cotton crew neck tee.", "Roadster", 799, 499, "1 piece", 0.3, 100, Product.DeliveryType.SMALL);
        createProduct("Men Slim Fit Blue Jeans", "Stretchable comfortable denim jeans.", "Levis", 2499, 1599, "1 piece", 0.7, 50, Product.DeliveryType.SMALL);
        createProduct("Women Floral Casual Dress", "Elegant breathable summer dress.", "SASSAFRAS", 1499, 899, "1 piece", 0.4, 60, Product.DeliveryType.SMALL);
        createProduct("Women Ethnic Kurta Set", "Cotton printed kurta with pant & dupatta.", "Libas", 2299, 1299, "1 set", 0.6, 45, Product.DeliveryType.SMALL);

        // Electronics, Mobile, Laptop, TV, AC, Fridge, Washing Machine
        createProduct("boAt Rockerz Wireless Earbuds", "Immersive sound with 40H playback.", "boAt", 1999, 1299, "1 unit", 0.2, 80, Product.DeliveryType.SMALL);
        createProduct("OnePlus Nord CE 5G Smartphone", "Fluid AMOLED display, fast charging.", "OnePlus", 24999, 21999, "1 unit", 0.4, 25, Product.DeliveryType.MEDIUM);
        createProduct("Dell Inspiron 15 Business Laptop", "Intel Core i5, 16GB RAM, 512GB SSD.", "Dell", 62999, 54999, "1 unit", 1.8, 15, Product.DeliveryType.MEDIUM);
        createProduct("Samsung 55-inch Crystal 4K Smart TV", "PurColor 4K UHD smart LED television.", "Samsung", 45999, 36999, "1 unit", 14.0, 10, Product.DeliveryType.LARGE);
        createProduct("LG 1.5 Ton 5 Star Inverter Split AC", "AI convertible cooling AC.", "LG", 52999, 39999, "1 unit", 35.0, 8, Product.DeliveryType.LARGE);
        createProduct("Whirlpool 265L 3 Star Frost Free Refrigerator", "Intelligent inverter technology fridge.", "Whirlpool", 31999, 24999, "1 unit", 52.0, 12, Product.DeliveryType.HEAVY);
        createProduct("Bosch 7kg Front Load Washing Machine", "Fully automatic with heater.", "Bosch", 3499-9, 28999, "1 unit", 64.0, 10, Product.DeliveryType.HEAVY);

        // Furniture
        createProduct("Wakefit 3-Seater Fabric Sofa", "Ergonomic plush comfort living room sofa.", "Wakefit", 2499-9, 18999, "1 unit", 45.0, 6, Product.DeliveryType.HEAVY);
        createProduct("Wakefit Queen Size Sheesham Bed", "Solid wood engineered bed with storage.", "Wakefit", 28999, 21999, "1 unit", 75.0, 5, Product.DeliveryType.HEAVY);

        // Home & Kitchen, Beauty, Medicine
        createProduct("Pigeon Non-Stick Cookware Set", "Kadai, fry pan and flat dosa tava combo.", "Pigeon", 1999, 1199, "3 pieces", 2.1, 40, Product.DeliveryType.MEDIUM);
        createProduct("Mamaearth Vitamin C Face Wash", "Brightening face wash with turmeric.", "Mamaearth", 399, 349, "150 ml", 0.2, 90, Product.DeliveryType.SMALL);
        createProduct("Omron Digital Clinical Thermometer", "Fast and accurate digital fever check.", "Omron", 299, 199, "1 unit", 0.1, 100, Product.DeliveryType.SMALL);
        createProduct("Dettol Antiseptic Liquid 550ml", "First aid disinfectant liquid.", "Dettol", 210, 185, "550 ml", 0.6, 120, Product.DeliveryType.SMALL);
    }

    private Category createCategory(String name, String desc, int order) {
        Category cat = Category.builder()
                .name(name)
                .description(desc)
                .active(true)
                .displayOrder(order)
                .build();
        return categoryRepository.save(cat);
    }

    private void createProduct(String name, String desc, String brand, Category cat, double mrp, double selling, String unit, double weight, int stock, Product.DeliveryType deliveryType) {
        BigDecimal mrpDec = BigDecimal.valueOf(mrp);
        BigDecimal sellingDec = BigDecimal.valueOf(selling);
        BigDecimal discount = mrpDec.subtract(sellingDec)
                .divide(mrpDec, 2, java.math.RoundingMode.HALF_UP)
                .multiply(BigDecimal.valueOf(100));

        Product product = Product.builder()
                .name(name)
                .description(desc)
                .brand(brand)
                .category(cat)
                .mrp(mrpDec)
                .sellingPrice(sellingDec)
                .discountPercentage(discount)
                .unit(unit)
                .weight(weight)
                .available(true)
                .stockQuantity(stock)
                .deliveryType(deliveryType)
                .build();
        productRepository.save(product);
    }
}
