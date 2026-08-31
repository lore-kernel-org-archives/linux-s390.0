Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78FC509F0B;
	Mon, 31 Aug 2026 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188480; cv=none; b=t4VUqCEOjSzY010ICKpBfNkx9sZoxRJp2c3xQY2gqwbdev67xFXk7TL9CG9/ZIMm7DSPHtMcpsExDhlH48Fq9NCJA56rxtybGPTvLVhwsgpPB3qusS3yHDvmb5WvQVLtfabRkQ2Yi3XZSnQxxjDjiMhfNDFrPoFoFRncvCi8sdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188480; c=relaxed/simple;
	bh=5dailRVSe+VsldTuSYEmtZFIQr4igWshIO178Iz9+Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qO1jI0p0cqNXDgqIyTsP29hG/VyRSJRxKPrziHNi2kIvTgMbjQ0zXD1172+9ELv8YnV1FJArZIh+v1/PGP8S0b94VTSbCEmG9djyud8ZNrvB6wMbV2l8xblHwZsEKECZhul2sO67banM4SBLFXyOk4tWnbsZohBIIRBLED5Kuvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lgmqdRRV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lgmqdRRV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZBL41398304;
	Mon, 31 Aug 2026 14:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wcmwS7jF3rj7V99Rl
	jlhYCWfLOZpsW/C/eD2i0th7sc=; b=lgmqdRRVEuU7K99uoizgqzXTcOX0fwr3k
	d8dFRhGDwTrs5ZGKe92uS8rRQLesRLozQ2WE0V3wrQ+Jx678VvsS+au/m6U2h+oF
	Zpy3lcpGqahTFwMe0eERuFl8laHttk7AANvuVN+iSyM1kvjieuuCaQbt437qLmcQ
	4j8TfCu6mi2ecM/uVMEiqtjDwXYiYYTiqw2yWJUFM1NTQEkvsGW/4bbxyOZ2O5Hu
	OVAT1cqTXyERsDEbEWLuMxyZpaBK1MQjd+HStzLOttg2li5bN9C08lc7V3fLyq3O
	SHakFgS+Bizt2kELZnsCKW6MKJkzqxtKgdAiMs2CsRSneIqBNnDJQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudj18x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfklF017001;
	Mon, 31 Aug 2026 14:55:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h6dq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtk6I51184082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 986DB2004D;
	Mon, 31 Aug 2026 14:55:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 202A12004B;
	Mon, 31 Aug 2026 14:55:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:46 +0000 (GMT)
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
Subject: [PATCH v2 18/20] KVM: s390: arm64: Implement SVE for arm guests
Date: Mon, 31 Aug 2026 16:55:33 +0200
Message-ID: <20260831145536.913567-19-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: nrw0vK86z51JOtYhQOLga4hUDbYzckZR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX8RnGh/LuG2Zk
 hVTDEI4Rwbl5lWfp5mIJOQVzN9egmeak43zwPDKi0UHeE6NnkrAIpAurYX+0wbxFAF0grD7J+wy
 oZf6Ksm0ebK8i4neKB0NtklXfuqxiuqtFL0XhuMbl6eE5X1ZQQmFSg2iUNboNwF4wcekBLjriTy
 D7n2G+ReX/Gzx5xpwzO10p0tX5GecYgNahoD/JBl79yeKeqxn90Pdf4lVto2UpA+0025972jTmt
 eZe8kg1NF3il1J97Pxb7Hvle2nghms5zlgnFAYhkHgWbr7EBOCbu/Xi6mq5t00GvjdkSuT6Wx7s
 yRdB5BUMyJyfgrJZbSPZv+P/DWXeH9yyFtqD0nBdK5l38AD/UT711+FDivRPox07pHeP5BxRV92
 XuyNF4pNHgfndsDiChXy3SGi+ERKDwz/GJvaTPPk9X8kxm5WI0nbdDZfwC6kbzjNIQXcmVwp7oP
 WcHpES5GBvJY+j2eQ7A==
X-Proofpoint-ORIG-GUID: zHrYd4-axRbu28OfRnqLc_QTBJsJX__4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX8Mi3CwD23jBw
 UOwU3vrw/4Sb0k3jZjlPgRG25TCemz8k70XsvYImf6VMWbxqwgxg4C3MMp4z6jPG44iOulAh90q
 SaTndNyMmPM+O7LB8looHhMgsXn46/8=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9595fd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=cbRFlhSh8nMfZDnRg2QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

