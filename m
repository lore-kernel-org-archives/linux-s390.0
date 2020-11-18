Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:54298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgKRKyD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Nov 2020 05:54:03 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/6] s390/ctcm: Put struct pdu on stack.
Date: Wed, 18 Nov 2020 11:53:14 +0100
Message-Id: <20201118105317.605671-4-bigeasy@linutronix.de>
In-Reply-To: <20201118105317.605671-1-bigeasy@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The size of struct pdu is 8 byte. The memory is allocated, initialized,
used and deallocated a few lines later.

It is more efficient to avoid the allocation/free dance and keeping the
variable on stack. Especially since the compiler is smart enough to not
allocate the memory on stack but assign the values directly.

Add a variable pdu_hdr on stack and use it instead of p_header. p_header
is used later as a pointer without an allocation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_main.c | 41 ++++++++++++------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 6c7d6bbd27406..b56f51806b3d0 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -649,6 +649,7 @@ static void ctcmpc_send_sweep_req(struct channel *rch)
 static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
 {
 	struct pdu *p_header;
+	struct pdu pdu_hdr;
 	struct net_device *dev =3D ch->netdev;
 	struct ctcm_priv *priv =3D dev->ml_priv;
 	struct mpc_group *grp =3D priv->mpcg;
@@ -666,23 +667,16 @@ static int ctcmpc_transmit_skb(struct channel *ch, st=
ruct sk_buff *skb)
 	if ((fsm_getstate(ch->fsm) !=3D CTC_STATE_TXIDLE) || grp->in_sweep) {
 		spin_lock_irqsave(&ch->collect_lock, saveflags);
 		refcount_inc(&skb->users);
-		p_header =3D kmalloc(PDU_HEADER_LENGTH, gfp_type());
=20
-		if (!p_header) {
-			spin_unlock_irqrestore(&ch->collect_lock, saveflags);
-				goto nomem_exit;
-		}
-
-		p_header->pdu_offset =3D skb->len;
-		p_header->pdu_proto =3D 0x01;
-		p_header->pdu_flag =3D 0x00;
+		pdu_hdr.pdu_offset =3D skb->len;
+		pdu_hdr.pdu_proto =3D 0x01;
 		if (be16_to_cpu(skb->protocol) =3D=3D ETH_P_SNAP) {
-			p_header->pdu_flag |=3D PDU_FIRST | PDU_CNTL;
+			pdu_hdr.pdu_flag =3D PDU_FIRST | PDU_CNTL;
 		} else {
-			p_header->pdu_flag |=3D PDU_FIRST;
+			pdu_hdr.pdu_flag =3D PDU_FIRST;
 		}
-		p_header->pdu_seq =3D 0;
-		memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header,
+		pdu_hdr.pdu_seq =3D 0;
+		memcpy(skb_push(skb, PDU_HEADER_LENGTH), &pdu_hdr,
 		       PDU_HEADER_LENGTH);
=20
 		CTCM_PR_DEBUG("%s(%s): Put on collect_q - skb len: %04x \n"
@@ -692,7 +686,6 @@ static int ctcmpc_transmit_skb(struct channel *ch, stru=
ct sk_buff *skb)
=20
 		skb_queue_tail(&ch->collect_queue, skb);
 		ch->collect_len +=3D skb->len;
-		kfree(p_header);
=20
 		spin_unlock_irqrestore(&ch->collect_lock, saveflags);
 			goto done;
@@ -722,23 +715,15 @@ static int ctcmpc_transmit_skb(struct channel *ch, st=
ruct sk_buff *skb)
 		}
 	}
=20
-	p_header =3D kmalloc(PDU_HEADER_LENGTH, gfp_type());
-
-	if (!p_header)
-		goto nomem_exit;
-
-	p_header->pdu_offset =3D skb->len;
-	p_header->pdu_proto =3D 0x01;
-	p_header->pdu_flag =3D 0x00;
-	p_header->pdu_seq =3D 0;
+	pdu_hdr.pdu_offset =3D skb->len;
+	pdu_hdr.pdu_proto =3D 0x01;
+	pdu_hdr.pdu_seq =3D 0;
 	if (be16_to_cpu(skb->protocol) =3D=3D ETH_P_SNAP) {
-		p_header->pdu_flag |=3D PDU_FIRST | PDU_CNTL;
+		pdu_hdr.pdu_flag =3D PDU_FIRST | PDU_CNTL;
 	} else {
-		p_header->pdu_flag |=3D PDU_FIRST;
+		pdu_hdr.pdu_flag =3D PDU_FIRST;
 	}
-	memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header, PDU_HEADER_LENGTH);
-
-	kfree(p_header);
+	memcpy(skb_push(skb, PDU_HEADER_LENGTH), &pdu_hdr, PDU_HEADER_LENGTH);
=20
 	if (ch->collect_len > 0) {
 		spin_lock_irqsave(&ch->collect_lock, saveflags);
--=20
2.29.2
