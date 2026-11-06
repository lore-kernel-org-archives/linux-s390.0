Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981341;
	b=K8GLVwCPCF4O6vaESXQBWlxY65dAE8YF8gfFmru5LwW4xoQ5IycSyKFqKvTJq0r2tyBQ
	 49P9mYDOQSJ7siqckT9bknP3n8oaoTm4McAY0PP/VFt1ilroqtbAgFm8SNpmtrw4PPd18
	 +PchepDQtzxqllABneDwvOTV+zSWf5TyE1ee7yy4+PBsKQ1gD2AUiTJIDZ7KOydY25I8X
	 IQ6knx8ZGa7E8Sb7DdIAmv57rCwx+n0ZF0mAqV8t4XU4kgr/VkjfJhjkdZZp0+2qo0paQ
	 KaR7+kei6H2H08pq5Kh82CObxjrW5OgiBDd/uYIMg5B2LNqs3z4cWTsEXEg4DAbdjWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981341;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UoG+N7sFPyhJfOQ3AS4CdkcQ5IpgxCbwJzW/6wfd6d0=;
	b=xnyN2qBkA3pmIm07S//IMMca5404l93OoFq+oy9hr8brmejd272lTQ4aHW1I5/qeG7uu
	 uIRhFwy/lA8gMU/IsHsZt0xqdd8R2zkVDwQmf1v9KeKOeF6rXpLEdapvdRiDab6NukEh5
	 JOLQU371HUAW6Jd1FLHUTcw9/AphUjVYyK9KfnnIXpDckI8UrJSNEG9husMvjMrJZE4NA
	 sJ6WA+KHUhPZabuQzEzx/vQHYUTuj5FhgesmiN8DPCBwRHoFxpTofXbsklyW9hgl4qIwU
	 A9+II5FJ8l6rPQ+xBcmQmWovEIDei7o2kEuN56mVkvt4tmiY+oxfdEKOfZ/Xj5BbzbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VNIqd4Mf;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268860A3810;
	Fri,  6 Nov 2026 16:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D268860A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VNIqd4Mf
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEC752656391;
	Fri, 6 Nov 2026 16:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UoG+N7
	sFPyhJfOQ3AS4CdkcQ5IpgxCbwJzW/6wfd6d0=; b=VNIqd4MfMVi6uGMJkMiD1D
	YOJg48vL+/0pNStM07JJ8p3zNFPveK61JhuD/zXCm561/4rPwwAiLYv9/NpMvI9y
	kcN13hsiEqS0kFZiBjtZe6dz1qylnXuGZ1htsglESqwfKFXuDItZ8NAgmlWYoQjw
	eElIqTF/rK1DQPrP/EQvXZCpHhuxOQAE6+2q3L4Ai5uxq8Yt4ls/Tg+JrAt7CnWr
	9qcWeAx95YHG1IYIN7fxaAnSUwpZVxqxuCjy3hxL6SQoynuHLtiX/6icXVkshnn3
	Dhto4qcvFvOSqxMoZAr/7oTJFJQhhEkBUppBz1TVga1La0s5N9DQh3qr2h1V83BA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc5ets-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4wgh2390145;
	Fri, 6 Nov 2026 16:08:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h13wer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8JFw16646640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 450C920040;
	Fri,  6 Nov 2026 16:08:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D19052004F;
	Fri,  6 Nov 2026 16:08:18 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:18 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:46 +0100
Subject: [PATCH v3 13/23] KVM: s390: arm64: Query Available Arm features
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
Message-Id: <20261106-sysreg-v3-13-75e95980fb10@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX+3Y8vjxsShH0
 S4kYSfH8y2YidXXo02LTwo3jX+B+4rfCc5+95guHCsCyGKZRzWG1qjfDLx6vUFbiV1BJ09bmuiT
 FW/ttW15L3in3f42StvFSDNhQZ81+10=
