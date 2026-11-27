Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789454;
	b=Gvvs1aigM4xealR1tRhaJqJz48FNQNfx8O1cE5dB9H/To2jAmKoG6Y+bJkrR6yvItD3W
	 LxFm8d0cbYpfJknNJe1x0MHAttkgQRU2GbiLMA4+b870N2ZcI4tGC2LEAaaJT5S4+nrxY
	 GfyEeFmApuX210Mwdnt3vvoTXX8EDXX1OBFvLBcQgISticj9Tsfaa/TK+OuRVpZ+Ho/v9
	 AwdpAoc6dk1ScYEsEwjMQzRhVjuX7rygkkHTD1+asfbf3dNCCHPAfx0Z4ZA0KXxQV+q+L
	 8rJPeqt17l4HpW7NBdPtTGzuM+IZotIe6wTUCMtKZCOvmXSzusZt+DK80AO8pnmZfGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789454;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=5lNbSb0sQEjX+HK0YWuCp6kpae+JapJ88byCMIRT2qY=;
	b=ge/w4hpazKpOFp0CIzT5hU4hjM5umJMNiUvDZOfBsxjdNjX0/nUmkdji4c6RGxS2FXIY
	 /cEMlDbkq0428RWsRNB4YoCQlaUmBdG0ASOXLxcYLoBY9WWvdgx99g98rPMAOBaDEop7w
	 fD1pemFIRy0pZPxRu9xSce1vCA7aUDFPhRhcTDqejFJj6+3esnrg7EHt90X9MOCVPNbb5
	 e28iRkC6daN3IW2J9uHlyXgbhbRk7UbmJcHksX/tBjKs8XiiVFldHlLtiAhWvYlKHqA5K
	 LYcTSvoP/2wdpSKtn0KrLhaZtK2h74jlU5s0uC2w1jMfYGH9MNUVcjwEvocCTENJJTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pBn8aHqf;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D760A6F76;
	Fri, 27 Nov 2026 14:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 683D760A6F76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pBn8aHqf
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4oGw3265944;
	Fri, 27 Nov 2026 14:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5lNbSb
	0sQEjX+HK0YWuCp6kpae+JapJ88byCMIRT2qY=; b=pBn8aHqfmu0ph2vTI8lsYo
	jWvKlU4DnEF8maOWJgmGfBHIWWD6qy3XstuE4N6VIX8e3RJPhJd7c4FOkbpMKRA7
	DgYJYDzlnReMT5LfSY2hlXcTvZI/EXUwSsgyXB0cpjzKVw4nVawpLli7hT01+8sE
	AX4q/DuxZz/cS0cbnNm9BBzc/y8LgdHMVJRcvg5FNFizghvlcVZ8ciNG5n+5sdsP
	V5I2UF5F537hAlaIZ04OV/BBAPMwKPJiQXcYoKoMg6V7NQrvYYiXaHjIiGLAwyOG
	wO5vrmKpoKSzl+hdaLaJ2Zl9Qr2w3354nBY8Z6ZsIZ0bTuXFvMK7Qi1/cYLH1ITg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g1ne1q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4KH13245757;
	Fri, 27 Nov 2026 14:23:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx9511-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENMhB50659694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97BBE20043;
	Fri, 27 Nov 2026 14:23:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAF5D2006A;
	Fri, 27 Nov 2026 14:23:21 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:21 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:20 +0100
Subject: [PATCH v4 17/25] KVM: s390: arm64: Implement feature sanitisation
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
Message-Id: <20261127-sysreg-v4-17-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ntIJbrhtwTBZbjGIhkXCcTXD0lgUiu5U
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX8K1y0dh25rsD
 wdp1I1hWIkWaCClUAj5BN4LiNNiUy0mO7tDwPUICk9q677w07RA1T6HiJAnCZRZLsrjWnsXe1tR
 hT2AZOhSBG0BwGyeJWHlV8li/rUal+Y=