Add support for Scalable Vector Extension (SVE) in ARM64 guests running
on s390 hardware, providing 128-bit vector operations backed by s390's
Vector Extension (VX).

The implementation is limited to 128-bit vectors (VQ=1) matching s390 VX
register width. Z registers reuse existing FP/SIMD register space (vregs),
while P registers and FFR are stored in the SAE block.

This enables ARM64 guests to use basic SVE instructions while maintaining
compatibility with s390 hardware capabilities.

Co-developed-by: Friedrich Welter <fritz@linux.ibm.com>
Signed-off-by: Friedrich Welter <fritz@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h |   6 +-
 arch/s390/kvm/arm64/arm.c              |   7 +
 arch/s390/kvm/arm64/feature.c          |   9 +-
 arch/s390/kvm/arm64/feature.h          |  10 ++
 arch/s390/kvm/arm64/guest.c            | 204 +++++++++++++++++++++++++
 arch/s390/kvm/arm64/reset.c            |  22 ++-
 6 files changed, 253 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index c0e8fbddc9dc..73eb09e98848 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -31,8 +31,9 @@ bool cpus_have_final_cap(unsigned int num);
 
 #define KVM_HAVE_MMU_RWLOCK
 #define KVM_MAX_VCPUS 1
-#define KVM_S390_ARM64_IMPL_FEATURES \
-	(BIT(KVM_ARM_VCPU_PTRAUTH_ADDRESS) | BIT(KVM_ARM_VCPU_PTRAUTH_GENERIC))
+#define KVM_S390_ARM64_IMPL_FEATURES (		\
+	 BIT(KVM_ARM_VCPU_SVE)			\
+)
 
 #define KVM_HALT_POLL_NS_DEFAULT 50000
 
@@ -132,7 +133,6 @@ struct kvm_vcpu_stat {
 };
 
 #define kvm_has_mte(_kvm) false
-#define vcpu_has_sve(_vcpu) false
 #define vcpu_has_ptrauth(_vcpu) false
 
 struct kvm_arch_memory_slot {
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index d2ff69422217..a46c9c62a5f9 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -22,6 +22,7 @@
 #include <kvm_mmu.h>
 
 #include "arm.h"
+#include "feature.h"
 #include "handle_exit.h"
 #include "qaaf.h"
 #include "feature.h"
@@ -53,6 +54,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IOEVENTFD:
 		ret = 1;
 		break;
+	case KVM_CAP_ARM_SVE:
+		ret = system_supports_sve();
+		break;
 	default:
 		ret = 0;
 	}
@@ -258,6 +262,9 @@ static unsigned long system_supported_vcpu_features(void)
 {
 	unsigned long features = KVM_S390_ARM64_IMPL_FEATURES;
 
+	if (!system_supports_sve())
+		clear_bit(KVM_ARM_VCPU_SVE, &features);
+
 	return features;
 }
 
diff --git a/arch/s390/kvm/arm64/feature.c b/arch/s390/kvm/arm64/feature.c
index 39c8ae7e951c..3847cdd2f92b 100644
--- a/arch/s390/kvm/arm64/feature.c
+++ b/arch/s390/kvm/arm64/feature.c
@@ -56,7 +56,6 @@ int __init kvm_arm_host_sanitize_features(struct qaaf_qmc_block *qaaf_qmc)
 	MASK_RESERVED(qaaf_qmc, ID_AA64MMFR4_EL1);
 
 	MODIFY(qaaf_qmc, ID_AA64PFR0_EL1, SEL2, NI);
-	MODIFY(qaaf_qmc, ID_AA64PFR0_EL1, SVE, NI);
 	MASK_RESERVED(qaaf_qmc, ID_AA64PFR0_EL1);
 	MASK_RESERVED(qaaf_qmc, ID_AA64PFR1_EL1);
 	MASK_RESERVED(qaaf_qmc, ID_AA64PFR2_EL1);
@@ -163,3 +162,11 @@ bool cpus_have_final_cap(unsigned int num)
 		return false;
 	}
 }
