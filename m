From: Ursula Braun <ursula.braun@de.ibm.com>
Subject: [patch 5/7] [PATCH] af_iucv: handle non-accepted sockets after resuming from suspend
Date: Wed, 16 Sep 2009 16:37:26 +0200
Message-ID: <20090916144304.680334000@linux.vnet.ibm.com>
References: <20090916143721.863799000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=605-af_iucv-socket-discon.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

After resuming from suspend, all af_iucv sockets are disconnected.
Ensure that iucv_accept_dequeue() can handle disconnected sockets
which are not yet accepted.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
---

 net/iucv/af_iucv.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6-uschi/net/iucv/af_iucv.c
===================================================================
--- linux-2.6-uschi.orig/net/iucv/af_iucv.c
+++ linux-2.6-uschi/net/iucv/af_iucv.c
@@ -569,6 +569,7 @@ struct sock *iucv_accept_dequeue(struct 
 
 		if (sk->sk_state == IUCV_CONNECTED ||
 		    sk->sk_state == IUCV_SEVERED ||
+		    sk->sk_state == IUCV_DISCONN ||	/* due to PM restore */
 		    !newsock) {
 			iucv_accept_unlink(sk);
 			if (newsock)
