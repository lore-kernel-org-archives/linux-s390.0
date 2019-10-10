Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733236AbfJJIQb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Oct 2019 04:16:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9A8DZKm020041
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 04:16:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vhy9sb9w7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 04:16:29 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Thu, 10 Oct 2019 09:16:28 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH v2 net 2/3] net/smc: receive returns without data
Date: Thu, 10 Oct 2019 10:16:10 +0200
In-Reply-To: <20191010081611.35446-1-kgraul@linux.ibm.com>
References: <20191010081611.35446-1-kgraul@linux.ibm.com>
Message-Id: <20191010081611.35446-3-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

smc_cdc_rxed_any_close_or_senddone() is used as an end condition for the
receive loop. This conflicts with smc_cdc_msg_recv_action() which could
run in parallel and set the bits checked by
smc_cdc_rxed_any_close_or_senddone() before the receive is processed.
In that case we could return from receive with no data, although data is
available. The same applies to smc_rx_wait().
Fix this by checking for RCV_SHUTDOWN only, which is set in
smc_cdc_msg_recv_action() after the receive was actually processed.

Fixes: 952310ccf2d8 ("smc: receive data from RMBE")
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_rx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 413a6abf227e..000002642288 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -211,8 +211,7 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
 	rc = sk_wait_event(sk, timeo,
 			   sk->sk_err ||
 			   sk->sk_shutdown & RCV_SHUTDOWN ||
-			   fcrit(conn) ||
-			   smc_cdc_rxed_any_close_or_senddone(conn),
+			   fcrit(conn),
 			   &wait);
 	remove_wait_queue(sk_sleep(sk), &wait);
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
@@ -310,7 +309,6 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 			smc_rx_update_cons(smc, 0);
 
 		if (sk->sk_shutdown & RCV_SHUTDOWN ||
-		    smc_cdc_rxed_any_close_or_senddone(conn) ||
 		    conn->local_tx_ctrl.conn_state_flags.peer_conn_abort)
 			break;
 
-- 
2.17.1
