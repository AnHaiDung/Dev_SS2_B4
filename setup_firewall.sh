#!/bin/bash
# ==============================================================================
# Script: setup_firewall.sh
# Purpose: Cấu hình UFW Firewall tự động cho máy chủ Ubuntu (Bài tập 4)
# ==============================================================================

set -e

echo "[+] Bắt đầu cấu hình UFW Firewall..."

# 1. Đảm bảo ufw đã được cài đặt
if ! command -v ufw &> /dev/null; then
    echo "[*] Đang cài đặt ufw..."
    sudo apt-get update -y
    sudo apt-get install -y ufw
fi

# 2. Reset cấu hình UFW về mặc định (nếu muốn làm sạch)
# sudo ufw --force reset

# 3. Thiết lập chính sách mặc định: chặn tất cả inbound, cho phép outbound
echo "[*] Thiết lập chính sách mặc định..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 4. Mở cổng SSH (22/tcp) để tránh mất kết nối
echo "[*] Mở cổng SSH (22/tcp)..."
sudo ufw allow 22/tcp comment 'Allow SSH access'

# 5. Mở cổng HTTP (80/tcp) cho Web server
echo "[*] Mở cổng HTTP (80/tcp)..."
sudo ufw allow 80/tcp comment 'Allow HTTP web traffic'

# 6. Kích hoạt UFW
echo "[*] Kích hoạt UFW..."
sudo ufw --force enable

# 7. Kiểm tra trạng thái UFW
echo "[+] Hoàn tất! Trạng thái UFW chi tiết:"
sudo ufw status verbose
