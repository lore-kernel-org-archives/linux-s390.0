Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730328AbfHTOrB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 10:47:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KEXp7D121472
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 10:47:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ughmvcn39-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 10:46:59 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 20 Aug 2019 15:46:57 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 8/9] s390/ctcm: don't use intparm for channel IO
Date: Tue, 20 Aug 2019 16:46:42 +0200
In-Reply-To: <20190820144643.64041-1-jwi@linux.ibm.com>
References: <20190820144643.64041-1-jwi@linux.ibm.com>
Message-Id: <20190820144643.64041-9-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

ctcm passes an intparm when calling ccw_device_*(), even though
ctcm_irq_handler() later makes no use of this.

To reduce the confusion, consistently pass 0 as intparm instead.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
---
 drivers/s390/net/ctcm_fsms.c | 42 ++++++++++++++----------------------
 drivers/s390/net/ctcm_main.c |  6 ++----
 drivers/s390/net/ctcm_mpc.c  |  6 ++----
 3 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/s390/net/ctcm_fsms.c b/drivers/s390/net/ctcm_fsms.c
index 4a8a5373cb35..3ce99e4db44d 100644
--- a/drivers/s390/net/ctcm_fsms.c
+++ b/drivers/s390/net/ctcm_fsms.c
@@ -307,8 +307,7 @@ static void chx_txdone(fsm_instance *fi, int event, void *arg)
 		ch->ccw[1].count = ch->trans_skb->len;
 		fsm_addtimer(&ch->timer, CTCM_TIME_5_SEC, CTC_EVENT_TIMER, ch);
 		ch->prof.send_stamp = jiffies;
-		rc = ccw_device_start(ch->cdev, &ch->ccw[0],
-						(unsigned long)ch, 0xff, 0);
+		rc = ccw_device_start(ch->cdev, &ch->ccw[0], 0, 0xff, 0);
 		ch->prof.doios_multi++;
 		if (rc != 0) {
 			priv->stats.tx_dropped += i;
@@ -417,8 +416,7 @@ static void chx_rx(fsm_instance *fi, int event, void *arg)
 	if (ctcm_checkalloc_buffer(ch))
 		return;
 	ch->ccw[1].count = ch->max_bufsize;
-	rc = ccw_device_start(ch->cdev, &ch->ccw[0],
-					(unsigned long)ch, 0xff, 0);
+	rc = ccw_device_start(ch->cdev, &ch->ccw[0], 0, 0xff, 0);
 	if (rc != 0)
 		ctcm_ccw_check_rc(ch, rc, "normal RX");
 }
@@ -478,8 +476,7 @@ static void chx_firstio(fsm_instance *fi, int event, void *arg)
 
 	fsm_newstate(fi, (CHANNEL_DIRECTION(ch->flags) == CTCM_READ)
 		     ? CTC_STATE_RXINIT : CTC_STATE_TXINIT);