+
+bool system_supports_sve(void)
+{
+	return cpu_has_vx() &&
+	       SYS_FIELD_GET(ID_AA64PFR0_EL1, SVE,
+			     read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1)) ==
+		       ID_AA64PFR0_EL1_SVE_IMP;
+}
diff --git a/arch/s390/kvm/arm64/feature.h b/arch/s390/kvm/arm64/feature.h
index 9c902df1f26c..892cf8bcf3a1 100644
--- a/arch/s390/kvm/arm64/feature.h
+++ b/arch/s390/kvm/arm64/feature.h
@@ -5,9 +5,13 @@
 
 #include <linux/types.h>
 #include <linux/bitfield.h>
+#include <linux/cpufeature.h>
 
 #include <asm/sae.h>
 
+#include <arm64/sysreg.h>
+#include <arm64/sys_regs.h>
+
 #include "qaaf.h"
 
 int __init kvm_arm_host_sanitize_features(struct qaaf_qmc_block *qaaf_qmc);
@@ -84,4 +88,10 @@ static inline u64 kvm_sae_irptc(void)
 
 #define kvm_vcpu_has_pmu(_v) false
 
+#define vcpu_has_sve(_vcpu)							\
+	(system_supports_sve() &&						\
+	 test_bit(KVM_ARCH_FLAG_GUEST_HAS_SVE, &((_vcpu)->kvm)->arch.flags))
+
+bool system_supports_sve(void);
+
 #endif /* ARCH_S390_KVM_FEATURE_H */
diff --git a/arch/s390/kvm/arm64/guest.c b/arch/s390/kvm/arm64/guest.c
index 047460975936..63fc4a64ab48 100644
--- a/arch/s390/kvm/arm64/guest.c
+++ b/arch/s390/kvm/arm64/guest.c
@@ -5,6 +5,9 @@
 #include <arm64/kvm_emulate.h>
 #include <arm64/kvm_nested.h>
 #include <arm64/sys_regs.h>
+#include <arm64/sve_context.h>
+
+#include "feature.h"
 
 #define SVE_VQ_MIN	__SVE_VQ_MIN
 #define SVE_NUM_ZREGS	KVM_ARM64_SVE_NUM_ZREGS
