$(document).ready(function() {
  function handleQuantityChange() {
    var quantity = $(this).val();
    var price = parseFloat($(this).closest('.card-body').find('.subtotal').data('price'));
    var subtotal = (quantity * price).toFixed(2);
    $(this).closest('.card-body').find('.subtotal').text(subtotal);
    $(this).closest('form').find('.hidden-update-btn').click();
    updateUI();
  }
  function updateUI() {
    var total = 0;
    $('.subtotal').each(function() {
      total += parseFloat($(this).text());
    });
    var discountResult = $('#discountResult');
    var discountValue = parseFloat(discountResult.data('discount'));
    if (!isNaN(discountValue) && discountValue > 0) {
      total *= (1 - discountValue);
      discountResult.text('Discount Applied: ' + (discountValue * 100) + '%');
    } else {
      discountResult.text('');
    }

    $('.total-value').text(total.toFixed(2));
  }

  $('.quantity-input').on('input', handleQuantityChange);
  $('.delete-link').on('ajax:complete', function(event, xhr, status) {
    if (status === 'success') {
      updateUI();
    }
  });
  function updateDiscountResult(discountValue) {
    var discountResult = $('#discountResult');
    if (!isNaN(discountValue) && discountValue > 0) {
      discountResult.text('Discount Applied: ' + (discountValue * 100) + '%');
    } else {
      discountResult.text('');
    }
  }
  // Function to check promo code
  function checkPromoCode() {
    const promoCode = $('#promoCode').val();
    console.log("Checking Promo Code:", promoCode);
    fetch('/check_promo_code', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ promoCode: promoCode })
    })
      .then(response => response.json())
      .then(data => {
        console.log("Response Data:", data);
        $('#discountResult').data('discount', data.discount);
        updateDiscountResult(data.discount);
        updateUI();
      })
      .catch(error => {
        console.error('Error:', error);
      });
  }
  $('#promoForm button').on('click', checkPromoCode);
});

