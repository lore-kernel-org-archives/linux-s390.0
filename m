Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:12724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbgIPGVA (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Sep 2020 02:21:00 -0400
From: Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] s390/ap: remove unnecessary spin_lock_init()
Date: Wed, 16 Sep 2020 14:21:30 +0800
Message-ID: <20200916062130.190910-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Qinglang Miao <miaoqinglang@huawei.com>

The spinlock ap_poll_timer_lock is initialized statically. It is
unnecessary to initialize by spin_lock_init().

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/s390/crypto/ap_bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 24a1940b8..231a98c91 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1575,7 +1575,6 @@ static int __init ap_module_init(void)
 	 */
 	if (MACHINE_IS_VM)
 		poll_timeout = 1500000;
-	spin_lock_init(&ap_poll_timer_lock);
 	hrtimer_init(&ap_poll_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	ap_poll_timer.function = ap_poll_timeout;
 
-- 
2.23.0
