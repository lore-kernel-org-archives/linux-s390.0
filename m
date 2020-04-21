Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:2856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgDUM3m (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 08:29:42 -0400
From: Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] s390/zcrypt: fix kzalloc-simple.cocci warnings
Date: Tue, 21 Apr 2020 20:35:48 +0800
Message-ID: <1587472548-105240-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: freude@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zou Wei <zou_wei@huawei.com>

This patch fixes below warning reported by coccicheck

drivers/s390/crypto/zcrypt_ep11misc.c:198:8-15: WARNING:
kzalloc should be used for cprb, instead of kmalloc/memset

Fixes: 7384eb725e2d ("s390/zcrypt: add new low level ep11 functions support file")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 004ce02..3c3d403 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -195,11 +195,10 @@ static inline struct ep11_cprb *alloc_cprb(size_t payload_len)
 	size_t len = sizeof(struct ep11_cprb) + payload_len;
 	struct ep11_cprb *cprb;
 
-	cprb = kmalloc(len, GFP_KERNEL);
+	cprb = kzalloc(len, GFP_KERNEL);
 	if (!cprb)
 		return NULL;
 
-	memset(cprb, 0, len);
 	cprb->cprb_len = sizeof(struct ep11_cprb);
 	cprb->cprb_ver_id = 0x04;
 	memcpy(cprb->func_id, "T4", 2);
-- 
2.6.2
