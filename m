Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728574AbgK3KKs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Nov 2020 05:10:48 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/6] s390/ctcm: Use GFP_KERNEL in add_channel().
Date: Mon, 30 Nov 2020 11:09:49 +0100
Message-Id: <20201130100950.42051-6-jwi@linux.ibm.com>
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

The memory allocation of `ch' a few lines above is using GFP_KERNEL,
also an allocation a few lines later is using GFP_KERNEL.

Use GFP_KERNEL for the memory allocation.

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/ctcm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 92dd3c803d23..c446883de5c8 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1321,7 +1321,7 @@ static int add_channel(struct ccw_device *cdev, enum ctcm_channel_types type,
 
 	ch->protocol = priv->protocol;
 	if (IS_MPC(priv)) {
-		ch->discontact_th = kzalloc(TH_HEADER_LENGTH, gfp_type());
+		ch->discontact_th = kzalloc(TH_HEADER_LENGTH, GFP_KERNEL);
 		if (ch->discontact_th == NULL)
 					goto nomem_return;
 
-- 
2.17.1
