Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728577AbgK3KKz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Nov 2020 05:10:55 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/6] s390/ctcm: Avoid temporary allocation of struct pdu.
Date: Mon, 30 Nov 2020 11:09:47 +0100
Message-Id: <20201130100950.42051-4-jwi@linux.ibm.com>
In-Reply-To: <20201130100950.42051-1-jwi@linux.ibm.com>
References: <20201130100950.42051-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The size of struct pdu is 8 byte. The memory is allocated, initialized,
used and deallocated a few lines later.

It is more efficient to avoid the allocation/free dance and assign the
values directly to skb's data part instead of using memcpy() for it.

Avoid an allocation of struct pdu and use the resulting skb pointer
instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[jwi: Fix-up the pdu_offset, adjust skb->len for the pushed length.
      Reflow the commit msg.]
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/ctcm_main.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 9e28c63415ed..92dd3c803d23 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -665,24 +665,16 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
 	if ((fsm_getstate(ch->fsm) != CTC_STATE_TXIDLE) || grp->in_sweep) {
 		spin_lock_irqsave(&ch->collect_lock, saveflags);
 		refcount_inc(&skb->users);
-		p_header = kmalloc(PDU_HEADER_LENGTH, gfp_type());
 
-		if (!p_header) {
-			spin_unlock_irqrestore(&ch->collect_lock, saveflags);
-				goto nomem_exit;
-		}
-
-		p_header->pdu_offset = skb->len;
+		p_header = skb_push(skb, PDU_HEADER_LENGTH);
+		p_header->pdu_offset = skb->len - PDU_HEADER_LENGTH;
 		p_header->pdu_proto = 0x01;
-		p_header->pdu_flag = 0x00;
 		if (be16_to_cpu(skb->protocol) == ETH_P_SNAP) {
-			p_header->pdu_flag |= PDU_FIRST | PDU_CNTL;
+			p_header->pdu_flag = PDU_FIRST | PDU_CNTL;
 		} else {
-			p_header->pdu_flag |= PDU_FIRST;
+			p_header->pdu_flag = PDU_FIRST;
 		}
 		p_header->pdu_seq = 0;
-		memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header,
-		       PDU_HEADER_LENGTH);
 
 		CTCM_PR_DEBUG("%s(%s): Put on collect_q - skb len: %04x \n"
 				"pdu header and data for up to 32 bytes:\n",
@@ -691,7 +683,6 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
 
 		skb_queue_tail(&ch->collect_queue, skb);
 		ch->collect_len += skb->len;
-		kfree(p_header);
 
 		spin_unlock_irqrestore(&ch->collect_lock, saveflags);
 			goto done;
@@ -721,23 +712,15 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
 		}
 	}
 
-	p_header = kmalloc(PDU_HEADER_LENGTH, gfp_type());
-
-	if (!p_header)
-		goto nomem_exit;
-
-	p_header->pdu_offset = skb->len;
+	p_header = skb_push(skb, PDU_HEADER_LENGTH);
+	p_header->pdu_offset = skb->len - PDU_HEADER_LENGTH;
 	p_header->pdu_proto = 0x01;
-	p_header->pdu_flag = 0x00;
 	p_header->pdu_seq = 0;
 	if (be16_to_cpu(skb->protocol) == ETH_P_SNAP) {
-		p_header->pdu_flag |= PDU_FIRST | PDU_CNTL;
+		p_header->pdu_flag = PDU_FIRST | PDU_CNTL;
 	} else {
-		p_header->pdu_flag |= PDU_FIRST;
+		p_header->pdu_flag = PDU_FIRST;
 	}
-	memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header, PDU_HEADER_LENGTH);
-
-	kfree(p_header);
 
 	if (ch->collect_len > 0) {
 		spin_lock_irqsave(&ch->collect_lock, saveflags);
-- 
2.17.1
