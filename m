Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6224C8C6B;
	Thu,  1 Oct 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850796; cv=none; b=Q4thZ6YDXXObjKW1YmQy6sz5zf+2im5oisgheGafAhiqNRQ5KgWwWA1ht/X5ya0AbnKa7sMbclA005m2lWbqw5w/89X6IgwltHKmDZIcQ4h+DM1CL/at6HcqQ9vR5L36LziVWHAnTYfprFi1CeEfjvPVpJanf3Nn2OyF3bCQhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850796; c=relaxed/simple;
	bh=Nbw5GiANbjL54p2QBQ7tmODKAfVL8CHLvLDKmWZ98OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/7Eea/KoMOoiAU+VyQlprd0zbedc1Ap2fji74rhCdRbKBrwR64adAPzDCm82PBL75H/sxnCHSNSsO9Cn/nSWQeI8+ozj6W6L/i7upvgJZDklCMunAI3BdTHNPJ64uK2yDQrzeXmCGK7ysLMtHNcGyhpQQ043knZOfNDBqYutOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PS56HOrS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PS56HOrS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175Qeu907214;
	Thu, 1 Oct 2026 10:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4FutSsXzoL0LGhdmP
	V+VB7XpTSSnYgRBKGS1QWO84wE=; b=PS56HOrSNVeuyaZqqdbBnLgaK0MB1TdT1
	/0Gse19sY7PsFTx/J6yqBHvLXeue5WBt/QG6milN9KmS2lWgizHV96hcPUBHjOt5
	pt8YQLT57Un/9hMokn1zwZpMThrRg6jfQiZgpn43T9CgzTnPZ7D2GI0q18bKQM1B
	mC1yPhupJmZPBLfeFpf2OwdysldnJc0gFizQFj2SKArU8Yl0Q+u06SLj/M3loNsM
	Ysfv0tfQKTLPI0CJarJ7jD3mQqlqJ9QjMVNxMG7i+uTG38BngA+56jyBnoD83Ay7
	sCcYqSwN4JemcjrjHBtvVwC/emxT/QH38PIxvA149FOYstuxSO7PQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkhsq5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172sWF3460485;
	Thu, 1 Oct 2026 10:32:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pexb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWrTV52167130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBDD120040;
	Thu,  1 Oct 2026 10:32:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C1A72004B;
	Thu,  1 Oct 2026 10:32:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:53 +0000 (GMT)
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
Subject: [PATCH 20/32] s390/ap: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:35 +0200
Message-ID: <20261001103247.1989111-21-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 1ANSvHyG3a8ZXRn28lULOMergeMsjjwq
X-Proofpoint-GUID: 1ANSvHyG3a8ZXRn28lULOMergeMsjjwq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX6r0FfhTXfdO3
 hCdg+/y73Zw3D5S7vlhl///9et+XRRRMQ24YCPrBo+iMF3kH6yw+o9asaPbeSc34tiLAmaQwc2g
 NTP9VXohVSfm4+a4ZId1SIfHCXw0jJ4=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abe36da cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=rHyoCaKgv23gh7QR-QcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX+z8raWUAOB1G
 RFyk6im/jZT7HVQDSIiKsUG0Iu2st7/mHs2/krNr4dkND6GslyY/wt/FfjG8k4O+9oXPXjZjJB1
 I5mgPG0fI6j424bkOghzlKpb8LoODFWuuNDVWZMKAy9rNH8DYOOzsFo9wF6fXUkjVFli35f2xhS
 OTRQIebicKG3QDcD4j8bGpfqlfdvV+HDu0YzAJGstzTUAverBZwf18Z+QGhread6XPsQxTPZKt6
 WdvKZhBfK1rgYIujm/PzgUhdShXMvN7g2LChdF+TCJRpKb9/n3h0d/y/zU9bjrIfB7nN8VoHP1E
 r7IBPdgm1lFfIOeiETa11nDo//X1Q9gxNofV/2g9EyiOM835gHo2O7NVJ8cwGggoZAleuPetW2O
 iSupffbPx784czvL1KtcWlMovdkQjdgQzhGwgfOiWeRuQOfTJsEc8Sm9Cd10PYH9QLh9hb7rMzM
 atr1D1aEIGM4PEmk9Dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Convert all ap exception table entries to use EX_TABLE_INSN.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/ap.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index c91b6ace199d..b0f8e3946a43 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -91,10 +91,10 @@ static inline bool ap_instructions_available(void)
 		"	lgr	0,%[reg0]\n"		/* qid into gr0 */
 		"	lghi	1,0\n"			/* 0 into gr1 */
 		"	lghi	2,0\n"			/* 0 into gr2 */
-		"	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(TAPQ) */
-		"0:	la	%[reg1],1\n"		/* 1 into reg1 */
+		"0:	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(TAPQ) */
+		"	la	%[reg1],1\n"		/* 1 into reg1 */
 		"1:\n"
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: [reg1] "+&d" (reg1)
 		: [reg0] "d" (reg0)
 		: "cc", "0", "1", "2");
@@ -272,10 +272,10 @@ static inline int ap_qci(struct ap_config_info *config)
 	asm volatile(
 		"	lgr	0,%[reg0]\n"		/* QCI fc into gr0 */
 		"	lgr	2,%[reg2]\n"		/* ptr to config into gr2 */
-		"	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(QCI) */
-		"0:	la	%[reg1],0\n"		/* good case, QCI fc available */
+		"0:	.insn	rre,0xb2af0000,0,0\n"	/* PQAP(QCI) */
+		"	la	%[reg1],0\n"		/* good case, QCI fc available */
 		"1:\n"
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: [reg1] "+&d" (reg1)
 		: [reg0] "d" (reg0), [reg2] "d" (reg2)
 		: "cc", "memory", "0", "2");
-- 
2.53.0

