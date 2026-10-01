Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1EB3D6CA3;
	Thu,  1 Oct 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850796; cv=none; b=it79vP6/3+AXiEhumYYLYjQ0+CrIyb2U+8Ntz2d8fKNuA3ceTNz+dKCjS/IMN3ZjZtG178W+jv8NPOsAecqltHj53T4pJt8lL72FTZYGR3fi86ch/q9IUOPUAlRevHGC1CXaen/lMUcDR+FJ8Gl2B1rANW7e0+Mro2vGMfWL3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850796; c=relaxed/simple;
	bh=PSLqnC4Wo9AmENyTAevnNxI/sMV6ualdCLzawx4NU90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hxf8jYERL124c4Jqpznz9gZ1/5auGFBovvY6D2hA+fmcrRw1aNY7ebQ8LLxIaf4uXlZwtDqXLHTyzs07FriEngSph/K35IwcPEewOn9YsrHgGrF2OvPdYmMBA/dZfO7/Tv/ik5FTo5KF+w38iL0U5CZqNVLyCI2RocxV99JoGsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z0jx8YdK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z0jx8YdK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175Xwt1086072;
	Thu, 1 Oct 2026 10:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eK9wxooq1mGlThIy/
	kRl0AYnLfp2T2Dt5A8fbaMTZKU=; b=Z0jx8YdKoIQe3OplkmneoggOADGSHqDJL
	X/niYZgvUdkwx/6juxjIHhF6PSJq0AFRYHeOK/3bbqXZaIbTD6LmoGpxqKh2T2Fn
	SkfEpM/pDjlyMhERhFN6DQqPEss38LCJ4Eanw0KkYq/sO3VusElstlXNDtHrevXM
	usB4WbbLguLdKSUfVEBxAUI141m4UdwbHBEgnxY2DLUPku+fZCkNC73w7g/JXG6h
	Cl6GN6XnOnBbXF9gDSkiLrsKxYsbOblaB8IutfR0ztHaXyhs/dxFHPC4utMpGwCC
	Y2mSZZ7fiLPeiZXb5hTBs0WKXRrKnat1tswAIS5HBaDD4OEk25MkQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pthch9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172gAQ561279;
	Thu, 1 Oct 2026 10:32:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e8kb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWtvB42336736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A11D2004B;
	Thu,  1 Oct 2026 10:32:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 152B52004D;
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
Subject: [PATCH 25/32] s390/pci: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:40 +0200
Message-ID: <20261001103247.1989111-26-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 9f5eFX-s2Anu5Ob3SUsNB0xzRTzqdrha
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX1YOPwMkyAQdM
 4feS7jK5OWgEWdiw3klXXww6foN7KQVDPTYs6818gAcfgWuFQ3TZorD2OhEXWVMvVs1sW0HDqPH
 hXRvXyzYFq99J8xZGkac1Y+Tf7V2mdvtEfC+vELpQANj7/8ue9JROUjsb8k4HBOkdZU1gMLZvRs
 7p3PGw9wEue0vDBIRapZjlXPe2413EVHhHqQm22j34TzPhvp/afQceQRpMqQ5C2Bt8bvQ08og6X
 ePOjEOobDGllOWspB7HMLlTehogUg4pTI8U1oF3UNXUg7WiNj/I7pcxikhKZgH/+4IelarbBVbK
 7N9pCPDWWBAwmV5qBVB1lxPh/EF1IEVNZClWV6FHa3LVyJpU/5PZOf5wY8/mS5BTg3wvdM64qui
 6cLlBpGj6ZVVTLvcJrNT1DO998w4qv5bkRbfhn1y9fe3LyaMx6uhoUcpi8sXQ5yHJdwr+Kf68eC
 mMIhJVfWAptjOuICdRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXxqVodwvF+Rgm
 bKELGvutiYq6Pl8mRKS60WwJAMI3GozdDE5AFa/6sV5iBfYeUA7tesBiCTRXxmXIF6I/MZRB7F/
 oeZxYxw+Ooxl7FTtJo+QX7pp3JEdPzQ=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abe36db cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=M1MybpfZHo4ebeBcTrMA:9
