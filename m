Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH] s390/zcrypt: Use kmemdup to replace kmalloc + memcpy
Date: Sat, 8 Sep 2018 16:50:21 +0800
Message-ID: <1536396621-19363-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: freude@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

kmemdup has implemented the function that kmalloc() + memcpy() will
do. and we prefer to use the kmemdup rather than the open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 2101776..9ac960d 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1131,10 +1131,9 @@ unsigned int get_cprb_fc(struct ica_xcRB *xcRB,
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long long) current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg->private = kmalloc(sizeof(resp_type), GFP_KERNEL);
+	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
 	if (!ap_msg->private)
 		return -ENOMEM;
-	memcpy(ap_msg->private, &resp_type, sizeof(resp_type));
 	return XCRB_msg_to_type6CPRB_msgX(ap_msg, xcRB, func_code, dom);
 }
 
@@ -1187,10 +1186,9 @@ unsigned int get_ep11cprb_fc(struct ep11_urb *xcrb,
 	ap_msg->receive = zcrypt_msgtype6_receive_ep11;
 	ap_msg->psmid = (((unsigned long long) current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg->private = kmalloc(sizeof(resp_type), GFP_KERNEL);
+	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
 	if (!ap_msg->private)
 		return -ENOMEM;
-	memcpy(ap_msg->private, &resp_type, sizeof(resp_type));
 	return xcrb_msg_to_type6_ep11cprb_msgx(ap_msg, xcrb, func_code);
 }
 
@@ -1282,10 +1280,9 @@ unsigned int get_rng_fc(struct ap_message *ap_msg, int *func_code,
 	ap_msg->receive = zcrypt_msgtype6_receive;
 	ap_msg->psmid = (((unsigned long long) current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg->private = kmalloc(sizeof(resp_type), GFP_KERNEL);
+	ap_msg->private = kmemdup(&resp_type, sizeof(resp_type), GFP_KERNEL);
 	if (!ap_msg->private)
 		return -ENOMEM;
-	memcpy(ap_msg->private, &resp_type, sizeof(resp_type));
 
 	rng_type6CPRB_msgX(ap_msg, ZCRYPT_RNG_BUFFER_SIZE, domain);
 
-- 
1.7.12.4
