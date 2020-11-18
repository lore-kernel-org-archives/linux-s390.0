Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:54282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRKyC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Nov 2020 05:54:02 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/6] s390/ctcm: Put struct th_header and th_sweep on stack.
Date: Wed, 18 Nov 2020 11:53:12 +0100
Message-Id: <20201118105317.605671-2-bigeasy@linutronix.de>
In-Reply-To: <20201118105317.605671-1-bigeasy@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The size of struct th_header is 8 byte and the size of struct th_sweep
is 16 byte. The memory for is allocated, initialized, used and
deallocated a few lines later.

It is more efficient to avoid the allocation/free dance and keeping the
variable on stack. Especially since the compiler is smart enough to not
allocate the memory on stack but assign the values directly.

Declare struct th_sweep/th_header on stack and initialize it to zero.
Use the local variable instead of the pointer.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_fsms.c | 17 +++++-----------
 drivers/s390/net/ctcm_main.c | 39 ++++++++----------------------------
 drivers/s390/net/ctcm_mpc.c  | 21 ++++---------------
 3 files changed, 17 insertions(+), 60 deletions(-)

diff --git a/drivers/s390/net/ctcm_fsms.c b/drivers/s390/net/ctcm_fsms.c
index 661d2a49bce96..d6592d576d1dd 100644
--- a/drivers/s390/net/ctcm_fsms.c
+++ b/drivers/s390/net/ctcm_fsms.c
@@ -1220,7 +1220,7 @@ static void ctcmpc_chx_txdone(fsm_instance *fi, int e=
vent, void *arg)
 	unsigned long	duration;
 	struct sk_buff	*peekskb;
 	int		rc;
-	struct th_header *header;
+	struct th_header header =3D {0, };
 	struct pdu	*p_header;
 	unsigned long done_stamp =3D jiffies;
=20
@@ -1303,24 +1303,17 @@ static void ctcmpc_chx_txdone(fsm_instance *fi, int=
 event, void *arg)
 	/* p_header points to the last one we handled */
 	if (p_header)
 		p_header->pdu_flag |=3D PDU_LAST;	/*Say it's the last one*/
-	header =3D kzalloc(TH_HEADER_LENGTH, gfp_type());
-	if (!header) {
-		spin_unlock(&ch->collect_lock);
-		fsm_event(priv->mpcg->fsm, MPCG_EVENT_INOP, dev);
-				goto done;
-	}
-	header->th_ch_flag =3D TH_HAS_PDU;  /* Normal data */
+
+	header.th_ch_flag =3D TH_HAS_PDU;  /* Normal data */
 	ch->th_seq_num++;
-	header->th_seq_num =3D ch->th_seq_num;
+	header.th_seq_num =3D ch->th_seq_num;
=20
 	CTCM_PR_DBGDATA("%s: ToVTAM_th_seq=3D %08x\n" ,
 					__func__, ch->th_seq_num);
