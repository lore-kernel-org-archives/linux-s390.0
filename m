Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbfKOLjl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 06:39:41 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFBX6n3033372
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 06:39:40 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nse40qk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 06:39:40 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Fri, 15 Nov 2019 11:39:38 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net] net/smc: fix fastopen for non-blocking connect()
Date: Fri, 15 Nov 2019 12:39:30 +0100
Message-Id: <20191115113930.38684-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

FASTOPEN does not work with SMC-sockets. Since SMC allows fallback to
TCP native during connection start, the FASTOPEN setsockopts trigger
this fallback, if the SMC-socket is still in state SMC_INIT.
But if a FASTOPEN setsockopt is called after a non-blocking connect(),
this is broken, and fallback does not make sense.
This change complements
commit cd2063604ea6 ("net/smc: avoid fallback in case of non-blocking connect")
and fixes the syzbot reported problem "WARNING in smc_unhash_sk".

Reported-by: syzbot+8488cc4cf1c9e09b8b86@syzkaller.appspotmail.com
Fixes: e1bbdd570474 ("net/smc: reduce sock_put() for fallback sockets")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 8edf1619f0e4..737b49909a7a 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1732,7 +1732,7 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
 		/* option not supported by SMC */
-		if (sk->sk_state == SMC_INIT) {
+		if (sk->sk_state == SMC_INIT && !smc->connect_nonblock) {
 			smc_switch_to_fallback(smc);
 			smc->fallback_rsn = SMC_CLC_DECL_OPTUNSUPP;
 		} else {
-- 
2.17.1
