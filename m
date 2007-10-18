Return-Path: <linux-kernel-owner+w=401wt.eu-S1763420AbXJRKiF@vger.kernel.org>
Subject: Re: s390x: getting ipv6 bugs on mainline since 2.6.23-git3
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <47172AD5.2030009@trash.net>
References: <20071018093556.GT21136@shadowen.org>
	 <47172AD5.2030009@trash.net>
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 18 Oct 2007 12:37:44 +0200
Message-Id: <1192703864.13572.3.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Patrick McHardy <kaber@trash.net>
Cc: Andy Whitcroft <apw@shadowen.org>, linux390@de.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On Thu, 2007-10-18 at 11:43 +0200, Patrick McHardy wrote:
> Andy Whitcroft wrote:
> > Seems we are getting some kind of bug out of our s390x partition (lnxab=
at1)
> > when booting latest mainline releases, specifically since 2.6.23-git3.
> >=20
> > Kernel BUG at 0000000000000002 =DDverbose debug info unavailable?
> > illegal operation: 0001 =DD#1?
> Which network driver are you using? Please post the output of
> "ip link list <dev>".

This is a bug in the qeth driver. It has been introduced by this commit:

commit 3b04ddde02cf1b6f14f2697da5c20eca5715017f
Author: Stephen Hemminger <shemminger@linux-foundation.org>
Date:   Tue Oct 9 01:40:57 2007 -0700

    [NET]: Move hardware header operations out of netdevice.

    Since hardware header operations are part of the protocol class
    not the device instance, make them into a separate object and
    save memory.

    Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

I've hacked up a fix for it. The real fix will be done by our networking
people.

--=20
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

---

 drivers/s390/net/qeth_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers=
/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2007-10-17 15:05:36.000000000 +0=
200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2007-10-17 15:05:46.0000=
00000 +0200
@@ -6643,7 +6643,8 @@ qeth_netdev_init(struct net_device *dev)
 	dev->vlan_rx_kill_vid =3D qeth_vlan_rx_kill_vid;
 	dev->vlan_rx_add_vid =3D qeth_vlan_rx_add_vid;
 #endif
-	dev->header_ops =3D &qeth_null_ops;
+	if (qeth_get_netdev_flags(card) & IFF_NOARP)
+		dev->header_ops =3D &qeth_null_ops;
=20
 #ifdef CONFIG_QETH_IPV6
 	/*IPv6 address autoconfiguration stuff*/
