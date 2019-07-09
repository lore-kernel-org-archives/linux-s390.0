Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40871 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIMZQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jul 2019 08:25:16 -0400
From: Denis Efremov <efremov@linux.com>
Subject: [PATCH] s390/zcrypt: remove the exporting of ap_query_configuration
Date: Tue,  9 Jul 2019 15:25:07 +0300
Message-Id: <20190709122507.11158-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Denis Efremov <efremov@linux.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

The function ap_query_configuration is declared static and marked
EXPORT_SYMBOL, which is at best an odd combination. Because the
function is not used outside of the drivers/s390/crypto/ap_bus.c
file it is defined in, this commit removes the EXPORT_SYMBOL() marking.

Fixes: f1b0a4343c41 ("s390/zcrypt: Integrate ap_asm.h into include/asm/ap.h.")
Fixes: 050349b5b71d ("s390/zcrypt: externalize AP config info query")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/s390/crypto/ap_bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index b9fc502c58c2..379e43b79006 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -208,7 +208,6 @@ static inline int ap_query_configuration(struct ap_config_info *info)
 		return -EINVAL;
 	return ap_qci(info);
 }
-EXPORT_SYMBOL(ap_query_configuration);
 
 /**
  * ap_init_configuration(): Allocate and query configuration array.
-- 
2.21.0
