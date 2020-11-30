Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728557AbgK3KKs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Nov 2020 05:10:48 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/6] s390/ctcm: Use GFP_ATOMIC in ctcmpc_tx().
Date: Mon, 30 Nov 2020 11:09:50 +0100
Message-Id: <20201130100950.42051-7-jwi@linux.ibm.com>
In-Reply-To: <20201130100950.42051-1-jwi@linux.ibm.com>
References: <20201130100950.42051-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

gfp_type() uses in_interrupt() to figure out the correct GFP mask.

The usage of in_interrupt() in drivers is phased out and Linus clearly
requested that code which changes behaviour depending on context should
either be separated or the context be conveyed in an argument passed by the
caller, which usually knows the context.

ctcmpc_tx() is used as net_device_ops::ndo_start_xmit. This callback is
invoked with disabled bottom halves.

Use GFP_ATOMIC for memory allocation in ctcmpc_tx().
Remove gfp_type() since the last user is gone.

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/ctcm_main.c | 2 +-
 drivers/s390/net/ctcm_main.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index c446883de5c8..fd705429708e 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -903,7 +903,7 @@ static int ctcmpc_tx(struct sk_buff *skb, struct net_device *dev)
 		CTCM_D3_DUMP((char *)skb->data, min_t(int, 32, skb->len));
 
 		len =  skb->len + TH_HEADER_LENGTH + PDU_HEADER_LENGTH;
-		newskb = __dev_alloc_skb(len, gfp_type() | GFP_DMA);
+		newskb = __dev_alloc_skb(len, GFP_ATOMIC | GFP_DMA);
 
 		if (!newskb) {
 			CTCM_DBF_TEXT_(MPC_TRACE, CTC_DBF_ERROR,
diff --git a/drivers/s390/net/ctcm_main.h b/drivers/s390/net/ctcm_main.h
index 16bdf23ee02b..90bd7b3f80c3 100644
--- a/drivers/s390/net/ctcm_main.h
+++ b/drivers/s390/net/ctcm_main.h
@@ -298,11 +298,6 @@ struct mpc_group *ctcmpc_init_mpc_group(struct ctcm_priv *priv);
 /* test if struct ctcm_priv of struct net_device has MPC protocol setting */
 #define IS_MPCDEV(dev) IS_MPC((struct ctcm_priv *)dev->ml_priv)
 
-static inline gfp_t gfp_type(void)
-{
-	return in_interrupt() ? GFP_ATOMIC : GFP_KERNEL;
-}
-
 /*
  * Definition of our link level header.
  */
-- 
2.17.1
