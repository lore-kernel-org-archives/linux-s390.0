Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729203AbfJUONk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Oct 2019 10:13:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9LEDXMq118381
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2019 10:13:39 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vsddsj7a0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2019 10:13:37 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Mon, 21 Oct 2019 15:13:24 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 5/8] net/smc: tell peers about abnormal link group termination
Date: Mon, 21 Oct 2019 16:13:12 +0200
In-Reply-To: <20191021141315.58969-1-kgraul@linux.ibm.com>
References: <20191021141315.58969-1-kgraul@linux.ibm.com>
Message-Id: <20191021141315.58969-6-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

There are lots of link group termination scenarios. Most of them
still allow to inform the peer of the terminating sockets about aborting.
This patch tries to call smc_close_abort() for terminating sockets.

And the internal TCP socket is reset with tcp_abort().

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_close.c | 9 ++++-----
 net/smc/smc_close.h | 1 +
 net/smc/smc_core.c  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 1d706c581592..2bbcd45a421e 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -13,6 +13,7 @@
 #include <linux/sched/signal.h>
 
 #include <net/sock.h>
+#include <net/tcp.h>
 
 #include "smc.h"
 #include "smc_tx.h"
@@ -102,7 +103,7 @@ static int smc_close_final(struct smc_connection *conn)
 	return smc_cdc_get_slot_and_msg_send(conn);
 }
 
-static int smc_close_abort(struct smc_connection *conn)
+int smc_close_abort(struct smc_connection *conn)
 {
 	conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
 
@@ -118,10 +119,8 @@ static void smc_close_active_abort(struct smc_sock *smc)
 
 	if (sk->sk_state != SMC_INIT && smc->clcsock && smc->clcsock->sk) {
 		sk->sk_err = ECONNABORTED;
-		if (smc->clcsock && smc->clcsock->sk) {
-			smc->clcsock->sk->sk_err = ECONNABORTED;
-			smc->clcsock->sk->sk_state_change(smc->clcsock->sk);
-		}
+		if (smc->clcsock && smc->clcsock->sk)
+			tcp_abort(smc->clcsock->sk, ECONNABORTED);
 	}
 	switch (sk->sk_state) {
 	case SMC_ACTIVE:
diff --git a/net/smc/smc_close.h b/net/smc/smc_close.h
index e0e3b5df25d2..084c4f37aa96 100644
--- a/net/smc/smc_close.h
+++ b/net/smc/smc_close.h
@@ -24,5 +24,6 @@ int smc_close_active(struct smc_sock *smc);
 int smc_close_shutdown_write(struct smc_sock *smc);
 void smc_close_init(struct smc_sock *smc);
 void smc_clcsock_release(struct smc_sock *smc);
+int smc_close_abort(struct smc_connection *conn);
 
 #endif /* SMC_CLOSE_H */
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index e7e9dbcd7d8b..494288f32df6 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -513,8 +513,8 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr)
 		smc = container_of(conn, struct smc_sock, conn);
 		lock_sock(&smc->sk);
 		sock_hold(&smc->sk); /* sock_put in close work */
+		smc_close_abort(conn);
 		conn->killed = 1;
-		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
 		smc_lgr_unregister_conn(conn);
 		conn->lgr = NULL;
 		if (!schedule_work(&conn->close_work))
-- 
2.17.1
