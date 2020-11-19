Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:33826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgKSN53 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Nov 2020 08:57:29 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/6] s390/ctcm: Avoid temporary allocation of struct pdu.
Date: Thu, 19 Nov 2020 14:57:15 +0100
Message-Id: <20201119135719.983170-4-bigeasy@linutronix.de>
In-Reply-To: <20201119135719.983170-1-bigeasy@linutronix.de>
References: <20201119135719.983170-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The size of struct pdu is 8 byte. The memory is allocated, initialized,
used and deallocated a few lines later.

It is more efficient to avoid the allocation/free dance and assign the
values directly to skb's data part instead of using memcpy() for it.

Avoid an allocation of struct pdu and use the resulting skb pointer instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_main.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index a3a74ebfee635..0cb130c280031 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -666,24 +666,16 @@ static int ctcmpc_transmit_skb(struct channel *ch, st=
ruct sk_buff *skb)
 	if ((fsm_getstate(ch->fsm) !=3D CTC_STATE_TXIDLE) || grp->in_sweep) {
 		spin_lock_irqsave(&ch->collect_lock, saveflags);
 		refcount_inc(&skb->users);
-		p_header =3D kmalloc(PDU_HEADER_LENGTH, gfp_type());
-
-		if (!p_header) {
-			spin_unlock_irqrestore(&ch->collect_lock, saveflags);
-				goto nomem_exit;
-		}
=20
+		p_header =3D skb_push(skb, PDU_HEADER_LENGTH);
 		p_header->pdu_offset =3D skb->len;
 		p_header->pdu_proto =3D 0x01;
-		p_header->pdu_flag =3D 0x00;
 		if (be16_to_cpu(skb->protocol) =3D=3D ETH_P_SNAP) {
-			p_header->pdu_flag |=3D PDU_FIRST | PDU_CNTL;
+			p_header->pdu_flag =3D PDU_FIRST | PDU_CNTL;
 		} else {
-			p_header->pdu_flag |=3D PDU_FIRST;
+			p_header->pdu_flag =3D PDU_FIRST;
 		}
 		p_header->pdu_seq =3D 0;
-		memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header,
-		       PDU_HEADER_LENGTH);
=20
 		CTCM_PR_DEBUG("%s(%s): Put on collect_q - skb len: %04x \n"
 				"pdu header and data for up to 32 bytes:\n",
@@ -692,7 +684,6 @@ static int ctcmpc_transmit_skb(struct channel *ch, stru=
ct sk_buff *skb)
=20
 		skb_queue_tail(&ch->collect_queue, skb);
 		ch->collect_len +=3D skb->len;
-		kfree(p_header);
=20
 		spin_unlock_irqrestore(&ch->collect_lock, saveflags);
 			goto done;
@@ -722,23 +713,15 @@ static int ctcmpc_transmit_skb(struct channel *ch, st=
ruct sk_buff *skb)
 		}
 	}
=20
-	p_header =3D kmalloc(PDU_HEADER_LENGTH, gfp_type());
-
-	if (!p_header)
-		goto nomem_exit;
-
+	p_header =3D skb_push(skb, PDU_HEADER_LENGTH);
 	p_header->pdu_offset =3D skb->len;
 	p_header->pdu_proto =3D 0x01;
-	p_header->pdu_flag =3D 0x00;
 	p_header->pdu_seq =3D 0;
 	if (be16_to_cpu(skb->protocol) =3D=3D ETH_P_SNAP) {
-		p_header->pdu_flag |=3D PDU_FIRST | PDU_CNTL;
+		p_header->pdu_flag =3D PDU_FIRST | PDU_CNTL;
 	} else {
-		p_header->pdu_flag |=3D PDU_FIRST;
+		p_header->pdu_flag =3D PDU_FIRST;
 	}
-	memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header, PDU_HEADER_LENGTH);
-
-	kfree(p_header);
=20
 	if (ch->collect_len > 0) {
 		spin_lock_irqsave(&ch->collect_lock, saveflags);
--=20
2.29.2
