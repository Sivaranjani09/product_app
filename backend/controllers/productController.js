const Product = require('../models/product');

// GET all products
const getAllProducts = async (req, res) => {
  try {
    const products = await Product.find();
    res.json(products); // Send all products as JSON
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch products', error });
  }
};

// GET single product by ID
const getProductById = async (req, res) => {
  try {
    const product = await Product.findById(req.params.id);
    if (!product) {
      return res.status(404).json({ message: 'Product not found' });
    }
    res.json(product);
  } catch (error) {
    res.status(500).json({ message: 'Error getting product', error });
  }
};

// POST create new product
const createProduct = async (req, res) => {
  try {
    // Destructure request body to get name, description, price, and imageUrl
    const { name, description, price, imageUrl } = req.body;

    // Create new product with the provided data
    const newProduct = new Product({ name, description, price, imageUrl });

    // Save the new product to the database
    const savedProduct = await newProduct.save();
    
    // Send the saved product as a response
    res.status(201).json(savedProduct);
  } catch (error) {
    res.status(400).json({ message: 'Failed to create product', error });
  }
};

// PUT update product by ID
const updateProduct = async (req, res) => {
  try {
    // Destructure request body to get name, description, price, and imageUrl
    const { name, description, price, imageUrl } = req.body;

    // Find and update the product by its ID
    const updatedProduct = await Product.findByIdAndUpdate(
      req.params.id,
      { name, description, price, imageUrl }, // Include imageUrl for updating
      { new: true } // Return the updated product
    );

    if (!updatedProduct) {
      return res.status(404).json({ message: 'Product not found' });
    }

    // Send the updated product as a response
    res.json(updatedProduct);
  } catch (error) {
    res.status(400).json({ message: 'Failed to update product', error });
  }
};

// DELETE product by ID
const deleteProduct = async (req, res) => {
  try {
    const deletedProduct = await Product.findByIdAndDelete(req.params.id);
    if (!deletedProduct) {
      return res.status(404).json({ message: 'Product not found' });
    }
    res.json({ message: 'Product deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Failed to delete product', error });
  }
};

module.exports = {
  getAllProducts,
  getProductById,
  createProduct,
  updateProduct,
  deleteProduct,
};



// const Product = require('../models/product');

// // GET all products
// const getAllProducts = async (req, res) => {
//   try {
//     const products = await Product.find();
//     res.json(products); // Send all products as JSON
//   } catch (error) {
//     res.status(500).json({ message: 'Failed to fetch products', error });
//   }
// };

// // GET single product by ID
// const getProductById = async (req, res) => {
//   try {
//     const product = await Product.findById(req.params.id);
//     if (!product) {
//       return res.status(404).json({ message: 'Product not found' });
//     }
//     res.json(product);
//   } catch (error) {
//     res.status(500).json({ message: 'Error getting product', error });
//   }
// };

// // POST create new product
// const createProduct = async (req, res) => {
//   try {
//     const { name, description, price } = req.body;
//     const newProduct = new Product({ name, description, price });
//     const savedProduct = await newProduct.save();
//     res.status(201).json(savedProduct);
//   } catch (error) {
//     res.status(400).json({ message: 'Failed to create product', error });
//   }
// };

// // PUT update product by ID
// const updateProduct = async (req, res) => {
//   try {
//     const { name, description, price } = req.body;
//     const updatedProduct = await Product.findByIdAndUpdate(
//       req.params.id,
//       { name, description, price },
//       { new: true } // return the updated product
//     );

//     if (!updatedProduct) {
//       return res.status(404).json({ message: 'Product not found' });
//     }

//     res.json(updatedProduct);
//   } catch (error) {
//     res.status(400).json({ message: 'Failed to update product', error });
//   }
// };

// // DELETE product by ID
// const deleteProduct = async (req, res) => {
//   try {
//     const deletedProduct = await Product.findByIdAndDelete(req.params.id);
//     if (!deletedProduct) {
//       return res.status(404).json({ message: 'Product not found' });
//     }
//     res.json({ message: 'Product deleted successfully' });
//   } catch (error) {
//     res.status(500).json({ message: 'Failed to delete product', error });
//   }
// };

// module.exports = {
//   getAllProducts,
//   getProductById,
//   createProduct,
//   updateProduct,
//   deleteProduct,
// };
