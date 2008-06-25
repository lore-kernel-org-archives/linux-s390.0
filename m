Return-Path: <linux-kernel-owner+w=401wt.eu-S1759645AbYFYOk5@vger.kernel.org>
Message-Id: <20080625143615.981543822@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 18/21] Cleanup iucv printk messages.
Content-Disposition: inline; filename=817-printk-iucv.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Ursula Braun <braunu@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Ursula Braun <braunu@de.ibm.com>
---

 net/iucv/af_iucv.c |    8 ++------
 net/iucv/iucv.c    |    9 ++-------
 2 files changed, 4 insertions(+), 13 deletions(-)

Index: quilt-2.6/net/iucv/af_iucv.c
===================================================================
--- quilt-2.6.orig/net/iucv/af_iucv.c
+++ quilt-2.6/net/iucv/af_iucv.c
@@ -1135,8 +1135,7 @@ static void iucv_callback_txdone(struct 
 		if (this)
 			kfree_skb(this);
 	}
-	if (!this)
-		printk(KERN_ERR "AF_IUCV msg tag %u not found\n", msg->tag);
+	BUG_ON(!this);
 
 	if (sk->sk_state == IUCV_CLOSING) {
 		if (skb_queue_empty(&iucv_sk(sk)->send_skb_q)) {
@@ -1196,7 +1195,7 @@ static int __init afiucv_init(void)
 	}
 	cpcmd("QUERY USERID", iucv_userid, sizeof(iucv_userid), &err);
 	if (unlikely(err)) {
-		printk(KERN_ERR "AF_IUCV needs the VM userid\n");
+		WARN_ON(err);
 		err = -EPROTONOSUPPORT;
 		goto out;
 	}
@@ -1210,7 +1209,6 @@ static int __init afiucv_init(void)
 	err = sock_register(&iucv_sock_family_ops);
 	if (err)
 		goto out_proto;
-	printk(KERN_INFO "AF_IUCV lowlevel driver initialized\n");
 	return 0;
 
 out_proto:
@@ -1226,8 +1224,6 @@ static void __exit afiucv_exit(void)
 	sock_unregister(PF_IUCV);
 	proto_unregister(&iucv_proto);
 	iucv_unregister(&af_iucv_handler, 0);
-
-	printk(KERN_INFO "AF_IUCV lowlevel driver unloaded\n");
 }
 
 module_init(afiucv_init);
Index: quilt-2.6/net/iucv/iucv.c
===================================================================
--- quilt-2.6.orig/net/iucv/iucv.c
+++ quilt-2.6/net/iucv/iucv.c
@@ -1559,16 +1559,11 @@ static void iucv_external_interrupt(u16 
 
 	p = iucv_irq_data[smp_processor_id()];
 	if (p->ippathid >= iucv_max_pathid) {
-		printk(KERN_WARNING "iucv_do_int: Got interrupt with "
-		       "pathid %d > max_connections (%ld)\n",
-		       p->ippathid, iucv_max_pathid - 1);
+		WARN_ON(p->ippathid >= iucv_max_pathid);
 		iucv_sever_pathid(p->ippathid, iucv_error_no_listener);
 		return;
 	}
-	if (p->iptype  < 0x01 || p->iptype > 0x09) {
-		printk(KERN_ERR "iucv_do_int: unknown iucv interrupt\n");
-		return;
-	}
+	BUG_ON(p->iptype  < 0x01 || p->iptype > 0x09);
 	work = kmalloc(sizeof(struct iucv_irq_list), GFP_ATOMIC);
 	if (!work) {
 		printk(KERN_WARNING "iucv_external_interrupt: out of memory\n");

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
