Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC393EB118;
	Thu,  1 Oct 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850796; cv=none; b=VBgQ7u5SuBXtlUbH7CGnGkmYrV321u2blBQGxrPHf1sDhnJ4LcyImPLxYt/XxWXTJcGC4vO3i1oHBqT0mL9MkMoyLLN23zzXWSTd7uSpgPXeQwyLvWkMEBiNGMYxBTkLGtBzQTjV5NK93OOi6ZXllmYCCBnsd7xJi046uIJO3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850796; c=relaxed/simple;
	bh=YmKqWDC+ybr4Z7O+fBWcVdJ6uJeu0sUa7GCazKbB+OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfHkJVSt03nrg3kPRTtdtDVNcwEwtCRgKHdNSk2it3CRomOXOwyQZr6N8HPLC2qdP+9TSM79H7PR//jMJ5S9SAla/tel5z+zgOJFviQGOEDeQBPT9J3rS2foSdgqYVtl3krbYLjB3J99vc/o5D8pTKd4JJMLyRpHAToYFjIKVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZhBCgfWX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZhBCgfWX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175dpU1119261;
	Thu, 1 Oct 2026 10:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3SZznmnD7zuz8UEKM
	7y8II6wx+arI3yYW2YIbisFJCs=; b=ZhBCgfWXceav3h/OuwrBAazi3UGI3+eQ8
	PySQU32Ray4hLZlq5BjbTu4+f4taQV2tTAErVeAHnk7JcjseBrRxCXAy8ew/kbPk
	JXZm08O5/8zvCGT95W0jnUAiwAxB8hi/Fmcv4KvAP0x9lnbOYSY57rF/d7aJ4LMQ
	qDFRkfc5a+7QvE7sjVWLvZh4u/3qOYkyhcPXI54CLrozLXXDRrIktPxzlZ5F/J8L
	zYx9if5SUW3GCGChGCtYHC7oboWtS4nF7Tzx1gSv2HNyjFWQlqJGVdmV0n+8katx
	GmHMwhuroMGoSfsDUofifDTaN800ztWBQI4L4skXwuo4mPMmVpC5g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5jrb3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:33:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6917HP8Q545519;
	Thu, 1 Oct 2026 10:32:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsdg17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWtVi42336738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ACEF20043;
	Thu,  1 Oct 2026 10:32:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F7E92004E;
	Thu,  1 Oct 2026 10:32:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:55 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 26/32] s390/boot: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:41 +0200
Message-ID: <20261001103247.1989111-27-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001103247.1989111-1-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXz42DPmLW9ki/
 Wi31n7Aq86WP77YeVWD43ZaZVITRg71ntHlDqxjITpiHpMNEO06h79QGH5hTFe0H055aKT5H4qu
 jd1+fOyeJ9BEiCKXlzX5hTBif1+IdBM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX2aJnPQK1+OwK
 z/qgmH5Xwf66LKiH3BNqV83aEfeqoPfwvR2fpEsCM4oo1MQMMHuEYOHjGag8JQiRRSRi337EM/W
 kMvyGLgLAu+xfxpQW3o/Jv94w8vHH7jk8ZNVjwMoi1tvCfIz9zcCMzioirHW1yRp5wjk5r2belw
 kYdhm4ogNpSNnZZUW4fVIxIi7g4gZFYiVW8/pHmkwi8jzpF19NCgiLzRFcwKRnxN7QFu5z/kBYG
 cENhQHdttFE+en5HtZ7CCyqWaJFZ0rfo6DLsnzOVgW/1wIFrmT7jyGsxqKzOw3jNLBqEoO0F0r6
 0Ap7z3tffSdxVXuxcwfLGi8DTeqnUMg1GMPi0AZTpqIAvO4sPEU8kEi9ehZ4RCw45rTbRsrDKTN
 N9iMHX1mLt8TObtUimZ3pB8BAoVvUsxuVpFvJR7ri9jabFTgNkA3zep73Y8isIeYzPg1689ffhL
 HSZV9joL5MD+E/LRFVg==
