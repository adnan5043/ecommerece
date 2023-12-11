// function checkPromoCode() {
//   const promoCode = document.getElementById('promoCode').value;

//   // Make AJAX request to Rails backend
//   fetch('/check_promo_code', {
//     method: 'POST',
//     headers: {
//       'Content-Type': 'application/json',
//       'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
//     },
//     body: JSON.stringify({ promoCode: promoCode })
//   })
//   .then(response => response.json())
//   .then(data => {
//     // Update UI with discount value
//     document.getElementById('discountResult').innerText = data.discount ? `Discount: ${data.discount * 100}%` : 'Invalid Promo Code';
//   })
//   .catch(error => console.error('Error:', error));
// }
