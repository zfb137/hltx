-- 1. 系统配置表 (site_config)
CREATE TABLE IF NOT EXISTS site_config (
    key  TEXT PRIMARY KEY,
    value TEXT
);
-- 仅在没有数据时插入默认配置
INSERT OR IGNORE INTO site_config (key, value) VALUES 
('site_name', '夏雨 Faka Demo'), 
('announce', '<p>欢迎光临</p>'), 
('theme', 'default');

-- 2. 支付网关表 (pay_gateways)
CREATE TABLE IF NOT EXISTS pay_gateways (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    config TEXT NOT NULL,
    active INTEGER DEFAULT 1
);

-- 3. 商品分类表 (categories)
CREATE TABLE IF NOT EXISTS categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    sort INTEGER DEFAULT 0,
    image_url TEXT
);
INSERT OR IGNORE INTO categories (id, name, sort) VALUES (1, '默认分类', 0);

-- 4. 商品表 (products)
CREATE TABLE IF NOT EXISTS products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER DEFAULT 1,
    name TEXT NOT NULL,
    description TEXT,
    sort INTEGER DEFAULT 0,
    active INTEGER DEFAULT 1,
    created_at INTEGER,
    image_url TEXT,
    tags TEXT
);

-- 5. 商品规格表 (variants)
CREATE TABLE IF NOT EXISTS variants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    price REAL NOT NULL,
    stock INTEGER DEFAULT 0,
    color TEXT,
    image_url TEXT,
    wholesale_config TEXT,
    custom_markup REAL DEFAULT 0,
    sales_count INTEGER DEFAULT 0,
    auto_delivery INTEGER DEFAULT 1,
    created_at INTEGER,
    selection_label TEXT,
    sort INTEGER DEFAULT 0,
    active INTEGER DEFAULT 1,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- 6. 卡密表 (cards)
CREATE TABLE IF NOT EXISTS cards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    variant_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    status INTEGER DEFAULT 0,
    order_id TEXT,
    created_at INTEGER,
    FOREIGN KEY (variant_id) REFERENCES variants(id) ON DELETE CASCADE
);

-- 7. 订单表 (orders)
CREATE TABLE IF NOT EXISTS orders (
    id TEXT PRIMARY KEY,
    trade_no TEXT,
    variant_id INTEGER NOT NULL,
    product_name TEXT,
    variant_name TEXT,
    price REAL,
    quantity INTEGER DEFAULT 1,
    total_amount REAL,
    contact TEXT,
    payment_method TEXT,
    status INTEGER DEFAULT 0,
    cards_sent TEXT,
    created_at INTEGER,
    paid_at INTEGER,
    query_password TEXT
);

-- 8. 文章分类表 (article_categories)
CREATE TABLE IF NOT EXISTS article_categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    sort INTEGER DEFAULT 0
);
INSERT OR IGNORE INTO article_categories (id, name, sort) VALUES (1, '默认分类', 0);

-- 9. 文章表 (articles)
CREATE TABLE IF NOT EXISTS articles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER DEFAULT 1,
    title TEXT NOT NULL,
    content TEXT,
    is_notice INTEGER DEFAULT 0,
    view_count INTEGER DEFAULT 0,
    created_at INTEGER,
    updated_at INTEGER,
    cover_image TEXT,
    active INTEGER DEFAULT 1,
    FOREIGN KEY (category_id) REFERENCES article_categories(id) ON DELETE SET DEFAULT
);

-- 10. 图片分类表 (image_categories)
CREATE TABLE IF NOT EXISTS image_categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    sort INTEGER DEFAULT 0
);
INSERT OR IGNORE INTO image_categories (id, name, sort) VALUES (1, '默认分类', 0);

-- 11. 图片库表 (images)
CREATE TABLE IF NOT EXISTS images (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER DEFAULT 1,
    url TEXT NOT NULL,
    name TEXT,
    created_at INTEGER,
    FOREIGN KEY (category_id) REFERENCES image_categories(id) ON DELETE SET DEFAULT
);
