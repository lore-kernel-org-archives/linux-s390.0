Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086EF328B77;
	Thu, 13 Aug 2026 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607015; cv=none; b=uxpiA72RnefDGSpVLE198yy+/ZnynSafiEMJvqDurjNxrUSJfRii6/HLTyHC44jLyP5VyJnzlFryKDSB+sPGMr+lcaTRXwTRDMzP9FSf/inqUwc62u/mrs1CDzZETma5ed2ro3Ba2KxxkgbJIMQI2unW/bJLVrMH4qVtAbOeuj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607015; c=relaxed/simple;
	bh=a4YVlWFl709Eb8AQrJEmuuJjttVNj/1mZiX+yfWZG9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gy0GER3IRwa+mrre9Zcfxl5vUffUHIrs2xRwezKGsOk8g2BpEXcKkug0JgiNtgzafnZaTV6ysqvs5ishgVe//Klc8fi1O4LaZl7BSXi9UL+xH1r1Ch9S7EyDaHaBpleiVROL+qsd7o8R+R07JdllsrgaBpzcTX5D751Ui0v8RhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MjJ+C/Em; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MjJ+C/Em"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D61wue1430858;
	Thu, 13 Aug 2026 07:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FPhKMOovbs4yAYQc6W7yJ3HqLdyHsafJlCTmhwLRY
	54=; b=MjJ+C/EmdwofNG4D2HEzQFrXhZDl8SHmsdVc8VRGur5hjH9AN2x9hm0Uu
	UN2NY3lijPta9fjMWGnLsM2j8oddhHRhkesuRiYdysjTFP7ld+Q8wL+hVOaSf87G
	bdaMgKCYiuSPhsGpe4+3vSLg8oNzVcNfYJU/HP7+2LHzpLHRozlcGlvs1NCKc/Ka
	HMarlcKOi7MikRbkoBlZERPJcrcUX9veRXaAJsx0U5IJ3pKMls9VB4CrvmX04P7d
	ZV/3AsQaJZCsRdHCFxB02kcvB30zjNU4EHay9jlx3BzvE0KbekNjuW6Bo40RsBLQ
	MDX8D3OWXbFYSsxYm8Oee3Uj7aNYw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp35v6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:43:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D7fGI8005035;
	Thu, 13 Aug 2026 07:43:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy9vnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 07:43:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D7hMRb30540164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 07:43:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37F282004B;
	Thu, 13 Aug 2026 07:43:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F38FC20043;
	Thu, 13 Aug 2026 07:43:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 13 Aug 2026 07:43:21 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id DC1051612E0; Thu, 13 Aug 2026 09:43:21 +0200 (CEST)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
        hidayath@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: [PATCH net] net/smc: hash socket only after full initialisation in smc_sk_init()
Date: Thu, 13 Aug 2026 09:43:15 +0200
Message-ID: <20260813074315.554926-1-mjambigi@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7d759f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=-ibLmwfWAAAA:8 a=VnNF1IyMAAAA:8
 a=KdTQYx-huaeXBQr4oQUA:9 a=A6MkUVyZPcTV1i89ro0M:22
X-Proofpoint-GUID: oDi_CjKzNQ4jV8TMfHBH-2yDRyNGNkkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1MSBTYWx0ZWRfX0q6ANZMqxhgr
 n6E9X0ydAm3CMCnICzNyyjac246WvSRymkfNJTbs5lsgXYM5Mznzn+UB7fEh696S+zi56cqvKJd
 ZxrS2QS5aR1tz65ThhM+OToNDCxhEMgZohq73p7e3oE/PlsFGrqkgZWf8+TLk0GVClrwlY1Reo9
 ceI6V9/WY41SP1PyR/7oleMrAn/6DO4eBLI6FBBNUWZuQmVGD94G2FRxMVZFC1uBtC9YN2ukB/r
 dF93xXwhfeW9vB1RyvS/LvYWJt8QbQg48oD1oPa4C+VUJqtZCFamnYYFzAc4i7yCl2vkGqRfrZn
 t/DtM+ci6lsPVGY7qDD3gADSDhIXu/tbzrRR/+CJxKMK8Gu3+R4ouWrIcYsip5b+8qT8lJc1AGq
 pTgaAJI6KQLrGMMesN7g3KVN1jajvbbEf/HArFcrq+a2314ILV/3AFSeLafbg0+6hB5enY9gRLb
 87Ml5e6q2vORBQid6hA==
X-Proofpoint-ORIG-GUID: 0TQjeYdrXLIJF6b0d_leJqwo4d_wtfwB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1MSBTYWx0ZWRfX8ht0d/O88Slq
 X1mPstt44Eq6pAltQqdkSHGw6krsF0q5Ufh/H0PxN3Ldrrdmxtj49jVtlMh7ZkgKRgOluFnlnvG
 DqcSqoqbMaZDlH5GOK2PSzHK+D3ImJU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130051

smc_sk_init() calls sk->sk_prot->hash(sk) before several fields are
fully initialised: clcsock_release_lock, the saved clcsk_* callbacks,
use_fallback/fallback_rsn, and conn.close_work.  Once hash() returns the
socket is visible to concurrent hash walkers, which can then observe
uninitialised state.

Move hash(sk) to the end of smc_sk_init() so the socket is published
only after it is fully constructed.

Fixes: d0e35656d834 ("net/smc: refactoring initialization of smc sock")
Reviewed-by: Hidayath Khan <hidayath@linux.ibm.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
Found by syzbot while testing a diag dump patch that drops the hash
read lock before calling mutex_lock(&smc->clcsock_release_lock).  That
change made the uninitialised mutex reachable for the first time and
triggered DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock) immediately.

syzbot report:
https://ci.syzbot.org/series/ab0d12fd-741a-4a0f-9f49-e52b84e94f4a

 net/smc/af_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 00403175b740..5e7560417ec7 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -409,13 +409,13 @@ void smc_sk_init(struct net *net, struct sock *sk, =
int protocol)
 				      "sk_lock-AF_SMC", &smc_key);
 	spin_lock_init(&smc->accept_q_lock);
 	spin_lock_init(&smc->conn.send_lock);
-	sk->sk_prot->hash(sk);
 	mutex_init(&smc->clcsock_release_lock);
 	smc_init_saved_callbacks(smc);
 	smc->limit_smc_hs =3D net->smc.limit_smc_hs;
 	smc->use_fallback =3D false; /* assume rdma capability first */
 	smc->fallback_rsn =3D 0;
 	smc_close_init(smc);
+	sk->sk_prot->hash(sk);
 }
=20
 static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
--=20
2.50.1
