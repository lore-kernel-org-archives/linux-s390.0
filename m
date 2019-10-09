Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725440AbfJIIFC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 04:05:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9982r0O096078
        for <linux-s390@vger.kernel.org>; Wed, 9 Oct 2019 04:05:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vhbpd82pk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 04:05:00 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Wed, 9 Oct 2019 09:04:59 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 3/3] net/smc: receive pending data after RCV_SHUTDOWN
Date: Wed,  9 Oct 2019 10:04:41 +0200
In-Reply-To: <20191009080441.76077-1-kgraul@linux.ibm.com>
References: <20191009080441.76077-1-kgraul@linux.ibm.com>
Message-Id: <20191009080441.76077-4-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

smc_rx_recvmsg() first checks if data is available, and then if
RCV_SHUTDOWN is set. There is a race when smc_cdc_msg_recv_action() runs
in between these 2 checks, receives data and sets RCV_SHUTDOWN.
In that case smc_rx_recvmsg() would return from receive without to
process the available data.
Fix that with a final check for data available if RCV_SHUTDOWN is set.
Move the check for data into a function and call it twice.
And use the existing helper smc_rx_data_available().

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_rx.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 000002642288..97e8369002d7 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -261,6 +261,18 @@ static int smc_rx_recv_urg(struct smc_sock *smc, struct msghdr *msg, int len,
 	return -EAGAIN;
 }
 
+static bool smc_rx_recvmsg_data_available(struct smc_sock *smc)
+{
+	struct smc_connection *conn = &smc->conn;
+
+	if (smc_rx_data_available(conn))
+		return true;
+	else if (conn->urg_state == SMC_URG_VALID)
+		/* we received a single urgent Byte - skip */
+		smc_rx_update_cons(smc, 0);
+	return false;
+}
+
 /* smc_rx_recvmsg - receive data from RMBE
  * @msg:	copy data to receive buffer
  * @pipe:	copy data to pipe if set - indicates splice() call
@@ -302,15 +314,18 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 		if (read_done >= target || (pipe && read_done))
 			break;
 
-		if (atomic_read(&conn->bytes_to_rcv))
+		if (smc_rx_recvmsg_data_available(smc))
 			goto copy;
-		else if (conn->urg_state == SMC_URG_VALID)
-			/* we received a single urgent Byte - skip */
-			smc_rx_update_cons(smc, 0);
 
 		if (sk->sk_shutdown & RCV_SHUTDOWN ||
-		    conn->local_tx_ctrl.conn_state_flags.peer_conn_abort)
+		    conn->local_tx_ctrl.conn_state_flags.peer_conn_abort) {
+			/* smc_cdc_msg_recv_action() could have run after
+			 * above smc_rx_recvmsg_data_available()
+			 */
+			if (smc_rx_recvmsg_data_available(smc))
+				goto copy;
 			break;
+		}
 
 		if (read_done) {
 			if (sk->sk_err ||
-- 
2.17.1
