Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-m975.mail.163.com ([123.126.97.5]:40412 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgLIJZD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 04:25:03 -0500
From: Xiaohui Zhang <ruc_zhangxiaohui@163.com>
Subject: [PATCH 1/1] crypto: Fix possible buffer overflows in pkey_protkey_aes_attr_read
Date: Wed,  9 Dec 2020 14:47:14 +0800
Message-Id: <20201209064714.33380-1-ruc_zhangxiaohui@163.com>
List-ID: <linux-s390.vger.kernel.org>
To: Xiaohui Zhang <ruc_zhangxiaohui@163.com>, Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>

pkey_protkey_aes_attr_read() calls memcpy() without checking the
destination size may trigger a buffer overflower.

Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
---
 drivers/s390/crypto/pkey_api.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 99cb60ea6..abc237130 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1589,6 +1589,8 @@ static ssize_t pkey_protkey_aes_attr_read(u32 keytype, bool is_xts, char *buf,
 	if (rc)
 		return rc;
 
+	if (protkey.len > MAXPROTKEYSIZE)
+		protkey.len = MAXPROTKEYSIZE;
 	protkeytoken.len = protkey.len;
 	memcpy(&protkeytoken.protkey, &protkey.protkey, protkey.len);
 
@@ -1599,6 +1601,8 @@ static ssize_t pkey_protkey_aes_attr_read(u32 keytype, bool is_xts, char *buf,
 		if (rc)
 			return rc;
 
+		if (protkey.len > MAXPROTKEYSIZE)
+			protkey.len = MAXPROTKEYSIZE;
 		protkeytoken.len = protkey.len;
 		memcpy(&protkeytoken.protkey, &protkey.protkey, protkey.len);
 
-- 
2.17.1