X-Proofpoint-GUID: ntIJbrhtwTBZbjGIhkXCcTXD0lgUiu5U
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b09925f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Oy4CJlU8JfxsjEMJYM8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX2XoWj40dZ47E
 knvARcsxZ8MEMgmo3kp2+LmuXh9HmaLKCZZTBVUFpIaj1PN1/8Q3373rn+b9wNKrqPb6av1nPgY
 ISsPtYrxOpU2F0fAbx4BUE8mAueKBY2OY8BA+Eldo5xci+LnFt9YFhxzTXxxsXZqqti/+7FYntH
 zAD+ko0wlp7C+epeIWytubm1zswIsaR/bvQuPvgUjsMNV3IMADyxx2j1ta49umKim3N8tZhHIMR
 QAxo6pQ4z/iL+vteQxZck74MJsusR3c3Nb1VrTK52roySAohzo8Ba/0KfaTqqPELL/zcgkliZ79
 kZg7OlVZIY+Gztd+dpgyzSGHMxOtal/cw8cOoj5Bl5Bd9rJR8PzBbtjHm9SNDBFOjQYaIuLwYpk
 TzcADhvoB7mobjOLWlViVNLJm4NZFmNpnLMSUldCbUNrUZo2bhKTbXeJ51kZWALOFm3Om67+Ia8
 dvtpQHlf2DI3tzp9TSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

Implement feature detection and sanitization for arm64 KVM guests on
s390.

Query hardware capabilities using QAAF instruction and sanitize arm64 ID
registers. Provide accessor functions for queried capabilities and
integrate feature detection into module initialization sequence.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h |  13 +++
 arch/s390/kvm/arm64/Makefile           |   1 +
 arch/s390/kvm/arm64/arm.c              |   2 +-
 arch/s390/kvm/arm64/feature.c          | 153 +++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/feature.h          |  86 ++++++++++++++++++
 arch/s390/kvm/arm64/qaaf.c             |   2 +
 6 files changed, 256 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 3e69724f17c9..9afe37f6696c 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -15,6 +15,19 @@ enum vcpu_sysreg;
 
 #include <asm/sae.h>
 
+enum {
+	ARM64_HAS_WFXT,
+	ARM64_HAS_RASV1P1_EXTN,
+	ARM64_HAS_STAGE2_FWB,
+	ARM64_HAS_RAS_EXTN,
+	ARM64_HAS_EVT,
+	ARM64_HAS_HCR_NV1,
+	ARM64_MISMATCHED_CACHE_TYPE,
+	ARM64_HAS_ECV_CNTPOFF,
+};
+
+bool cpus_have_final_cap(unsigned int num);
+
 #define KVM_HAVE_MMU_RWLOCK
 #define KVM_MAX_VCPUS 1
 #define __KVM_HAVE_VCPU_RUN_PID_CHANGE
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index e9587c6d6de9..e75b38071f8a 100644
--- a/arch/s390/kvm/arm64/Makefile
+++ b/arch/s390/kvm/arm64/Makefile
@@ -11,6 +11,7 @@ ccflags-y += -I $(src) -I $(objtree)/$(obj) -I$(srctree)/arch/$(SRCARCH)/kvm/gma
 
 kvm-arm64-local := \
 	arm.o \
+	feature.o \
 	guest.o \
 	handle_exit.o \
 	inject_fault.o \
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 3af0b47b8377..ba6235629c7d 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -20,6 +20,7 @@
 #include <kvm_mmu.h>
 
 #include "arm.h"
+#include "feature.h"
 #include "handle_exit.h"
 #include "qaaf.h"
 
@@ -27,7 +28,6 @@
 #include "trace.h"
 
 static unsigned long system_supported_vcpu_features(struct kvm_vcpu *vcpu);
-#define read_sanitised_ftr_reg(_id) 0
 
 #define __INCL_GEN_ARM_FILE
 #include "generated/arm.inc"
