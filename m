Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729970AbfJIIIC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 04:08:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9987Met023774
        for <linux-s390@vger.kernel.org>; Wed, 9 Oct 2019 04:08:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vhaxr1w71-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 04:08:01 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Wed, 9 Oct 2019 09:07:58 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 5/5] net/smc: improve close of terminated socket
Date: Wed,  9 Oct 2019 10:07:47 +0200
In-Reply-To: <20191009080747.95516-1-kgraul@linux.ibm.com>
References: <20191009080747.95516-1-kgraul@linux.ibm.com>
Message-Id: <20191009080747.95516-6-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

Make sure a terminated SMC socket reaches the CLOSED state.
Even if sending of close flags fails, change the socket state to
the intended state to avoid dangling sockets not reaching the
CLOSED state.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_close.c | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index fc06720b53c1..1a858e59fc31 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -65,8 +65,8 @@ static void smc_close_stream_wait(struct smc_sock *smc, long timeout)
 
 		rc = sk_wait_event(sk, &timeout,
 				   !smc_tx_prepared_sends(&smc->conn) ||
-				   (sk->sk_err == ECONNABORTED) ||
-				   (sk->sk_err == ECONNRESET),
+				   sk->sk_err == ECONNABORTED ||
+				   sk->sk_err == ECONNRESET,
 				   &wait);
 		if (rc)
 			break;
@@ -113,9 +113,6 @@ static void smc_close_active_abort(struct smc_sock *smc)
 {
 	struct sock *sk = &smc->sk;
 
-	struct smc_cdc_conn_state_flags *txflags =
-		&smc->conn.local_tx_ctrl.conn_state_flags;
-
 	if (sk->sk_state != SMC_INIT && smc->clcsock && smc->clcsock->sk) {
 		sk->sk_err = ECONNABORTED;
 		if (smc->clcsock && smc->clcsock->sk) {
@@ -129,35 +126,26 @@ static void smc_close_active_abort(struct smc_sock *smc)
 		release_sock(sk);
 		cancel_delayed_work_sync(&smc->conn.tx_work);
 		lock_sock(sk);
+		sk->sk_state = SMC_CLOSED;
 		sock_put(sk); /* passive closing */
 		break;
 	case SMC_APPCLOSEWAIT1:
 	case SMC_APPCLOSEWAIT2:
-		if (!smc_cdc_rxed_any_close(&smc->conn))
-			sk->sk_state = SMC_PEERABORTWAIT;
-		else
-			sk->sk_state = SMC_CLOSED;
 		release_sock(sk);
 		cancel_delayed_work_sync(&smc->conn.tx_work);
 		lock_sock(sk);
+		sk->sk_state = SMC_CLOSED;
 		break;
 	case SMC_PEERCLOSEWAIT1:
 	case SMC_PEERCLOSEWAIT2:
-		if (!txflags->peer_conn_closed) {
-			/* just SHUTDOWN_SEND done */
-			sk->sk_state = SMC_PEERABORTWAIT;
-		} else {
-			sk->sk_state = SMC_CLOSED;
-		}
+	case SMC_PEERFINCLOSEWAIT:
+		sk->sk_state = SMC_CLOSED;
 		sock_put(sk); /* passive closing */
 		break;
 	case SMC_PROCESSABORT:
 	case SMC_APPFINCLOSEWAIT:
 		sk->sk_state = SMC_CLOSED;
 		break;
-	case SMC_PEERFINCLOSEWAIT:
-		sock_put(sk); /* passive closing */
-		break;
 	case SMC_INIT:
 	case SMC_PEERABORTWAIT:
 	case SMC_CLOSED:
@@ -215,8 +203,6 @@ int smc_close_active(struct smc_sock *smc)
 		if (sk->sk_state == SMC_ACTIVE) {
 			/* send close request */
 			rc = smc_close_final(conn);
-			if (rc)
-				break;
 			sk->sk_state = SMC_PEERCLOSEWAIT1;
 		} else {
 			/* peer event has changed the state */
@@ -229,8 +215,6 @@ int smc_close_active(struct smc_sock *smc)
 		    !smc_close_sent_any_close(conn)) {
 			/* just shutdown wr done, send close request */
 			rc = smc_close_final(conn);
-			if (rc)
-				break;
 		}
 		sk->sk_state = SMC_CLOSED;
 		break;
@@ -246,8 +230,6 @@ int smc_close_active(struct smc_sock *smc)
 			goto again;
 		/* confirm close from peer */
 		rc = smc_close_final(conn);
-		if (rc)
-			break;
 		if (smc_cdc_rxed_any_close(conn)) {
 			/* peer has closed the socket already */
 			sk->sk_state = SMC_CLOSED;
@@ -263,8 +245,6 @@ int smc_close_active(struct smc_sock *smc)
 		    !smc_close_sent_any_close(conn)) {
 			/* just shutdown wr done, send close request */
 			rc = smc_close_final(conn);
-			if (rc)
-				break;
 		}
 		/* peer sending PeerConnectionClosed will cause transition */
 		break;
@@ -272,10 +252,12 @@ int smc_close_active(struct smc_sock *smc)
 		/* peer sending PeerConnectionClosed will cause transition */
 		break;
 	case SMC_PROCESSABORT:
-		smc_close_abort(conn);
+		rc = smc_close_abort(conn);
 		sk->sk_state = SMC_CLOSED;
 		break;
 	case SMC_PEERABORTWAIT:
+		sk->sk_state = SMC_CLOSED;
+		break;
 	case SMC_CLOSED:
 		/* nothing to do, add tracing in future patch */
 		break;
@@ -451,8 +433,6 @@ int smc_close_shutdown_write(struct smc_sock *smc)
 			goto again;
 		/* send close wr request */
 		rc = smc_close_wr(conn);
-		if (rc)
-			break;
 		sk->sk_state = SMC_PEERCLOSEWAIT1;
 		break;
 	case SMC_APPCLOSEWAIT1:
@@ -466,8 +446,6 @@ int smc_close_shutdown_write(struct smc_sock *smc)
 			goto again;
 		/* confirm close from peer */
 		rc = smc_close_wr(conn);
-		if (rc)
-			break;
 		sk->sk_state = SMC_APPCLOSEWAIT2;
 		break;
 	case SMC_APPCLOSEWAIT2:
-- 
2.17.1
