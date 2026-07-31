Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03340403EA5;
	Fri, 31 Jul 2026 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503376; cv=none; b=pdV8kfhGtfFIerOOE4FCSxW3MTge1Lq8StYD5ltD2Mrh9jABCvC4XWDx0RwKZL054gDV517L5rDbj3WjxWVg9aWiv2FVGpk7xmZnA+sbe9aO7BzoYVNPAL/pCXxTbSHEnIU5BWdGaYy7leZVMz9SF+ku3yOnG4ebEXOClVMXj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503376; c=relaxed/simple;
	bh=pKMG+pTcDQXZZx0j8Jl/6Zx3cxV7TbzRslaJ1873Kb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgsn9EY29FDMlRpJrmMat0Rqin0fD51MHHC7adMBgBDxPFN1hQS07Ed12oj/ZOAvGQ4/w28sTQOS2a3VjDTEyghhwx/NO6+4hSYTLU7qHZSTu+m+Vj1OzT6UVA7gDxeJpiRGJVLPdlIaRANgGnDOMiYXcF24slaUpdD/hQD86KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nnXwXRUP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nnXwXRUP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlxVG4072948;
	Fri, 31 Jul 2026 13:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sKaPD0GBm7OH0DCkp
	gRZ2wPwwuBU/2nK/HFJ1bUGeuo=; b=nnXwXRUP7sRH+EWC3uySZA6pmYM24upOb
	0Vi3AF3nqP9HuDMbztDiB5yHVHNVzL1484X8ZXyvFz+lei5kzpzAOvYMrdK10ztx
	zBWQ9teJLylM2J8ho44zmvLFZn0+pF8ttjszQUT3h5YWYa4Cm79O+YGJbEfkVAud
	W7vNLJg4bDkdaAiK0ZRrNhDbdySPTK917cHouYtXFeOOotr8+QSBP897Iwrdv7kD
	wZpHBYIjF/D/MzT9TiNxO6/h4tMS+5Z7iz9OphbKzTJ9iZjcHT/RGpC4+p0Ox5B1
	NH0HLPX8nVDs+78Qrp/zHP/9W0FoYnxBeCrLUpniuQsCp4/Dp/Shw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw2n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCQEIF026841;
	Fri, 31 Jul 2026 13:09:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqtbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD95UI30671174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D88B520043;
	Fri, 31 Jul 2026 13:09:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7639C20040;
	Fri, 31 Jul 2026 13:09:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:05 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v5 06/31] arm64/sysreg: Convert SPSR_ELx to automatic register generation
Date: Fri, 31 Jul 2026 15:08:34 +0200
Message-ID: <20260731130902.654679-7-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: xFdaPvHbcxmvcTa5fx8PWhhYQoO9bVy_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX5FhqiuiFNHwS
 xc6pQWhH8BztvNld/+e56OZ/FkVF6UBV7FNKNmRZwV/BSrPuCrS0vffb9QTxjUyATIDCHGC8dnl
 F04oclHAybrauRLwLW+vyRGDwTOncoN8yE/lkd5I/tkoVXc6v5EPIkx9YDHZ1nBwIjVLU2L7vEb
 EqsurKMzt9ppgUnrsvtqDLx3f+cw34BIxMjMQ5pNB3YaaVNFCIyvjmwD1WEJsItbFjr/OrOUZQI
 qsCLPJ5qhYs39TuwAXpZKcNr1Kna8RSz4ngPJdE3T93+g+4Klkhvi6T14hOGWfzXDTuI9h9tHRV
 VXrU7YWoXRAaBTICGN3X/m7+1fiBQDFw2s5DJUoHhssAWbGeMYsKFboITGkcG+4FJ7DjM1+gqPg
 7E6pt6TMqVtK3IzfzFlpFUCS5AW5epXR5iSGuZ8HVfiWZxuDswMkXAvNVUsrTvR8J5V1Ms6Daxb
 lWyx8yH2MckH2cF2TtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX70latcCQcgs2
 JHPvvOBsjvUAqz4qc+YzoSvHdk/iVJMcQVjnyUP7ot6LnBaPdXVnbhfxdelkF4kLjTtD0JNEnSF
 /G3zxN3v/pjnQ84cSCAh2uNmmaCI4mA=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9e7a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ABWHSbNOgyVrhIrjGdkA:9
