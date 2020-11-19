Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgKSN52 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Nov 2020 08:57:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B6EC0613D4
        for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2020 05:57:28 -0800 (PST)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/6] s390/ctcm: Avoid temporary allocation of struct qllc.
Date: Thu, 19 Nov 2020 14:57:14 +0100
Message-Id: <20201119135719.983170-3-bigeasy@linutronix.de>
In-Reply-To: <20201119135719.983170-1-bigeasy@linutronix.de>
References: <20201119135719.983170-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The size of struct qllc is 2 byte. The memory for is allocated, initialized,
used and deallocated a few lines later.

It is more efficient to avoid the allocation/free dance and assign the
values directly to skb's data part instead of using memcpy() for it.

Avoid an allocation of struct qllc and use the resulting skb pointer instea=
d.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_mpc.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 0929ff2fd5c1a..76a9e0d0c0710 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -2049,7 +2049,6 @@ static void mpc_action_rcvd_xid7(fsm_instance *fsm, i=
nt event, void *arg)
  */
 static int mpc_send_qllc_discontact(struct net_device *dev)
 {
-	__u32	new_len	=3D 0;
 	struct sk_buff   *skb;
 	struct qllc      *qllcptr;
 	struct ctcm_priv *priv =3D dev->ml_priv;
@@ -2080,31 +2079,20 @@ static int mpc_send_qllc_discontact(struct net_devi=
ce *dev)
 	case MPCG_STATE_FLOWC:
 	case MPCG_STATE_READY:
 		grp->send_qllc_disc =3D 2;
-		new_len =3D sizeof(struct qllc);
-		qllcptr =3D kzalloc(new_len, gfp_type() | GFP_DMA);
-		if (qllcptr =3D=3D NULL) {
-			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
-				"%s(%s): qllcptr allocation error",
-						CTCM_FUNTAIL, dev->name);
-			return -ENOMEM;
-		}
-
-		qllcptr->qllc_address =3D 0xcc;
-		qllcptr->qllc_commands =3D 0x03;
-
-		skb =3D __dev_alloc_skb(new_len, GFP_ATOMIC);
=20
+		skb =3D __dev_alloc_skb(sizeof(struct qllc), GFP_ATOMIC);
 		if (skb =3D=3D NULL) {
 			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
 				"%s(%s): skb allocation error",
 						CTCM_FUNTAIL, dev->name);
 			priv->stats.rx_dropped++;
-			kfree(qllcptr);
 			return -ENOMEM;
 		}
=20
-		skb_put_data(skb, qllcptr, new_len);
-		kfree(qllcptr);
+
+		qllcptr =3D skb_put(skb, sizeof(struct qllc));
+		qllcptr->qllc_address =3D 0xcc;
+		qllcptr->qllc_commands =3D 0x03;
=20
 		if (skb_headroom(skb) < 4) {
 			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
--=20
2.29.2
