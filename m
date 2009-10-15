From: Ursula Braun <ursula.braun@de.ibm.com>
Subject: [patch 2/5] [PATCH] af_iucv: remove duplicate sock_set_flag
Date: Thu, 15 Oct 2009 10:54:56 +0200
Message-ID: <20091015090749.638697000@linux.vnet.ibm.com>
References: <20091015085454.124154000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=602-af_iucv-fallout.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Remove duplicate sock_set_flag(sk, SOCK_ZAPPED) in iucv_sock_close,
which has been overlooked in September-commit
7514bab04e567c9408fe0facbde4277f09d5eb74.

Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>

---

 net/iucv/af_iucv.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-next-uschi/net/iucv/af_iucv.c
===================================================================
--- linux-next-uschi.orig/net/iucv/af_iucv.c
+++ linux-next-uschi/net/iucv/af_iucv.c
@@ -428,7 +428,6 @@ static void iucv_sock_close(struct sock 
 		break;
 
 	default:
-		sock_set_flag(sk, SOCK_ZAPPED);
 		/* nothing to do here */
 		break;
 	}
