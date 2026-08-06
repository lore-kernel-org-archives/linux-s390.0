Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209923BB674;
	Thu,  6 Aug 2026 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004163; cv=none; b=qUoi1REwHq11KA7c9ueUYL85nyRmBP7AAXx/fqYS54oR6+j7B3pQTlN2uM8GDOkTG+JbkZEMTbUevc3+x6DUdUYiWDwvqv2mgjziH9Gb44sFZCqh927pQx7M/WhOcZ68kwBL8WuGkfaobxFEYxPf7UENf7RbMjHdoK7MMdQalGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004163; c=relaxed/simple;
	bh=gdY0u5QHCOwfszhHEIhrdGRjU96/ovDQ5xj92FVYtn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmZTe+f5D4as7zDEomuQrlW/rOYdX1HSRqB+CZnNw3Twodv/eumuuGgvFid2+V7ODQjMXbuVeMaGlk5J98a5my5fu77BbiC1pXNcl9kQ7zsLDDjeUvWkh4kdAJgCcKwj947Isd+SZ/QcvyqKNxWsgYW3X8x+qKU/PLiX336MVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=giS+S1VJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="giS+S1VJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Nluqj993470;
	Thu, 6 Aug 2026 08:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GzwcfyJSU+6R2Bsk1VVBvvghxbF5nO6h/PJzqZUY9
	yA=; b=giS+S1VJS4V6lUHaVcVFweLAQddR4I1pUFY29Sc+n3KbwekfEyWpzezV5
	mKRATibsoU9364myncP5FoEvy/t3OtIcRCtdjCRzt6ZL7VhVTuDfDOTr3XhH42el
	UaZIOgDXYbUNY7/VuFyMTploYr5jp1+9+lYlsuJFX+UDtVF95AohadwonIhrQ+FW
	K15GkIJX/N4hdMh/LFTJZQTeUvmDTWYf1tKVQrZBXP/36iWMrya5FR8Jj0Bs9v3D
	L7uOxuRUoTqxIsj9ZCAkCYc2QoR82iKfyRdom0eLx9XAjdqAM5R1zEs5qoI63l+X
	7/b3HUkU3FxiKW386dHE0BS7IsuyA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gepea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 08:15:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6768BNsV024629;
	Thu, 6 Aug 2026 08:15:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qtenf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 08:15:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6768FnOh17301854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 08:15:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DABD22004B;
	Thu,  6 Aug 2026 08:15:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F0C920043;
	Thu,  6 Aug 2026 08:15:49 +0000 (GMT)
Received: from t83lp68.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 08:15:49 +0000 (GMT)
From: Hidayath Khan <hidayath@linux.ibm.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
        sidraya@linux.ibm.com, mjambigi@linux.ibm.com, andrew+netdev@lunn.ch
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, pasic@linux.ibm.com, hidayath@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net] net/smc: drop the abort_work reference when the work is cancelled
Date: Thu,  6 Aug 2026 10:15:49 +0200
Message-ID: <20260806081549.595001-1-hidayath@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA1OSBTYWx0ZWRfX0BJcsRHuJwbx
 XijN5XIK4gvG8i7IhZilAiVR1yYAm/UhstxzQwUJro2Z9y2hj92ZRitwSalIpvRxEMrts6OQmjn
 4E0PFaB6ek1TrbMb/dEcFtdVDH2+BeU3O6IdHTG3szo8hjhusuvOpdKPlsL7Qp+DmfqFJZHRqQD
 ziJb4ZMI9WC2e4iEeHlUmOtYXNnoV82zQMQkAg5NAZmzVHxrB6SmIxvCQ3UgcPolfFvaLbjHHR/
 fRN0Gy5bGNATkOe4pN0vF+uSqf+JyclILvVKFesVxK+0DC3DERArHowEWq1XuW5Hzp5fTO6rX8v
 pZ8ZRq2vMOOzthciyytUUNJaTlrBPLyMBnYy7OcNdxc1evrvSJMwTp1phtYaI1dbL9ibiHoz0DF
 VKJ99zeCEOfE/PzMTFQt2D2u6WKYkvi9eyYHmM2LMxHW/H164IAB7daPJmInP6ZfB4webHhnfcA
 PuBuqnDPWNZoCV7BQgQ==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a7442bb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=CsfcX7A8SnD_svm5:21 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=OeUCff8P1W_ZF3PiYk8A:9
