// هذا السكريبت يحدث النتائج كل 5 ثواني بمحاكاة (في نسخة حقيقية يجب جلب النتائج من API)
document.addEventListener("DOMContentLoaded", function() {
    setInterval(function() {
        // مثال عشوائي: (ممكن تغييره لطلب حقيقي من سيرفر)
        const dogCount = Math.floor(Math.random() * 100);
        const catCount = Math.floor(Math.random() * 100);

        document.getElementById("dogCount").textContent = dogCount;
        document.getElementById("catCount").textContent = catCount;
    }, 5000);
});
