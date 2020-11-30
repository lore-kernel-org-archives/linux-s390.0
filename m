Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729024AbgK3KKz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Nov 2020 05:10:55 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/6] s390/ctcm: Use explicit allocation mask in ctcmpc_unpack_skb().
Date: Mon, 30 Nov 2020 11:09:48 +0100
Message-Id: <20201130100950.42051-5-jwi@linux.ibm.com>
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

The call chain of ctcmpc_unpack_skb():
ctcmpc_bh()
 -> ctcmpc_unpack_skb()

ctcmpc_bh() is a tasklet handler so GFP_ATOMIC is needed.

Use GFP_ATOMIC as allocation type in ctcmpc_unpack_skb().

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/ctcm_mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 8ae49732d1d2..19ee91acb89d 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -1163,7 +1163,7 @@ static void ctcmpc_unpack_skb(struct channel *ch, struct sk_buff *pskb)
 			skb_pull(pskb, new_len); /* point to next PDU */
 		}
 	} else {
-		mpcginfo = kmalloc(sizeof(struct mpcg_info), gfp_type());
+		mpcginfo = kmalloc(sizeof(struct mpcg_info), GFP_ATOMIC);
 		if (mpcginfo == NULL)
 					goto done;
 
-- 
2.17.1
