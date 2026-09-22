Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69E388866;
	Tue, 22 Sep 2026 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062350; cv=none; b=je5QLwznUtViGmX9tJuLs/pbSRm8LUm3j6Ohl/xSq+FEYLg9DUSHk94Qd4fMPlNTChbVHGksxnu5l3HNc596rxp0NOaVxLAsLIvFg7FH5AZLx4Rm+1T7pq4Jf54pQMDA1/w1Ff/OB0aS4wUOAPZM+FhdfM7J2JzcZjvL2R1UELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062350; c=relaxed/simple;
	bh=dflm89WV46Y54LLm/MlFMMsT6lup5HIiKROHc3J5cPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUVOprDGGHvW/EtN1AvLsB45GD2kF7mJILfZhuB5ZPAFERI4GfxXZyM5XYYp8O7uNwVfzJcry14DSLunUGH8wy+QtgVUKdMOUed95Kd8dKeomF2XpK6Rxi3cGzOte41XyTFDu8ygWA3Njb4QLBbhomhW6mzpf9BEMs0PSkmRJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qUAWzaJk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qUAWzaJk"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05eCS2940191;
	Tue, 22 Sep 2026 07:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XIDKa6v33qiLkZlR2kga3m/pOyTAzeEmEve590H1F
	VU=; b=qUAWzaJkHMQVLa2B/Rq1JhM8i+bF6DbCIJDYDIzt/mHda/v0JcLhASejN
	iMzJc/NvKV0uzNlCZor6d3C0a0qMVzSIPqLGYOB+G1eisNjcMrjgKtbqdRAU9V9O
	DXruXGjtPOse2vYfdVZ+yjMFsAtqlhOjZZTa4vrQXEmF5LRD2x/rh48o9w68l5S9
	XhQIqfCyciDp6nyFEQXmj5qTjLF9AeECFwHcnH981j459HqGDY4JsmNHs+Hxl4mf
	GycdfAWB1DpE+R+4CMRdi2dG0hqRZWvydLWoxr12/gdLY+T7U13Oi23XAPbXBBzQ
	NvjJV7dzwRWVLWkoCsxS5kJXQVeeA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2cj2n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 07:32:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5abo8764392;
	Tue, 22 Sep 2026 07:32:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkbcug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 07:32:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M7WJM840632726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 07:32:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A867620043;
	Tue, 22 Sep 2026 07:32:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6022220040;
	Tue, 22 Sep 2026 07:32:19 +0000 (GMT)
Received: from a3560036.lnxne.boe (unknown [9.87.84.240])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 07:32:19 +0000 (GMT)
From: Sidraya Jayagond <sidraya@linux.ibm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, horms@kernel.org, mjambigi@linux.ibm.com
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, hidayath@linux.ibm.com,
        pasic@linux.ibm.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Sidraya Jayagond <sidraya@linux.ibm.com>
Subject: [PATCH net] net/smc: fix UAF on lgr list traversal in smcr_port_err()
Date: Tue, 22 Sep 2026 09:31:49 +0200
Message-ID: <20260922073149.474762-1-sidraya@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ocFeFL8uoPj236ybzlmj_n1bLnUBuarB
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab22f08 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ymF_nRivq1EBAYUJqxcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEwMCBTYWx0ZWRfX9R2/cxkhhHjt
 M/Ds9bJORr5QqP+4TqtBbnlGCwRyle4y38fCKzPyC44m9pojrt4TEX5lisrCaRdB6kMJrcWmbPV
 Qqob0DcwNmTA5KGinbKqlmYCJfBx37Rv1OYVZVjGauskoh9KeQ927O8wX1XWvK9UKvOF3Bxgm6r
 7BAv+IEzvS4XGuiB/IbWc9xdOxxTQsjpXKjqGAQvLmmjFQNhFwoQVEKx5OgQwaPZAUG3NtkVwxn
 CCRbrzx730rvKuVMJYJ0M/s8LoQvxjCRqv534x1WaOBXmPfhEjuyuXFczGqNt6MM1YUsxW1GskN
 t93z9Dku5NasWSwcn1Fac2R+usep9lp8XNO6XtIeNct0arp3ncavXoa0j/0uq5uJSQAEvaVS3H6
 M6J5WexmDFLImV7sgikjBnDPvzLOC4KXuYpAwZgUiRYPsigGE1Doedx01TBDFIX70OCAnqzO2S6
 8RQVJJaqDr3at95F/Bw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEwMCBTYWx0ZWRfX2CIGnFOAIdUO
 DOiT8oMfEaOCYAJjaE2/uPE9IT9COA8Ks/VDWpnyVG6jdSKXbYQqZIoH/jBkhuHOifYFkOdMYqF
 dFEP5H9mr3YhcTXZQ9sugaafZin5LIM=
X-Proofpoint-GUID: Lz4NKzJssx3bxIQVxP92h8rnPjXOMyLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220100

smcr_port_err() traverses smc_lgr_list.list without holding
smc_lgr_list.lock, allowing a concurrent smc_lgr_terminate_sched()
to free an lgr while it is still being dereferenced.

Hold smc_lgr_list.lock across the traversal. Update
smc_ib_gid_check() to call smcr_port_err() after releasing the lock.

Fixes: 541afa10c126 ("net/smc: add smcr_port_err() and smcr_link_down() processing")
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Signed-off-by: Sidraya Jayagond <sidraya@linux.ibm.com>
---
 net/smc/smc_core.c |  2 ++
 net/smc/smc_ib.c   | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 04aedd957543..9974149659c2 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1849,6 +1849,7 @@ void smcr_port_err(struct smc_ib_device *smcibdev, u8 ibport)
 	struct smc_link_group *lgr, *n;
 	int i;
 
+	spin_lock_bh(&smc_lgr_list.lock);
 	list_for_each_entry_safe(lgr, n, &smc_lgr_list.list, list) {
 		if (strncmp(smcibdev->pnetid[ibport - 1], lgr->pnet_id,
 			    SMC_MAX_PNETID_LEN))
@@ -1863,6 +1864,7 @@ void smcr_port_err(struct smc_ib_device *smcibdev, u8 ibport)
 				smcr_link_down_cond_sched(lnk);
 		}
 	}
+	spin_unlock_bh(&smc_lgr_list.lock);
 }
 
 static void smc_link_down_work(struct work_struct *work)
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 9bb495707445..daaa8a72da90 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -333,6 +333,7 @@ static bool smc_ib_check_link_gid(u8 gid[SMC_GID_SIZE], bool smcrv2,
 static void smc_ib_gid_check(struct smc_ib_device *smcibdev, u8 ibport)
 {
 	struct smc_link_group *lgr;
+	bool stale_gid = false;
 	int i;
 
 	spin_lock_bh(&smc_lgr_list.lock);
@@ -348,11 +349,16 @@ static void smc_ib_gid_check(struct smc_ib_device *smcibdev, u8 ibport)
 				continue;
 			if (!smc_ib_check_link_gid(lgr->lnk[i].gid,
 						   lgr->smc_version == SMC_V2,
-						   smcibdev, ibport))
-				smcr_port_err(smcibdev, ibport);
+						   smcibdev, ibport)) {
+				stale_gid = true;
+				goto out;
+			}
 		}
 	}
+out:
 	spin_unlock_bh(&smc_lgr_list.lock);
+	if (stale_gid)
+		smcr_port_err(smcibdev, ibport);
 }
 
 static int smc_ib_remember_port_attr(struct smc_ib_device *smcibdev, u8 ibport)

base-commit: f0b88fade64c6fe52e15b246097d10bb115d8af3
-- 
2.55.0