diff --git a/arch/s390/kvm/arm64/feature.c b/arch/s390/kvm/arm64/feature.c
new file mode 100644
index 000000000000..8fd278ace942
--- /dev/null
+++ b/arch/s390/kvm/arm64/feature.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm_host.h>
+#include <linux/printk.h>
+#include <linux/bitfield.h>
+#include <asm/sae.h>
+#include <asm/kvm_host_types.h>
+
+#include <arm64/sysreg.h>
+
+#include "feature.h"
+
+#define MASK_RESERVED(_qaafp, _id)				\
+	({							\
+		u64 *_reg = &((_qaafp)->regs[QAAF_REG_##_id]);	\
+		*_reg = (*_reg & ~_id##_RES0) | _id##_RES1;	\
+	})
+
+#define QAAF_FIELD_MODIFY(_idp, _id_field, _val) \
+	FIELD_MODIFY(_id_field##_MASK, _idp, _id_field##_##_val)
+
+#define MODIFY(_qaafp, _id, _field, _val) \
+	QAAF_FIELD_MODIFY(&((_qaafp)->regs[QAAF_REG_##_id]), _id##_##_field, _val)
+
+void __init kvm_arm_host_sanitize_features(struct qaaf_qmc_block *qaaf_qmc)
+{
+	MASK_RESERVED(qaaf_qmc, ID_AA64ISAR0_EL1);
+
+	MODIFY(qaaf_qmc, ID_AA64ISAR1_EL1, LS64, NI);
+	MASK_RESERVED(qaaf_qmc, ID_AA64ISAR1_EL1);
+
+	MODIFY(qaaf_qmc, ID_AA64ISAR2_EL1, SYSINSTR_128, NI);
+	MODIFY(qaaf_qmc, ID_AA64ISAR2_EL1, SYSREG_128, NI);
+	MODIFY(qaaf_qmc, ID_AA64ISAR2_EL1, PAC_frac, NI);
+	MASK_RESERVED(qaaf_qmc, ID_AA64ISAR2_EL1);
+
+	MASK_RESERVED(qaaf_qmc, ID_AA64ISAR3_EL1);
+
+	MASK_RESERVED(qaaf_qmc, ID_AA64MMFR0_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_AA64MMFR1_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_AA64MMFR2_EL1);
+
+	MODIFY(qaaf_qmc, ID_AA64MMFR3_EL1, Spec_FPACC, NI);
+	MODIFY(qaaf_qmc, ID_AA64MMFR3_EL1, ADERR, NI);
+	MODIFY(qaaf_qmc, ID_AA64MMFR3_EL1, SDERR, NI);
+	MODIFY(qaaf_qmc, ID_AA64MMFR3_EL1, ANERR, NI);
+	MODIFY(qaaf_qmc, ID_AA64MMFR3_EL1, SNERR, NI);
+	MODIFY(qaaf_qmc, ID_AA64MMFR3_EL1, MEC, NI);
+	MASK_RESERVED(qaaf_qmc, ID_AA64MMFR3_EL1);
+
+	MODIFY(qaaf_qmc, ID_AA64MMFR4_EL1, SRMASK, NI);
+	MODIFY(qaaf_qmc, ID_AA64MMFR4_EL1, E3DSE, NI);
+	MODIFY(qaaf_qmc, ID_AA64MMFR4_EL1, RMEGDI, NI);
+	MODIFY(qaaf_qmc, ID_AA64MMFR4_EL1, FGWTE3, NI);
+	MODIFY(qaaf_qmc, ID_AA64MMFR4_EL1, ASID2, NI);
+	MASK_RESERVED(qaaf_qmc, ID_AA64MMFR4_EL1);
+
+	MODIFY(qaaf_qmc, ID_AA64PFR0_EL1, SEL2, NI);
+	MODIFY(qaaf_qmc, ID_AA64PFR0_EL1, SVE, NI);
+	MASK_RESERVED(qaaf_qmc, ID_AA64PFR0_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_AA64PFR1_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_AA64PFR2_EL1);
+
+	MODIFY(qaaf_qmc, ID_AA64DFR0_EL1, PMUVer, NI);
+	MASK_RESERVED(qaaf_qmc, ID_AA64DFR0_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_AA64DFR1_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_AA64DFR2_EL1);
+
+	MASK_RESERVED(qaaf_qmc, ID_AA64AFR0_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_AA64AFR1_EL1);
+
+	MASK_RESERVED(qaaf_qmc, ID_AA64ZFR0_EL1);
+
+	MASK_RESERVED(qaaf_qmc, ID_AA64SMFR0_EL1);
+
+	MASK_RESERVED(qaaf_qmc, ID_AA64FPFR0_EL1);
+
+	MASK_RESERVED(qaaf_qmc, ID_PFR0_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_PFR1_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_PFR2_EL1);
+
+	MASK_RESERVED(qaaf_qmc, ID_DFR0_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_DFR1_EL1);
+
+	MASK_RESERVED(qaaf_qmc, ID_MMFR0_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_MMFR1_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_MMFR2_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_MMFR3_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_MMFR4_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_MMFR5_EL1);
+
+	MASK_RESERVED(qaaf_qmc, ID_ISAR0_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_ISAR1_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_ISAR2_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_ISAR3_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_ISAR4_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_ISAR5_EL1);
+	MASK_RESERVED(qaaf_qmc, ID_ISAR6_EL1);
+
+	MASK_RESERVED(qaaf_qmc, MVFR0_EL1);
+	MASK_RESERVED(qaaf_qmc, MVFR1_EL1);
+	MASK_RESERVED(qaaf_qmc, MVFR2_EL1);
+
+	MASK_RESERVED(qaaf_qmc, CTR_EL0);
+
+	MASK_RESERVED(qaaf_qmc, ICH_VTR_EL2);
+}
+
+/**
+ * cpus_have_final_cap - Check if an ARM64 CPU capability is supported
+ * @num: Capability number to check
+ *
+ * Maps ARM64 CPU capabilities to their corresponding ID register fields
+ * and checks if the feature is supported by the s390 hardware via QAAF.
+ *
+ * Return: true if capability is supported, false otherwise
+ */
+bool cpus_have_final_cap(unsigned int num)
+{
+	u64 reg_val;
+
+	switch (num) {
+	case ARM64_HAS_STAGE2_FWB:
+		reg_val = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
+		return SYS_FIELD_GET(ID_AA64MMFR2_EL1, FWB, reg_val) >=
+		       ID_AA64MMFR2_EL1_FWB_IMP;
+	case ARM64_HAS_WFXT:
+		reg_val = read_sanitised_ftr_reg(SYS_ID_AA64ISAR2_EL1);
+		return SYS_FIELD_GET(ID_AA64ISAR2_EL1, WFxT, reg_val) >=
+		       ID_AA64ISAR2_EL1_WFxT_IMP;
+	case ARM64_HAS_RASV1P1_EXTN:
+		reg_val = read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);
+		return SYS_FIELD_GET(ID_AA64PFR1_EL1, RAS_frac, reg_val) ==
+		       ID_AA64PFR1_EL1_RAS_frac_RASv1p1;
+	case ARM64_HAS_RAS_EXTN:
+		reg_val = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+		return SYS_FIELD_GET(ID_AA64PFR0_EL1, RAS, reg_val) >=
+		       ID_AA64PFR0_EL1_RAS_IMP;
+	case ARM64_HAS_EVT:
+		reg_val = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
+		return SYS_FIELD_GET(ID_AA64MMFR2_EL1, EVT, reg_val) >=
+		       ID_AA64MMFR2_EL1_EVT_IMP;
+	case ARM64_HAS_ECV_CNTPOFF:
+		reg_val = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+		return SYS_FIELD_GET(ID_AA64MMFR0_EL1, ECV, reg_val) >=
+		       ID_AA64MMFR0_EL1_ECV_CNTPOFF;
+	case ARM64_HAS_HCR_NV1:
+	case ARM64_MISMATCHED_CACHE_TYPE:
+		return false;
+	default:
+		return false;
+	}
+}
diff --git a/arch/s390/kvm/arm64/feature.h b/arch/s390/kvm/arm64/feature.h
new file mode 100644
index 000000000000..7b0698cc5563
--- /dev/null
+++ b/arch/s390/kvm/arm64/feature.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ARCH_S390_KVM_FEATURE_H
+#define ARCH_S390_KVM_FEATURE_H
+
+#include <linux/types.h>
+#include <linux/bitfield.h>
+
+#include <asm/sae.h>
+
+#include "qaaf.h"
+
+void __init kvm_arm_host_sanitize_features(struct qaaf_qmc_block *qaaf_qmc);
+
+/**
+ * read_sanitised_ftr_reg() - Get the value of a sys register
+ *
+ * @id: ARM system register id
+ *
+ * Get the value of a sys register describing the host configuration.
+ * The returned value indicates support by the machine (HW/FW)
+ * after some sanitisation.
+ *
+ * Example:
+ *	read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1)
+ *
+ * Return: Sanitised HW value of the specified register
+ */
+static inline u64 read_sanitised_ftr_reg(u32 id)
+{
+	return kvm_qaaf_read_ftr_reg(id);
+}
+
+/**
+ * kvm_sae_supported_sd_formats() - Retrieve supported SAE SD formats
+ *
+ * Return: Bitmap of supported SAE state description formats.
+ */
+static inline u32 kvm_sae_supported_sd_formats(void)
+{
+	struct qaaf_qmc_block *qmc = kvm_qaaf_qmc();
+
+	return qmc->ssdf;
+}
+
+/**
+ * kvm_sae_supported_sa_formats() - Retrieve supported SAE SA formats
+ *
+ * Return: Bitmap of supported SAE save area formats.
+ */
+static inline u32 kvm_sae_supported_sa_formats(void)
+{
+	struct qaaf_qmc_block *qmc = kvm_qaaf_qmc();
+
+	return qmc->ssaf;
+}
+
+/**
+ * kvm_sae_max_vcpus() - Retrieve maximum supported vcpus
+ *
+ * Return: Max number of vCPUs supported by the SAE instruction/the machine
+ *	as indicated by QAAF, not necessarily that supported by the host software.
+ */
+static inline u32 kvm_sae_max_vcpus(void)
+{
+	struct qaaf_qmc_block *qmc = kvm_qaaf_qmc();
+
+	/* QAAF QMC reports the max id not the max num */
+	return qmc->maxncpu + 1;
+}
+
+/**
+ * kvm_sae_irptc() - Retrieve supported SAE IRPTCs
+ *
+ * Return: Bitmap of supported SAE IRPTCs.
+ */
+static inline u64 kvm_sae_irptc(void)
+{
+	struct qaaf_qmc_block *qmc = kvm_qaaf_qmc();
+
+	return qmc->regs[QAAF_IRPTC];
+}
+
+#define kvm_vcpu_has_pmu(_v) false
+
+#endif /* ARCH_S390_KVM_FEATURE_H */
diff --git a/arch/s390/kvm/arm64/qaaf.c b/arch/s390/kvm/arm64/qaaf.c
index f6b1750aed68..36487025013c 100644
--- a/arch/s390/kvm/arm64/qaaf.c
+++ b/arch/s390/kvm/arm64/qaaf.c
@@ -3,6 +3,7 @@
 #include <linux/kvm_host.h>
 #include <asm/aef.h>
 #include "qaaf.h"
+#include "feature.h"
 
 static struct qaaf_qmc_block qmc_sanitized;
 
@@ -17,6 +18,7 @@ struct qaaf_qmc_block *kvm_qaaf_qmc(void)
 void __init kvm_init_qaaf(void)
 {
 	qmc_sanitized = *aef_qmc();
+	kvm_arm_host_sanitize_features(&qmc_sanitized);
 }
 
 #define _qaaf_reg_case(id) case SYS_##id: return qmc_sanitized.regs[QAAF_REG_##id]

-- 
2.56.1

