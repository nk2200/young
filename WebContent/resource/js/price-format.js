$(document).ready(function() {
    function addCommaToPrice() {
        $(".featured__item__text h5 a").each(function() {
            var priceText = $(this).text().replace(/[^\d]/g, ''); // 숫자만 추출
            var formattedPrice = formatPrice(priceText); // 가격에 콤마 추가
            $(this).text(formattedPrice + '원'); // 콤마 추가된 가격으로 텍스트 변경
        });
        
        $(".featured__item__text h5").each(function() {
            var priceText = $(this).text().replace(/[^\d]/g, ''); // 숫자만 추출
            var formattedPrice = formatPrice(priceText); // 가격에 콤마 추가
            $(this).text(formattedPrice + '원'); // 콤마 추가된 가격으로 텍스트 변경
        });

        $(".shoping__cart__total .order-total-price").each(function() {
            var priceText = $(this).text().replace(/[^\d]/g, ''); // 숫자만 추출
            var formattedPrice = formatPrice(priceText); // 가격에 콤마 추가
            $(this).text(formattedPrice + '원'); // 콤마 추가된 가격으로 텍스트 변경
        });
    }

    function formatPrice(price) {
        return price.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    addCommaToPrice();
});
