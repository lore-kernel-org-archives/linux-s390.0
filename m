From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 3/3] af_iucv: defensive programming of iucv_callback_txdone
Date: Thu, 07 Feb 2008 15:28:45 +0100
Message-ID: <20080207143534.776313000@linux.vnet.ibm.com>
References: <20080207142842.852003000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=714-afiucv-txdone.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>

The loop in iucv_callback_txdone presumes existence of an entry
with msg->tag in the send_skb_q list. In error cases this
assumption might be wrong and might cause an endless loop.
Loop is rewritten to guarantee loop end in case of missing
msg->tag entry in send_skb_q.

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
---

 net/iucv/af_iucv.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/net/iucv/af_iucv.c linux-2.6-patched/net/iucv/af_iucv.c
--- linux-2.6/net/iucv/af_iucv.c	2008-02-07 13:24:39.000000000 +0100
+++ linux-2.6-patched/net/iucv/af_iucv.c	2008-02-07 13:24:39.000000000 +0100
@@ -1112,24 +1112,31 @@ static void iucv_callback_txdone(struct 
 				 struct iucv_message *msg)
 {
 	struct sock *sk = path->private;
-	struct sk_buff *this;
+	struct sk_buff *this = NULL;
 	struct sk_buff_head *list = &iucv_sk(sk)->send_skb_q;
 	struct sk_buff *list_skb = list->next;
 	unsigned long flags;
 
-	if (list_skb) {
+	if (!skb_queue_empty(list)) {
 		spin_lock_irqsave(&list->lock, flags);
 
-		do {
-			this = list_skb;
+		while (list_skb != (struct sk_buff *)list) {
+			if (!memcmp(&msg->tag, list_skb->cb, 4)) {
+				this = list_skb;
+				break;
+			}
 			list_skb = list_skb->next;
-		} while (memcmp(&msg->tag, this->cb, 4) && list_skb);
-		__skb_unlink(this, list);
+		}
+		if (this)
+			__skb_unlink(this, list);
 
 		spin_unlock_irqrestore(&list->lock, flags);
 
-		kfree_skb(this);
+		if (this)
+			kfree_skb(this);
 	}
+	if (!this)
+		printk(KERN_ERR "AF_IUCV msg tag %u not found\n", msg->tag);
 
 	if (sk->sk_state == IUCV_CLOSING) {
 		if (skb_queue_empty(&iucv_sk(sk)->send_skb_q)) {

-- 
