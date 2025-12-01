// js/main.js

document.addEventListener('DOMContentLoaded', () => {

    // =========================================================================
    // MOCK DATA (Dummy data for demonstration)
    // =========================================================================
    const mockData = {
        products: [
            { id: 1, name: 'Wireless Bluetooth Headphones', sku: 'SKU-001', category: 'Electronics', price: 79.99, stock: 150, status: 'instock' },
            { id: 2, name: 'Men\'s Running Shoes', sku: 'SKU-002', category: 'Footwear', price: 120.50, stock: 8, status: 'lowstock' },
            { id: 3, name: 'Smart Fitness Tracker', sku: 'SKU-003', category: 'Electronics', price: 49.95, stock: 200, status: 'instock' },
            { id: 4, name: 'Cotton T-Shirt Pack', sku: 'SKU-004', category: 'Clothing', price: 29.99, stock: 0, status: 'outofstock' },
            { id: 5, name: 'Professional Football', sku: 'SKU-005', category: 'Sports', price: 35.00, stock: 75, status: 'instock' },
            { id: 6, name: 'Yoga Mat', sku: 'SKU-006', category: 'Sports', price: 25.00, stock: 120, status: 'instock' },
            { id: 7, name: 'Leather Wallet', sku: 'SKU-007', category: 'Accessories', price: 45.00, stock: 5, status: 'lowstock' },
            { id: 8, name: 'HD Webcam', sku: 'SKU-008', category: 'Electronics', price: 89.99, stock: 0, status: 'outofstock' },
        ],
        orders: [
            { id: '#1234', customer: 'John Doe', date: '2025-10-08', total: 125.50, payment: 'Paid', status: 'delivered' },
            { id: '#1235', customer: 'Sarah Smith', date: '2025-10-09', total: 49.95, payment: 'Paid', status: 'shipped' },
            { id: '#1236', customer: 'Mike Wilson', date: '2025-10-09', total: 85.00, payment: 'Paid', status: 'processing' },
            { id: '#1237', customer: 'Emily Brown', date: '2025-10-09', total: 29.99, payment: 'Unpaid', status: 'pending' },
            { id: '#1238', customer: 'David Jones', date: '2025-10-07', total: 250.00, payment: 'Paid', status: 'delivered' },
            { id: '#1239', customer: 'Laura White', date: '2025-10-06', total: 70.00, payment: 'Unpaid', status: 'cancelled' },
        ],
        customers: [
            { id: 1, name: 'John Doe', email: 'john.d@example.com', phone: '123-456-7890', orders: 5, totalSpent: 650.75, group: 'VIP' },
            { id: 2, name: 'Sarah Smith', email: 'sarah.s@example.com', phone: '987-654-3210', orders: 2, totalSpent: 180.40, group: 'Regular' },
            { id: 3, name: 'Mike Wilson', email: 'mike.w@example.com', phone: '555-123-4567', orders: 8, totalSpent: 1200.00, group: 'VIP' },
            { id: 4, name: 'Emily Brown', email: 'emily.b@example.com', phone: '444-555-6666', orders: 1, totalSpent: 29.99, group: 'New' },
        ],
        coupons: [
            { code: 'SAVE20', discount: 20, status: 'active' },
            { code: 'FALL15', discount: 15, status: 'active' },
            { code: 'SUMMER50', discount: 50, status: 'expired' },
        ]
    };

    let charts = {}; // To store chart instances

    // =========================================================================
    // GENERAL UI INITIALIZATION
    // =========================================================================
    const initApp = () => {
        initThemeToggle();
        initSidebar();
        initDropdowns();
        initModals();

        // Initialize scripts based on which page is currently open
        if (document.getElementById('index')) {
            initDashboard();
        }
        if (document.getElementById('product')) {
            initProductsPage();
        }
        if (document.getElementById('orders')) {
            initOrdersPage();
        }
        if (document.getElementById('customers')) {
            initCustomersPage();
        }
        if (document.getElementById('inventory')) {
            initInventoryPage();
        }
    };

    // =========================================================================
    // THEME (DARK/LIGHT MODE)
    // =========================================================================
    const initThemeToggle = () => {
        const themeToggle = document.getElementById('themeToggle');
        if (!themeToggle) return;
        const body = document.body;
        const icon = themeToggle.querySelector('i');

        const applyTheme = (theme) => {
            if (theme === 'dark') {
                body.classList.add('dark-mode');
                icon.classList.remove('fa-moon');
                icon.classList.add('fa-sun');
            } else {
                body.classList.remove('dark-mode');
                icon.classList.remove('fa-sun');
                icon.classList.add('fa-moon');
            }
        };

        const currentTheme = localStorage.getItem('theme') || 'light';
        applyTheme(currentTheme);

        themeToggle.addEventListener('click', () => {
            const newTheme = body.classList.contains('dark-mode') ? 'light' : 'dark';
            localStorage.setItem('theme', newTheme);
            applyTheme(newTheme);
            // Re-render charts for theme change if needed
            Object.values(charts).forEach(chart => chart.destroy());
            if (document.getElementById('index')) {
                initDashboardCharts();
            }
            // Add other chart re-initializations if needed for other pages
        });
    };

    // =========================================================================
    // SIDEBAR
    // =========================================================================
    const initSidebar = () => {
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');
        if (!sidebar || !sidebarToggle) return;

        // Toggle sidebar on button click
        sidebarToggle.addEventListener('click', (e) => {
            e.stopPropagation();
            
            // On mobile, toggle 'active' class
            if (window.innerWidth <= 768) {
                sidebar.classList.toggle('active');
            } else {
                // On desktop, toggle 'collapsed' class
                sidebar.classList.toggle('collapsed');
            }
        });

        // Close sidebar if clicking outside of it on mobile
        document.addEventListener('click', (e) => {
            if (window.innerWidth <= 768 && 
                sidebar.classList.contains('active') && 
                !sidebar.contains(e.target) && 
                !sidebarToggle.contains(e.target)) {
                sidebar.classList.remove('active');
            }
        });

        // Handle window resize
        window.addEventListener('resize', () => {
            if (window.innerWidth > 768) {
                sidebar.classList.remove('active');
            } else {
                sidebar.classList.remove('collapsed');
            }
        });
    };

    // =========================================================================
    // DROPDOWNS (Notifications, Mail, Profile)
    // =========================================================================
    const initDropdowns = () => {
        const dropdownTogglers = {
            'notificationBtn': 'notificationDropdown',
            'mailBtn': 'mailDropdown',
            'userProfile': 'profileDropdown'
        };

        Object.keys(dropdownTogglers).forEach(togglerId => {
            const toggler = document.getElementById(togglerId);
            const dropdownId = dropdownTogglers[togglerId];
            const dropdown = document.getElementById(dropdownId);

            if (toggler && dropdown) {
                toggler.addEventListener('click', (e) => {
                    e.stopPropagation();
                    // Close other dropdowns
                    Object.values(dropdownTogglers).forEach(id => {
                        const otherDropdown = document.getElementById(id);
                        if (id !== dropdownId && otherDropdown) {
                            otherDropdown.classList.remove('active');
                        }
                    });
                    dropdown.classList.toggle('active');
                });
            }
        });

        // Close dropdowns if clicking outside
        window.addEventListener('click', () => {
            Object.values(dropdownTogglers).forEach(id => {
                const dropdown = document.getElementById(id);
                if(dropdown) dropdown.classList.remove('active');
            });
        });
    };
    
    // =========================================================================
    // MODAL HANDLING
    // =========================================================================
    const initModals = () => {
        const modals = document.querySelectorAll('.modal');
        const closeButtons = document.querySelectorAll('.close-btn, [data-close]');

        closeButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                const modalId = btn.dataset.modal || btn.dataset.close;
                closeModal(modalId);
            });
        });

        modals.forEach(modal => {
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    closeModal(modal.id);
                }
            });
        });
    };

    const openModal = (modalId) => {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.classList.add('active');
        }
    };

    const closeModal = (modalId) => {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.classList.remove('active');
        }
    };

    // =========================================================================
    // DASHBOARD
    // =========================================================================
    const initDashboard = () => {
        const dateEl = document.getElementById('currentDate');
        if(dateEl) dateEl.textContent = new Date().toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });

        animateStat('todaySales', 1850.75, true);
        animateStat('todayOrders', 62);
        animateStat('totalRevenue', 125430.50, true);
        animateStat('newCustomers', 15);
        
        const pendingOrdersEl = document.getElementById('pendingOrders');
        if(pendingOrdersEl) pendingOrdersEl.textContent = '3';
        
        const outOfStockEl = document.getElementById('outOfStock');
        if(outOfStockEl) outOfStockEl.textContent = '2';

        const siteVisitorsEl = document.getElementById('siteVisitors');
        if(siteVisitorsEl) siteVisitorsEl.textContent = '1,289';

        const returnsEl = document.getElementById('returns');
        if(returnsEl) returnsEl.textContent = '1';

        populateTopProducts();
        initDashboardCharts();
    };

    const animateStat = (elementId, finalValue, isCurrency = false) => {
        const element = document.getElementById(elementId);
        if (!element) return;

        let startValue = 0;
        const duration = 1500;
        const increment = finalValue / (duration / 16);

        const updateCount = () => {
            startValue += increment;
            if (startValue >= finalValue) {
                element.textContent = isCurrency ? `$${finalValue.toLocaleString('en-US')}` : finalValue.toLocaleString('en-US');
            } else {
                element.textContent = isCurrency ? `$${Math.ceil(startValue).toLocaleString('en-US')}` : Math.ceil(startValue).toLocaleString('en-US');
                requestAnimationFrame(updateCount);
            }
        };
        updateCount();
    };
    
    const populateTopProducts = () => {
        const listEl = document.getElementById('topProductsList');
        if (!listEl) return;
        const topProducts = [
            { name: 'Wireless Headphones', category: 'Electronics', sales: 1250, revenue: 99987.50 },
            { name: 'Running Shoes', category: 'Footwear', sales: 850, revenue: 102425.00 },
            { name: 'Smart Tracker', category: 'Electronics', sales: 1500, revenue: 74925.00 },
            { name: 'Football', category: 'Sports', sales: 600, revenue: 21000.00 },
        ];
        
        let html = '';
        topProducts.forEach((p, index) => {
            html += `
                <div class="top-product-item">
                    <div class="product-info">
                        <span class="product-rank">${index + 1}</span>
                        <div class="product-details">
                            <h4>${p.name}</h4>
                            <span>${p.category}</span>
                        </div>
                    </div>
                    <div class="product-sales">
                        <strong>$${p.revenue.toLocaleString()}</strong>
                        <span>${p.sales} sales</span>
                    </div>
                </div>
            `;
        });
        listEl.innerHTML = html;
    };

    const initDashboardCharts = () => {
        createSalesChart();
        createRevenueChart();
    };

    const getChartOptions = () => {
        const isDarkMode = document.body.classList.contains('dark-mode');
        const gridColor = isDarkMode ? 'rgba(255, 255, 255, 0.1)' : 'rgba(0, 0, 0, 0.1)';
        const textColor = isDarkMode ? '#eee' : '#2c3e50';
        return { gridColor, textColor };
    };

    const createSalesChart = () => {
        const ctx = document.getElementById('salesChart')?.getContext('2d');
        if (!ctx) return;
        
        const { gridColor, textColor } = getChartOptions();

        const labels = Array.from({ length: 30 }, (_, i) => {
            const d = new Date();
            d.setDate(d.getDate() - (29 - i));
            return d.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
        });

        const data = {
            labels: labels,
            datasets: [{
                label: 'Sales',
                data: Array.from({ length: 30 }, () => Math.floor(Math.random() * (5000 - 1000 + 1)) + 1000),
                fill: true,
                backgroundColor: 'rgba(52, 152, 219, 0.2)',
                borderColor: '#3498db',
                tension: 0.4,
                pointBackgroundColor: '#3498db',
            }]
        };

        charts.sales = new Chart(ctx, {
            type: 'line',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    x: { ticks: { color: textColor }, grid: { color: gridColor } },
                    y: { ticks: { color: textColor }, grid: { color: gridColor } }
                }
            }
        });
    };

    const createRevenueChart = () => {
        const ctx = document.getElementById('revenueChart')?.getContext('2d');
        if (!ctx) return;
        
        const { textColor } = getChartOptions();

        const data = {
            labels: ['Electronics', 'Footwear', 'Clothing', 'Sports'],
            datasets: [{
                label: 'Revenue',
                data: [125000, 85000, 45000, 32000],
                backgroundColor: ['#3498db', '#2ecc71', '#f39c12', '#9b59b6'],
                hoverOffset: 4
            }]
        };

        charts.revenue = new Chart(ctx, {
            type: 'doughnut',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom', labels: { color: textColor } }
                }
            }
        });
    };

    // =========================================================================
    // PRODUCTS PAGE
    // =========================================================================
    const initProductsPage = () => {
        renderProductsTable();

        const stockFilter = document.getElementById('stockFilter');
        if (stockFilter) {
            stockFilter.addEventListener('change', renderProductsTable);
        }

        const categoryFilter = document.getElementById('categoryFilter');
        if (categoryFilter) {
            categoryFilter.addEventListener('change', renderProductsTable);
        }

        const addProductBtn = document.getElementById('addProductBtn');
        if (addProductBtn) {
            addProductBtn.addEventListener('click', () => {
                const productForm = document.getElementById('productForm');
                if (productForm) {
                    productForm.reset();
                    document.getElementById('productModalTitle').textContent = 'Add New Product';
                    document.getElementById('productId').value = '';
                    clearValidationErrors(productForm);
                    openModal('productModal');
                }
            });
        }
        
        const productForm = document.getElementById('productForm');
        if (productForm) {
            productForm.addEventListener('submit', handleProductFormSubmit);
        }
    };

    const renderProductsTable = () => {
        const tableBody = document.getElementById('productsTableBody');
        if (!tableBody) return;
        const categoryFilter = document.getElementById('categoryFilter').value;
        const stockFilter = document.getElementById('stockFilter').value;

        let filteredProducts = mockData.products;
        
        if (categoryFilter) {
            filteredProducts = filteredProducts.filter(p => p.category === categoryFilter);
        }
        if (stockFilter) {
            filteredProducts = filteredProducts.filter(p => p.status === stockFilter);
        }

        let html = '';
        if (filteredProducts.length === 0) {
            html = '<tr><td colspan="7" class="text-center">No products found.</td></tr>';
        } else {
            filteredProducts.forEach(product => {
                const statusBadge = `<span class="status-badge ${product.status}">${product.status.replace('outof', 'out of ')}</span>`;
                html += `
                    <tr>
                        <td><strong>${product.name}</strong></td>
                        <td>${product.sku}</td>
                        <td>${product.category}</td>
                        <td>$${product.price.toFixed(2)}</td>
                        <td>${product.stock}</td>
                        <td>${statusBadge}</td>
                        <td>
                            <div class="action-btns">
                                <button class="edit-btn" onclick="editProduct(${product.id})"><i class="fas fa-edit"></i></button>
                                <button class="delete-btn" onclick="deleteProduct(${product.id})"><i class="fas fa-trash"></i></button>
                            </div>
                        </td>
                    </tr>
                `;
            });
        }
        tableBody.innerHTML = html;
    };
    
    window.editProduct = (id) => {
        const product = mockData.products.find(p => p.id === id);
        if (product) {
            document.getElementById('productId').value = product.id;
            document.getElementById('productName').value = product.name;
            document.getElementById('productSKU').value = product.sku;
            document.getElementById('productCategory').value = product.category;
            document.getElementById('productPrice').value = product.price;
            document.getElementById('productStock').value = product.stock;
            document.getElementById('productModalTitle').textContent = 'Edit Product';
            clearValidationErrors(document.getElementById('productForm'));
            openModal('productModal');
        }
    };
    
    window.deleteProduct = (id) => {
        if (confirm('Are you sure you want to delete this product?')) {
            mockData.products = mockData.products.filter(p => p.id !== id);
            renderProductsTable();
        }
    };

    const handleProductFormSubmit = (e) => {
        e.preventDefault();
        const form = e.target;
        if (!validateForm(form)) return;

        const productId = document.getElementById('productId').value;
        const productData = {
            name: document.getElementById('productName').value,
            sku: document.getElementById('productSKU').value,
            category: document.getElementById('productCategory').value,
            price: parseFloat(document.getElementById('productPrice').value),
            stock: parseInt(document.getElementById('productStock').value),
        };

        if (productData.stock > 10) productData.status = 'instock';
        else if (productData.stock > 0) productData.status = 'lowstock';
        else productData.status = 'outofstock';
        
        if (productId) {
            const index = mockData.products.findIndex(p => p.id == productId);
            mockData.products[index] = { ...mockData.products[index], ...productData };
        } else {
            productData.id = Math.max(...mockData.products.map(p => p.id)) + 1;
            mockData.products.push(productData);
        }
        
        renderProductsTable();
        closeModal('productModal');
    };

    // =========================================================================
    // ORDERS PAGE
    // =========================================================================
    const initOrdersPage = () => {
        renderOrdersTable();
        const orderStatusFilter = document.getElementById('orderStatusFilter');
        if(orderStatusFilter) orderStatusFilter.addEventListener('change', renderOrdersTable);
        
        const orderDateFilter = document.getElementById('orderDateFilter');
        if(orderDateFilter) orderDateFilter.addEventListener('change', renderOrdersTable);
    };

    const renderOrdersTable = () => {
        const tableBody = document.getElementById('ordersTableBody');
        if(!tableBody) return;
        const statusFilter = document.getElementById('orderStatusFilter').value;
        const dateFilter = document.getElementById('orderDateFilter').value;

        let filteredOrders = mockData.orders;
        if (statusFilter) {
            filteredOrders = filteredOrders.filter(o => o.status === statusFilter);
        }
        if (dateFilter) {
            filteredOrders = filteredOrders.filter(o => o.date === dateFilter);
        }

        let html = '';
        filteredOrders.forEach(order => {
            const statusBadge = `<span class="status-badge ${order.status}">${order.status}</span>`;
            const paymentBadge = `<span class="status-badge ${order.payment.toLowerCase()}">${order.payment}</span>`;
            html += `
                <tr>
                    <td><strong>${order.id}</strong></td>
                    <td>${order.customer}</td>
                    <td>${order.date}</td>
                    <td>$${order.total.toFixed(2)}</td>
                    <td>${paymentBadge}</td>
                    <td>${statusBadge}</td>
                    <td>
                        <div class="action-btns">
                            <button class="view-btn" onclick="viewOrderDetails('${order.id}')"><i class="fas fa-eye"></i></button>
                        </div>
                    </td>
                </tr>
            `;
        });
        tableBody.innerHTML = html;
    };
    
    window.viewOrderDetails = (orderId) => {
        const order = mockData.orders.find(o => o.id === orderId);
        if (order) {
            const contentEl = document.getElementById('orderDetailsContent');
            contentEl.innerHTML = `
                <h4>Order ID: ${order.id}</h4>
                <p><strong>Customer:</strong> ${order.customer}</p>
                <p><strong>Date:</strong> ${order.date}</p>
                <p><strong>Total Amount:</strong> $${order.total.toFixed(2)}</p>
                <p><strong>Payment Status:</strong> ${order.payment}</p>
                <p><strong>Order Status:</strong> ${order.status}</p>
            `;
            openModal('orderModal');
        }
    };

    // =========================================================================
    // CUSTOMERS PAGE
    // =========================================================================
    const initCustomersPage = () => {
        renderCustomersTable();
    };

    const renderCustomersTable = () => {
        const tableBody = document.getElementById('customersTableBody');
        if(!tableBody) return;
        let html = '';
        mockData.customers.forEach(customer => {
            html += `
                <tr>
                    <td><strong>${customer.name}</strong></td>
                    <td>${customer.email}</td>
                    <td>${customer.phone}</td>
                    <td>${customer.orders}</td>
                    <td>$${customer.totalSpent.toFixed(2)}</td>
                    <td>${customer.group}</td>
                    <td>
                        <div class="action-btns">
                             <button class="view-btn"><i class="fas fa-eye"></i></button>
                             <button class="edit-btn"><i class="fas fa-edit"></i></button>
                        </div>
                    </td>
                </tr>
            `;
        });
        tableBody.innerHTML = html;
    };
    
    // =========================================================================
    // INVENTORY PAGE
    // =========================================================================
    const initInventoryPage = () => {
        renderInventoryTable();
    };

    const renderInventoryTable = () => {
        const tableBody = document.getElementById('inventoryTableBody');
        if(!tableBody) return;
        let html = '';
        let lowStockCount = 0;
        let outOfStockCount = 0;

        mockData.products.forEach(product => {
            const minStock = 10;
            const statusBadge = `<span class="status-badge ${product.status}">${product.status.replace('outof', 'out of ')}</span>`;
            if (product.status === 'lowstock') lowStockCount++;
            if (product.status === 'outofstock') outOfStockCount++;

            html += `
                <tr>
                    <td><strong>${product.name}</strong></td>
                    <td>${product.sku}</td>
                    <td>${product.stock}</td>
                    <td>${minStock}</td>
                    <td>${statusBadge}</td>
                    <td>
                        <div class="action-btns">
                            <button class="edit-btn">Restock</button>
                        </div>
                    </td>
                </tr>
            `;
        });
        tableBody.innerHTML = html;

        const lowStockCountEl = document.getElementById('lowStockCount');
        if(lowStockCountEl) lowStockCountEl.textContent = `${lowStockCount} products are running low on stock`;
        
        const outOfStockCountEl = document.getElementById('outOfStockCount');
        if(outOfStockCountEl) outOfStockCountEl.textContent = `${outOfStockCount} products are out of stock`;
    };

    // =========================================================================
    // FORM VALIDATION
    // =========================================================================
    const validateForm = (form) => {
        let isValid = true;
        clearValidationErrors(form);

        form.querySelectorAll('[required]').forEach(input => {
            if (!input.value.trim()) {
                showValidationError(input, 'This field is required.');
                isValid = false;
            } else if (input.type === 'number' && input.min && parseFloat(input.value) < parseFloat(input.min)) {
                showValidationError(input, `Value must be at least ${input.min}.`);
                isValid = false;
            } else if (input.type === 'number' && input.max && parseFloat(input.value) > parseFloat(input.max)) {
                showValidationError(input, `Value must be no more than ${input.max}.`);
                isValid = false;
            }
        });
        return isValid;
    };

    const showValidationError = (input, message) => {
        const formGroup = input.closest('.form-group');
        if (!formGroup) return;
        formGroup.classList.add('error');
        const errorDiv = formGroup.querySelector('.error');
        if (errorDiv) {
            errorDiv.textContent = message;
        }
    };

    const clearValidationErrors = (form) => {
        form.querySelectorAll('.form-group.error').forEach(group => {
            group.classList.remove('error');
            const errorDiv = group.querySelector('.error');
            if (errorDiv) {
                errorDiv.textContent = '';
            }
        });
    };
   
    // Initialize the application
    initApp();

});