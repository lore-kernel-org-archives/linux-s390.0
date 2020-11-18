Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:54304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgKRKyC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Nov 2020 05:54:02 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/6] s390/ctcm: Use explicit allocation mask in ctcmpc_unpack_skb().
Date: Wed, 18 Nov 2020 11:53:15 +0100
Message-Id: <20201118105317.605671-5-bigeasy@linutronix.de>
In-Reply-To: <20201118105317.605671-1-bigeasy@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 4ff51af44d338..38c535f016363 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -1164,7 +1164,7 @@ static void ctcmpc_unpack_skb(struct channel *ch, str=
uct sk_buff *pskb)
 			skb_pull(pskb, new_len); /* point to next PDU */
 		}
 	} else {
-		mpcginfo =3D kmalloc(sizeof(struct mpcg_info), gfp_type());
+		mpcginfo =3D kmalloc(sizeof(struct mpcg_info), GFP_ATOMIC);
 		if (mpcginfo =3D=3D NULL)
 					goto done;
=20
--=20
2.29.2