X-Proofpoint-GUID: QW562MhpmT1a_Ahx8PlWauJ0TJNjV3LU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX/7dnktGWn2vM
 g/WbByH/hU4RCgyZvtwJu2nPo0aKcrbbT3Aqg1WHcWXttpO30HdmC60Skz9ndhl+s1LnNPSVLYT
 LsXMFF/bkY5lCx8qlah6qZeLxyj5G6iw6j9beazqxuQhHQnW/t396kE/9CihnJQCZ+r62VPjI6v
 bv5W+yHoJ3t3oEOXNR2hAWnYXv4+dntNAdgK5XWnKMWV19fLAK6UqakiMZXE2JnpxGrn67HhHnY
 YAV148cMO3SgxIXqxY/5bC/x2Qd5VNQDYzP+ap8CdJ072sAOZGgKOcdHB+cmxAULQb5ffi/BQlq
 rPJEDerNjI3C7aalBxsxuRPg2r2LViIgbPpzK/p+4lArlcuxrD5cLPV4Y7XBYUJLbFsTG7RUlMM
 /s/tv8oO9fwyaYNtaOfbPV/W9NyuzPnlS/GjhyM0vfrJNTofCf9w2g1GPJ+Plv3jjnl8eweMXY1
 qJc8y9ErjW4Z3BTXC7Q==
X-Proofpoint-ORIG-GUID: QW562MhpmT1a_Ahx8PlWauJ0TJNjV3LU
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aedfb78 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=o3ct1ghBEqN8h786NAEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

QAAF enables s390 hosts to gain information about the support
and handling of various arm features supported by the machine.

Function code 1 provides general information about available formats,
machine defined content of system/id register, and other various
information for running arm guests.

Function code 2 provides a initialised save area.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/aef.h                  |  12 +++
 arch/s390/include/asm/kvm_host_arm64_types.h | 115 +++++++++++++++++++++++++++
 arch/s390/include/asm/sae.h                  |  26 ++++++
 arch/s390/kernel/Makefile                    |   2 +-
 arch/s390/kernel/aef.c                       |  94 ++++++++++++++++++++++
 arch/s390/kvm/arm64/Makefile                 |   1 +
 arch/s390/kvm/arm64/arm.c                    |   6 +-
 arch/s390/kvm/arm64/qaaf.c                   |  83 +++++++++++++++++++
 arch/s390/kvm/arm64/qaaf.h                   |  12 +++
 arch/s390/tools/opcodes.txt                  |   1 +
 10 files changed, 350 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/aef.h b/arch/s390/include/asm/aef.h
new file mode 100644
index 000000000000..06519cc575be
--- /dev/null
+++ b/arch/s390/include/asm/aef.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_S390_AEF_H
+#define _ASM_S390_AEF_H
+
+#include <asm/kvm_host_arm64_types.h>
+
+const struct kvm_sae_save_area *aef_gisrsa(void);
+const struct qaaf_qmc_block *aef_qmc(void);
+bool aef_usable(void);
+
+#endif /* _ASM_S390_AEF_H */
diff --git a/arch/s390/include/asm/kvm_host_arm64_types.h b/arch/s390/include/asm/kvm_host_arm64_types.h
index 8783a66d3029..d9471f3b0d46 100644
--- a/arch/s390/include/asm/kvm_host_arm64_types.h
+++ b/arch/s390/include/asm/kvm_host_arm64_types.h
@@ -121,4 +121,119 @@ struct kvm_sae_save_area {
 } __packed __aligned(PAGE_SIZE);
 static_assert(sizeof(struct kvm_sae_save_area) == PAGE_SIZE);
 
