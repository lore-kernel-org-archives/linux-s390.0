Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F83939D7;
	Mon, 10 Aug 2026 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786344065; cv=none; b=BXr9mljMde/GQYzZPotnXzmIXRcetivyxnT8cIL+VcZ66UjU3+xmR1Cpm++XQUGxVZzkIj5fHbuWZMVfh91zbiESzZnpCzyHR2ywzTOp8iZlQ3NHx4BhvYOjY++bq8tmeVifvZzDWjIt/nqPjw6T3Rxp1H6SjD0UTCZARIyD3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786344065; c=relaxed/simple;
	bh=irOsHIsjQFnCgXpbVIJoXrWkBbPVuThlKCsiOgQsgsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5xhHZC41kwPPR3xNHLldOUoJ1UUx5hQV7AyAEBtntkLU+KLtaqAv1VQutxuQJ6J7rA4d6YGACK34l3Z73C9xk20IibJVEsX3aUxe7bftLjEl548pLoADROWRt1HrLnkpQs+X6TX9nEy/awdDZVALzbcV6rSvQVKX8XOBBT4sO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZZQrkEvG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZZQrkEvG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A5Vab8621195;
	Mon, 10 Aug 2026 06:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zoVg7bDT5XsSdd29XppNleSOEenkEEItlAzHHEY2x
	Sw=; b=ZZQrkEvGur5zaFq9XHKwY2mH6zZP+kDHcyu5COzvNgiCi9D7D+7OFuGrf
	tZyf+b8x4PPIJtJERom/yNqBKAqrd7bU60uuuw95kGB0K7vJ47vRvvUG6F4dRGkq
	k2OzQETSefdH8wSy4zSWoBm7uItDJ9BwIGil1hN8mwSxHgjo0LU0ZZqA0Dw4v7ez
	hz9O3gSp8xm1BXYuPnIi1hDJW8sydFkZUfTzdww7ctTLqceHsQG0LcRfPrqHKZsl
	1MbF1xG/A2UO8qqJutHXMxFNN80wQJ8/F9/uan76jNG24+hcB5uONyGHCHxonjdA
	JjBTmtfntvEmV6+66UrNE33Gqwezg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvkcp784-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 06:40:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67A6QHKV023884;
	Mon, 10 Aug 2026 06:40:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g3h0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 06:40:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67A6efHE30998800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 06:40:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9F7F20043;
	Mon, 10 Aug 2026 06:40:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 873AA20040;
	Mon, 10 Aug 2026 06:40:41 +0000 (GMT)
Received: from t83lp68.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 06:40:41 +0000 (GMT)
From: Hidayath Khan <hidayath@linux.ibm.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
        sidraya@linux.ibm.com, mjambigi@linux.ibm.com, andrew+netdev@lunn.ch
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, pasic@linux.ibm.com, hidayath@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net] net/smc: fix use-after-free in smc_rx_pipe_buf_release()
Date: Mon, 10 Aug 2026 08:40:41 +0200
Message-ID: <20260810064041.720441-1-hidayath@linux.ibm.com>
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
X-Proofpoint-GUID: vPpIq3dr5kiL5YlXlFuc84gMPL36jWC2
X-Authority-Analysis: v=2.4 cv=J86aKgnS c=1 sm=1 tr=0 ts=6a79726e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=El3dwMI6zd4-qOQQ5tQA:9
X-Proofpoint-ORIG-GUID: V8R-_RCcoFtQdBZ27GEBxJsIcTvtz9Ey
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA1NCBTYWx0ZWRfX6DWR4lcXeYOC
 JQLIO2p+l6AxmCvz12mEi1LVoK9Na+AlAqQN4CzcyIu2TLWTAtwYIbpw3WulTdfPJcBtuuK3ufZ
 4yKIB1/SgXBc2nyHMvBXzUO9k/KjJz3nM7VlBFhiC1yZWJvioKrpME2Mu80KoPQMGbglZsd28sO
 Ls6HBLWbfZ1o0Rhwi/H+7arsiQk1zggO8M+8x+AhT7xn/04aVwqdLSMkpVE0WOCSZ5kvKnX1rt/
 BzerajmOnp6JZmDr11c8AnBfemTSu0qbJO0G5MIitAMEZkDkrBPaRgUFQmZ/J6shrjn6Bue4/jC
 3mwhb3kygTBawUfSAXGGpE2UqnbTGPu5P92QWgs+EAcIlF9JNlM3ZA/nkuGowhLj/0nttbv7zNo
 YJy586//A+uE5d6BEO7UzWbtQFLBkqSMMKOvwWn+oxeEVFyF6YJVMKTX+cUD0/zoqGHLdNE1ikn
 E0lx7tepB15ywCJTPmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA1NCBTYWx0ZWRfXw9KCxTDdTa6k
 Q11dPELG20sj+kS3rwaCQhEagB6NrGReazTvHTcexD8kGQ9WBCSAIv0qelrLFcoNuC57hp15Eza
 iQBgN8KMxVvwUHbEB9HChw+rse0E4ak=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100054

