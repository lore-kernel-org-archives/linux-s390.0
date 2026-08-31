Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8A3D9DC5;
	Mon, 31 Aug 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188203; cv=none; b=Uviua9XOBlY/pnYZMqF90D50719W3IjFzo9hOWksGKPoLH5l3iW7agUinXb5Tk7rXzqc4GNq7SvPxKDENOKaOny1KRwEfumcSciky6TL7FUYdtGRFF4xzxHhjW7+ukj7WohNOgsBzUjDNQv+Ygzv/svDUgd9oCX5wim5GBpuMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188203; c=relaxed/simple;
	bh=CxV36+AR/FBlaQB0ffhgBLAk0PbRgE1YDZKh/54grVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lp8IytwbnYlLJMsro04IY0Y+frMawnlsi0wykwXeDz2oJIGKo7JGGb3kBvwyLNSqXgeWAJt99PETFsCCH3xE3SR72tb2Cde4NrgwYHZvI71G39E6NLVY9Hns0ObZQgQv4yZZsjBPqwFWtdFLjryYWPQvRB0HLO4Ze/ut9SUnTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C6+W8097; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C6+W8097"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ1rB2525384;
	Mon, 31 Aug 2026 14:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XPf1+SWyutNtNrNBF
	q5UTX9MKvjceGl5LU5Q2m/cdas=; b=C6+W8097bUZtZq+fMh2JSZVOMQRAjfUYi
	pRigb+B64KBR3rPl+YpgseIeqKdsOxQ9dPP0Nrtp6XIKZsRpShMm4m7nayCPB2/A
	9ylvhvntJcIEaEM5F5mhHvJMOzuvFrurPQ2K+zAIMgLZR7Y2HQH+RAU5DibVSYrJ
	4VPHTk8vg55oed5Zc+zLFYDKiKcduqpceHjE5ySsXYpjguVjDQ6UTuF4eewV7J1s
	fdR2PnotiMBD+rdCTsz9IA5LgbiMcmqETcKV6rV705lUcc6sb69FyDW/USe9s+u4
	XHwt1gqrbRmfmqa7djDakAySzUbGvEQRd8h8R/xXg2hNDXy8PPjoA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54j0sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfboR015527;
	Mon, 31 Aug 2026 14:55:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq6nc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEthAV45023708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C4F220043;
	Mon, 31 Aug 2026 14:55:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0426D2004D;
	Mon, 31 Aug 2026 14:55:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:42 +0000 (GMT)
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
Subject: [PATCH v2 12/20] KVM: s390: arm64: Implement feature sanitisation
Date: Mon, 31 Aug 2026 16:55:27 +0200
Message-ID: <20260831145536.913567-13-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX2fxiJD+YMfAd
 cIi4Y4MZvmwVB1fSgpaxKbT3elHw4fnLMBSSNiqKat3K9eAYrvVT9UGyPyoe2Ibb7tA8dQzkqlo
 yAhpmYOo3clQ3SgYcFAsXGelSzzGW8d8NyvFKjI9/yWZqytutxKfLpbKGUw4RGqEuArMcBwkGwn
 Fydzhk/8Hh4R3lvdvP5YvK9SUFmk7eBzoaPDTG4K8JKrk9x5UCLHNQn6/ZDZRIX048yFpClNMyb
 C1ZWhvw5yX6cVdYY80ESn4FGpDHUzVUrYehRCtNYnM3CSyrV2b3bwtg6s8kTs47awlaFvQucD33
 a/APP1W42MnrtY3AF/eEg4nAVDNpoO9VhnB2Q/A2boeaubD3EFUf6X/62SvaqjACALK3pYzvk8O
 s+sFMiTSf7pFIpRhH7rlkdtHOfRoBVu4Vpq4job8ffqrSHhY6ciJd2MkCYWiJEt98OkW0FtesSk
 0IcKIwuzF0VfCkSaDnQ==
X-Proofpoint-ORIG-GUID: W7qZTtvfIUsNiJj6DzQ9e6r_1z2MYBQW
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9595f7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=GB6mbaFeBmmjm_s_m-AA:9
X-Proofpoint-GUID: N-08JLcRBowA8b1Lj3VmYCboL8uf6WPv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX3JASSlDvIMUz
 W2avplZII+FQLqGNZR2TBAVRINB7Mcxmo3Osa2Hq5xKMKxpdmtDj+Pyf5aa+PVB4TxA59pb/Vw3
 uThxBjOZOaVRMmdAiPYZrlzzCuuBr7c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Implement feature detection and sanitization for arm64 KVM guests on
