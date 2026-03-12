class Product{
  final String name;
  final double price;

  const Product({required this.name,required this.price});
}

class User{
  final String name;
  final String email;

  const User({required this.name,required this.email});
}

const product1=Product(name: 'pen', price: 1000);

const user1=User(name: 'aayush', email: 'aayush@gmail.com');
