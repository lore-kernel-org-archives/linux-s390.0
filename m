Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731234AbfHBIsK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Aug 2019 04:48:10 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x728lFXu116775
        for <linux-s390@vger.kernel.org>; Fri, 2 Aug 2019 04:48:09 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4gx32rqb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 02 Aug 2019 04:48:09 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Fri, 2 Aug 2019 09:48:06 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net] net/smc: avoid fallback in case of non-blocking connect
Date: Fri,  2 Aug 2019 10:47:50 +0200
Message-Id: <20190802084750.5518-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

FASTOPEN is not possible with SMC. sendmsg() with msg_flag MSG_FASTOPEN
triggers a fallback to TCP if the socket is in state SMC_INIT.
But if a nonblocking connect is already started, fallback to TCP
is no longer possible, even though the socket may still be in state
SMC_INIT.
And if a nonblocking connect is already started, a listen() call
does not make sense.

Reported-by: syzbot+bd8cc73d665590a1fcad@syzkaller.appspotmail.com
Fixes: 50717a37db032 ("net/smc: nonblocking connect rework")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index f5ea09258ab0..5b932583e407 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -263,7 +263,7 @@ static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
 
 	/* Check if socket is already active */
 	rc = -EINVAL;
-	if (sk->sk_state != SMC_INIT)
+	if (sk->sk_state != SMC_INIT || smc->connect_nonblock)
 		goto out_rel;
 
 	smc->clcsock->sk->sk_reuse = sk->sk_reuse;
@@ -1390,7 +1390,8 @@ static int smc_listen(struct socket *sock, int backlog)
 	lock_sock(sk);
 
 	rc = -EINVAL;
-	if ((sk->sk_state != SMC_INIT) && (sk->sk_state != SMC_LISTEN))
+	if ((sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) ||
+	    smc->connect_nonblock)
 		goto out;
 
 	rc = 0;
@@ -1518,7 +1519,7 @@ static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out;
 
 	if (msg->msg_flags & MSG_FASTOPEN) {
-		if (sk->sk_state == SMC_INIT) {
+		if (sk->sk_state == SMC_INIT && !smc->connect_nonblock) {
 			smc_switch_to_fallback(smc);
 			smc->fallback_rsn = SMC_CLC_DECL_OPTUNSUPP;
 		} else {
-- 
2.21.0
