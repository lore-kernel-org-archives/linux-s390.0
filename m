Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726799AbfKLPDu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Nov 2019 10:03:50 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACEkeH4021052
        for <linux-s390@vger.kernel.org>; Tue, 12 Nov 2019 10:03:50 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7wj0utja-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 12 Nov 2019 10:03:50 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Tue, 12 Nov 2019 15:03:47 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net] net/smc: fix refcount non-blocking connect() -part 2
Date: Tue, 12 Nov 2019 16:03:41 +0100
Message-Id: <20191112150341.90681-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

If an SMC socket is immediately terminated after a non-blocking connect()
has been called, a memory leak is possible.
Due to the sock_hold move in
commit 301428ea3708 ("net/smc: fix refcounting for non-blocking connect()")
an extra sock_put() is needed in smc_connect_work(), if the internal
TCP socket is aborted and cancels the sk_stream_wait_connect() of the
connect worker.

Reported-by: syzbot+4b73ad6fc767e576e275@syzkaller.appspotmail.com
Fixes: 301428ea3708 ("net/smc: fix refcounting for non-blocking connect()")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index cde4dc0ed173..d0271bcb2191 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -799,6 +799,7 @@ static void smc_connect_work(struct work_struct *work)
 			smc->sk.sk_err = EPIPE;
 		else if (signal_pending(current))
 			smc->sk.sk_err = -sock_intr_errno(timeo);
+		sock_put(&smc->sk); /* passive closing */
 		goto out;
 	}
 
-- 
2.17.1
