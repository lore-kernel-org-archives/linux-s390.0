Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BF8373BEC;
	Mon, 31 Aug 2026 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187712; cv=none; b=cPF4vcZ+tgUO30/UTl2Ao8RaocGJpvEBGui9ncoO0CutMBEonQ1fSGBzhjbuSORxrDk/lqDHdWujKJf6jmeYWZw+hqdUFztFP2OzhHCALA6OOLfaQLpTNZ2PgUIR2AmMtGPUDkeWpWh7oNluNDjM07PrDvnaw3R83SF0y5pR05I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187712; c=relaxed/simple;
	bh=2mUB/Zb+wJR8Brxh3hdGKTIWjCCl94nE9bkIKMoxed4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vl9u1WsHa7pYYpQ8Rtcqy0pTVDuerkjC94GSYlsmgVfIkV0PtEHp7BncFf8m9pDRynNDKF2bKKZ1gKmeOhQBpkKEhs+JTVoJLIIXerUoXWyYje96386RO6yHkcPv2ryxjpNUwOsSu4kScoKjzizxMaKFXvbv+EnHSTvAVlB3NOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cXKGlmpe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cXKGlmpe"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ7nK2530426;
	Mon, 31 Aug 2026 14:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kXpGqjwL3LJiqnjvi
	NTG1AYP8Ty1ye94cTF+5lhO3IQ=; b=cXKGlmpeOrB47DkUFSKnkfoNi8+m3tB9n
	YPfGSLM+TLwZ+BZjht0MehKIVNmKAfV6oCE04RzWMsqueqW+SP1Z2NFRxIrMiSGX
	p5OzJZ6eiPu9KtmTlaS/bWl75O7oMM9vkPrY5XNhnLJhrx2APejAUwmQBFdLswOe
	MbFj8NuoPWOI0OxUrOTuTnYWviYN/dmVpUgzl68E9oXnUvBkqA+WnPOVJrzDmFAz
	QaI9psT3RFQtk3nOBmjbNA0Y5B2tO8IgD10ASBHslNMp7L3FJV/fS+AwDQ+CPBh8
	tQlUb+MxDniZwQPZgl4/WFhoCM9svcX3W4jJTHvd5J691MYW8nnKA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5a0ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfgVg016964;
	Mon, 31 Aug 2026 14:48:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h6cjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEm5Gq51708206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:48:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEB6120043;
	Mon, 31 Aug 2026 14:48:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D0EF2004B;
	Mon, 31 Aug 2026 14:48:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:48:05 +0000 (GMT)
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
Subject: [PATCH v7 06/23] arm64: sysreg: Convert SPSR_ELx to automatic register generation
Date: Mon, 31 Aug 2026 16:47:43 +0200
Message-ID: <20260831144802.834315-7-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831144802.834315-1-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a95942b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=qAnUzrOnmDNqMeXR4cMA:9
X-Proofpoint-GUID: 9lZ4dDKGEWl_lnL3Pp7S052-LsVXpeHn
X-Proofpoint-ORIG-GUID: ueiIeIa4ZQzrONzuU4KI3jeOZQdNnZP4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX5KXfKinaDrEM
 527hnzeHlWVWQX/8P3uoPzJvkE/0VpIY7nr/gKYegdBBAG/YGrfKUy9KyNiwsFIxYqtSpjLECgz
 ofwz7KZkhONBKLwH6FgUhByLjJWD7rw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX1iDjhFmF3fGC
 2vKOZwgCeGQNOWOOqj96gp3Hlcvr4TRD2qsISRwMZAxEPs9Xep79V1AgwuUrI4Uc4By7G/mGbo/
 11AEHoQMMGfRI/0ZIn8fx7CMZzRugIJPi+WC+IkHlCVVHxJ7KBi02Gu7Gg9t/H9B3zzDF57z8VY
 6GTUhoIZQnY041Rxw1rCTyNP7R2GQ7Rnk774lXSxB/FYbutJUkNUejHi8amO0KHFQS/SSDNYQAR
 Sb0ZHV3jGCyu02kD8fX/K85y7RQ+UkQHy/QouKlcW9JpWnrwbWPg//zCoCGAjF8EgGr6y5/5sNQ
 Gvoc1Y54jgWwoPNhnCrbQfgT9j1vIUFsYjaf3ZZkvFEzLSkq8sVKo+wMIovpyV16ogJ2A6+lI/v
 JIT8p2S+QvoMeMQKz2i5bn4/HDdwVUjmoKFZMfVG32cr8ihh402pY19+jGJwygrFP7r7eK3vCWU
 Jtb9zZsaSFPy89BO8Ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

Convert SPSR_EL{1, 2, 12} to automatic register generation as per
DDIO616 2026-06. No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/sysreg.h |  3 --
 arch/arm64/tools/sysreg         | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 3 deletions(-)

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
index 94bf065c8ac7..553d3859fb00 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -401,6 +401,57 @@ Res0	3:1
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
+Field	4	M4
+Enum	3:0	M
+	0b0000	EL0
+	0b0100	EL1t
+	0b0101	EL1h
+	0b1000	EL2t
+	0b1001	EL2h
+	0b1100	EL3t
+	0b1101	EL3h
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

