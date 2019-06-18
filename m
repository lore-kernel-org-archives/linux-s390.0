Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729642AbfFRSnS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Jun 2019 14:43:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IIgrZv046841
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2019 14:43:17 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t73p7d2sh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Jun 2019 14:43:16 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 18 Jun 2019 19:43:14 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/3] net/af_iucv: remove GFP_DMA restriction for HiperTransport
Date: Tue, 18 Jun 2019 20:42:59 +0200
In-Reply-To: <20190618184301.96472-1-jwi@linux.ibm.com>
References: <20190618184301.96472-1-jwi@linux.ibm.com>
Message-Id: <20190618184301.96472-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

af_iucv sockets over z/VM IUCV require that their skbs are allocated
in DMA memory. This restriction doesn't apply to connections over
HiperSockets. So only set this limit for z/VM IUCV sockets, thereby
increasing the likelihood that the large (and linear!) allocations for
HiperTransport messages succeed.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 net/iucv/af_iucv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 36eb8d1d9128..2ee68d2d4693 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -588,7 +588,6 @@ static struct sock *iucv_sock_alloc(struct socket *sock, int proto, gfp_t prio,
 
 	sk->sk_destruct = iucv_sock_destruct;
 	sk->sk_sndtimeo = IUCV_CONN_TIMEOUT;
-	sk->sk_allocation = GFP_DMA;
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
@@ -782,6 +781,7 @@ static int iucv_sock_bind(struct socket *sock, struct sockaddr *addr,
 		memcpy(iucv->src_user_id, iucv_userid, 8);
 		sk->sk_state = IUCV_BOUND;
 		iucv->transport = AF_IUCV_TRANS_IUCV;
+		sk->sk_allocation |= GFP_DMA;
 		if (!iucv->msglimit)
 			iucv->msglimit = IUCV_QUEUELEN_DEFAULT;
 		goto done_unlock;
@@ -806,6 +806,8 @@ static int iucv_sock_autobind(struct sock *sk)
 		return -EPROTO;
 
 	memcpy(iucv->src_user_id, iucv_userid, 8);
+	iucv->transport = AF_IUCV_TRANS_IUCV;
+	sk->sk_allocation |= GFP_DMA;
 
 	write_lock_bh(&iucv_sk_list.lock);
 	__iucv_auto_name(iucv);
@@ -1781,6 +1783,8 @@ static int iucv_callback_connreq(struct iucv_path *path,
 
 	niucv = iucv_sk(nsk);
 	iucv_sock_init(nsk, sk);
+	niucv->transport = AF_IUCV_TRANS_IUCV;
+	nsk->sk_allocation |= GFP_DMA;
 
 	/* Set the new iucv_sock */
 	memcpy(niucv->dst_name, ipuser + 8, 8);
-- 
2.17.1
