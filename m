Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbgKRKyF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Nov 2020 05:54:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0808C061A48
        for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2020 02:54:04 -0800 (PST)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/6] s390/ctcm: Use GFP_KERNEL in add_channel().
Date: Wed, 18 Nov 2020 11:53:16 +0100
Message-Id: <20201118105317.605671-6-bigeasy@linutronix.de>
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

The memory allocation of `ch' a few lines above is using GFP_KERNEL,
also an allocation a few lines later is using GFP_KERNEL.

Use GFP_KERNEL for the memory allocation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index b56f51806b3d0..ca218489e0be4 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1323,7 +1323,7 @@ static int add_channel(struct ccw_device *cdev, enum =
ctcm_channel_types type,
=20
 	ch->protocol =3D priv->protocol;
 	if (IS_MPC(priv)) {
-		ch->discontact_th =3D kzalloc(TH_HEADER_LENGTH, gfp_type());
+		ch->discontact_th =3D kzalloc(TH_HEADER_LENGTH, GFP_KERNEL);
 		if (ch->discontact_th =3D=3D NULL)
 					goto nomem_return;
=20
--=20
2.29.2
