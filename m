Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6B470135;
	Wed, 12 Aug 2026 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549046; cv=none; b=hIzrRE4sPvsiTnkyh9sNaQARelTGDeo3YFBiq1VGcqU8wdeFtP7GI3ffhso6FMbhsMtRCRVc/Z21SKYO28mfXPFV8n8tnTb/RsSk+nQSPbAuYmv+dhOOs/24clo3F6wj29pmzh1+lqv2TImyDb7oO+ASEQl/7iC1/Di60H0Z7LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549046; c=relaxed/simple;
	bh=TVQaQmRnmBhta/zgdtQYlEzfKdGrKE5RbZXcZPD+9G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRMRUdkbI16RZAvcCVrTz6hJZ6+J3kpcj3/JQFrlP0SQLDlGZjLVuIFlrS0Ug9r6azG1XrwEVF13CDtsO4Yq8B7Ql0LsN6/ZiH+Wrx8mBJyYeJm006JbXxNJEgBUTsuclBU2wtKuPM13IfzneVTpcB2BcdNk8FIiKPRRgdqZjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dF6GEtXA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dF6GEtXA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1eUK2585741;
	Wed, 12 Aug 2026 15:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xalLNEWrJY6441oMy
	g+rTz0yPpUDhYP9aCyCGhuBalE=; b=dF6GEtXAyunRzG27I6sfAU4H6Z1+l8wSt
	DOONnbesqfFMOmwjAt7lGeKlOTXH1hT89w66xpEZURLuikLC1Tp/wEexrKp314J+
	aNpTCWFIlUEQSuJL0s6oZ5nWInKSd5DxoRqubycOZ9YLZt/dPgjcUYwLCZ7iC/BS
	4budAHIaLJMEhHb3w6MH1rJOI/565UzM4Sqq7Re90fdALxE+F9W9vdDHwtpw3sLY
	eMhI5BUa8SUIKUNgvJnkeVxw3/VMa4mso8Cuu9GZFmIoUy29lOFUShANfoDpVtw+
	7ujVGE2YOIFacnK7cR+sm51Oko5lSnrPqmZWmrLFHK5VVP3CivLxg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23usfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQOux013787;
	Wed, 12 Aug 2026 15:36:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h6mjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFaYAU39846232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A821F20040;
	Wed, 12 Aug 2026 15:36:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 569112005A;
	Wed, 12 Aug 2026 15:36:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:34 +0000 (GMT)
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v6 06/33] arm64: sysreg: Convert SPSR_ELx to automatic register generation
Date: Wed, 12 Aug 2026 17:36:02 +0200
Message-ID: <20260812153631.3376090-7-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c9308 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=qAnUzrOnmDNqMeXR4cMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfXzLOSztFwq1rM
 TLnTbKzxQ5PjPusYwkoWRufpDgw4r1EUjC8ntBqRMMx1yD/fGdCzH1G/ErXcPjY6aXvwhkrY31/
 D2UEujNpUvrZp4YoP/YqX6BZU0tPgk+gHhkrtxBQaX+rhxTumhrF6nfXpa4lkN7+GEUXfDa9/07
 mQHm0Qm1rz0E9+k93faGk/QA2eoq/YVHFVSEtqjxczj3spQkdTdF99TR1f3hXNRvHBGzxGoI8BG
 AO0IihWvwuL1rbcIlYIju5wMCq4ZXBTL6wdrlWlHUukiQhZU0jt62bSzhZZi/5cafnC802CmBXD
 hsVvUjgo5YTsloSyOmDTkWN9pjCiNIYB3UwhYiR0FLGUdzEIS2r5aDvE+CAP+MHiEge6deZPQyk
 bu+SZn2mWj36P0USBuu4TuTNSC0zeNcrG0WsRzF22VwQmr8WER0S/1sBobftBjx/vYrIVLOt5Pf
 95CG+TGW5DW4bsgFgMA==
X-Proofpoint-ORIG-GUID: mV2r1km3Yvu7iM34gEtAqFW3U6R-B2Te
X-Proofpoint-GUID: K95bFIa4deShqD3jNtm-8ub_33cdind6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX31fcQ2gX0qhk
 oN0YLipqK4Pw3wY/guravnvRmVboeop4uU8QYkju15JDlV9+rkIy1BuZTr67icpl+kcc0raFtxS
 ziPxhSU3vzGQLlnGk2Fmraze8iohyFw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126

Convert SPSR_EL{1, 2, 12} to automatic register generation as per
DDIO616 2026-06. No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/sysreg.h |  3 ---
 arch/arm64/tools/sysreg         | 48 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 3 deletions(-)

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
index 94bf065c8ac7..6e625a05c477 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -401,6 +401,54 @@ Res0	3:1
 Field	0	SO
 EndSysreg
 
+SysregFields	SPSR_ELx
+Res0	63:37
+Field	36	UNIJ
+Field	35	PACM
+Field	34	EXLOCK
+Res0	33
+Field	32	PM
+Field	31	N
+Field	30	Z
+Field	29	C
+Field	28	V
+Res0	27:26
+Field	25	TCO
+Field	24	DIT
+Field	23	UAO
+Field	22	PAN
+Field	21	SS
+Field	20	IL
+Res0	19:14
+Field	13	ALLINT
+Field	12	SSBS
+Field	11:10	BTYPE
+Field	9	D
+Field	8	A
+Field	7	I
+Field	6	F
+Res0	5
+Enum	4:0	M
+	0b0000	EL0
+	0b0100	EL1t
+	0b0101	EL1h
+	0b1000	EL2t
+	0b1001	EL2h
+EndEnum
+EndSysregFields
+
+Sysreg	SPSR_EL1	3	0	4	0	0
+Fields	SPSR_ELx
+EndSysreg
+
+Sysreg	SPSR_EL2	3	4	4	0	0
+Fields	SPSR_ELx
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

