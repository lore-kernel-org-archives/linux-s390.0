Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBFF470429;
	Tue,  4 Aug 2026 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852684; cv=none; b=WcLPZOAkfUwSqe9feGAVjSYwKDN+QlyFKiNqjl3qUzPGY+Yrov/rByf8sroymr6U+1mDNLZNbAJVuve6zVQY57hoXDUdnmaMMDBu31BfBI1tJO11XBgXPRhQCRGSlIKga/HYZf7Q5J0jbdpmU+ayoH3nG5YUdrufUXFWIZhxahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852684; c=relaxed/simple;
	bh=ONhc2FfzGDvxRX5KqVoreJchMV9CHt3NHCCngi6bNd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=il15sNflAFwddbqTn4zvp6bAVg36yNUurFLEFH80QIJgotbc+OAbbAlftLSjBp3l0e1/4Pt34nXLp8gOK5SD8y2fdA8ZkGWmyqcavKGfwhWqY48QFvzjjvYJ+YLNOUfXhE+lrj8itSEIOkuNleh33ZjWwFIzMWp+B+NdNiig1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JhiZcp+j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JhiZcp+j"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674ClpAU3207835;
	Tue, 4 Aug 2026 14:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZU5Tyo3GR7HCzyR0tYBme+tD3HicUoDyX6IRqtsWM
	3c=; b=JhiZcp+jF44pdJZZwDjYt/s7+03MVBvO9eIV5WVAKqMLQX78NiJlo8+M6
	Ub2ybuxJ/R9TIFiMbBlZk6qn9tuNOJSvIxhBMGxRhhw64lAoiZHiNR/eMw5TM5bH
	pSOtB7m57hlCBWkp7BNhQhVcmtAyLEoRTCQspEQr/wS2MuNzK0MwvVT2DVoj2IHY
	sn9r1oV2rZHOQOYD7wc4kztRiUeOe+apb4Q1un6o9wLK5v4/aiI7wYoFo//H9Cv8
	1OkafczjqpDemuubgPMrJ2CEZk8e6HnJFsg9i4awYwIQmDhWk3H62TlgBQ8dk9ut
	M0OO7NKAhRySnJxnmEKOona3yyD3g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqp5b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:11:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674DuIdA006085;
	Tue, 4 Aug 2026 14:11:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyj155-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 14:11:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674EBA9927656464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 14:11:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E59A320043;
	Tue,  4 Aug 2026 14:11:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B37BF20040;
	Tue,  4 Aug 2026 14:11:09 +0000 (GMT)
Received: from t83lp68.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 14:11:09 +0000 (GMT)
From: Hidayath Khan <hidayath@linux.ibm.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
        sidraya@linux.ibm.com, mjambigi@linux.ibm.com, andrew+netdev@lunn.ch
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, pasic@linux.ibm.com, hidayath@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next] net/smc: abort the connection when the peer overruns the RMB
Date: Tue,  4 Aug 2026 16:11:09 +0200
Message-ID: <20260804141109.542202-1-hidayath@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: SjNmc7u_DVBD2uv0zTcpEZ-iq5aYKjN3
X-Proofpoint-ORIG-GUID: aSTt3derDNY96CcUQ7hh0isGWTFQtMGL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMSBTYWx0ZWRfXyrLulnpTL4Yt
 IFCXTQDjEm307hJ2CTwOjZpyxaViHxMsUlSuXoLq8QMhj5abY2TJyR54sNRjMnandHIV8oHl7fL
 vOL6BY5Bk7AolHZ+GcEArukCHceZgnw=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a71f303 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=m3AjExkALmJRz1eEorMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMSBTYWx0ZWRfX5daLn8QKVfRv
 1ErBLFYOjCvBYbTR9Az/pUu3LAuBLUS7BtX1DgVcLGSatPIdxUD8lh61pvm/M4h+A0XlAh0B9XU
 h17eg2Pw+7Jo8Hiw2QNbf6xAMDINBuq5MX8Sfaf3Dv6X2Wp1GvksqlQGgbR5ufQdB0GAzUiOiAa
 4AD0tzd75Vg3hhnqS5pZBixWzLbDgjzmzl1NlxLRDdALSZ9Ey6nS8DogFdfergYowDZI8hmPZ+K
 eW19gBPFG3EmlFwTTMxlnLvMwkeyac2sFF7idjsm62xatNVx+3Sl+YyUwovYykJdq9XeNJOE629
 wXyGNmlPBTCJXNufxc64tm+QUIxBUe3XPQ5AyV2qWpaNNkXF/nQUv0yYdfqun4nW1i+e+rZODSP
 yo42lou/MIS9PvZ91A8I4yQbrI+e26xKiiZbEzkknFfDQ6ICF/R11d0QDF1RVEb2pPWtpXkDmQY
 KJcEStabmHD9YSbF4ZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040111

