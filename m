Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884233D6FC;
	Thu,  1 Oct 2026 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850788; cv=none; b=A8UkgBRkbm2LIfn5J1t0NTf1yjdvB0j7XZBLfMh+azcYLp/SaIKjzkup7vOmK1Xb4YqjRIq612igsQYfIfAWx9Dinw1fJJJwfJVp8lzZNfkOvruySP7gZtS8LVdbwcP/ahK57rbrRQDlDb1fQHzRr6txVrG4HwrGoR/js6HvGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850788; c=relaxed/simple;
	bh=yvaUtkXIpiL/WfggL7hk6lKuOQJXCS271qGSs9qm7nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5+MSvpcBxOrriSxcLk/uNNcOC+7y4V+2varooT8HTA1naqOYPNxEz1HG7aVZA0BfZ3cuCFwgkRYfWyqNrer/ljCcSUFpU6KFpvRINFcnt7TVaIjedrkoD77NOZD7REM/KuIL0u0Ee5l2mOg0orK1NycJYwrNEL3OFIEKQWL/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D2SsUsSN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D2SsUsSN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175cQ8907397;
	Thu, 1 Oct 2026 10:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PzAxEjPmdKyslbTkB
	xq1bMtFayuPl9GSHENrEdPBnt8=; b=D2SsUsSNQI4ma1YU9WGknJBd43yBahhu0
	/5UcJbM1eDCfqBZwF+Keg3bPLRbQawDSqTzQF5bWTpkJYOu/VbHnKLtRAHJh85Fy
	ZNSPPVpgsytOqypuRT1CnaLb+9OKUtBwEPkTInhmZST7Ve/m2jPdkLq0RIcb3zLo
	aFF9kFBSCGpOzPdKEbhqa6bkMuoj+TnLLzeE0D4uqKtgkVGM5a9X6KsLEkQrSE5W
	Wn4ySllhn+iO2kHmNxTAboYNnwMWf3OMr0Y5DvBXixfoVclG4kMAmuVbgSo/Tp2Y
	ZaLzf2cve64Vu2WdhkWX9OmpQ6p5jIUUPGEm3jBJxKRFyUIITPb5A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkhsq3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172U5i557921;
	Thu, 1 Oct 2026 10:32:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23r4d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWrFV39911712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B90720040;
	Thu,  1 Oct 2026 10:32:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9FC62004B;
	Thu,  1 Oct 2026 10:32:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:52 +0000 (GMT)
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
Subject: [PATCH 18/32] s390/ipl: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:33 +0200
Message-ID: <20261001103247.1989111-19-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: S3he2n2wxw849UHVGkqWSXaPwaShFqgP
X-Proofpoint-GUID: S3he2n2wxw849UHVGkqWSXaPwaShFqgP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX/1hFSKsTBodp
 JjLWgTARy0TGnO2XF0sQWC3nj/Rxp7JyF9sfURBvmw7VUxejbYPBh4RPHi/X3RJvO0EUm0F55kH
 R0vkaGgjLjCH8vHFOQfBLADaMqbR7Ao=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abe36d9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=v0tfPaRulT_9CaumWagA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXwAwc8yIrrg0h
 SEB/FyK8N2dcNhV5Q6RW8j6PPWbKUZBA5fDdd+iIQYvOaYEjUO/36FupH56fuF3qH3VHEFKpWoL
 dXvj2eWTpzQVeic8l/DbjhkOvU1UXuw1X0KiobmrkwUxprb6Ckn73RZ7Ct3lmURPY+hRAfxKK+a
 EeFYMS96S317g7x0I1VkA+gw7ujxjWyWCKVCY1CY4qMtadZaroIJ2Eb6r6kzvmNaztMV748SCpk
 99GQw6GU/cKqOoiUVrDOeRZWltyF10GMwYREVOvTMzOeQOXHCauJgD2Rqz0bwnM7yxye4DoPSv+
 0OR37ApBkMNFMrIe9xHe89Zg9cXe8SrW2hiCGNDxhZ6ycFCneL59U8KJt3hj2l1HWocqJYJ4qAh
 w9J7tIkAlo9IKeI6wmKpp5MfR4XTV7uJUxUtgTqQiEKHVDLYpARjqXiMYoHHfOguysfRgbHdUjW
 YbxXlMEBZsOXHyBeRJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Convert the diag308 exception table entry to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so nopr padding is no longer needed and removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/ipl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index b1e798f8e1dd..c441b1357492 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -188,9 +188,9 @@ static inline int __diag308(unsigned long subcode, unsigned long addr)
 	r1.even = addr;
 	r1.odd	= 0;
 	asm_inline volatile(
-		"	diag	%[r1],%[subcode],0x308\n"
-		"0:	nopr	%%r7\n"
-		EX_TABLE(0b,0b)
+		"0:	diag	%[r1],%[subcode],0x308\n"
+		"1:\n"
+		EX_TABLE_INSN(0b, 1b)
 		: [r1] "+&d" (r1.pair)
 		: [subcode] "d" (subcode)
 		: "cc", "memory");
-- 
2.53.0

