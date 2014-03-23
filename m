Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20140323150752.843705144@linutronix.de>
Date: Sun, 23 Mar 2014 15:09:25 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 03/16] s390: net: lcs: Add missing destroy_timer_on_stack()
References: <20140323150557.288925975@linutronix.de>
Content-Disposition: inline;
 filename=s390-net-lcs-add-missing-destroy-timer-on-stack.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, Ursula Braun <ursula.braun@de.ibm.com>, s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Otherwise we leak a tracking object when DEBUG_OBJECTS is enabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ursula Braun <ursula.braun@de.ibm.com>
Cc: s390 <linux-s390@vger.kernel.org>
---
 drivers/s390/net/lcs.c |    1 +
 1 file changed, 1 insertion(+)

Index: tip/drivers/s390/net/lcs.c
===================================================================
--- tip.orig/drivers/s390/net/lcs.c
+++ tip/drivers/s390/net/lcs.c
@@ -899,6 +899,7 @@ lcs_send_lancmd(struct lcs_card *card, s
 	add_timer(&timer);
 	wait_event(reply->wait_q, reply->received);
 	del_timer_sync(&timer);
+	destroy_timer_on_stack(&timer);
 	LCS_DBF_TEXT_(4, trace, "rc:%d",reply->rc);
 	rc = reply->rc;
 	lcs_put_reply(reply);
