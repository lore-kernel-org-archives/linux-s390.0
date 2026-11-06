Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981322;
	b=EewlnopQroLvD3bAE1JsztY+yro8SGqeLYPknfAW6jHae03GpkiUx4ZDAahvrgJsj0Uq
	 +0EBgamISvNeKNXBfYRLr7MxyxKyMmT6uJ6rPIqCc3YaamTgf/qipYrVTy/Bzp02qLLtc
	 ivybkO8aBZeYOiFxnWkk7wbn8vOuWEty9/LfGqR4lqWXXhF06SZGiTJKrWqFYyBKcZ3ik
	 MRJlLkHsl6fR0fNZx5UvkyGcAbCzFTp+OLhH3EyKD7ru3nV6ZC83NGv95g3ROiLQUNqjK
	 lh4OwIdz7BGnNtRcE4RJxcNXrzR0eANLYD7J2RioIJAuvs3duPEZp30kAKEnlSZ6VOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981322;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=aljBCf9/MmrTLX/Ccg8ZLrEoj6cKNfroAB+y0foXNJE=;
	b=LIXXGbhk8DOolyXD8+X4ksR1vSU9Qth5O5yc1EbqKdAQJzzNrbkCHSsnHGTBpYSxNOwZ
	 S7DYJ2yTyMnGbH/847IRuRLk6GL5Sb6uzBOnLtMM74ixoO6LTBkDW0l13hbYS/6ZKNcei
	 DTfIvgKwvFTDtU0izgk0nQqrizswl9TzEagBlRtwSQ7gtjAq9HRr6RrLGbzeiWLEOINTq
	 S0UfgczhfkOWh4Rw7BzX+QiXwAQJ4cpX+72D5wjWyhjNZlhNKVduERGL17kjqs+ydzgNH
	 V4k+8bG8xcrEbb24deFeSjdjRory4m0pseqLK+JFunivl5DSmJkWBTnLAzwv7Y2676g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i1584vgL;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A2606A32D;
	Fri,  6 Nov 2026 16:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A3A2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i1584vgL
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEKhB2656491;
	Fri, 6 Nov 2026 16:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aljBCf
	9/MmrTLX/Ccg8ZLrEoj6cKNfroAB+y0foXNJE=; b=i1584vgLDNnIsuCIFXD2fo
	1wZMi6H3d/AYRxHZbqExqi4xCW8XmahpJogKPOBVB8lG01z2XU5zte0L+SbfQv9g
	fH6eZ2gcA//akwPwWzi+sD6FPgt1UXwLelb1uJVicjz7JFB34PHIbbCFyqYn4BYf
	N+NDzdlkzjxrLmUJ5aUTf/ivCwWb4pxsVGPo5/Ll61CumHHLqIR3zS1E6O2P23qr
	0XWRYA8VV/etp6idk8MWXLB+rrrfPOie5EPXU+VyEhXD+MUMFQkqUUpUt5O1VVIp
	65eka0M+8xdIs16A63FJ0lYhgcZgw8Nkyi4hov7zM413l2H7qS3SJW3ASntYBTXw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc5esv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4xUJ2390175;
	Fri, 6 Nov 2026 16:08:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h13wds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8Fd652494794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 265922004B;
	Fri,  6 Nov 2026 16:08:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDCD22005A;
	Fri,  6 Nov 2026 16:08:14 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:14 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:36 +0100
Subject: [PATCH v3 03/23] arm64: sysreg: Convert OSLSR to automatic
 register generation
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-sysreg-v3-3-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfXx7H/w9GaMmvC
 wgKjs+HR7dhAyHENO+GdQFOat5SREYxDz9O5rPqdwCgFNuFUGnlTCdSg1r80ZsnRxznEj0twbYp
 cko3wZaAtPcfzs/r952L+3LIi8VcZB0=
