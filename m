Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728317AbfJ2Llk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Oct 2019 07:41:40 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9TBdrCA124947
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 07:41:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxmr9r1qf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 07:41:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Tue, 29 Oct 2019 11:41:36 -0000
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/1] net/smc: fix refcounting for non-blocking connect()
Date: Tue, 29 Oct 2019 12:41:26 +0100
Message-Id: <20191029114126.59907-1-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com

If a nonblocking socket is immediately closed after connect(),
the connect worker may not have started. This results in a refcount
problem, since sock_hold() is called from the connect worker.
This patch moves the sock_hold in front of the connect worker
scheduling.

Reported-by: syzbot+4c063e6dea39e4b79f29@syzkaller.appspotmail.com
Fixes: 50717a37db03 ("net/smc: nonblocking connect rework")
Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index cea3c36ea0da..47946f489fd4 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -707,8 +707,6 @@ static int __smc_connect(struct smc_sock *smc)
 	int smc_type;
 	int rc = 0;
 
-	sock_hold(&smc->sk); /* sock put in passive closing */
-
 	if (smc->use_fallback)
 		return smc_connect_fallback(smc, smc->fallback_rsn);
 
@@ -853,6 +851,8 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
 	rc = kernel_connect(smc->clcsock, addr, alen, flags);
 	if (rc && rc != -EINPROGRESS)
 		goto out;
+
+	sock_hold(&smc->sk); /* sock put in passive closing */
 	if (flags & O_NONBLOCK) {
 		if (schedule_work(&smc->connect_work))
 			smc->connect_nonblock = 1;
-- 
2.17.1
