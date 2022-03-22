Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01282C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 22 Mar 2022 02:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiCVCyX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Mar 2022 22:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbiCVCyW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Mar 2022 22:54:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CA85717B;
        Mon, 21 Mar 2022 19:52:55 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KMwyR0XqXz1GCph;
        Tue, 22 Mar 2022 10:52:47 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 10:52:53 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 10:52:53 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <liaoyu15@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH] s390: cleanup timer API use
Date:   Tue, 22 Mar 2022 11:00:57 +0800
Message-ID: <20220322030057.1243196-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

cleanup the s390's use of the timer API
- del_timer() contains timer_pending() condition
- mod_timer(timer, expires) is equivalent to:

	del_timer(timer);
	timer->expires = expires;
	add_timer(timer);

If the timer is inactive it will be activated, using add_timer() on
condition !timer_pending(&private->timer) is redundant.

Just cleanup, no logic change.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/s390/char/sclp.c       |  4 +---
 drivers/s390/char/sclp_con.c   |  3 +--
 drivers/s390/char/sclp_vt220.c |  6 ++----
 drivers/s390/cio/device_fsm.c  | 12 +++---------
 drivers/s390/cio/eadm_sch.c    | 12 +++---------
 5 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index f0763e36b861..cb2491761958 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -745,9 +745,7 @@ sclp_sync_wait(void)
 	/* Loop until driver state indicates finished request */
 	while (sclp_running_state != sclp_running_state_idle) {
 		/* Check for expired request timer */
-		if (timer_pending(&sclp_request_timer) &&
-		    get_tod_clock_fast() > timeout &&
-		    del_timer(&sclp_request_timer))
+		if (get_tod_clock_fast() > timeout && del_timer(&sclp_request_timer))
 			sclp_request_timer.function(&sclp_request_timer);
 		cpu_relax();
 	}
diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index de028868c6f4..fe5ee2646fcf 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -109,8 +109,7 @@ static void sclp_console_sync_queue(void)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sclp_con_lock, flags);
-	if (timer_pending(&sclp_con_timer))
-		del_timer(&sclp_con_timer);
+	del_timer(&sclp_con_timer);
 	while (sclp_con_queue_running) {
 		spin_unlock_irqrestore(&sclp_con_lock, flags);
 		sclp_sync_wait();
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 7bc4e4a10937..3b4e7e5d9b71 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -231,8 +231,7 @@ sclp_vt220_emit_current(void)
 			list_add_tail(&sclp_vt220_current_request->list,
 				      &sclp_vt220_outqueue);
 			sclp_vt220_current_request = NULL;
-			if (timer_pending(&sclp_vt220_timer))
-				del_timer(&sclp_vt220_timer);
+			del_timer(&sclp_vt220_timer);
 		}
 		sclp_vt220_flush_later = 0;
 	}
@@ -776,8 +775,7 @@ static void __sclp_vt220_flush_buffer(void)
 
 	sclp_vt220_emit_current();
 	spin_lock_irqsave(&sclp_vt220_lock, flags);
-	if (timer_pending(&sclp_vt220_timer))
-		del_timer(&sclp_vt220_timer);
+	del_timer(&sclp_vt220_timer);
 	while (sclp_vt220_queue_running) {
 		spin_unlock_irqrestore(&sclp_vt220_lock, flags);
 		sclp_sync_wait();
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 05e136cfb8be..6d63b968309a 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -113,16 +113,10 @@ ccw_device_timeout(struct timer_list *t)
 void
 ccw_device_set_timeout(struct ccw_device *cdev, int expires)
 {
-	if (expires == 0) {
+	if (expires == 0)
 		del_timer(&cdev->private->timer);
-		return;
-	}
-	if (timer_pending(&cdev->private->timer)) {
-		if (mod_timer(&cdev->private->timer, jiffies + expires))
-			return;
-	}
-	cdev->private->timer.expires = jiffies + expires;
-	add_timer(&cdev->private->timer);
+	else
+		mod_timer(&cdev->private->timer, jiffies + expires);
 }
 
 int
diff --git a/drivers/s390/cio/eadm_sch.c b/drivers/s390/cio/eadm_sch.c
index 8b463681a149..ab6a7495180a 100644
--- a/drivers/s390/cio/eadm_sch.c
+++ b/drivers/s390/cio/eadm_sch.c
@@ -112,16 +112,10 @@ static void eadm_subchannel_set_timeout(struct subchannel *sch, int expires)
 {
 	struct eadm_private *private = get_eadm_private(sch);
 
-	if (expires == 0) {
+	if (expires == 0)
 		del_timer(&private->timer);
-		return;
-	}
-	if (timer_pending(&private->timer)) {
-		if (mod_timer(&private->timer, jiffies + expires))
-			return;
-	}
-	private->timer.expires = jiffies + expires;
-	add_timer(&private->timer);
+	else
+		mod_timer(&private->timer, jiffies + expires);
 }
 
 static void eadm_subchannel_irq(struct subchannel *sch)
-- 
2.25.1