X-Proofpoint-GUID: p7-wuKhiZtXZBgUqi4hfS1lLaWQfXGfl
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abe36dc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=79UiqUrZH-lhCgubdzAA:9
X-Proofpoint-ORIG-GUID: p7-wuKhiZtXZBgUqi4hfS1lLaWQfXGfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Convert all boot exception table entries to use EX_TABLE_INSN.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/ipl_parm.c     |  6 +++---
 arch/s390/boot/physmem_info.c | 18 +++++++++---------
 arch/s390/boot/startup.c      | 12 ++++++------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index c1b43e5e688a..ff2ac7f16fe0 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -40,9 +40,9 @@ static inline int __diag308(unsigned long subcode, void *addr)
 	union register_pair r1 = { .even = (unsigned long)addr, .odd = 0 };
 
 	asm_inline volatile(
-		"	diag	%[r1],%[subcode],0x308\n"
-		"0:\n"
-		EX_TABLE(0b, 0b)
+		"0:	diag	%[r1],%[subcode],0x308\n"
+		"1:\n"
+		EX_TABLE_INSN(0b, 1b)
 		: [r1] "+d" (r1.pair)
 		: [subcode] "d" (subcode)
 		: "cc", "memory");
diff --git a/arch/s390/boot/physmem_info.c b/arch/s390/boot/physmem_info.c
index 0ebb2174713f..e5248b637326 100644
--- a/arch/s390/boot/physmem_info.c
+++ b/arch/s390/boot/physmem_info.c
@@ -68,11 +68,11 @@ static int __diag260(unsigned long rx1, unsigned long rx2)
 	ry = 0x10; /* storage configuration */
 	exception = 1;
 	asm_inline volatile(
-		"	diag	%[rx],%[ry],0x260\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	diag	%[rx],%[ry],0x260\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [exc] "+d" (exception), [ry] "+d" (ry)
 		: [rx] "d" (rx.pair)
 		: CC_CLOBBER_LIST("memory"));
@@ -108,9 +108,9 @@ static int diag500_storage_limit(unsigned long *max_physmem_end)
 	asm_inline volatile(
 		"	lghi	%%r1,%[subcode]\n"
 		"	lghi	%%r2,0\n"
-		"	diag	%%r2,%%r4,0x500\n"
-		"0:	lgr	%[slimit],%%r2\n"
-		EX_TABLE(0b, 0b)
+		"0:	diag	%%r2,%%r4,0x500\n"
+		"1:	lgr	%[slimit],%%r2\n"
+		EX_TABLE_INSN(0b, 1b)
 		: [slimit] "=d" (storage_limit)
 		: [subcode] "i" (DIAG500_SC_STOR_LIMIT)
 		: "memory", "1", "2");
@@ -127,11 +127,11 @@ static int tprot(unsigned long addr)
 
 	exception = 1;
 	asm_inline volatile(
-		"	tprot	0(%[addr]),0\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	tprot	0(%[addr]),0\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [exc] "+d" (exception)
 		: [addr] "a" (addr)
 		: CC_CLOBBER_LIST("memory"));
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index c1dcf8b1b579..5eb7a3e1f9f1 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -89,10 +89,10 @@ static void detect_diag9c(void)
 
 	cpu = stap();
 	asm_inline volatile(
-		"	diag	%[cpu],%%r0,0x9c\n"
-		"0:	lhi	%[rc],0\n"
+		"0:	diag	%[cpu],%%r0,0x9c\n"
+		"	lhi	%[rc],0\n"
 		"1:\n"
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: [rc] "+d" (rc)
 		: [cpu] "d" (cpu)
 		: "cc", "memory");
@@ -150,10 +150,10 @@ static int cmma_test_essa(void)
 
 	/* Test ESSA_GET_STATE */
 	asm_inline volatile(
-		"	.insn	rrf,0xb9ab0000,%[tmp],%[tmp],%[cmd],0\n"
-		"0:	lhi	%[rc],0\n"
+		"0:	.insn	rrf,0xb9ab0000,%[tmp],%[tmp],%[cmd],0\n"
+		"	lhi	%[rc],0\n"
 		"1:\n"
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: [rc] "+d" (rc), [tmp] "+d" (tmp)
 		: [cmd] "i" (ESSA_GET_STATE)
 		: "cc", "memory");
-- 
2.53.0

