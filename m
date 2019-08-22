Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?=5bPATCH=5d_s390/ctcm=3a_Delete_unnecessary_checks_before?=
 =?UTF-8?B?IHRoZSBtYWNybyBjYWxsIOKAnGRldl9rZnJlZV9za2LigJ0=?=
Message-ID: <84733436-46d1-8f43-780e-7b3ab9f2a0ae@web.de>
Date: Thu, 22 Aug 2019 11:04:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 22 Aug 2019 10:55:33 +0200

The dev_kfree_skb() function performs also input parameter validation.
Thus the test around the shown calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/s390/net/ctcm_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index f63c5c871d3d..90025d1923d2 100644
=2D-- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1074,10 +1074,8 @@ static void ctcm_free_netdevice(struct net_device *=
dev)
 		if (grp) {
 			if (grp->fsm)
 				kfree_fsm(grp->fsm);
-			if (grp->xid_skb)
-				dev_kfree_skb(grp->xid_skb);
-			if (grp->rcvd_xid_skb)
-				dev_kfree_skb(grp->rcvd_xid_skb);
+			dev_kfree_skb(grp->xid_skb);
+			dev_kfree_skb(grp->rcvd_xid_skb);
 			tasklet_kill(&grp->mpc_tasklet2);
 			kfree(grp);
 			priv->mpcg =3D NULL;
=2D-
2.23.0