s390.

Query hardware capabilities using QAAF instruction and sanitize arm64 ID
registers. Provide accessor functions for queried capabilities and
integrate feature detection into module initialization sequence.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h |  13 ++
 arch/s390/kvm/arm64/Makefile           |   1 +
 arch/s390/kvm/arm64/arm.c              |   5 +-
 arch/s390/kvm/arm64/feature.c          | 165 +++++++++++++++++++++++++
 arch/s390/kvm/arm64/feature.h          |  87 +++++++++++++
 arch/s390/kvm/arm64/qaaf.c             |   7 +-
 arch/s390/kvm/arm64/qaaf.h             |   1 +
 7 files changed, 277 insertions(+), 2 deletions(-)
 create mode 100644 arch/s390/kvm/arm64/feature.c
 create mode 100644 arch/s390/kvm/arm64/feature.h

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index b8a689c649bd..22e4bf788fa2 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -14,6 +14,19 @@
 
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
 #define KVM_S390_ARM64_IMPL_FEATURES \
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index 577b0653a68e..8c7110956573 100644
--- a/arch/s390/kvm/arm64/Makefile
+++ b/arch/s390/kvm/arm64/Makefile
@@ -9,6 +9,7 @@ ccflags-y += -I $(src) -I $(objtree)/$(obj) -I$(srctree)/arch/s390/kvm/gmap -DKV
 
 kvm-arm64-obj := \
 	arm.o \
+	feature.o \
 	guest.o \
 	handle_exit.o \
 	inject_fault.o \
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 664fea5cf6b5..c573a3da5766 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -22,12 +22,13 @@
 
 #include "arm.h"
 #include "handle_exit.h"
+#include "qaaf.h"
+#include "feature.h"
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
 static unsigned long system_supported_vcpu_features(void);
-#define read_sanitised_ftr_reg(_id) 0
 
 #define __INCL_GEN_ARM_FILE
 #include "generated/arm.inc"
@@ -748,6 +749,8 @@ static int __init kvm_s390_arm64_init(void)
 	if (!aef_info()->arm_guest_supp)
 		return -ENXIO;
 
+	kvm_init_qaaf();
+
 	return kvm_init_with_dev(sizeof(struct kvm_vcpu), 0, THIS_MODULE,
 				 KVM_DEV_NAME, MISC_DYNAMIC_MINOR);
 }