X-Proofpoint-GUID: kJFy0knwEupD4rfiR7DcPIUtMLAUpusG
X-Proofpoint-ORIG-GUID: _fvljISag3PRVWwD_597e0fhfBfQ5va9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA1OSBTYWx0ZWRfX4KUL223bH048
 T5xCPdK6+w9W9PpkA18w7gW/NFJ0nUhhx37Cbt6AHs+RF1LHTBD2rtmjjQ43pLjDKZD6IHY9zrI
 +eM5JbKr2Rx0o7NJgsOZBC6BgyRoDNY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060059

The schedulers of conn->abort_work hand a socket reference to the work
item and rely on it to give the reference back:

        sock_hold(&smc->sk); /* sock_put in abort_work */
        if (!queue_work(smc_close_wq, &conn->abort_work))
                sock_put(&smc->sk);

The queue_work() failure case is handled, but the cancellation case is
not. smc_conn_free() cancels a still-pending abort_work:

        if (current_work() != &conn->abort_work)
                cancel_work_sync(&conn->abort_work);

and discards the return value.  When cancel_work_sync() returns true the
work was queued but had not started, so smc_conn_abort_work() never runs
and its sock_put() never happens.  The reference is lost.

As in smc_switch_conns(), a leaked sk_refcnt means the smc_sock is never
destroyed: its buffers stay allocated and the network namespace reference
a user socket holds is never released, so the netns cannot be torn down.

smc_cdc_msg_validate() queues abort_work from the receive tasklet when a
peer sends a CDC message with an out-of-order sequence number, so a
remote peer combined with a concurrent local close is enough to reach it.

Drop the reference when the work is cancelled, matching the pattern
smc_close_cancel_work() already uses for conn->close_work:

        if (cancel_work_sync(&smc->conn.close_work))
                sock_put(sk);

The sock_put() is safe here: every caller of smc_conn_free() passes the
connection of a socket it holds a reference to, so this cannot release
the last one.

Fixes: b286a0651e44 ("net/smc: handle incoming CDC validation message")
Cc: stable@vger.kernel.org
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
---
 net/smc/smc_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index c0027d2fe4e8..dd9fffbe41e0 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1254,6 +1254,7 @@ static void smc_buf_unuse(struct smc_connection *conn,
 /* remove a finished connection from its link group */
 void smc_conn_free(struct smc_connection *conn)
 {
+	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 	struct smc_link_group *lgr = conn->lgr;
 
 	if (!lgr || conn->freed)
@@ -1277,8 +1278,13 @@ void smc_conn_free(struct smc_connection *conn)
 		tasklet_kill(&conn->rx_tsklet);
 	} else {
 		smc_cdc_wait_pend_tx_wr(conn);
-		if (current_work() != &conn->abort_work)
-			cancel_work_sync(&conn->abort_work);
+		/* If the work was pending (cancel returns true) it never ran,
+		 * so the sock_hold taken by its scheduler was never released.
+		 */
+		if (current_work() != &conn->abort_work) {
+			if (cancel_work_sync(&conn->abort_work))
+				sock_put(&smc->sk);
+		}
 	}
 	if (!list_empty(&lgr->list)) {
 		smc_buf_unuse(conn, lgr); /* allow buffer reuse */

base-commit: 2b1c2bc2355fd59cc75045e42d9dc5470ef5fa9a
-- 
2.52.0

