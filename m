Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456023E2769;
	Thu,  1 Oct 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850795; cv=none; b=Iu5gllWf9IZC3y04j8I8RX8b7UdPjnQ3Cq25E66LpTGMG6tmjI/eB4RjFkaGah3DDybdHX9Qa60uq4b3j4UfWeMLHyibeApbl/6G1mOxqt2OoT66CiVJbZltfYih1n2jxbokLByrRu6aiVtDgfK6HtINKPfpsFyGim630IGCIQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850795; c=relaxed/simple;
	bh=w5DGaooBWxaswhdVxR/izJho1dJp6ifyRWBKv4Y4hA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWnDiYZczcZ0i3N2uQgfCrWZjA8NbkwLF9p+5SS8f2Iiq/3EGfVndCOJ0whX6+ObVlDdD4xoXLt0fV2oEKxbHnhCMl0vPl25aLfMVLN0tpqtQn06HoDpttmBIkwJEvMZsKa7VBmsovxku+7wm6AWnLZZtyHTkuUE9OAQRoXv7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qMVmQsSu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qMVmQsSu"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175nik907996;
	Thu, 1 Oct 2026 10:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nkYoKsEXR5MwVuog3
	rrHaF4naokp0N/oqq+/h6JhfLM=; b=qMVmQsSuqTFNSgmq5lfDdfsK7kwIV1eCc
	dsQXnjEcq5G/vbOnuW/t7kx5RNt4xRSy4KEwD0m20wqIMTA59NjBLr+MWeFFA3pD
	YrbWZEtpxGM5Q+4oP1hzaYLBmS3I7IZ0Yht0NI2qHhmsnzjHfANO/DfMciNQ2kvi
	KS222MQKz1ylgMfiHWmeLJ0F1sOlzVGUG8j19V1t4ov9DWIUBo6IhbZ5IwMuc2iy
	FGPCyRup4SJQzWIBU3mAYosNh3WAE1/iXLHmvB+k1/5ZR3tXXw4/j+MuXqNGArNj
	LUWBMzW0Y64yP9Dht+YNiftVtT7NYiWCgZfIOkbfP8K1Ab0fkl2Eg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkhsq9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:33:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172bbX561244;
	Thu, 1 Oct 2026 10:32:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e8kb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWtE242336740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB00E20043;
	Thu,  1 Oct 2026 10:32:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FB9E2004B;
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
Subject: [PATCH 27/32] s390/cio: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:42 +0200
Message-ID: <20261001103247.1989111-28-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: g-S5o-vSH8otOpoL_UsQmnc2L29dxIAh
X-Proofpoint-GUID: g-S5o-vSH8otOpoL_UsQmnc2L29dxIAh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX3a/jDbSDsm7k
 xmUHzp28qmxn3vD402Ye0uHxfw+TLP6WVJglriwKUN4sM6tHeG0Mz4F1yMwUE4AxOpDDBmLKulk
 8ZtopAV29h0K5tCQ7H1PoAGcylNOzwI=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abe36dc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=HQG6VQDMoNkXkp0hA3kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXx4jDgFcjBuB1
 vgLf1f2HS8Wm0ohW9P0CWmzm5wDWBvP5elgfJWiDHb5jPMhYWDHlFfVpySBX3Md1UXWTtgY5yGP
 dgrrc4YnJvsTodiUeYmjH4qdK8ZmyKl8r844Xg9yyUsP/X8v0BWi56G6xhtLOlrsPloTzC5NFlS
 YEVB0U+UeUlhqERskZI8VY4trkJf8SzM4DYhSW+ZIh/+xb+VxT7ER9GFDkMhb3jKlgjA36dUA4A
 WcrLkwDN2HR0G66Lfj4S1hTLdK9X5wtg6e+9xpkP8bZW2HhQkwQcV8IOtsD4bjY9mYZrkk/I63R
 Z6XOOP29ZzqAIaZDYCeNtSHv7PpW20q95C6ohAdGdt4ZwcTasME9H/cm5QjSDprcFjkJZPOeIzw
 ZtuzTn/AgCiy2OEsC481LDVdtdRxbMHby306i7Y8tgoyy+q584FGcc7mL9pAT1Y1wv4bbutYBXN
 T3ZnVW0Q+S6K6fCKBeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Convert all cio exception table entries to use EX_TABLE_INSN.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/cio/ioasm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/cio/ioasm.c b/drivers/s390/cio/ioasm.c
index 8b06b234e110..4974e80b0568 100644
--- a/drivers/s390/cio/ioasm.c
+++ b/drivers/s390/cio/ioasm.c
@@ -24,11 +24,11 @@ static inline int __stsch(struct subchannel_id schid, struct schib *addr)
 	exception = 1;
 	asm_inline volatile(
 		"	lgr	1,%[r1]\n"
-		"	stsch	%[addr]\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	stsch	%[addr]\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, ccode), [addr] "=Q" (*addr), [exc] "+d" (exception)
 		: [r1] "d" (r1)
 		: CC_CLOBBER_LIST("1"));
@@ -54,11 +54,11 @@ static inline int __msch(struct subchannel_id schid, struct schib *addr)
 	exception = 1;
 	asm_inline volatile(
 		"	lgr	1,%[r1]\n"
-		"	msch	%[addr]\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	msch	%[addr]\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, ccode), [exc] "+d" (exception)
 		: [r1] "d" (r1), [addr] "Q" (*addr)
 		: CC_CLOBBER_LIST("1"));
@@ -108,11 +108,11 @@ static inline int __ssch(struct subchannel_id schid, union orb *addr)
 	exception = 1;
 	asm_inline volatile(
 		"	lgr	1,%[r1]\n"
-		"	ssch	%[addr]\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	ssch	%[addr]\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, ccode), [exc] "+d" (exception)
 		: [r1] "d" (r1), [addr] "Q" (*addr)
 		: CC_CLOBBER_LIST("memory", "1"));
@@ -179,11 +179,11 @@ int chsc(void *chsc_area)
 
 	exception = 1;
 	asm_inline volatile(
-		"	.insn	rre,0xb25f0000,%[chsc_area],0\n"
-		"0:	lhi	%[exc],0\n"
+		"0:	.insn	rre,0xb25f0000,%[chsc_area],0\n"
+		"	lhi	%[exc],0\n"
 		"1:\n"
 		CC_IPM(cc)
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: CC_OUT(cc, cc), "+m" (*(addr_type *)chsc_area), [exc] "+d" (exception)
 		: [chsc_area] "d" (chsc_area)
 		: CC_CLOBBER);
-- 
2.53.0