diff --git a/arch/s390/kvm/arm64/feature.c b/arch/s390/kvm/arm64/feature.c
new file mode 100644
index 000000000000..39c8ae7e951c
--- /dev/null
+++ b/arch/s390/kvm/arm64/feature.c
@@ -0,0 +1,165 @@
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
+int __init kvm_arm_host_sanitize_features(struct qaaf_qmc_block *qaaf_qmc)
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
+
+	return 0;
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
+
+	case ARM64_HAS_WFXT:
+		reg_val = read_sanitised_ftr_reg(SYS_ID_AA64ISAR2_EL1);
+		return SYS_FIELD_GET(ID_AA64ISAR2_EL1, WFxT, reg_val) >=
+		       ID_AA64ISAR2_EL1_WFxT_IMP;
+
+	case ARM64_HAS_RASV1P1_EXTN:
+		reg_val = read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);
+		return SYS_FIELD_GET(ID_AA64PFR1_EL1, RAS_frac, reg_val) ==
+		       ID_AA64PFR1_EL1_RAS_frac_RASv1p1;
+
+	case ARM64_HAS_HCR_NV1:
+		reg_val = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
+		return SYS_FIELD_GET(ID_AA64MMFR2_EL1, NV, reg_val) >=
+		       ID_AA64MMFR2_EL1_NV_IMP;
+
+	case ARM64_HAS_RAS_EXTN:
+		reg_val = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+		return SYS_FIELD_GET(ID_AA64PFR0_EL1, RAS, reg_val) >=
+		       ID_AA64PFR0_EL1_RAS_IMP;
+
+	case ARM64_HAS_EVT:
+		reg_val = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
+		return SYS_FIELD_GET(ID_AA64MMFR2_EL1, EVT, reg_val) >=
+		       ID_AA64MMFR2_EL1_EVT_IMP;
+
+	case ARM64_HAS_ECV_CNTPOFF:
+		reg_val = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
+		return SYS_FIELD_GET(ID_AA64MMFR1_EL1, PAN, reg_val) >=
+		       ID_AA64MMFR1_EL1_PAN_IMP;
+
+	case ARM64_MISMATCHED_CACHE_TYPE:
+		return false;
+	default:
+		return false;
+	}
+}
diff --git a/arch/s390/kvm/arm64/feature.h b/arch/s390/kvm/arm64/feature.h
new file mode 100644
index 000000000000..9c902df1f26c
--- /dev/null
+++ b/arch/s390/kvm/arm64/feature.h
@@ -0,0 +1,87 @@
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
+int __init kvm_arm_host_sanitize_features(struct qaaf_qmc_block *qaaf_qmc);
+
+/**
+ * read_sanitised_ftr_reg() - Get the value of a sys register
+ *
+ * @id - ARM sysreg id
+ *
+ * Get the value of a sys register describing the host configuration.
+ * The returned value indicates support by the machine (HW/FW)
+ * after some sanitisation.
+ * See `enum qaaf_regs` for supported registers.
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
+	extern struct qaaf_qmc_block __qaaf_qmp;
+
+	return __qaaf_qmp.ssdf;
+}
+
+/**
+ * kvm_sae_supported_sa_formats() - Retrieve supported SAE SA formats
+ *
+ * Return: Bitmap of supported SAE save area formats.
+ */
+static inline u32 kvm_sae_supported_sa_formats(void)
+{
+	extern struct qaaf_qmc_block __qaaf_qmp;
+
+	return __qaaf_qmp.ssaf;
+}
+
+/**
+ * kvm_sae_max_vcpus() - Retrieve maximum supported vcpus
+ *
+ * Return: Max number of vCPUs supported by the SAE instruction/the machine
+ *	as indicated by QAAF, not necessarily that supported by the host software.
+ */
+static inline u16 kvm_sae_max_vcpus(void)
+{
+	extern struct qaaf_qmc_block __qaaf_qmp;
+
+	/* QAAF QMP reports the max id not the max num */
+	return __qaaf_qmp.maxncpu + 1;
+}
+
+/**
+ * kvm_sae_irptc() - Retrieve supported SAE IRPTCs
+ *
+ * Return: Bitmap of supported SAE IRPTCs.
+ */
+static inline u64 kvm_sae_irptc(void)
+{
+	extern struct qaaf_qmc_block __qaaf_qmp;
+
+	return __qaaf_qmp.regs[QAAF_IRPTC];
+}
+
+#define kvm_vcpu_has_pmu(_v) false
+
+#endif /* ARCH_S390_KVM_FEATURE_H */
diff --git a/arch/s390/kvm/arm64/qaaf.c b/arch/s390/kvm/arm64/qaaf.c
index c3124d38afc2..228e9cdcd684 100644
--- a/arch/s390/kvm/arm64/qaaf.c
+++ b/arch/s390/kvm/arm64/qaaf.c
@@ -3,9 +3,14 @@
 #include <linux/kvm_host.h>
 #include <asm/aef.h>
 #include "qaaf.h"
+#include "feature.h"
 
-#define _qaaf_reg_case(id) case SYS_##id: return aef_qmc()->regs[QAAF_REG_##id]
+void __init kvm_init_qaaf(void)
+{
+	kvm_arm_host_sanitize_features(aef_qmc());
+}
 
+#define _qaaf_reg_case(id) case SYS_##id: return aef_qmc()->regs[QAAF_REG_##id]
 u64 kvm_qaaf_read_ftr_reg(u32 id)
 {
 	switch (id) {
diff --git a/arch/s390/kvm/arm64/qaaf.h b/arch/s390/kvm/arm64/qaaf.h
index 8fed7f795ce0..87042f81e882 100644
--- a/arch/s390/kvm/arm64/qaaf.h
+++ b/arch/s390/kvm/arm64/qaaf.h
@@ -5,6 +5,7 @@
 
 #include <asm/aef.h>
 
+__init void kvm_init_qaaf(void);
 u64 kvm_qaaf_read_ftr_reg(u32 id);
 
 #endif
-- 
2.53.0