+#define QAAF_FC_QMC	1
+#define QAAF_FC_GISRSA	2
+
+union qaaf_gr0_gisrsa {
+	struct {
+		u8 _0000[6];
+		u8 saf;
+		u8 : 2;
+		u8 fc : 6;
+	};
+	u64 val;
+};
+
+static_assert(sizeof(union qaaf_gr0_gisrsa) == sizeof(u64));
+
+/* QAAF Query Model Capabilities */
+struct qaaf_qmc_block {
+	u64	_0000;			/* 0x0000 */
+	u8	ssdf;			/* 0x0008 */
+	u8	_0009;			/* 0x0009 */
+	u8	ssaf;			/* 0x000a */
+	u8	_000b[3];		/* 0x000b */
+	u16	maxncpu;		/* 0x000e */
+	u64	_0010[2];		/* 0x0010 */
+	u64	regs[0x1fc];		/* 0x0020 */
+} __aligned(PAGE_SIZE);
+static_assert(sizeof(struct qaaf_qmc_block) == PAGE_SIZE);
+
+union qaaf_block {
+	struct qaaf_qmc_block qmc;
+	struct kvm_sae_save_area save_area;
+} __aligned(PAGE_SIZE);
+static_assert(sizeof(union qaaf_block) == PAGE_SIZE);
+
+/*
+ * Keep in sync with mapping from SYS_* to QAAF_* in qaaf.c!
+ */
+enum {
+	QAAF_REG_MIDR_EL1		= 0x00,
+	/* 0x01-0x04 reserved */
+	QAAF_REG_MPIDR_EL1		= 0x05,
+	QAAF_REG_REVIDR_EL1		= 0x06,
+	/* 0x07 reserved */
+	QAAF_REG_ID_PFR0_EL1		= 0x08,
+	QAAF_REG_ID_PFR1_EL1		= 0x09,
+	QAAF_REG_ID_DFR0_EL1		= 0x0a,
+	QAAF_REG_ID_AFR0_EL1		= 0x0b,
+	QAAF_REG_ID_MMFR0_EL1		= 0x0c,
+	QAAF_REG_ID_MMFR1_EL1		= 0x0d,
+	QAAF_REG_ID_MMFR2_EL1		= 0x0e,
+	QAAF_REG_ID_MMFR3_EL1		= 0x0f,
+	QAAF_REG_ID_ISAR0_EL1		= 0x10,
+	QAAF_REG_ID_ISAR1_EL1		= 0x11,
+	QAAF_REG_ID_ISAR2_EL1		= 0x12,
+	QAAF_REG_ID_ISAR3_EL1		= 0x13,
+	QAAF_REG_ID_ISAR4_EL1		= 0x14,
+	QAAF_REG_ID_ISAR5_EL1		= 0x15,
+	QAAF_REG_ID_MMFR4_EL1		= 0x16,
+	QAAF_REG_ID_ISAR6_EL1		= 0x17,
+	QAAF_REG_MVFR0_EL1		= 0x18,
+	QAAF_REG_MVFR1_EL1		= 0x19,
+	QAAF_REG_MVFR2_EL1		= 0x1a,
+	/* 0x1b reserved */
+	QAAF_REG_ID_PFR2_EL1		= 0x1c,
+	QAAF_REG_ID_DFR1_EL1		= 0x1d,
+	QAAF_REG_ID_MMFR5_EL1		= 0x1e,
+	/* 0x1f reserved */
+	QAAF_REG_ID_AA64PFR0_EL1	= 0x20,
+	QAAF_REG_ID_AA64PFR1_EL1	= 0x21,
+	QAAF_REG_ID_AA64PFR2_EL1	= 0x22,
+	/* 0x23 reserved */
+	QAAF_REG_ID_AA64ZFR0_EL1	= 0x24,
+	QAAF_REG_ID_AA64SMFR0_EL1	= 0x25,
+	/* 0x26 reserved */
+	QAAF_REG_ID_AA64FPFR0_EL1	= 0x27,
+	QAAF_REG_ID_AA64DFR0_EL1	= 0x28,
+	QAAF_REG_ID_AA64DFR1_EL1	= 0x29,
+	QAAF_REG_ID_AA64DFR2_EL1	= 0x2a,
+	/* 0x2b reserved */
+	QAAF_REG_ID_AA64AFR0_EL1	= 0x2c,
+	QAAF_REG_ID_AA64AFR1_EL1	= 0x2d,
+	/* 0x2e,0x2f reserved */
+	QAAF_REG_ID_AA64ISAR0_EL1	= 0x30,
+	QAAF_REG_ID_AA64ISAR1_EL1	= 0x31,
+	QAAF_REG_ID_AA64ISAR2_EL1	= 0x32,
+	QAAF_REG_ID_AA64ISAR3_EL1	= 0x33,
+	/* 0x34-0x37 reserved */
+	QAAF_REG_ID_AA64MMFR0_EL1	= 0x38,
+	QAAF_REG_ID_AA64MMFR1_EL1	= 0x39,
+	QAAF_REG_ID_AA64MMFR2_EL1	= 0x3a,
+	QAAF_REG_ID_AA64MMFR3_EL1	= 0x3b,
+	QAAF_REG_ID_AA64MMFR4_EL1	= 0x3c,
+	/* 0x3d-0x3f reserved */
+	QAAF_REG_CNTFRQ_EL0		= 0x40,
+	QAAF_REG_CTR_EL0		= 0x41,
+	QAAF_REG_AIDR_EL1		= 0x42,
+	/* 0x43-0x47 reserved */
+	QAAF_IRPTC			= 0x48,
+	/* 0x49 reserved */
+	QAAF_REG_ICH_VTR_EL2		= 0x4a,
+	QAAF_GIC_ATTR			= 0x4b,
+	/* 0x4c-0x4f reserved */
+	QAAF_REG_PMMIR_EL1		= 0x50,
+	QAAF_REG_PMCR_EL0		= 0x51,
+	QAAF_REG_PMCEID0_EL0		= 0x52,
+	QAAF_REG_PMCEID1_EL0		= 0x53,
+	/* 0x54-0x1fb reserved */
+	_QAAF_MAX
+};
+
+static_assert((sizeof(struct qaaf_qmc_block) -
+	       offsetof(struct qaaf_qmc_block, regs)) /
+		      8 >=
+	      _QAAF_MAX);
+
 #endif /* ASM_KVM_HOST_ARM64_TYPES_H */