X-Proofpoint-GUID: xFcc7uGqZ-HYK0UJbpgCHve9C9pcjYKs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX5jg/b7IN7rGs
 faYNdYhVC4YQCKnxMBn23kpjHTub3g22+J2QL3X5MXWz3VneOJapiOCQV7lNc6QFOo4/Ph1tzbP
 9cbD5+7a5ucrgFm4PfxPCgT9C8CfFtl3YEJpYtWofPffVMPOYXBR/orXBsTzhGd1LOk3ZtJXGXc
 5PE62NwDej8l2gKLUlfqa8Zre3LB4F4zM1dCGTFjd7iby1L1agu+jycE+fQxbf6hBZB7IRgluL7
 SQEQhaLXlZUu7mHf8Ru+1UChX4cwPJIHSd9KQMeu3s5nm1hqfJKiraSPjUOzU6ZtOmpg9eLNJDr
 Q8IZRYU9+elZBg5Rm95mmlBsWIvhv5ghtEOWW2u65BedwPyxmgAVA7jv7bzYOXLEcbL4iuCH3Xr
 Han6K9p2CgVLctxtkwaixMe+Dx9xc/STC4bwTGAchGxxzDMPm41CUfjgBc6FAm0cbXCgR2V82wY
 KsizHyymRZh6vmhxXFA==
X-Proofpoint-ORIG-GUID: xFcc7uGqZ-HYK0UJbpgCHve9C9pcjYKs
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aedfb73 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=uoKN2WSkVIwsLX3wBB8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

Convert OSLSR to automatic register generation as per DDI0601. As
OSLSR_OLSM is a composite field using bit 0 and bit 3 the combined
values are still defined manually. While at it rename
OSLSR_EL1_OSLM_IMPLEMENTED to OSLSR_EL1_OSLM_IMP to be consistent with
the rest of the system register values.

No functional changes.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/sysreg.h | 12 +++++++-----
 arch/arm64/kvm/sys_regs.c       |  2 +-
 arch/arm64/tools/sysreg         | 14 ++++++++++++++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e3b60ee03023..2ec9ba9cd896 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -186,11 +186,13 @@
 #define SYS_DBGWCRn_EL1(n)		sys_reg(2, 0, 0, n, 7)
 #define SYS_MDRAR_EL1			sys_reg(2, 0, 1, 0, 0)
 
-#define SYS_OSLSR_EL1			sys_reg(2, 0, 1, 1, 4)
-#define OSLSR_EL1_OSLM_MASK		(BIT(3) | BIT(0))
-#define OSLSR_EL1_OSLM_NI		0
-#define OSLSR_EL1_OSLM_IMPLEMENTED	BIT(3)
-#define OSLSR_EL1_OSLK			BIT(1)
+#define OSLSR_EL1_OSLM_MASK (OSLSR_EL1_OSLM0_MASK | OSLSR_EL1_OSLM1_MASK)
+#define OSLSR_EL1_OSLM_NI						\
+	((OSLSR_EL1_OSLM1_NI << OSLSR_EL1_OSLM1_SHIFT) |		\
+	(OSLSR_EL1_OSLM0_VAL_0 << OSLSR_EL1_OSLM0_SHIFT))
+#define OSLSR_EL1_OSLM_IMP						\
+	((OSLSR_EL1_OSLM1_IMP << OSLSR_EL1_OSLM1_SHIFT) |		\
+	(OSLSR_EL1_OSLM0_VAL_0 << OSLSR_EL1_OSLM0_SHIFT))
 
 #define SYS_OSDLR_EL1			sys_reg(2, 0, 1, 3, 4)
 #define SYS_DBGPRCR_EL1			sys_reg(2, 0, 1, 4, 4)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2b28b929f9f3..8c91de6a4097 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3309,7 +3309,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_MDRAR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_OSLAR_EL1), trap_oslar_el1 },
 	{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1, reset_val, OSLSR_EL1,
-		OSLSR_EL1_OSLM_IMPLEMENTED, .set_user = set_oslsr_el1, },
+		OSLSR_EL1_OSLM_IMP, .set_user = set_oslsr_el1, },
 	{ SYS_DESC(SYS_OSDLR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_DBGPRCR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_DBGCLAIMSET_EL1), trap_raz_wi },
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 997c62ab72e6..5d38f115bac1 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -122,6 +122,20 @@ Res0	63:1
 Field	0	OSLK
 EndSysreg
 
+Sysreg	OSLSR_EL1	2	0	1	1	4
+Res0	63:4
+UnsignedEnum	3	OSLM1
+	 0b0	NI
+	 0b1	IMP
+EndEnum
+UnsignedEnum	2	nTT
+EndEnum
+Field	1	OSLK
+UnsignedEnum	0	OSLM0
+	 0b0	VAL_0
+EndEnum
+EndSysreg
+
 Sysreg	SPMACCESSR_EL1	2	0	9	13	3
 UnsignedEnum	63:62	P31
 	0b00	TRAP_RW

-- 
2.56.0

