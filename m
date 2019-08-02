Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404001AbfHBIRB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Aug 2019 04:17:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x728GZnx119429
        for <linux-s390@vger.kernel.org>; Fri, 2 Aug 2019 04:16:59 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4g83b1rf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 02 Aug 2019 04:16:59 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Fri, 2 Aug 2019 09:16:57 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net] net/smc: do not schedule tx_work in SMC_CLOSED state
Date: Fri,  2 Aug 2019 10:16:38 +0200
Message-Id: <20190802081638.56207-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

The setsockopts options TCP_NODELAY and TCP_CORK may schedule the
tx worker. Make sure the socket is not yet moved into SMC_CLOSED
state (for instance by a shutdown SHUT_RDWR call).

Reported-by: syzbot+92209502e7aab127c75f@syzkaller.appspotmail.com
Reported-by: syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com
Fixes: 01d2f7e2cdd31 ("net/smc: sockopts TCP_NODELAY and TCP_CORK")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 302e355f2ebc..f5ea09258ab0 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1732,14 +1732,18 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		}
 		break;
 	case TCP_NODELAY:
-		if (sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) {
+		if (sk->sk_state != SMC_INIT &&
+		    sk->sk_state != SMC_LISTEN &&
+		    sk->sk_state != SMC_CLOSED) {
 			if (val && !smc->use_fallback)
 				mod_delayed_work(system_wq, &smc->conn.tx_work,
 						 0);
 		}
 		break;
 	case TCP_CORK:
-		if (sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) {
+		if (sk->sk_state != SMC_INIT &&
+		    sk->sk_state != SMC_LISTEN &&
+		    sk->sk_state != SMC_CLOSED) {
 			if (!val && !smc->use_fallback)
 				mod_delayed_work(system_wq, &smc->conn.tx_work,
 						 0);
-- 
2.21.0
