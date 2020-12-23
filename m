Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:10071 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgLWOP2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Dec 2020 09:15:28 -0500
From: Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] s390: cio: Use DEFINE_SPINLOCK() for spinlock
Date: Wed, 23 Dec 2020 22:15:12 +0800
Message-ID: <20201223141512.1178-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zheng Yongjun <zhengyongjun3@huawei.com>

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/s390/cio/css.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index cca1a7c4bb33..022f573f0bcc 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -647,13 +647,12 @@ static void css_sch_todo(struct work_struct *work)
 }
 
 static struct idset *slow_subchannel_set;
-static spinlock_t slow_subchannel_lock;
+static DEFINE_SPINLOCK(slow_subchannel_lock);
 static wait_queue_head_t css_eval_wq;
 static atomic_t css_eval_scheduled;
 
 static int __init slow_subchannel_init(void)
 {
-	spin_lock_init(&slow_subchannel_lock);
 	atomic_set(&css_eval_scheduled, 0);
 	init_waitqueue_head(&css_eval_wq);
 	slow_subchannel_set = idset_sch_new();
-- 
2.22.0
