Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390619AbfJWNo6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Oct 2019 09:44:58 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9NDirDr034129
        for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2019 09:44:57 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vtp3fvwpa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2019 09:44:55 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Wed, 23 Oct 2019 14:44:17 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 1/2] net/smc: fix closing of fallback SMC sockets
Date: Wed, 23 Oct 2019 15:44:05 +0200
In-Reply-To: <20191023134406.66319-1-kgraul@linux.ibm.com>
References: <20191023134406.66319-1-kgraul@linux.ibm.com>
Message-Id: <20191023134406.66319-2-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

For SMC sockets forced to fallback to TCP, the file is propagated
from the outer SMC to the internal TCP socket. When closing the SMC
socket, the internal TCP socket file pointer must be restored to the
original NULL value, otherwise memory leaks may show up (found with
CONFIG_DEBUG_KMEMLEAK).

The internal TCP socket is released in smc_clcsock_release(), which
calls __sock_release() function in net/socket.c. This calls the
needed iput(SOCK_INODE(sock)) only, if the file pointer has been reset
to the original NULL-value.

Fixes: 07603b230895 ("net/smc: propagate file from SMC to TCP socket")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5b932583e407..d9566e84f2f9 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -123,6 +123,12 @@ struct proto smc_proto6 = {
 };
 EXPORT_SYMBOL_GPL(smc_proto6);
 
+static void smc_restore_fallback_changes(struct smc_sock *smc)
+{
+	smc->clcsock->file->private_data = smc->sk.sk_socket;
+	smc->clcsock->file = NULL;
+}
+
 static int __smc_release(struct smc_sock *smc)
 {
 	struct sock *sk = &smc->sk;
@@ -141,6 +147,7 @@ static int __smc_release(struct smc_sock *smc)
 		}
 		sk->sk_state = SMC_CLOSED;
 		sk->sk_state_change(sk);
+		smc_restore_fallback_changes(smc);
 	}
 
 	sk->sk_prot->unhash(sk);
-- 
2.17.1
