const mongoose = require('mongoose');
const productSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  description: {
    type: String,
  },
  price: {
    type: Number,
    required: true,
  },
  imageUrl: {
    type: String,
    required: false, // Optional
  }
}, {
  timestamps: true
});

module.exports = mongoose.model('Product', productSchema);





// const productSchema = new mongoose.Schema({
//   name: {
//     type: String,
//     required: true,
//   },
//   description: {
//     type: String,
//   },
//   price: {
//     type: Number,
//     required: true,
//   },
// }, {
//   timestamps: true
// });

// module.exports = mongoose.model('Product', productSchema);
