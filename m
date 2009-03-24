From: Ursula Braun <ursula.braun@de.ibm.com>
Subject: [patch 4/9] [PATCH] claw: invalid return codes from hard_start_xmit
Date: Tue, 24 Mar 2009 14:27:46 +0100
Message-ID: <20090324133049.239518000@linux.vnet.ibm.com>
References: <20090324132742.300929000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=611-claw-rc-warning.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Avoid kernel warnings by using the correct hard_start_xmit return
code NETDEV_TX_BUSY for skb requeuing.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
---

 drivers/s390/net/claw.c |    2 ++
 1 file changed, 2 insertions(+)

diff -urpN linux-2.6/drivers/s390/net/claw.c linux-2.6-patched/drivers/s390/net/claw.c
--- linux-2.6/drivers/s390/net/claw.c	2008-12-25 00:26:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/claw.c	2009-03-04 15:58:30.000000000 +0100
@@ -335,6 +335,8 @@ claw_tx(struct sk_buff *skb, struct net_
         rc=claw_hw_tx( skb, dev, 1 );
         spin_unlock_irqrestore(get_ccwdev_lock(p_ch->cdev), saveflags);
 	CLAW_DBF_TEXT_(4, trace, "clawtx%d", rc);
+	if (rc)
+		rc = NETDEV_TX_BUSY;
         return rc;
 }   /*  end of claw_tx */
 
