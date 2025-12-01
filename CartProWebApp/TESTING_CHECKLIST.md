# CartPro - Testing Checklist

## Pre-Testing Setup
- [ ] Open CartProWebApp.sln in Visual Studio
- [ ] Build the solution (Ctrl+Shift+B)
- [ ] Verify no build errors
- [ ] Press F5 to run the application

## Page Testing

### 1. Home Page (Default.aspx)
- [ ] Page loads successfully
- [ ] Header navigation is visible
- [ ] Hero section displays correctly
- [ ] Product section shows 3 products
- [ ] "Why Choose Us" section displays
- [ ] "Elevate Your Style" section displays
- [ ] Popular products section shows
- [ ] Testimonial slider works
- [ ] Footer displays correctly
- [ ] All images load properly

### 2. Shop Page (Shop.aspx)
- [ ] Page loads successfully
- [ ] All 12 products display
- [ ] Product images load
- [ ] Product prices show
- [ ] Hover effects work on products
- [ ] Category dropdown in header works

### 3. Cart Page (Cart.aspx)
- [ ] Page loads successfully
- [ ] Cart table displays
- [ ] Quantity buttons (+/-) work
- [ ] Update Cart button is visible
- [ ] Continue Shopping button works
- [ ] Coupon input field works
- [ ] Cart totals display
- [ ] Proceed to Checkout button works

### 4. Checkout Page (Checkout.aspx)
- [ ] Page loads successfully
- [ ] Billing details form displays
- [ ] All form fields are present
- [ ] Country dropdown works
- [ ] Coupon code section works
- [ ] Order summary displays
- [ ] Payment method options show
- [ ] Place Order button works
- [ ] Redirects to Thank You page

### 5. About Page (About.aspx)
- [ ] Page loads successfully
- [ ] Hero section displays
- [ ] "Why Choose Us" section shows
- [ ] Team section displays with 3 members
- [ ] Team member images load
- [ ] Testimonial slider works

### 6. Contact Page (Contact.aspx)
- [ ] Page loads successfully
- [ ] Contact information displays
- [ ] Contact form is present
- [ ] All form fields work
- [ ] Send Message button is functional

### 7. Services Page (Services.aspx)
- [ ] Page loads successfully
- [ ] Hero section displays
- [ ] Service features show (8 items)
- [ ] Product section displays
- [ ] All icons load properly

### 8. Login Page (Login.aspx)
- [ ] Page loads successfully
- [ ] Login form displays
- [ ] Username field works
- [ ] Password field works
- [ ] Login button is functional
- [ ] Link to Registration page works

### 9. Registration Page (Registration.aspx)
- [ ] Page loads successfully
- [ ] Registration form displays
- [ ] All form fields work
- [ ] Register button is functional
- [ ] Link to Login page works

### 10. Profile Page (ViewProfile.aspx)
- [ ] Page loads successfully
- [ ] Profile form displays
- [ ] All fields are editable
- [ ] Update Profile button works

### 11. Thank You Page (ThankYou.aspx)
- [ ] Page loads successfully
- [ ] Success icon displays
- [ ] Thank you message shows
- [ ] Back to Shop button works

### 12. Logout (Logout.aspx)
- [ ] Redirects to home page
- [ ] Session is cleared

## Navigation Testing

### Header Navigation
- [ ] Logo links to home page
- [ ] Home link works
- [ ] Shop dropdown works
  - [ ] Watches category link
  - [ ] Shoes category link
  - [ ] Belts category link
  - [ ] Perfumes category link
  - [ ] View All Products link
- [ ] About us link works
- [ ] Services link works
- [ ] Contact us link works
- [ ] User dropdown works
  - [ ] Login link
  - [ ] Registration link
  - [ ] Profile Update link
  - [ ] Logout link
- [ ] Cart icon link works

### Footer Navigation
- [ ] Newsletter subscription form displays
- [ ] Social media icons present
- [ ] Footer links work
- [ ] Copyright notice displays

## Responsive Design Testing
- [ ] Test on desktop (1920x1080)
- [ ] Test on laptop (1366x768)
- [ ] Test on tablet (768x1024)
- [ ] Test on mobile (375x667)
- [ ] Navigation collapses on mobile
- [ ] All content is readable on mobile
- [ ] Images scale properly

## Browser Compatibility
- [ ] Test in Chrome
- [ ] Test in Firefox
- [ ] Test in Edge
- [ ] Test in Safari (if available)

## Functionality Testing
- [ ] All buttons are clickable
- [ ] All links navigate correctly
- [ ] Forms can be submitted
- [ ] Dropdowns work properly
- [ ] Sliders/carousels function
- [ ] Hover effects work
- [ ] No JavaScript errors in console

## Performance Testing
- [ ] Pages load within 3 seconds
- [ ] Images are optimized
- [ ] No broken links
- [ ] No 404 errors
- [ ] CSS loads properly
- [ ] JavaScript loads properly

## Visual Testing
- [ ] Layout is consistent across pages
- [ ] Colors match design
- [ ] Fonts are correct
- [ ] Spacing is appropriate
- [ ] Images are not distorted
- [ ] Icons display correctly

## Issues Found
Document any issues here:

1. 
2. 
3. 

## Testing Completed By
- Name: _______________
- Date: _______________
- Signature: _______________

## Notes
- All tests should be performed after building the solution
- Report any errors or warnings in Visual Studio
- Check browser console for JavaScript errors
- Verify all static assets load correctly

---
**Status**: [ ] All Tests Passed  [ ] Issues Found  [ ] Needs Retesting