@@ -52,6 +55,197 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
+static int sve_zreg_index(__u64 id, unsigned int *regnum)
+{
+	/* Currently only one slice is supported on arm, and our zreg is only 128 bit */
+	const u64 zreg_id_max = KVM_REG_ARM64_SVE_ZREG(KVM_ARM64_SVE_NUM_ZREGS - 1,
+						       KVM_ARM64_SVE_MAX_SLICES - 1);
+	const u64 zreg_id_min = KVM_REG_ARM64_SVE_ZREG(0, 0);
+
+	if (id < zreg_id_min || id > zreg_id_max)
+		return -EINVAL;
+	if ((id & SVE_REG_SLICE_MASK) > 0)
+		return -ENOENT;
+
+	*regnum = (id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
+
+	return 0;
+}
+
+static int sve_preg_index(u64 id, unsigned int *regnum)
+{
+	const u64 preg_id_max = KVM_REG_ARM64_SVE_FFR(KVM_ARM64_SVE_MAX_SLICES - 1);
+	const u64 preg_id_min = KVM_REG_ARM64_SVE_PREG(0, 0);
+
+	if (id < preg_id_min || id > preg_id_max)
+		return -EINVAL;
+	if ((id & SVE_REG_SLICE_MASK) > 0)
+		return -ENOENT;
+
+	*regnum = (id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
+
+	return 0;
+}
+
+static int sve_ffr_index(u64 id, unsigned int *regnum)
+{
+	if (id != KVM_REG_ARM64_SVE_FFR(0))
+		return -EINVAL;
+	if ((id & SVE_REG_SLICE_MASK) > 0)
+		return -ENOENT;
+
+	*regnum = (id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
+
+	return 0;
+}
+
+static inline int get_sve_ffr_reg(struct kvm_vcpu *vcpu, unsigned int regnum,
+				  u16 __user *uptr)
+{
+	/* ffr is pregmax + 1 */
+	if (regnum != KVM_ARM64_SVE_NUM_PREGS)
+		return -EINVAL;
+
+	if (put_user(vcpu->arch.sae_block.sve_ffr, uptr))
+		return -EFAULT;
+	return 0;
+}
+
+static inline int get_sve_preg(struct kvm_vcpu *vcpu, unsigned int regnum,
+			       u16 __user *uptr)
+{
+	if (regnum < 0 || regnum >= KVM_ARM64_SVE_NUM_PREGS)
+		return -EINVAL;
+
+	if (put_user(vcpu->arch.sae_block.sve_pregs[regnum], uptr))
+		return -EFAULT;
+	return 0;
+}
+
+static inline int get_sve_zreg(struct kvm_vcpu *vcpu, unsigned int regnum,
+			       __vector128 __user *uptr)
+{
+	if (regnum < 0 || regnum >= KVM_ARM64_SVE_NUM_ZREGS)
+		return -EINVAL;
+
+	/* vreg and svreg overlap and zreg is also just 128 bit so we reuse the vreg space */
+	if (copy_to_user(uptr, &vcpu->arch.ctxt.vregs[regnum],
+			 sizeof(vcpu->arch.ctxt.vregs[regnum])))
+		return -EFAULT;
+	return 0;
+}
+
+static inline int set_sve_ffr_reg(struct kvm_vcpu *vcpu, unsigned int regnum,
+				  const u16 __user *uptr)
+{
+	/* ffr is pregmax + 1*/
+	if (regnum != KVM_ARM64_SVE_NUM_PREGS)
+		return -EINVAL;
+
+	if (get_user(vcpu->arch.sae_block.sve_ffr, uptr))
+		return -EFAULT;
+	return 0;
+}
+
+static inline int set_sve_preg(struct kvm_vcpu *vcpu, unsigned int regnum,
+			       const u16 __user *uptr)
+{
+	if (regnum < 0 || regnum >= KVM_ARM64_SVE_NUM_PREGS)
+		return -EINVAL;
+
+	if (get_user(vcpu->arch.sae_block.sve_pregs[regnum], uptr))
+		return -EFAULT;
+	return 0;
+}
+
+static inline int set_sve_zreg(struct kvm_vcpu *vcpu, unsigned int regnum,
+			       const __vector128 __user *uptr)
+{
+	if (regnum < 0 || regnum >= KVM_ARM64_SVE_NUM_ZREGS)
+		return -EINVAL;
+
+	/*vreg and svreg overlap and zreg is also just 128 bit so we reuse the vreg space*/
+	if (copy_from_user(&vcpu->arch.ctxt.vregs[regnum], uptr,
+			   sizeof(vcpu->arch.ctxt.vregs[regnum])))
+		return -EFAULT;
+	return 0;
+}
+
+static int set_sve_vls(struct kvm_vcpu *vcpu, const void __user *uptr)
+{
+	u64 vqs[KVM_ARM64_SVE_VLS_WORDS] = { 0 };
+	unsigned int vq;
+
+	if (!vcpu_has_sve(vcpu))
+		return -ENOENT;
+
+	if (kvm_arm_vcpu_sve_finalized(vcpu))
+		return -EPERM;
+
+	if (copy_from_user(vqs, uptr, sizeof(vqs)))
+		return -EFAULT;
+
+	/* only 128 bit and 1 VQ are supported , nothing saved just check validity */
+	for (vq = KVM_ARM64_SVE_VQ_MIN + 1; vq <= KVM_ARM64_SVE_VQ_MAX; ++vq)
+		if (vq_present(vqs, vq))
+			return -EINVAL;
+
+	/* run with a vl of 0 not valid */
+	if (!vq_present(vqs, KVM_ARM64_SVE_VQ_MIN))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int get_sve_vls(struct kvm_vcpu *vcpu, void __user *uptr)
+{
+	u64 vqs[KVM_ARM64_SVE_VLS_WORDS] = { 0 };
+
+	/* currently only 128 bit are supported so we only set bit 0  hardcoded */
+	vqs[0] |= vq_mask(KVM_ARM64_SVE_VQ_MIN);
+
+	if (copy_to_user(uptr, vqs, sizeof(vqs)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	void __user *uptr = (void __user *)reg->addr;
+	unsigned int regnum;
+	int ret = -EFAULT;
+
+	if (reg->id == KVM_REG_ARM64_SVE_VLS)
+		ret = get_sve_vls(vcpu, uptr);
+	else if (sve_ffr_index(reg->id, &regnum) >= 0)
+		ret = get_sve_ffr_reg(vcpu, regnum, uptr);
+	else if (sve_preg_index(reg->id, &regnum) >= 0)
+		ret = get_sve_preg(vcpu, regnum, uptr);
+	else if (sve_zreg_index(reg->id, &regnum) >= 0)
+		ret = get_sve_zreg(vcpu, regnum, uptr);
+
+	return ret;
+}
+
+static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	const void __user *uptr = (const void __user *)reg->addr;
+	int ret = -EFAULT;
+	unsigned int regnum;
+
+	if (reg->id == KVM_REG_ARM64_SVE_VLS)
+		ret = set_sve_vls(vcpu, uptr);
+	else if (sve_ffr_index(reg->id, &regnum) >= 0)
+		ret = set_sve_ffr_reg(vcpu, regnum, uptr);
+	else if (sve_preg_index(reg->id, &regnum) >= 0)
+		ret = set_sve_preg(vcpu, regnum, uptr);
+	else if (sve_zreg_index(reg->id, &regnum) >= 0)
+		ret = set_sve_zreg(vcpu, regnum, uptr);
+
+	return ret;
+}
+
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 {
 	int ret;
@@ -61,6 +255,11 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 		return ret;
 	uindices += ret;
 
+	ret = copy_sve_reg_indices(vcpu, uindices);
+	if (ret < 0)
+		return ret;
+	uindices += ret;
+
 	return kvm_arm_copy_sys_reg_indices(vcpu, uindices);
 }
 
@@ -68,6 +267,7 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 {
 	unsigned long num = num_core_regs(vcpu);
 
+	num += num_sve_regs(vcpu);
 	num += kvm_arm_num_sys_reg_descs(vcpu);
 	return num;
 }
@@ -81,6 +281,8 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
 	case KVM_REG_ARM_CORE:
 		return get_core_reg(vcpu, reg);
+	case KVM_REG_ARM64_SVE:
+		return get_sve_reg(vcpu, reg);
 	default:
 		return kvm_arm_sys_reg_get_reg(vcpu, reg);
 	}
@@ -95,6 +297,8 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
 	case KVM_REG_ARM_CORE:
 		return set_core_reg(vcpu, reg);
+	case KVM_REG_ARM64_SVE:
+		return set_sve_reg(vcpu, reg);
 	default:
 		return kvm_arm_sys_reg_set_reg(vcpu, reg);
 	}
diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
index bc7bcee75779..754c4d4a70b6 100644
--- a/arch/s390/kvm/arm64/reset.c
+++ b/arch/s390/kvm/arm64/reset.c
@@ -3,6 +3,8 @@
 #include <linux/kvm_host.h>
 #include <linux/fpu.h>
 
+#include "asm/cpufeature.h"
+
 #include <arm64/kvm_emulate.h>
 #include <arm64/kvm_nested.h>
 #include <arm64/sys_regs.h>
@@ -11,9 +13,13 @@
 #include <clocksource/arm_arch_timer.h>
 
 #include "qaaf.h"
+#include "feature.h"
 
 bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 {
+	if (vcpu_has_sve(vcpu) && !kvm_arm_vcpu_sve_finalized(vcpu))
+		return false;
+
 	return true;
 }
 
@@ -76,6 +82,10 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	 */
 	preempt_disable();
 
+	if (!vcpu_get_flag(vcpu, VCPU_SVE_FINALIZED) &&
+	    vcpu_has_feature(vcpu, KVM_ARM_VCPU_SVE))
+		set_bit(KVM_ARCH_FLAG_GUEST_HAS_SVE, &vcpu->kvm->arch.flags);
+
 	/* The reset must run with an unloaded save area */
 	loaded = vcpu_is_loaded(vcpu);
 	if (loaded)
@@ -114,5 +124,15 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
 int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
 {
-	return 0;
+	switch (feature) {
+	case KVM_ARM_VCPU_SVE:
+		if (!cpu_has_vx())
+			return -EINVAL;
+		if (vcpu_get_flag(vcpu, VCPU_SVE_FINALIZED))
+			return -EPERM;
+		vcpu_set_flag(vcpu, VCPU_SVE_FINALIZED);
+		return 0;
+	}
+
+	return -EINVAL;
 }
-- 
2.53.0