diff --git a/arch/s390/include/asm/sae.h b/arch/s390/include/asm/sae.h
index cac4fbf58e88..d1b9af770108 100644
--- a/arch/s390/include/asm/sae.h
+++ b/arch/s390/include/asm/sae.h
@@ -12,6 +12,7 @@
 asmlinkage void sae(phys_addr_t sae_block_phys);
 
 #include <linux/io.h>
+#include <asm/extable.h>
 #include <asm/kvm_host_arm64_types.h>
 #include <asm/insn-common-asm-emit.h>
 
@@ -112,5 +113,30 @@ static __always_inline void lasrm(struct kvm_sae_save_area *save_area)
 	);
 }
 
+/**
+ * qaaf() - Query Available Arm Features
+ * @gr0: QAAF function code
+ * @qaaf_block: Pointer to the page for the output
+ *
+ * Perform QAAF. The result is written to qaaf_block.
+ */
+static __always_inline int qaaf(u64 gr0, union qaaf_block *qaaf_block)
+{
+	int exception = 1;
+
+	asm_inline volatile(
+		"	lgr	0,%[r0]\n"
+		"0:	.insn	rre,0xb9ad0000,%[r1],0\n"
+		"	lhi	%[exc],0\n"
+		"1:\n"
+		EX_TABLE_INSN(0b, 1b)
+		: "=m" (*qaaf_block), [exc] "+d" (exception)
+		: [r1] "a" (qaaf_block), [r0] "d" (gr0)
+		: "0"
+	);
+
+	return exception;
+}
+
 #endif /* !__ASSEMBLER__ */
 #endif /* __ASM_S390_SAE_H */
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index f84b8fb41331..0f3b9fcd1885 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -46,7 +46,7 @@ obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
 obj-y	+= entry.o reipl.o kdebugfs.o alternative.o skey.o
 obj-y	+= nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
 obj-y	+= smp.o text_amode31.o stacktrace.o abs_lowcore.o facility.o uv.o wti.o
-obj-y	+= diag/
+obj-y	+= diag/ aef.o
 
 always-$(KBUILD_BUILTIN)	+= vmlinux.lds
 