smc_cdc_msg_recv_action() accumulates the peer's producer cursor advance
into conn->bytes_to_rcv:

        atomic_add(diff_prod, &conn->bytes_to_rcv);
        /* guarantee 0 <= bytes_to_rcv <= rmb_desc->len */

Nothing enforces that comment.  A conforming peer cannot advance its
producer cursor past our consumer cursor, so a peer that does fills the
accumulator without bound.

Bounding the cursor does not help: a wrap increment with count 0 is a legal
advance of exactly one bufferful, so every per-cursor check accepts it
while smc_curs_diff() returns size for each such message.

The copy-length clamps bound the copy but never repair the counter, so
SIOCINQ reports a readable length that does not exist and
smc_rx_data_available() keeps poll() readable forever with nothing for
recvmsg() to return.

Drop the connection instead, reusing the abort smc_cdc_msg_validate()
performs for an out-of-range sequence number.  The test precedes the
atomic_add() so the counter is never left inflated; abandoning the rest of
the message matches smc_cdc_msg_validate(), and abort_work tears the
connection down.

The test is written as a subtraction.  diff_prod is not bounded by the RMB:
smc_curs_diff() documents "difference cannot exceed size" as an assumption
about its inputs, but the peer controls the cursor it is computed from, so
it can return up to INT_MAX.  Adding that to bytes_to_rcv would overflow
and the comparison would then read as false, defeating the check in exactly
the case it exists for.  Subtracting cannot overflow, since bytes_to_rcv is
in [0, rmb_desc->len].

Both transports are affected: the accumulator is shared.

Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
---
 net/smc/smc_cdc.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 32d6d03df321..d8f747bbc6f6 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -305,6 +305,27 @@ static void smc_cdc_handle_urg_data_arrival(struct smc_sock *smc,
 	sk_send_sigurg(&smc->sk);
 }
 
+/* Drop a connection whose peer violated the CDC protocol.  @link is the link
+ * the offending message arrived on, or NULL when it is not known to the caller
+ * (SMC-D, and the shared receive path).  When @link is NULL conn->lnk is left
+ * unchanged: for SMC-R it already points to the right QP; for SMC-D there is
+ * no per-link QP to abort on.
+ */
+static void smc_cdc_abort_conn(struct smc_sock *smc, struct smc_link *link)
+{
+	struct smc_connection *conn = &smc->conn;
+
+	conn->out_of_sync = 1;  /* prevent any further receives */
+	spin_lock_bh(&conn->send_lock);
+	conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
+	if (link)
+		conn->lnk = link;
+	spin_unlock_bh(&conn->send_lock);
+	sock_hold(&smc->sk); /* sock_put in abort_work */
+	if (!queue_work(smc_close_wq, &conn->abort_work))
+		sock_put(&smc->sk);
+}
+
 static void smc_cdc_msg_validate(struct smc_sock *smc, struct smc_cdc_msg *cdc,
 				 struct smc_link *link)
 {
@@ -314,17 +335,8 @@ static void smc_cdc_msg_validate(struct smc_sock *smc, struct smc_cdc_msg *cdc,
 
 	/* check that seqnum was seen before */
 	diff = conn->local_rx_ctrl.seqno - recv_seq;
-	if (diff < 0) { /* diff larger than 0x7fff */
-		/* drop connection */
-		conn->out_of_sync = 1;	/* prevent any further receives */
-		spin_lock_bh(&conn->send_lock);
-		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
-		conn->lnk = link;
-		spin_unlock_bh(&conn->send_lock);
-		sock_hold(&smc->sk); /* sock_put in abort_work */
-		if (!queue_work(smc_close_wq, &conn->abort_work))
-			sock_put(&smc->sk);
-	}
+	if (diff < 0) /* diff larger than 0x7fff */
+		smc_cdc_abort_conn(smc, link);  /* drop connection */
 }
 
 static void smc_cdc_msg_recv_action(struct smc_sock *smc,
@@ -376,6 +388,11 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 	diff_prod = smc_curs_diff(conn->rmb_desc->len, &prod_old,
 				  &conn->local_rx_ctrl.prod);
 	if (diff_prod) {
+		if (diff_prod > conn->rmb_desc->len -
+				atomic_read(&conn->bytes_to_rcv)) {
+			smc_cdc_abort_conn(smc, NULL);
+			return;
+		}
 		if (conn->local_rx_ctrl.prod_flags.urg_data_present)
 			smc_cdc_handle_urg_data_arrival(smc, &diff_prod);
 		/* bytes_to_rcv is decreased in smc_recvmsg */

base-commit: cd138abf911f7a6b19656e446b09cff4453d1f3d
-- 
2.52.0

