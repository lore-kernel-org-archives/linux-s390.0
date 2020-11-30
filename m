Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728577AbgK3KKs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Nov 2020 05:10:48 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/6] s390/ctcm: Avoid temporary allocation of struct qllc.
Date: Mon, 30 Nov 2020 11:09:46 +0100
Message-Id: <20201130100950.42051-3-jwi@linux.ibm.com>
In-Reply-To: <20201130100950.42051-1-jwi@linux.ibm.com>
References: <20201130100950.42051-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The size of struct qllc is 2 byte. The memory for is allocated,
initialized, used and deallocated a few lines later.

It is more efficient to avoid the allocation/free dance and assign the
values directly to skb's data part instead of using memcpy() for it.

Avoid an allocation of struct qllc and use the resulting skb pointer
instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[jwi: remove a newline, reflow the commit msg]
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/ctcm_mpc.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 293d8870968c..8ae49732d1d2 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -2048,7 +2048,6 @@ static void mpc_action_rcvd_xid7(fsm_instance *fsm, int event, void *arg)
  */
 static int mpc_send_qllc_discontact(struct net_device *dev)
 {
-	__u32	new_len	= 0;
 	struct sk_buff   *skb;
 	struct qllc      *qllcptr;
 	struct ctcm_priv *priv = dev->ml_priv;
@@ -2079,31 +2078,19 @@ static int mpc_send_qllc_discontact(struct net_device *dev)
 	case MPCG_STATE_FLOWC:
 	case MPCG_STATE_READY:
 		grp->send_qllc_disc = 2;
-		new_len = sizeof(struct qllc);
-		qllcptr = kzalloc(new_len, gfp_type() | GFP_DMA);
-		if (qllcptr == NULL) {
-			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
-				"%s(%s): qllcptr allocation error",
-						CTCM_FUNTAIL, dev->name);
-			return -ENOMEM;
-		}
-
-		qllcptr->qllc_address = 0xcc;
-		qllcptr->qllc_commands = 0x03;
-
-		skb = __dev_alloc_skb(new_len, GFP_ATOMIC);
 
+		skb = __dev_alloc_skb(sizeof(struct qllc), GFP_ATOMIC);
 		if (skb == NULL) {
 			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
 				"%s(%s): skb allocation error",
 						CTCM_FUNTAIL, dev->name);
 			priv->stats.rx_dropped++;
-			kfree(qllcptr);
 			return -ENOMEM;
 		}
 
-		skb_put_data(skb, qllcptr, new_len);
-		kfree(qllcptr);
+		qllcptr = skb_put(skb, sizeof(struct qllc));
+		qllcptr->qllc_address = 0xcc;
+		qllcptr->qllc_commands = 0x03;
 
 		if (skb_headroom(skb) < 4) {
 			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
-- 
2.17.1
