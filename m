Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E639A80E;
	Mon,  3 Aug 2026 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785740857; cv=none; b=jL7Mk1RE4BA1vq4IoiC9naReWebY/jSQlMOkv87oF5QkvrySCjcfbATuQPVjcdlMAQLyON9gF2tPFPgaW8b9LjlhQy7ZKKK6TEuzW86h14xWyOKIP16iucouP6lbL26ynTPdt40BMdN5nC+fPLdEN+EKrfrE/exHp9ISJUEYxgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785740857; c=relaxed/simple;
	bh=4JGW7aLws0Zw/JTiFVve2F4mgqyMOenrAtBHYvHVT6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWPqJwJdEd4gZrSQbKl31/dQVTyAfkNrEL6CapZNojvWDlU/OWSoLrg7NVIPwnoNZbkoTjBJeeJ3ImQpj14+9dDRYiV4klzDAOGVuxCzjdQsusL4+XvSgtqeZLotuH4b1RwBtfBxzNmx7CQT3DVB8EbHY7WdPJScjBXfaeHjQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E6DiYbzD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E6DiYbzD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Lm0t1167495;
	Mon, 3 Aug 2026 07:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8NraqYT8DzyhVhdujQsltxuCpDsYTEKh7LULWnd91
	Yw=; b=E6DiYbzDaj+ThJl8nHDeZ5L32rz0YvPuESfSDi8cq1GvkpzYe9bGuROmN
	RG0mMEYkiJD0Pf+GiqowAImTe2GqpkQziBqLDEwBW+Wy2xDTg5CBKGz9mT6gjUpU
	KwrEO10ujr1xp8LCaJ6kAAEcBc9CNMOUMqJCRhNiqCTKqt0itPjAdJvgaSp2jsBe
	izenP6FqnEupt/ypASvfA18EZp/UeOV0ywNZl4w8jKkiKDh5WnQp7byEdUnMhsv3
	KV/MX9+XQ4fnm02pqQJHSlPh9xIWrk9UjrqX+xsxDk9Wp1p7oa/FZMtmAPBv+sjP
	0UCL1zF0I4OwKD01uQTasUojIQ2pA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fy74q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 07:07:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736fQcL002614;
	Mon, 3 Aug 2026 07:07:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jv6g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 07:07:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67377QxL30278126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 07:07:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 147902004E;
	Mon,  3 Aug 2026 07:07:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5F0E2004D;
	Mon,  3 Aug 2026 07:07:25 +0000 (GMT)
Received: from a3560036.lnxne.boe (unknown [9.87.84.240])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 07:07:25 +0000 (GMT)
From: Sidraya Jayagond <sidraya@linux.ibm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, horms@kernel.org, mjambigi@linux.ibm.com
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, hidayath@linux.ibm.com,
        pasic@linux.ibm.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Sidraya Jayagond <sidraya@linux.ibm.com>
Subject: [PATCH net] net/smc: fix TOCTOU race between smc_listen_out() and listener close
Date: Mon,  3 Aug 2026 09:07:01 +0200
Message-ID: <20260803070701.126339-1-sidraya@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX/PFMSsXo92Ie
 Jv70780vTRXxDQSCag4mljYIVogLxxxqlMVowPyn+bhiwlqFKLnbqFXatLPl5IeXFgTi5hFTLBJ
 Eh1W6gFIbKzl04A6IbeWgVvi3mERUPFjpuaGAXNxJWGUi++z08Vc9lSjB27zfRQkbb5sxLCAE+c
 x2bh2itPukZdmDlPpiux1Aui8EKfem6C8GgAgZ4hG2fO7OCDWA5i5DREfnhNyVDWzbzDbXY/T99
 9OnEBBf67zMKthCPmV57z11t/lGGvnJ5A3KtN2gx+tNbX0bcaS4zUZXQ1Sh+L2iaEAPFCSP0FpP
 AjHzgjJPp4T4qc++Mjso9ZVk1DzgOoY7d0BRSAyvv6Tj4VRV6ktlS7/CQmunRELf6DQ4NOis+Y8
 BLpvIjj2Gb5ruZ8+herWoKkA3PprWn93o/T5VIWbWbkD+pB86lWTadTPfJUMS0HiGhupIXsblny
 bEJom8Fs5qgRqH3dbkA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a703e33 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=hvW5EgSOMl2WrInL310A:9
X-Proofpoint-GUID: 0gmfMDE8XWTf_mEXb_peklPK2FiZyxUn
X-Proofpoint-ORIG-GUID: YPuvaEizlPCDDfKT_4LfclfCoGsN5Szp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX9N29nXeZ3QLF
 2znHruBj2jnmXxGg6iMfm2heYPEJROhiDfsa7dhaKQaIppCuHb4hq+mu734N+8gjbohu1+kEgqk
 h0+s8XsnqfTeJANw83x73RGJUTYovTY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030058

smc_listen_out() reads lsmc->sk.sk_state without the listener lock,
then acquires lock_sock_nested() only after the check passes. This
opens a window where smc_close_active() can transition the listener
to SMC_CLOSED, call smc_close_cleanup_listen() to drain the accept
queue, and release the lock, all between the lockless read and the
delayed lock acquisition:

  smc_listen_work (smc_hs_wq)          smc_close_active()
  -------------------------------      -------------------------
  release_sock(child)
  if (sk_state == SMC_LISTEN) TRUE
                                        lock_sock(listener)
                                        sk_state = SMC_CLOSED
                                        smc_close_cleanup_listen()
                                        release_sock(listener)
                                        flush_work(tcp_listen_work)
  lock_sock_nested(listener)
  smc_accept_enqueue(listener, child) /* child enqueued on dead listener */

smc_close_active() flushes only tcp_listen_work. Work items already
dispatched onto smc_hs_wq for the CLC handshake continue running
unguarded. smc_accept_enqueue() takes a sock_hold() on the child that
is never released, so the child smc_sock, its clcsock, and the
reference all leak. A remote peer that opens TCP connections while the
server calls close() can exhaust kernel memory.

Move lock_sock_nested() to before the sk_state check so that the test
and the enqueue are atomic under the listener lock.

Fixes: fd57770dd198 ("net/smc: wait for pending work before clcsock release_sock")
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Signed-off-by: Sidraya Jayagond <sidraya@linux.ibm.com>
---
 net/smc/af_smc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b5db69073e20..00403175b740 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1931,11 +1931,12 @@ static void smc_listen_out(struct smc_sock *new_smc)
 		atomic_dec(&lsmc->queued_smc_hs);
 
 	release_sock(newsmcsk); /* lock in smc_listen_work() */
+	lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
 	if (lsmc->sk.sk_state == SMC_LISTEN) {
-		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
 		smc_accept_enqueue(&lsmc->sk, newsmcsk);
 		release_sock(&lsmc->sk);
 	} else { /* no longer listening */
+		release_sock(&lsmc->sk);
 		smc_close_non_accepted(newsmcsk);
 	}
 
-- 
2.53.0

