const express = require('express');
const router = express.Router();
const {
  getAllProducts,
  getProductById,
  createProduct,
  updateProduct,
  deleteProduct,
} = require('../controllers/productController');

// Route: GET all products
router.get('/', getAllProducts);

// Route: GET single product by ID
router.get('/:id', getProductById);

// Route: POST create new product
router.post('/', createProduct);

// Route: PUT update product by ID
router.put('/:id', updateProduct);

// Route: DELETE product by ID
router.delete('/:id', deleteProduct);

module.exports = router;