-	rc = ccw_device_start(ch->cdev, &ch->ccw[0],
-					(unsigned long)ch, 0xff, 0);
+	rc = ccw_device_start(ch->cdev, &ch->ccw[0], 0, 0xff, 0);
 	if (rc != 0) {
 		fsm_deltimer(&ch->timer);
 		fsm_newstate(fi, CTC_STATE_SETUPWAIT);
@@ -527,8 +524,7 @@ static void chx_rxidle(fsm_instance *fi, int event, void *arg)
 			return;
 		ch->ccw[1].count = ch->max_bufsize;
 		fsm_newstate(fi, CTC_STATE_RXIDLE);
-		rc = ccw_device_start(ch->cdev, &ch->ccw[0],
-						(unsigned long)ch, 0xff, 0);
+		rc = ccw_device_start(ch->cdev, &ch->ccw[0], 0, 0xff, 0);
 		if (rc != 0) {
 			fsm_newstate(fi, CTC_STATE_RXINIT);
 			ctcm_ccw_check_rc(ch, rc, "initial RX");
@@ -571,8 +567,7 @@ static void ctcm_chx_setmode(fsm_instance *fi, int event, void *arg)
 			/* Such conditional locking is undeterministic in
 			 * static view. => ignore sparse warnings here. */
 
-	rc = ccw_device_start(ch->cdev, &ch->ccw[6],
-					(unsigned long)ch, 0xff, 0);
+	rc = ccw_device_start(ch->cdev, &ch->ccw[6], 0, 0xff, 0);
 	if (event == CTC_EVENT_TIMER)	/* see above comments */
 		spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
 	if (rc != 0) {
@@ -637,7 +632,7 @@ static void ctcm_chx_start(fsm_instance *fi, int event, void *arg)
 	fsm_newstate(fi, CTC_STATE_STARTWAIT);
 	fsm_addtimer(&ch->timer, 1000, CTC_EVENT_TIMER, ch);
 	spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
-	rc = ccw_device_halt(ch->cdev, (unsigned long)ch);
+	rc = ccw_device_halt(ch->cdev, 0);
 	spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
 	if (rc != 0) {
 		if (rc != -EBUSY)
@@ -672,7 +667,7 @@ static void ctcm_chx_haltio(fsm_instance *fi, int event, void *arg)
 			 * static view. => ignore sparse warnings here. */
 	oldstate = fsm_getstate(fi);
 	fsm_newstate(fi, CTC_STATE_TERM);
-	rc = ccw_device_halt(ch->cdev, (unsigned long)ch);
+	rc = ccw_device_halt(ch->cdev, 0);
 
 	if (event == CTC_EVENT_STOP)
 		spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
@@ -799,7 +794,7 @@ static void ctcm_chx_setuperr(fsm_instance *fi, int event, void *arg)
 		fsm_addtimer(&ch->timer, CTCM_TIME_5_SEC, CTC_EVENT_TIMER, ch);
 		if (!IS_MPC(ch) &&
 		    (CHANNEL_DIRECTION(ch->flags) == CTCM_READ)) {
-			int rc = ccw_device_halt(ch->cdev, (unsigned long)ch);
+			int rc = ccw_device_halt(ch->cdev, 0);
 			if (rc != 0)
 				ctcm_ccw_check_rc(ch, rc,
 					"HaltIO in chx_setuperr");
@@ -851,7 +846,7 @@ static void ctcm_chx_restart(fsm_instance *fi, int event, void *arg)
 			/* Such conditional locking is a known problem for
 			 * sparse because its undeterministic in static view.
 			 * Warnings should be ignored here. */
-	rc = ccw_device_halt(ch->cdev, (unsigned long)ch);
+	rc = ccw_device_halt(ch->cdev, 0);
 	if (event == CTC_EVENT_TIMER)
 		spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
 	if (rc != 0) {
@@ -947,8 +942,8 @@ static void ctcm_chx_rxdisc(fsm_instance *fi, int event, void *arg)
 	ch2 = priv->channel[CTCM_WRITE];
 	fsm_newstate(ch2->fsm, CTC_STATE_DTERM);
 
-	ccw_device_halt(ch->cdev, (unsigned long)ch);
-	ccw_device_halt(ch2->cdev, (unsigned long)ch2);
+	ccw_device_halt(ch->cdev, 0);
+	ccw_device_halt(ch2->cdev, 0);
 }
 
 /**
@@ -1041,8 +1036,7 @@ static void ctcm_chx_txretry(fsm_instance *fi, int event, void *arg)
 			ctcmpc_dumpit((char *)&ch->ccw[3],
 					sizeof(struct ccw1) * 3);
 
-		rc = ccw_device_start(ch->cdev, &ch->ccw[3],
-						(unsigned long)ch, 0xff, 0);
+		rc = ccw_device_start(ch->cdev, &ch->ccw[3], 0, 0xff, 0);
 		if (event == CTC_EVENT_TIMER)
 			spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev),
 					saveflags);
@@ -1361,8 +1355,7 @@ static void ctcmpc_chx_txdone(fsm_instance *fi, int event, void *arg)
 	ch->prof.send_stamp = jiffies;
 	if (do_debug_ccw)
 		ctcmpc_dumpit((char *)&ch->ccw[0], sizeof(struct ccw1) * 3);
-	rc = ccw_device_start(ch->cdev, &ch->ccw[0],
-					(unsigned long)ch, 0xff, 0);
+	rc = ccw_device_start(ch->cdev, &ch->ccw[0], 0, 0xff, 0);
 	ch->prof.doios_multi++;
 	if (rc != 0) {
 		priv->stats.tx_dropped += i;
@@ -1462,8 +1455,7 @@ static void ctcmpc_chx_rx(fsm_instance *fi, int event, void *arg)
 		if (dolock)
 			spin_lock_irqsave(
 				get_ccwdev_lock(ch->cdev), saveflags);
-		rc = ccw_device_start(ch->cdev, &ch->ccw[0],
-						(unsigned long)ch, 0xff, 0);
+		rc = ccw_device_start(ch->cdev, &ch->ccw[0], 0, 0xff, 0);
 		if (dolock) /* see remark about conditional locking */
 			spin_unlock_irqrestore(
 				get_ccwdev_lock(ch->cdev), saveflags);
@@ -1569,8 +1561,7 @@ void ctcmpc_chx_rxidle(fsm_instance *fi, int event, void *arg)
 		if (event == CTC_EVENT_START)
 			/* see remark about conditional locking */
 			spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
-		rc = ccw_device_start(ch->cdev, &ch->ccw[0],
-						(unsigned long)ch, 0xff, 0);
+		rc = ccw_device_start(ch->cdev, &ch->ccw[0], 0, 0xff, 0);
 		if (event == CTC_EVENT_START)
 			spin_unlock_irqrestore(
 					get_ccwdev_lock(ch->cdev), saveflags);
@@ -1825,8 +1816,7 @@ static void ctcmpc_chx_send_sweep(fsm_instance *fsm, int event, void *arg)
 
 	spin_lock_irqsave(get_ccwdev_lock(wch->cdev), saveflags);
 	wch->prof.send_stamp = jiffies;
-	rc = ccw_device_start(wch->cdev, &wch->ccw[3],
-					(unsigned long) wch, 0xff, 0);
+	rc = ccw_device_start(wch->cdev, &wch->ccw[3], 0, 0xff, 0);
 	spin_unlock_irqrestore(get_ccwdev_lock(wch->cdev), saveflags);
 
 	if ((grp->sweep_req_pend_num == 0) &&
diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index f63c5c871d3d..2117870ed855 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -569,8 +569,7 @@ static int ctcm_transmit_skb(struct channel *ch, struct sk_buff *skb)
 	fsm_addtimer(&ch->timer, CTCM_TIME_5_SEC, CTC_EVENT_TIMER, ch);
 	spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
 	ch->prof.send_stamp = jiffies;
-	rc = ccw_device_start(ch->cdev, &ch->ccw[ccw_idx],
-					(unsigned long)ch, 0xff, 0);
+	rc = ccw_device_start(ch->cdev, &ch->ccw[ccw_idx], 0, 0xff, 0);
 	spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
 	if (ccw_idx == 3)
 		ch->prof.doios_single++;
@@ -833,8 +832,7 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
 
 	spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
 	ch->prof.send_stamp = jiffies;
-	rc = ccw_device_start(ch->cdev, &ch->ccw[ccw_idx],
-					(unsigned long)ch, 0xff, 0);
+	rc = ccw_device_start(ch->cdev, &ch->ccw[ccw_idx], 0, 0xff, 0);
 	spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
 	if (ccw_idx == 3)
 		ch->prof.doios_single++;
diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 1534420a0243..ab316baa8284 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -1523,8 +1523,7 @@ void mpc_action_send_discontact(unsigned long thischan)
 	unsigned long	saveflags = 0;
 
 	spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
-	rc = ccw_device_start(ch->cdev, &ch->ccw[15],
-					(unsigned long)ch, 0xff, 0);
+	rc = ccw_device_start(ch->cdev, &ch->ccw[15], 0, 0xff, 0);
 	spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
 
 	if (rc != 0) {
@@ -1797,8 +1796,7 @@ static void mpc_action_side_xid(fsm_instance *fsm, void *arg, int side)
 	}
 
 	fsm_addtimer(&ch->timer, 5000 , CTC_EVENT_TIMER, ch);
-	rc = ccw_device_start(ch->cdev, &ch->ccw[8],
-				(unsigned long)ch, 0xff, 0);
+	rc = ccw_device_start(ch->cdev, &ch->ccw[8], 0, 0xff, 0);
 
 	if (gotlock)	/* see remark above about conditional locking */
 		spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
-- 
2.17.1
