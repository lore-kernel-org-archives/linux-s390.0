Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] s390/crypto/zcrypt_cex4: convert comma to semicolon
Date: Mon, 14 Dec 2020 21:43:41 +0800
Message-ID: <20201214134341.4671-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zheng Yongjun <zhengyongjun3@huawei.com>

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/s390/crypto/zcrypt_cex4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index f5195bca1d85..f4a6d3744241 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -631,7 +631,7 @@ static int zcrypt_cex4_queue_probe(struct ap_device *ap_dev)
 	atomic_set(&zq->load, 0);
 	ap_queue_init_state(aq);
 	ap_queue_init_reply(aq, &zq->reply);
-	aq->request_timeout = CEX4_CLEANUP_TIME,
+	aq->request_timeout = CEX4_CLEANUP_TIME;
 	aq->private = zq;
 	rc = zcrypt_queue_register(zq);
 	if (rc) {
-- 
2.22.0