X-Proofpoint-GUID: g9BRLfpZhitxLMLYmPoF67pJ-rYYvlPn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Convert SPSR_EL{1, 2, 12} to automatic register generation as per
DDIO616 2026-06. No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/sysreg.h |  3 --
 arch/arm64/tools/sysreg         | 72 +++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4bfdac9401bd..1aa601c95188 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -295,7 +295,6 @@
 #define SYS_APGAKEYLO_EL1		sys_reg(3, 0, 2, 3, 0)
 #define SYS_APGAKEYHI_EL1		sys_reg(3, 0, 2, 3, 1)
 
-#define SYS_SPSR_EL1			sys_reg(3, 0, 4, 0, 0)
 #define SYS_ELR_EL1			sys_reg(3, 0, 4, 0, 1)
 
 #define SYS_ICC_PMR_EL1			sys_reg(3, 0, 4, 6, 0)
@@ -518,7 +517,6 @@
 #define SYS_VTTBR_EL2			sys_reg(3, 4, 2, 1, 0)
 
 #define SYS_HAFGRTR_EL2			sys_reg(3, 4, 3, 1, 6)
-#define SYS_SPSR_EL2			sys_reg(3, 4, 4, 0, 0)
 #define SYS_ELR_EL2			sys_reg(3, 4, 4, 0, 1)
 #define SYS_SP_EL1			sys_reg(3, 4, 4, 1, 0)
 #define SYS_SPSR_irq			sys_reg(3, 4, 4, 3, 0)
@@ -604,7 +602,6 @@
 #define SYS_BRBCR_EL12			sys_reg(2, 5, 9, 0, 0)
 #define SYS_TTBR0_EL12			sys_reg(3, 5, 2, 0, 0)
 #define SYS_TTBR1_EL12			sys_reg(3, 5, 2, 0, 1)
-#define SYS_SPSR_EL12			sys_reg(3, 5, 4, 0, 0)
 #define SYS_ELR_EL12			sys_reg(3, 5, 4, 0, 1)
 #define SYS_AFSR0_EL12			sys_reg(3, 5, 5, 1, 0)
 #define SYS_AFSR1_EL12			sys_reg(3, 5, 5, 1, 1)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 7cb61aca3797..2a4b94e8c62f 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -401,6 +401,78 @@ Res0	3:1
 Field	0	SO
 EndSysreg
 
+Sysreg	SPSR_EL1	3	0	4	0	0
+Res0	63:37
+Field	36	UNIJ
+Res0	35:34
+Field	33	PPEND
+Res0	32
+Field	31	N
+Field	30	Z
+Field	29	C
+Field	28	V
+Field	27	Q
+Field	26:25	IT01
+Field	24	DIT
+Field	23	SSBS
+Field	22	PAN
+Field	21	SS
+Field	20	IL
+Field	19:16	GE
+Field	15:10	IT27
+Field	9	E
+Field	8	A
+Field	7	I
+Field	6	F
+Field	5	T
+Field	4	M4
+Enum	3:0	M
+	0b0000	EL0
+	0b0100	EL1t
+	0b0101	EL1h
+	0b1000	EL1tnv
+	0b1001	EL1hnv
+EndEnum
+EndSysreg
+
+Sysreg	SPSR_EL2	3	4	4	0	0
+Res0	63:37
+Field	36	UNIJ
+Res0	35:34
+Field	33	PPEND
+Res0	32
+Field	31	N
+Field	30	Z
+Field	29	C
+Field	28	V
+Field	27	Q
+Field	26:25	IT01
+Field	24	DIT
+Field	23	SSBS
+Field	22	PAN
+Field	21	SS
+Field	20	IL
+Field	19:16	GE
+Field	15:10	IT27
+Field	9	E
+Field	8	A
+Field	7	I
+Field	6	F
+Field	5	T
+Field	4	M4
+Enum	3:0	M
+	0b0000	EL0
+	0b0100	EL1t
+	0b0101	EL1h
+	0b1000	EL2t
+	0b1001	EL3h
+EndEnum
+EndSysreg
+
+Sysreg	SPSR_EL12	3	5	4	0	0
+Mapping	SPSR_EL1
+EndSysreg
+
 Sysreg ID_PFR0_EL1	3	0	0	1	0
 Res0	63:32
 UnsignedEnum	31:28	RAS
-- 
2.53.0