smc_rx_splice() hands RMB pages to a pipe and takes a socket reference for
each entry, so the smc_sock survives until the reader is done.  The
connection does not: a close in between runs smc_conn_free(), which
releases the link group and returns the receive buffer to the link group's
pool.

smc_rx_pipe_buf_release() tries to detect that by testing sk_state, but it
does so before taking the socket lock, and then dereferences the connection
anyway:

        if (sk->sk_state == SMC_CLOSED || ...)
                goto out;
        conn = &smc->conn;
        lock_sock(sk);
        smc_rx_update_cons(smc, priv->len);

smc_rx_update_cons() reads conn->rmb_desc->len twice and then calls
smc_tx_consumer_update(), which walks conn->lgr and conn->lnk.  The state
can change between the test and the lock, and on the is_reg_err path
smcr_buf_unuse() does not recycle the descriptor but frees it outright, so
this is a use-after-free rather than a stale read.

sk_state is also the wrong thing to test.  Take the socket lock first so
the test and the cursor update cannot be separated, and test the receive
buffer itself, which is what the code goes on to dereference.

For that test to mean anything, smc_buf_unuse() has to stop leaving a
pointer to a descriptor it has just released; clear conn->rmb_desc there.
Nothing in smc_conn_free() reads it afterwards, and smc_ism_unset_conn()
already returns early on a NULL rmb_desc, so an SMC-D teardown that reaches
it twice becomes a no-op instead of indexing smcd->conn[] with a stale
sba_idx.

Fixes: 9014db202cb7 ("smc: add support for splice()")
Cc: stable@vger.kernel.org
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
---
 net/smc/smc_core.c |  1 +
 net/smc/smc_rx.c   | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index c0027d2fe4e8..def65ebc0b53 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1248,6 +1248,7 @@ static void smc_buf_unuse(struct smc_connection *conn,
 			WRITE_ONCE(conn->rmb_desc->used, 0);
 		}
 		SMC_STAT_RMB_SIZE(smc, is_smcd, true, false, bufsize);
+		conn->rmb_desc = NULL;
 	}
 }
 
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index c1d9b923938d..c17d4757ec84 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -116,15 +116,17 @@ static void smc_rx_pipe_buf_release(struct pipe_inode_info *pipe,
 {
 	struct smc_spd_priv *priv = (struct smc_spd_priv *)buf->private;
 	struct smc_sock *smc = priv->smc;
-	struct smc_connection *conn;
+	struct smc_connection *conn = &smc->conn;
 	struct sock *sk = &smc->sk;
 
+	lock_sock(sk);
 	if (sk->sk_state == SMC_CLOSED ||
 	    sk->sk_state == SMC_PEERFINCLOSEWAIT ||
-	    sk->sk_state == SMC_APPFINCLOSEWAIT)
+	    sk->sk_state == SMC_APPFINCLOSEWAIT ||
+	    !conn->rmb_desc) {
+		release_sock(sk);
 		goto out;
-	conn = &smc->conn;
-	lock_sock(sk);
+	}
 	smc_rx_update_cons(smc, priv->len);
 	release_sock(sk);
 	if (atomic_sub_and_test(priv->len, &conn->splice_pending))

base-commit: 1c2c67f1a9009f643d1233fa6bb8f888deb797ba
-- 
2.52.0

