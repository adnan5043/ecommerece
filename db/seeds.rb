# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


PromoCode.create(code: 'AONETEC', discount: 0.3, valid_til: Date.parse('2023-12-02'))
PromoCode.create(code: 'AZADI', discount: 0.3, valid_til: Date.parse('2023-12-31'))
PromoCode.create(code: 'SALES', discount: 0.3, valid_til: Date.parse('2023-11-11'))
