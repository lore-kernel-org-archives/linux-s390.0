Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6013DDAFA
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441111; cv=none; b=ojD8wfRzYN0UmMKKsPg/1WsGfKg2yhW5fnihhbxl4ykEJJNzqIxGKmk5/bObS8h00vofvEbKyVSN91V81TBl4iJOIu6rChxeST5GKoNyBJcNvhHLT921BKB7ggWPxYDnzQouq0nGg3UL3ikpCYb7sz0O+ztKA+KAKOotIds0tCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441111; c=relaxed/simple;
	bh=+gkOl6Jma5OdYt9EGfZHA5frhFKAnc1cMPLw/iRwn1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdlfRzODUPKU+ipTAuemipthoptYnWoyUEJjQlbYu/hu0QMEZz8bk0vT7UZHoIqFhHS+Pvd+QVmt75o69m4KkDfngh0fc4o9UwnNweVBr9QZ3K+sFYeNbhiUhXiaTx0PC5t4XdIcFKQ5CLNuDnbrF6hEsU1Vuh4TTwlBVwfqWqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PTZEWYAs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PTZEWYAs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FmH4j309828;
	Tue, 7 Jul 2026 16:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7HeIz0x3Vg4GqOBlZ
	v/iGgOTB+uhuxBJfASbtqqOY7o=; b=PTZEWYAskIODaNYLKllxr6o+tE6/h4qsW
	l2LmQrhXpSMNP+unb26NUp7m7TiwvqMbYxlA71FZ2VUjBSvxWTAuM+FB2WzQJMKb
	CLz3647LlVD5uCNSYUPQktT+/YhZcvlK1vgZ8WH1dLbC+sjmSFcqKEQezcUBtKcl
	82dkFP3eO4bTJJF9xzP4AyLbRHE9TTjHyVrlARmh6w8qeYlg0uB3jr4Xu/yN8fPG
	6kuNVpO4CaKkhEFDaeFfjulO02MIwND760Q5N8Whh/FcDLKzCdtLOIgMxNHM7jVr
	YXktFIu57PFZE+BbxUgOsd4djQAGVdZtW1E+UYma958FcFN1OaN8Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqqw2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667G4cH6023292;
	Tue, 7 Jul 2026 16:18:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk3n39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667GIEMq24052110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 16:18:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3551F2004D;
	Tue,  7 Jul 2026 16:18:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1082020063;
	Tue,  7 Jul 2026 16:18:14 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.140.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 16:18:14 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v11 01/21] target/s390x: Fix wrong address handling in address loops
Date: Tue,  7 Jul 2026 18:17:48 +0200
Message-ID: <20260707161815.40919-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707161815.40919-1-freude@linux.ibm.com>
References: <20260707161815.40919-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfXyrxFZ3raPmuS
 1Od3XEhp13vUj0oFIjUq9hyjttdBBBNVK5wLVDglsQ0wW9WIJyFM0dj68PwMtZzrzNv83xJ8hcy
 4SIbeSGZVAcM2y5EwAgxzvLuzTBrYtc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX/p9mEAbdwV6j
 tYpLbikDQtJRoj20TyXoUNYdM94FvK77w6uEBukBsL3UMhMuZHkJPBcdcXuxXOAJhati0u2hSqW
 s+DT97W5RgHrGaqX8p4/Z2issUhP9CsYXkHJ/XIm7okDPYItgJpPee+lrH9UL1JDFlwmNRnrUZT
 jfhhHst57nbfTKYxHOUmBUzZ1hfOiSPDVUzCPw1MRe3SO/1scZM+3lPFnvZ2V4aV097OMMrd5jy
 n9HYrxsWWgcuvuoG1UMwPAfM7o/Y8iGq3HKFQlh0mZzE3DXPeKdcuzVq2bZh1H3+MFpiIvq2ojY
 HoHBmq+316mTVdOByPl3c8zvzRyW95Soc+8cqJI52YbCaRgiO4A9IpZrQZnCtxeBg2t6mYLL0zW
 PgroIO+zrUXd0n9RVZLh7Hm690HnfSxWUFZXTp1ztFmr+XdaEAijS5Yr0ha9tPH4BubVqSbLANw
 zj7xqH9ud2sh/lsDfGA==
X-Proofpoint-GUID: YzNIBB8JPTppGyj440b-vuxxh5-pt2j3
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4d26cb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=JcvBkDReJmzHsdK6FyIA:9
X-Proofpoint-ORIG-GUID: YzNIBB8JPTppGyj440b-vuxxh5-pt2j3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070160

The loop increments addr by the element stride (+= 4) before calling
wrap_address, but then overwrites the loop addr with the wrapped
value. On the next iteration the stride is applied to the wrapped
address of the previous element, not to the original unwrapped
address. This results in every element after the first is read from a
wrong (wrapped) address.

Fixes: 9f17bfdab4 ("target/s390x: support SHA-512 extensions")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/crypto_helper.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index ae392bce0e..8fe0a22219 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -126,8 +126,7 @@ static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
     for (int i = 0; i < 8; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
+        a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
     }
 }
 
@@ -137,8 +136,7 @@ static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
     for (int i = 0; i < 8; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        cpu_stq_mmu(env, addr, a[i], oi, ra);
+        cpu_stq_mmu(env, wrap_address(env, addr), a[i], oi, ra);
     }
 }
 
@@ -148,8 +146,7 @@ static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
     for (int i = 0; i < 16; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
+        a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
     }
 }
 
@@ -159,8 +156,7 @@ static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
 
     for (int i = 0; i < 16; i++, addr += 1) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldb_mmu(env, addr, oi, ra);
+        a[i] = cpu_ldb_mmu(env, wrap_address(env, addr), oi, ra);
     }
 }
 
-- 
2.43.0