diff --git a/arch/s390/kernel/aef.c b/arch/s390/kernel/aef.c
new file mode 100644
index 000000000000..31e18953d7b3
--- /dev/null
+++ b/arch/s390/kernel/aef.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/slab.h>
+
+#include <asm/aef.h>
+#include <asm/sae.h>
+#include <asm/sclp.h>
+
+static struct qaaf_qmc_block qmc = {};
+static struct kvm_sae_save_area save_area = {};
+
+const struct kvm_sae_save_area *aef_gisrsa(void)
+{
+	return &save_area;
+}
+EXPORT_SYMBOL_GPL(aef_gisrsa);
+
+const struct qaaf_qmc_block *aef_qmc(void)
+{
+	return &qmc;
+}
+EXPORT_SYMBOL_GPL(aef_qmc);
+
+/* set once the QMC block and GISRSA save area were fetched successfully */
+static bool aef_valid;
+
+/**
+ * aef_usable() - Report whether the QAAF query data is available
+ *
+ * false if sclp.has_aef is not set or the QAAF instruction failed.
+ */
+bool aef_usable(void)
+{
+	return aef_valid;
+}
+EXPORT_SYMBOL_GPL(aef_usable);
+
+static int __init aef_init_save_area(void)
+{
+	int ret;
+
+	union qaaf_gr0_gisrsa gr0 = {
+		.fc = QAAF_FC_GISRSA,
+		.saf = SAE_SAVE_AREA_FORMAT_0,
+	};
+
+	if (!sclp.has_aef)
+		return 0;
+
+	ret = qaaf(gr0.val, (union qaaf_block *)&save_area);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int __init aef_query_info(void)
+{
+	int ret;
+
+	if (!sclp.has_aef)
+		return 0;
+
+	ret = qaaf(QAAF_FC_QMC, (union qaaf_block *)&qmc);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int __init aef_sysfs_init(void)
+{
+	int rc;
+
+	if (!sclp.has_aef)
+		return 0;
+
+	rc = aef_query_info();
+	if (rc)
+		return rc;
+
+	rc = aef_init_save_area();
+	if (rc)
+		return rc;
+
+	aef_valid = true;
+
+	return 0;
+}
+
+arch_initcall(aef_sysfs_init);
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index b48dc65b7aaa..e9587c6d6de9 100644
--- a/arch/s390/kvm/arm64/Makefile
+++ b/arch/s390/kvm/arm64/Makefile
@@ -16,6 +16,7 @@ kvm-arm64-local := \
 	inject_fault.o \
 	mmio.o \
 	mmu.o \
+	qaaf.o \
 	reset.o
 
 kvm-arm64-obj := $(kvm-arm64-local)
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 29d3add0bbda..62c2b45599b9 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -11,6 +11,7 @@
 #include <linux/bitfield.h>
 
 #include <asm/access-regs.h>
+#include <asm/aef.h>
 
 #include <arm64/kvm_emulate.h>
 #include <arm64/sysreg.h>
@@ -20,6 +21,7 @@
 
 #include "arm.h"
 #include "handle_exit.h"
+#include "qaaf.h"
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -741,9 +743,11 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 
 static int __init kvm_s390_arm64_init(void)
 {
-	if (!sclp.has_aef)
+	if (!sclp.has_aef || !aef_usable())
 		return -ENODEV;
 
+	kvm_init_qaaf();
+
 	return kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 }
 
diff --git a/arch/s390/kvm/arm64/qaaf.c b/arch/s390/kvm/arm64/qaaf.c
new file mode 100644
index 000000000000..f6b1750aed68
--- /dev/null
+++ b/arch/s390/kvm/arm64/qaaf.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm_host.h>
+#include <asm/aef.h>
+#include "qaaf.h"
+
+static struct qaaf_qmc_block qmc_sanitized;
+
+/**
+ * kvm_qaaf_qmc() - Get the sanitised QAAF QMC block
+ */
+struct qaaf_qmc_block *kvm_qaaf_qmc(void)
+{
+	return &qmc_sanitized;
+}
+
+void __init kvm_init_qaaf(void)
+{
+	qmc_sanitized = *aef_qmc();
+}
+
+#define _qaaf_reg_case(id) case SYS_##id: return qmc_sanitized.regs[QAAF_REG_##id]
+u64 kvm_qaaf_read_ftr_reg(u32 id)
+{
+	switch (id) {
+	_qaaf_reg_case(MIDR_EL1);
+	_qaaf_reg_case(MPIDR_EL1);
+	_qaaf_reg_case(REVIDR_EL1);
+	_qaaf_reg_case(ID_PFR0_EL1);
+	_qaaf_reg_case(ID_PFR1_EL1);
+	_qaaf_reg_case(ID_DFR0_EL1);
+	_qaaf_reg_case(ID_AFR0_EL1);
+	_qaaf_reg_case(ID_MMFR0_EL1);
+	_qaaf_reg_case(ID_MMFR1_EL1);
+	_qaaf_reg_case(ID_MMFR2_EL1);
+	_qaaf_reg_case(ID_MMFR3_EL1);
+	_qaaf_reg_case(ID_ISAR0_EL1);
+	_qaaf_reg_case(ID_ISAR1_EL1);
+	_qaaf_reg_case(ID_ISAR2_EL1);
+	_qaaf_reg_case(ID_ISAR3_EL1);
+	_qaaf_reg_case(ID_ISAR4_EL1);
+	_qaaf_reg_case(ID_ISAR5_EL1);
+	_qaaf_reg_case(ID_MMFR4_EL1);
+	_qaaf_reg_case(ID_ISAR6_EL1);
+	_qaaf_reg_case(MVFR0_EL1);
+	_qaaf_reg_case(MVFR1_EL1);
+	_qaaf_reg_case(MVFR2_EL1);
+	_qaaf_reg_case(ID_PFR2_EL1);
+	_qaaf_reg_case(ID_DFR1_EL1);
+	_qaaf_reg_case(ID_MMFR5_EL1);
+	_qaaf_reg_case(ID_AA64PFR0_EL1);
+	_qaaf_reg_case(ID_AA64PFR1_EL1);
+	_qaaf_reg_case(ID_AA64PFR2_EL1);
+	_qaaf_reg_case(ID_AA64ZFR0_EL1);
+	_qaaf_reg_case(ID_AA64SMFR0_EL1);
+	_qaaf_reg_case(ID_AA64FPFR0_EL1);
+	_qaaf_reg_case(ID_AA64DFR0_EL1);
+	_qaaf_reg_case(ID_AA64DFR1_EL1);
+	_qaaf_reg_case(ID_AA64DFR2_EL1);
+	_qaaf_reg_case(ID_AA64AFR0_EL1);
+	_qaaf_reg_case(ID_AA64AFR1_EL1);
+	_qaaf_reg_case(ID_AA64ISAR0_EL1);
+	_qaaf_reg_case(ID_AA64ISAR1_EL1);
+	_qaaf_reg_case(ID_AA64ISAR2_EL1);
+	_qaaf_reg_case(ID_AA64ISAR3_EL1);
+	_qaaf_reg_case(ID_AA64MMFR0_EL1);
+	_qaaf_reg_case(ID_AA64MMFR1_EL1);
+	_qaaf_reg_case(ID_AA64MMFR2_EL1);
+	_qaaf_reg_case(ID_AA64MMFR3_EL1);
+	_qaaf_reg_case(ID_AA64MMFR4_EL1);
+	_qaaf_reg_case(CNTFRQ_EL0);
+	_qaaf_reg_case(CTR_EL0);
+	_qaaf_reg_case(AIDR_EL1);
+	_qaaf_reg_case(ICH_VTR_EL2);
+	_qaaf_reg_case(PMMIR_EL1);
+	_qaaf_reg_case(PMCR_EL0);
+	_qaaf_reg_case(PMCEID0_EL0);
+	_qaaf_reg_case(PMCEID1_EL0);
+	default:
+		WARN(true, "Unknown feature register 0x%x\n", id);
+		return 0xbad1234bad;
+	}
+}
diff --git a/arch/s390/kvm/arm64/qaaf.h b/arch/s390/kvm/arm64/qaaf.h
new file mode 100644
index 000000000000..f1d50a9654b1
--- /dev/null
+++ b/arch/s390/kvm/arm64/qaaf.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ARCH_S390_KVM_ARM64_QAAF_H
+#define ARCH_S390_KVM_ARM64_QAAF_H
+
+#include <asm/aef.h>
+
+__init void kvm_init_qaaf(void);
+struct qaaf_qmc_block *kvm_qaaf_qmc(void);
+u64 kvm_qaaf_read_ftr_reg(u32 id);
+
+#endif
diff --git a/arch/s390/tools/opcodes.txt b/arch/s390/tools/opcodes.txt
index 22fb9c500a56..bb4ba4038cb0 100644
--- a/arch/s390/tools/opcodes.txt
+++ b/arch/s390/tools/opcodes.txt
@@ -600,6 +600,7 @@ b9a7	stiasrm	RRE_R0
 b9aa	lptea	RRF_RURR2
 b9ab	essa	RRF_U0RR
 b9ac	irbm	RRE_RR
+b9ad	qaaf	RRE_R0
 b9ae	rrbm	RRE_RR
 b9af	pfmf	RRE_RR
 b9b0	cu14	RRF_U0RR

-- 
2.56.0