=20
-	memcpy(skb_push(ch->trans_skb, TH_HEADER_LENGTH), header,
+	memcpy(skb_push(ch->trans_skb, TH_HEADER_LENGTH), &header,
 		TH_HEADER_LENGTH);	/* put the TH on the packet */
=20
-	kfree(header);
-
 	CTCM_PR_DBGDATA("%s: trans_skb len:%04x \n",
 		       __func__, ch->trans_skb->len);
 	CTCM_PR_DBGDATA("%s: up-to-50 bytes of trans_skb "
diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index d06809eac16d3..6c7d6bbd27406 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -599,7 +599,7 @@ static void ctcmpc_send_sweep_req(struct channel *rch)
 	struct net_device *dev =3D rch->netdev;
 	struct ctcm_priv *priv;
 	struct mpc_group *grp;
-	struct th_sweep *header;
+	struct th_sweep header =3D { 0, };
 	struct sk_buff *sweep_skb;
 	struct channel *ch;
 	/* int rc =3D 0; */
@@ -623,24 +623,10 @@ static void ctcmpc_send_sweep_req(struct channel *rch)
 				goto nomem;
 	}
=20
-	header =3D kmalloc(TH_SWEEP_LENGTH, gfp_type());
+	header.th.th_ch_flag	=3D TH_SWEEP_REQ;  /* 0x0f */
+	header.sw.th_last_seq	=3D ch->th_seq_num;
=20
-	if (!header) {
-		dev_kfree_skb_any(sweep_skb);
-		/* rc =3D -ENOMEM; */
-				goto nomem;
-	}
-
-	header->th.th_seg	=3D 0x00 ;
-	header->th.th_ch_flag	=3D TH_SWEEP_REQ;  /* 0x0f */
-	header->th.th_blk_flag	=3D 0x00;
-	header->th.th_is_xid	=3D 0x00;
-	header->th.th_seq_num	=3D 0x00;
-	header->sw.th_last_seq	=3D ch->th_seq_num;
-
-	skb_put_data(sweep_skb, header, TH_SWEEP_LENGTH);
-
-	kfree(header);
+	skb_put_data(sweep_skb, &header, TH_SWEEP_LENGTH);
=20
 	netif_trans_update(dev);
 	skb_queue_tail(&ch->sweep_queue, sweep_skb);
@@ -666,7 +652,7 @@ static int ctcmpc_transmit_skb(struct channel *ch, stru=
ct sk_buff *skb)
 	struct net_device *dev =3D ch->netdev;
 	struct ctcm_priv *priv =3D dev->ml_priv;
 	struct mpc_group *grp =3D priv->mpcg;
-	struct th_header *header;
+	struct th_header header =3D { 0, };
 	struct sk_buff *nskb;
 	int rc =3D 0;
 	int ccw_idx;
@@ -768,24 +754,15 @@ static int ctcmpc_transmit_skb(struct channel *ch, st=
ruct sk_buff *skb)
=20
 	ch->prof.txlen +=3D skb->len - PDU_HEADER_LENGTH;
=20
-	header =3D kmalloc(TH_HEADER_LENGTH, gfp_type());
-	if (!header)
-		goto nomem_exit;
-
-	header->th_seg =3D 0x00;
-	header->th_ch_flag =3D TH_HAS_PDU;  /* Normal data */
-	header->th_blk_flag =3D 0x00;
-	header->th_is_xid =3D 0x00;          /* Just data here */
+	header.th_ch_flag =3D TH_HAS_PDU;  /* Normal data */
 	ch->th_seq_num++;
-	header->th_seq_num =3D ch->th_seq_num;
+	header.th_seq_num =3D ch->th_seq_num;
=20
 	CTCM_PR_DBGDATA("%s(%s) ToVTAM_th_seq=3D %08x\n" ,
 		       __func__, dev->name, ch->th_seq_num);
=20
 	/* put the TH on the packet */
-	memcpy(skb_push(skb, TH_HEADER_LENGTH), header, TH_HEADER_LENGTH);
-
-	kfree(header);
+	memcpy(skb_push(skb, TH_HEADER_LENGTH), &header, TH_HEADER_LENGTH);
=20
 	CTCM_PR_DBGDATA("%s(%s): skb len: %04x\n - pdu header and data for "
 			"up to 32 bytes sent to vtam:\n",
diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 85a1a4533cbeb..04a51cc89e74c 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -641,7 +641,7 @@ static void ctcmpc_send_sweep_resp(struct channel *rch)
 	struct net_device *dev =3D rch->netdev;
 	struct ctcm_priv *priv =3D dev->ml_priv;
 	struct mpc_group *grp =3D priv->mpcg;
-	struct th_sweep *header;
+	struct th_sweep header =3D { 0, };
 	struct sk_buff *sweep_skb;
 	struct channel *ch  =3D priv->channel[CTCM_WRITE];
=20
@@ -655,23 +655,10 @@ static void ctcmpc_send_sweep_resp(struct channel *rc=
h)
 		goto done;
 	}
=20
-	header =3D kmalloc(sizeof(struct th_sweep), gfp_type());
+	header.th.th_ch_flag	=3D TH_SWEEP_RESP;
+	header.sw.th_last_seq	=3D ch->th_seq_num;
=20
-	if (!header) {
-		dev_kfree_skb_any(sweep_skb);
-		goto done;
-	}
-
-	header->th.th_seg	=3D 0x00 ;
-	header->th.th_ch_flag	=3D TH_SWEEP_RESP;
-	header->th.th_blk_flag	=3D 0x00;
-	header->th.th_is_xid	=3D 0x00;
-	header->th.th_seq_num	=3D 0x00;
-	header->sw.th_last_seq	=3D ch->th_seq_num;
-
-	skb_put_data(sweep_skb, header, TH_SWEEP_LENGTH);
-
-	kfree(header);
+	skb_put_data(sweep_skb, &header, TH_SWEEP_LENGTH);
=20
 	netif_trans_update(dev);
 	skb_queue_tail(&ch->sweep_queue, sweep_skb);
--=20
2.29.2
