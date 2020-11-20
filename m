Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727137AbgKTKHI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 05:07:08 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net] net/af_iucv: set correct sk_protocol for child sockets
Date: Fri, 20 Nov 2020 11:06:57 +0100
Message-Id: <20201120100657.34407-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Child sockets erroneously inherit their parent's sk_type (ie. SOCK_*),
instead of the PF_IUCV protocol that the parent was created with in
iucv_sock_create().

We're currently not using sk->sk_protocol ourselves, so this shouldn't
have much impact (except eg. getting the output in skb_dump() right).

Fixes: eac3731bd04c ("[S390]: Add AF_IUCV socket support")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 net/iucv/af_iucv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 047238f01ba6..db7d888914fa 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1645,7 +1645,7 @@ static int iucv_callback_connreq(struct iucv_path *path,
 	}
 
 	/* Create the new socket */
-	nsk = iucv_sock_alloc(NULL, sk->sk_type, GFP_ATOMIC, 0);
+	nsk = iucv_sock_alloc(NULL, sk->sk_protocol, GFP_ATOMIC, 0);
 	if (!nsk) {
 		err = pr_iucv->path_sever(path, user_data);
 		iucv_path_free(path);
@@ -1851,7 +1851,7 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 		goto out;
 	}
 
-	nsk = iucv_sock_alloc(NULL, sk->sk_type, GFP_ATOMIC, 0);
+	nsk = iucv_sock_alloc(NULL, sk->sk_protocol, GFP_ATOMIC, 0);
 	bh_lock_sock(sk);
 	if ((sk->sk_state != IUCV_LISTEN) ||
 	    sk_acceptq_is_full(sk) ||
-- 
2.17.1