X-Proofpoint-GUID: 9f5eFX-s2Anu5Ob3SUsNB0xzRTzqdrha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Convert all pci exception table entries to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so duplicate entries are removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/pci/pci_clp.c  | 12 ++++++------
 arch/s390/pci/pci_insn.c | 36 ++++++++++++++++++------------------
 arch/s390/pci/pci_mmio.c | 28 +++++++++++++++-------------
 3 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 177aa0214547..2d7eaf4d9d59 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -55,11 +55,11 @@ static inline int clp_get_ilp(unsigned long *ilp)
 
 	exception = 1;
 	asm_inline volatile (
-		"	.insn	rrf,0xb9a00000,%[mask],%[cmd],8,0\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	.insn	rrf,0xb9a00000,%[mask],%[cmd],8,0\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [mask] "=d" (mask), [exc] "+d" (exception)
 		: [cmd] "a" (1)
 		: CC_CLOBBER);
@@ -78,11 +78,11 @@ static __always_inline int clp_req(void *data, unsigned int lps)
 
 	exception = 1;
 	asm_inline volatile (
-		"	.insn	rrf,0xb9a00000,%[ign],%[req],0,%[lps]\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	.insn	rrf,0xb9a00000,%[ign],%[req],0,%[lps]\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [ign] "=d" (ignored), "+m" (*req), [exc] "+d" (exception)
 		: [req] "a" (req), [lps] "i" (lps)
 		: CC_CLOBBER);
diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
index 35ceb1bea1c6..ed0def408f18 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -161,11 +161,11 @@ static inline int ____pcilg(u64 *data, u64 req, u64 offset, u8 *status)
 
 	exception = 1;
 	asm_inline volatile (
-		"	.insn	rre,0xb9d20000,%[data],%[req_off]\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	.insn	rre,0xb9d20000,%[data],%[req_off]\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [data] "=d" (__data),
 		  [req_off] "+d" (req_off.pair), [exc] "+d" (exception)
 		:
@@ -230,11 +230,11 @@ static inline int __pcilg_mio(u64 *data, u64 ioaddr, u64 len, u8 *status)
 
 	exception = 1;
 	asm_inline volatile (
-		"       .insn   rre,0xb9d60000,%[data],%[ioaddr_len]\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	.insn	rre,0xb9d60000,%[data],%[ioaddr_len]\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [data] "=d" (__data),
 		  [ioaddr_len] "+d" (ioaddr_len.pair), [exc] "+d" (exception)
 		:
@@ -268,11 +268,11 @@ static inline int __pcistg(u64 data, u64 req, u64 offset, u8 *status)
 
 	exception = 1;
 	asm_inline volatile (
-		"	.insn	rre,0xb9d00000,%[data],%[req_off]\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	.insn	rre,0xb9d00000,%[data],%[req_off]\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [req_off] "+d" (req_off.pair), [exc] "+d" (exception)
 		: [data] "d" (data)
 		: CC_CLOBBER);
@@ -322,11 +322,11 @@ static inline int __pcistg_mio(u64 data, u64 ioaddr, u64 len, u8 *status)
 
 	exception = 1;
 	asm_inline volatile (
-		"       .insn   rre,0xb9d40000,%[data],%[ioaddr_len]\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	.insn	rre,0xb9d40000,%[data],%[ioaddr_len]\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [ioaddr_len] "+d" (ioaddr_len.pair), [exc] "+d" (exception)
 		: [data] "d" (data)
 		: CC_CLOBBER_LIST("memory"));
@@ -357,11 +357,11 @@ static inline int __pcistb(const u64 *data, u64 req, u64 offset, u8 *status)
 
 	exception = 1;
 	asm_inline volatile (
-		"	.insn	rsy,0xeb00000000d0,%[req],%[offset],%[data]\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	.insn	rsy,0xeb00000000d0,%[req],%[offset],%[data]\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [req] "+d" (req), [exc] "+d" (exception)
 		: [offset] "d" (offset), [data] "Q" (*data)
 		: CC_CLOBBER);
@@ -411,11 +411,11 @@ static inline int __pcistb_mio(const u64 *data, u64 ioaddr, u64 len, u8 *status)
 
 	exception = 1;
 	asm_inline volatile (
-		"       .insn   rsy,0xeb00000000d4,%[len],%[ioaddr],%[data]\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	.insn	rsy,0xeb00000000d4,%[len],%[ioaddr],%[data]\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [len] "+d" (len), [exc] "+d" (exception)
 		: [ioaddr] "d" (ioaddr), [data] "Q" (*data)
 		: CC_CLOBBER);
diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index f3f79ba78410..8b49175b0031 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -39,10 +39,10 @@ static inline int __pcistb_mio_inuser(
 	asm_inline volatile (
 		"	sacf	256\n"
 		"0:	.insn	rsy,0xeb00000000d4,%[len],%[ioaddr],%[src]\n"
-		"1:	lhi	%[exc],0\n"
-		"2:	sacf	768\n"
+		"	lhi	%[exc],0\n"
+		"1:	sacf	768\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), [len] "+d" (len), [exc] "+d" (exception)
 		: [ioaddr] "a" (ioaddr), [src] "Q" (*((u8 __force *)src))
 		: CC_CLOBBER_LIST("memory"));
@@ -72,15 +72,16 @@ static inline int __pcistg_mio_inuser(
 	asm_inline volatile (
 		"	sacf	256\n"
 		"0:	llgc	%[tmp],0(%[src])\n"
-		"4:	sllg	%[val],%[val],8\n"
+		"	sllg	%[val],%[val],8\n"
 		"	aghi	%[src],1\n"
 		"	ogr	%[val],%[tmp]\n"
 		"	brctg	%[cnt],0b\n"
 		"1:	.insn	rre,0xb9d40000,%[val],%[ioaddr_len]\n"
-		"2:	lhi	%[exc],0\n"
-		"3:	sacf	768\n"
+		"	lhi	%[exc],0\n"
+		"2:	sacf	768\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 3b) EX_TABLE(4b, 3b) EX_TABLE(1b, 3b) EX_TABLE(2b, 3b)
+		EX_TABLE_INSN(0b, 2b)
+		EX_TABLE_INSN(1b, 2b)
 		: [src] "+a" (src), [cnt] "+d" (cnt),
 		  [val] "+d" (val), [tmp] "=d" (tmp), [exc] "+d" (exception),
 		  CC_OUT(cc, cc), [ioaddr_len] "+&d" (ioaddr_len.pair)
@@ -227,13 +228,13 @@ static inline int __pcilg_mio_inuser(
 	asm_inline volatile (
 		"	sacf	256\n"
 		"0:	.insn	rre,0xb9d60000,%[val],%[ioaddr_len]\n"
-		"1:	lhi	%[exc],0\n"
+		"	lhi	%[exc],0\n"
 		"	jne	4f\n"
-		"2:	ahi	%[shift],-8\n"
+		"1:	ahi	%[shift],-8\n"
 		"	srlg	%[tmp],%[val],0(%[shift])\n"
-		"3:	stc	%[tmp],0(%[dst])\n"
-		"5:	aghi	%[dst],1\n"
-		"	brctg	%[cnt],2b\n"
+		"2:	stc	%[tmp],0(%[dst])\n"
+		"	aghi	%[dst],1\n"
+		"	brctg	%[cnt],1b\n"
 		/*
 		 * Use xr to clear exc and set condition code to zero
 		 * to ensure flag output is correct for this branch.
@@ -241,7 +242,8 @@ static inline int __pcilg_mio_inuser(
 		"	xr	%[exc],%[exc]\n"
 		"4:	sacf	768\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 4b) EX_TABLE(1b, 4b) EX_TABLE(3b, 4b) EX_TABLE(5b, 4b)
+		EX_TABLE_INSN(0b, 4b)
+		EX_TABLE_INSN(2b, 4b)
 		: [ioaddr_len] "+&d" (ioaddr_len.pair), [exc] "+d" (exception),
 		  CC_OUT(cc, cc), [val] "=d" (val),
 		  [dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=d" (tmp),
-- 
2.53.0

