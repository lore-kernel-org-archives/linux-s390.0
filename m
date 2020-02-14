Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728239AbgBNH7O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 02:59:14 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01E7wfCM090340
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 02:59:13 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4qytw7j4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 02:59:13 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Fri, 14 Feb 2020 07:59:10 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 1/2] net/smc: transfer fasync_list in case of fallback
Date: Fri, 14 Feb 2020 08:58:59 +0100
In-Reply-To: <20200214075900.31624-1-kgraul@linux.ibm.com>
References: <20200214075900.31624-1-kgraul@linux.ibm.com>
Message-Id: <20200214075900.31624-2-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

SMC does not work together with FASTOPEN. If sendmsg() is called with
flag MSG_FASTOPEN in SMC_INIT state, the SMC-socket switches to
fallback mode. To handle the previous ioctl FIOASYNC call correctly
in this case, it is necessary to transfer the socket wait queue
fasync_list to the internal TCP socket.

Reported-by: syzbot+4b1fe8105f8044a26162@syzkaller.appspotmail.com
Fixes: ee9dfbef02d18 ("net/smc: handle sockopts forcing fallback")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index cee5bf4a9bb9..90988a511cd5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -470,6 +470,8 @@ static void smc_switch_to_fallback(struct smc_sock *smc)
 	if (smc->sk.sk_socket && smc->sk.sk_socket->file) {
 		smc->clcsock->file = smc->sk.sk_socket->file;
 		smc->clcsock->file->private_data = smc->clcsock;
+		smc->clcsock->wq.fasync_list =
+			smc->sk.sk_socket->wq.fasync_list;
 	}
 }
 
-- 
2.17.1
