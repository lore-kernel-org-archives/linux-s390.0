Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E3743637D;
	Fri, 29 May 2026 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070229; cv=none; b=qvwCRIj17UVxSu6O5sIw7BkCwd6qzkOfnXp9Q4jsIkcixoSIawwb9TcnMRcNoNVMqwAbcWamgDR4fjYf/OG0yNjk5I87vX+uD/T661jrwE19aMH9G60dTloKYAWaRDZ72ERgPPsgmgAUnsfBzaee3brgHgX0RW5WPxkRXYJEaSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070229; c=relaxed/simple;
	bh=Snpt7TSib1q6Sj8l4X5CXeC1HI+B3MJyIgfiNupQt2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4ZlRlpitDOAtLfJobtToBY3//XZ8bo28/w7VrDUv/OUE9URFqi0H5QI/53PNY+38hL30xT4o+vlM4Ckv09K7YNMeTWzq1DgDS3PU4a2geQYwLpInenmnzpEC/TUZHyp+t2h0oEKt4PMMGCpxrnbkjTz5aXupeKEHt0wIW99FkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mLuAJGHg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mLuAJGHg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFAijr2418321;
	Fri, 29 May 2026 15:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=07zjaI064nmoh49b2
	migjE+4CKaKKwfhbZQP8VBqk3c=; b=mLuAJGHgpPSISgqhOr7G+oUwXk/04R0JQ
	1iNztFDaAMiygYJsLj0J0rFU0TI6Ogkmg4w9lk98tWHPf7IKJd5Xxgg2Bodnubpq
	/Pj9HHWnVhRRa+lqinuAv6vSVTf5G0ucLd/UmvtXXteWkUHYDlTJzNkC+Qwl9hM5
	GZJ19pFaLkQSeV9jbI6F7O+rMVPsmq7l1wUbliU7a/IJEP2IUMur3a31DrvWM0CC
	yBwZJrLLgc8paCv1G6wEWPYe/3qVJKv8TtRnKtGD1a90K9HfIgZrnp5QnOC4DpG5
	AmkpQjGJZMnlRfDK8d0fQE+kcPU0A06C+kHenXO3vyifuheY9Zd+w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884vksu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs7Tm027776;
	Fri, 29 May 2026 15:56:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc8jpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFuBdY16187722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C65120040;
	Fri, 29 May 2026 15:56:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 262042004E;
	Fri, 29 May 2026 15:56:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:11 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>,
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
Subject: [PATCH v1 24/26] KVM: s390: arm64: Implement sysreg handling
Date: Fri, 29 May 2026 17:55:57 +0200
Message-ID: <20260529155601.2927240-25-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155601.2927240-1-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a19b724 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=4AYil0YxhE6jXFOO_r0A:9
X-Proofpoint-ORIG-GUID: CQrKwnA0xXDswTaBjqlyDi65rdKTqCPp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX8485wTThnZHv
 dmnM4ePGem6GKE/3sYko81gI+P9h4aOOC23d/311oLw70kEJPsFjqyyifxs7pj+Bxe4+6+drMD2
 4DxHyiEK4T9RWfCG+kXg+yonrj9Ykbr7ZmNU7jqMR2aZ68LPtOykwLnjfdd/1agAZ60NiUvvNo0
 /mYkOZvXiKp3ALtdizn/RuTVEVes7hz2oJp1PhQkDwbDuOIpdbrj3tOBhdTbeRxhhEOkSMNRzop
 5nXtdcXNfse2p/6+oyL5t1ln1WFN/azcVRDFPlxJSguYm/QkTGQ4BkKPsUmlRiJcOt/fhEFOEBs
 RGbtoc9tLJlBl1xBIeAGcv16BxJ1iy5y4c1QaNXcYVM+BFFBRs9ijIHJw9d+oimH46EXlVp0Cpw
 HzBBj5+Tmz/pa7aJRtbszQYvWIoR1NefN/+yzVZiXVcRNkoquY/TPodDkkteMUckHyIh5rYasVU
 WJA1BMWtz+V9zU3fEuQ==
X-Proofpoint-GUID: CQrKwnA0xXDswTaBjqlyDi65rdKTqCPp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

Add arm64 system register support for the s390 KVM backend, including
register enumeration, userspace get/set handling, reset/finalization
hooks, and vCPU run integration for trapped sysreg accesses.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/Makefile                |   1 -
 arch/s390/include/asm/kvm_emulate.h    |  34 ++
 arch/s390/include/asm/kvm_host_arm64.h |   2 +-
 arch/s390/kvm/arm64/Makefile           |   1 +
 arch/s390/kvm/arm64/arm.c              |  23 +-
 arch/s390/kvm/arm64/guest.c            |  20 +-
 arch/s390/kvm/arm64/handle_exit.c      |   1 +
 arch/s390/kvm/arm64/reset.c            |   5 +
 arch/s390/kvm/arm64/sys_regs.c         | 769 +++++++++++++++++++++++++
 arch/s390/kvm/arm64/trace.h            |  33 ++
 virt/kvm/arm64/Makefile.kvm            |   1 +
 11 files changed, 875 insertions(+), 15 deletions(-)
 create mode 100644 arch/s390/kvm/arm64/sys_regs.c
 create mode 100644 arch/s390/kvm/arm64/trace.h

diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index d55c7245aad9..5b4a8d002fc9 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -19,7 +19,6 @@ kvm-y += arm.o mmu.o psci.o hypercalls.o pvtime.o \
 	 guest.o debug.o reset.o sys_regs.o stacktrace.o \
 	 vgic-sys-reg-v3.o fpsimd.o pkvm.o \
 	 arch_timer.o trng.o vmid.o emulate-nested.o nested.o at.o \
-	 $(KVM_ARM64)/sys_regs.o \
 	 vgic/vgic.o vgic/vgic-init.o \
 	 vgic/vgic-irqfd.o vgic/vgic-v2.o \
 	 vgic/vgic-v3.o vgic/vgic-v4.o \
diff --git a/arch/s390/include/asm/kvm_emulate.h b/arch/s390/include/asm/kvm_emulate.h
index 93b9e777b51e..5549d44fda18 100644
--- a/arch/s390/include/asm/kvm_emulate.h
+++ b/arch/s390/include/asm/kvm_emulate.h
@@ -12,6 +12,7 @@
 
 #include <kvm/arm64/kvm_arm.h>
 #include <kvm/arm64/kvm_emulate.h>
+#include <clocksource/arm_arch_timer.h>
 
 static __always_inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcpu)
 {
@@ -84,6 +85,39 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 			      HCR_TID4 | HCR_TID5 | HCR_TIDCP;
 }
 
+static inline void vcpu_reset_hcrx(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcrx_elz = 0;
+	if (kvm_has_feat(vcpu->kvm, ID_AA64ISAR2_EL1, MOPS, IMP))
+		vcpu->arch.hcrx_elz |= HCRX_EL2_MSCEn ;
+}
+
+static inline void vcpu_reset_cptr(struct kvm_vcpu *vcpu)
+{
+	u64 cptr;
+
+	/* we unconditionally have E2H, so disable traps to EL2 for FP and SVE, if enabled */
+	cptr = CPACR_EL1_FPEN;
+	if (vcpu_has_sve(vcpu))
+		cptr |= CPACR_EL1_ZEN;
+	vcpu_write_host_sys_reg(vcpu, cptr, SYS_CPTR_EL2);
+}
+
+static inline void vcpu_reset_cnthctl(struct kvm_vcpu *vcpu)
+{
+	u64 cnthctl;
+
+	/* we unconditionally have E2H, so disable traps to EL2 for physical timer registers */
+	cnthctl = (CNTHCTL_EL1PCEN | CNTHCTL_EL1PCTEN) << 10;
+	vcpu_write_host_sys_reg(vcpu, cnthctl, SYS_CNTHCTL_EL2);
+}
+
+static inline void vcpu_reset_icc(struct kvm_vcpu *vcpu)
+{
+	/* ensure ICC_SRE_EL2.Enable = 1 so ICC_SRE_EL1 is handled in hardware */
+	vcpu_write_host_sys_reg(vcpu, 0xf, SYS_ICC_SRE_EL2);
+}
+
 static inline unsigned long vcpu_get_vsesr(struct kvm_vcpu *vcpu)
 {
 	WARN(true, "not implemented, just feat RAS");
diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index f62daff3303b..cc457d69621c 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -370,7 +370,7 @@ int __init kvm_sys_reg_table_init(void);
 
 static inline u64 kvm_sanitised_host_ftr_reg(u32 id)
 {
-	return 0xbad1234bad;
+	return kvm_arm_host_sys_reg_by_id(id);
 }
 
 #endif /* ASM_KVM_HOST_ARM64_H */
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index 28deeb90efa9..bec24b60a071 100644
--- a/arch/s390/kvm/arm64/Makefile
+++ b/arch/s390/kvm/arm64/Makefile
@@ -15,6 +15,7 @@ kvm-arm64-obj := \
 	inject_fault.o \
 	mmu.o \
 	reset.o \
+	sys_regs.o \
 
 kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(shared-arm64-obj))
 kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(kvm-y))
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index dc0e070f8a62..88b66552cff0 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -14,6 +14,7 @@
 
 #include <kvm/arm64/handle_exit.h>
 #include <kvm/arm64/kvm_emulate.h>
+#include <kvm/arm64/sys_regs.h>
 
 #include <gmap.h>
 
@@ -227,6 +228,7 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
+	int ret;
 
 	if (!kvm_vcpu_initialized(vcpu))
 		return -ENOEXEC;
@@ -237,6 +239,9 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 	if (likely(READ_ONCE(vcpu->pid)))
 		return 0;
 
+	ret = kvm_finalize_sys_regs(vcpu);
+	if (ret)
+		return ret;
 
 	mutex_lock(&kvm->arch.config_lock);
 	set_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags);
@@ -363,6 +368,9 @@ static void arm_vcpu_run(struct kvm_vcpu *vcpu)
 	guest_enter_irqoff();
 	local_irq_enable();
 
+	vcpu_write_host_sys_reg(vcpu, vcpu->arch.hcr_elz, SYS_HCR_EL2);
+	vcpu_write_host_sys_reg(vcpu, vcpu->arch.hcrx_elz, SYS_HCRX_EL2);
+	vcpu_write_host_sys_reg(vcpu, vcpu->arch.mpidr, SYS_VMPIDR_EL2); //TODO implement mpidr plumbing
 	sae_block->icptr = 0;
 
 	sae64a(sae_block);
@@ -690,15 +698,6 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 	return -ENOIOCTLCMD;
 }
 
-void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, enum vcpu_sysreg reg)
-{
-}
-
-u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, enum vcpu_sysreg reg)
-{
-	return 0xbad12324bad;
-}
-
 static int __init kvm_s390_arm64_init(void)
 {
 	int err = 0;
@@ -717,6 +716,12 @@ static int __init kvm_s390_arm64_init(void)
 	if (err)
 		return err;
 
+	err = kvm_sys_reg_table_init();
+	if (err) {
+		kvm_info("Error initializing system register tables");
+		return err;
+	}
+
 	return kvm_init_with_dev(sizeof(struct kvm_vcpu), 0, THIS_MODULE,
 				 KVM_DEV_NAME, MISC_DYNAMIC_MINOR);
 }
diff --git a/arch/s390/kvm/arm64/guest.c b/arch/s390/kvm/arm64/guest.c
index 893d48037292..3287059f89c7 100644
--- a/arch/s390/kvm/arm64/guest.c
+++ b/arch/s390/kvm/arm64/guest.c
@@ -2,6 +2,8 @@
 #include <linux/kvm_host.h>
 #include <linux/kvm.h>
 
+#include <kvm/arm64/sys_regs.h>
+
 #include "guest.h"
 
 const struct kvm_stats_desc kvm_vm_stats_desc[] = {
@@ -42,12 +44,22 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 {
-	return copy_core_reg_indices(vcpu, uindices);
+	int ret;
+
+	ret = copy_core_reg_indices(vcpu, uindices);
+	if (ret < 0)
+		return ret;
+	uindices += ret;
+
+	return kvm_arm_copy_sys_reg_indices(vcpu, uindices);
 }
 
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 {
-	return num_core_regs(vcpu);
+	unsigned long num = num_core_regs(vcpu);
+
+	num += kvm_arm_num_sys_reg_descs(vcpu);
+	return num;
 }
 
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
@@ -60,7 +72,7 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_CORE:
 		return get_core_reg(vcpu, reg);
 	default:
-		return -EINVAL;
+		return kvm_arm_sys_reg_get_reg(vcpu, reg);
 	}
 }
 
@@ -74,7 +86,7 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_CORE:
 		return set_core_reg(vcpu, reg);
 	default:
-		return -EINVAL;
+		return kvm_arm_sys_reg_set_reg(vcpu, reg);
 	}
 }
 
diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/handle_exit.c
index bccd644fb07c..53aa7f6c4745 100644
--- a/arch/s390/kvm/arm64/handle_exit.c
+++ b/arch/s390/kvm/arm64/handle_exit.c
@@ -47,6 +47,7 @@ static int handle_hvc(struct kvm_vcpu *vcpu)
 exit_handle_fn arm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
 	[ESR_ELx_EC_HVC64]	= handle_hvc,
+	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
 	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
 };
diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
index b38b36c72c72..19404bfb85b6 100644
--- a/arch/s390/kvm/arm64/reset.c
+++ b/arch/s390/kvm/arm64/reset.c
@@ -33,9 +33,14 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 		vcpu_put(vcpu);
 
 	kvm_reset_vcpu_core_regs(vcpu);
+	kvm_reset_sys_regs(vcpu);
 
 	/* Reset special registers */
 	vcpu_reset_hcr(vcpu);
+	vcpu_reset_hcrx(vcpu);
+	vcpu_reset_cptr(vcpu);
+	vcpu_reset_cnthctl(vcpu);
+	vcpu_reset_icc(vcpu);
 
 	if (reset_state.reset) {
 		*vcpu_pc(vcpu) = reset_state.pc;
diff --git a/arch/s390/kvm/arm64/sys_regs.c b/arch/s390/kvm/arm64/sys_regs.c
new file mode 100644
index 000000000000..0bcfdade8509
--- /dev/null
+++ b/arch/s390/kvm/arm64/sys_regs.c
@@ -0,0 +1,769 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/cpumask.h>
+#include <linux/cacheinfo.h>
+#include <linux/kvm_host.h>
+#include <linux/log2.h>
+#include <asm/sysreg-defs.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_feature.h>
+#include <asm/kvm_nested.h>
+
+#include <kvm/arm64/sys_regs.h>
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
+#define SR_INVALID 0x8badf00d8badf00d
+
+enum sr_loc_attr {
+	SR_LOC_SAVE_AREA,	/* Register on SA, loaded (on cpu) */
+	SR_LOC_SPECIAL,		/* Register in state description or Special care register*/
+	SR_LOC_INVALID,		/* Register is unknown */
+};
+
+struct sr_loc {
+	enum sr_loc_attr loc;
+};
+
+#define SREG_RANGE(NAME) __##NAME##_BEGIN__ + 1 ... __##NAME##_END__ - 1
+static __always_inline void locate_register(const struct kvm_vcpu *vcpu,
+					    enum vcpu_sysreg reg,
+					    struct sr_loc *loc)
+{
+	switch (reg) {
+	case SREG_RANGE(STATE_DESC):
+	case SREG_RANGE(SPECIAL):
+		loc->loc = SR_LOC_SPECIAL;
+		break;
+	case SREG_RANGE(SAVE_AREA):
+		loc->loc = SR_LOC_SAVE_AREA;
+		break;
+	default:
+		WARN(true, "%s wants to read invalid register %x", __func__, reg);
+		loc->loc = SR_LOC_INVALID;
+	}
+}
+
+static __always_inline u64 read_special_sr(const struct kvm_vcpu *vcpu,
+					   enum vcpu_sysreg reg)
+{
+	switch (reg) {
+	case CLIDR_EL1:		return vcpu->arch.sys_reg_clidr_el1;
+	case CSSELR_EL1:	return vcpu->arch.sys_reg_csselr_el1;
+	case MPIDR_EL1:		return vcpu->arch.mpidr;
+	case CNTP_CTL_EL0:	return vcpu->arch.sae_block.cntp_ctl;
+	case CNTV_CTL_EL0:	return vcpu->arch.sae_block.cntv_ctl;
+	case CONTEXTIDR_EL1:	return vcpu->arch.sae_block.contextidr_el1;
+	case SP_EL1:		return vcpu->arch.sae_block.sp_el1;
+	default:
+		WARN(true, "%s wants to read non-special register %x", __func__, reg);
+		return SR_INVALID;
+	}
+}
+
+static __always_inline u64 read_sr_from_vcpu(const struct kvm_vcpu *vcpu,
+					     enum vcpu_sysreg reg)
+{
+	switch (reg) {
+	case ACTLR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_ACTLR_EL1);
+	case AFSR0_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_AFSR0_EL1);
+	case AFSR1_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_AFSR1_EL1);
+	case CNTFRQ_EL0:	return _vcpu_read_sys_reg(vcpu, SYS_CNTFRQ_EL0);
+	case CNTP_CVAL_EL0:	return _vcpu_read_sys_reg(vcpu, SYS_CNTP_CVAL_EL0);
+	case CNTV_CVAL_EL0:	return _vcpu_read_sys_reg(vcpu, SYS_CNTV_CVAL_EL0);
+	case DISR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_DISR_EL1);
+	case MIDR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_MIDR_EL1);
+	case OSLSR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_OSLSR_EL1);
+	case PAR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_PAR_EL1);
+	case SCTLR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_SCTLR_EL1);
+	case CPACR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_CPACR_EL1);
+	case VBAR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_VBAR_EL1);
+	case SPSR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_SPSR_EL1);
+	case ELR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_ELR_EL1);
+	case ESR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_ESR_EL1);
+	case TCR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_TCR_EL1);
+	case MAIR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_MAIR_EL1);
+	case TTBR0_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_TTBR0_EL1);
+	case TTBR1_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_TTBR1_EL1);
+	case FAR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_FAR_EL1);
+	case TPIDR_EL0:		return _vcpu_read_sys_reg(vcpu, SYS_TPIDR_EL0);
+	case TPIDR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_TPIDR_EL1);
+	case TPIDRRO_EL0:	return _vcpu_read_sys_reg(vcpu, SYS_TPIDRRO_EL0);
+	case CNTKCTL_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_CNTKCTL_EL1);
+	case ZCR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_ZCR_EL1);
+	case SCXTNUM_EL0:	return _vcpu_read_sys_reg(vcpu, SYS_SCXTNUM_EL0);
+	case SCXTNUM_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_SCXTNUM_EL1);
+	case APIBKEYLO_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APIBKEYLO_EL1);
+	case APIBKEYHI_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APIBKEYHI_EL1);
+	case APIAKEYLO_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APIAKEYLO_EL1);
+	case APIAKEYHI_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APIAKEYHI_EL1);
+	case APGAKEYLO_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APGAKEYLO_EL1);
+	case APGAKEYHI_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APGAKEYHI_EL1);
+	case APDBKEYLO_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APDBKEYLO_EL1);
+	case APDBKEYHI_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APDBKEYHI_EL1);
+	case APDAKEYLO_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APDAKEYLO_EL1);
+	case APDAKEYHI_EL1:	return _vcpu_read_sys_reg(vcpu, SYS_APDAKEYHI_EL1);
+	case MDSCR_EL1:		return _vcpu_read_sys_reg(vcpu, SYS_MDSCR_EL1);
+	default:
+		WARN(true, "%s: failed to resolve %x", __func__,  reg);
+		return SR_INVALID;
+	}
+}
+
+u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, enum vcpu_sysreg reg)
+{
+	struct sr_loc loc = {};
+
+	locate_register(vcpu, reg, &loc);
+
+	if (unlikely(loc.loc == SR_LOC_INVALID)) {
+		WARN(true, "%s: failed to locate %u", __func__,  reg);
+		return SR_INVALID;
+	}
+
+	if (loc.loc == SR_LOC_SPECIAL)
+		return read_special_sr(vcpu, reg);
+
+	return read_sr_from_vcpu(vcpu, reg);
+}
+
+static __always_inline void write_special_sr(struct kvm_vcpu *vcpu, u64 val,
+					     enum vcpu_sysreg reg)
+{
+	switch (reg) {
+	case CLIDR_EL1:		vcpu->arch.sys_reg_clidr_el1 = val;		break;
+	case CSSELR_EL1:	vcpu->arch.sys_reg_csselr_el1 = val;		break;
+	case MPIDR_EL1:		vcpu->arch.mpidr = val;				break;
+	case CNTP_CTL_EL0: 	vcpu->arch.sae_block.cntp_ctl = val;		break;
+	case CNTV_CTL_EL0:	vcpu->arch.sae_block.cntv_ctl = val;		break;
+	case CONTEXTIDR_EL1:	vcpu->arch.sae_block.contextidr_el1 = val;	break;
+	case SP_EL1:		vcpu->arch.sae_block.sp_el1 = val;		break;
+	default:
+		WARN(true, "%s wants to write non-special register %x", __func__, reg);
+	}
+}
+
+static __always_inline void write_sr_to_vcpu(struct kvm_vcpu *vcpu, u64 val,
+					     enum vcpu_sysreg reg)
+{
+	switch (reg) {
+	case ACTLR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_ACTLR_EL1);		break;
+	case AFSR0_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_AFSR0_EL1);		break;
+	case AFSR1_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_AFSR1_EL1);		break;
+	case CNTFRQ_EL0:	_vcpu_write_sys_reg(vcpu, val, SYS_CNTFRQ_EL0);		break;
+	case CNTP_CVAL_EL0:	_vcpu_write_sys_reg(vcpu, val, SYS_CNTP_CVAL_EL0);	break;
+	case CNTV_CVAL_EL0:	_vcpu_write_sys_reg(vcpu, val, SYS_CNTV_CVAL_EL0);	break;
+	case DISR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_DISR_EL1);		break;
+	case MIDR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_MIDR_EL1);		break;
+	case PAR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_PAR_EL1);		break;
+	case OSLAR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_OSLAR_EL1);		break;
+	case SCTLR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_SCTLR_EL1);		break;
+	case CPACR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_CPACR_EL1);		break;
+	case VBAR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_VBAR_EL1);		break;
+	case SPSR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_SPSR_EL1);		break;
+	case ELR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_ELR_EL1);		break;
+	case ESR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_ESR_EL1);		break;
+	case TCR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_TCR_EL1);		break;
+	case MAIR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_MAIR_EL1);		break;
+	case TTBR0_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_TTBR0_EL1);		break;
+	case TTBR1_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_TTBR1_EL1);		break;
+	case FAR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_FAR_EL1);		break;
+	case TPIDR_EL0:		_vcpu_write_sys_reg(vcpu, val, SYS_TPIDR_EL0);		break;
+	case TPIDR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_TPIDR_EL1);		break;
+	case TPIDRRO_EL0:	_vcpu_write_sys_reg(vcpu, val, SYS_TPIDRRO_EL0);	break;
+	case CNTKCTL_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_CNTKCTL_EL1);	break;
+	case ZCR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_ZCR_EL1);		break;
+	case SCXTNUM_EL0:	_vcpu_write_sys_reg(vcpu, val, SYS_SCXTNUM_EL0);	break;
+	case SCXTNUM_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_SCXTNUM_EL1);	break;
+	case APIBKEYLO_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APIBKEYLO_EL1);	break;
+	case APIBKEYHI_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APIBKEYHI_EL1);	break;
+	case APIAKEYLO_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APIAKEYLO_EL1);	break;
+	case APIAKEYHI_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APIAKEYHI_EL1);	break;
+	case APGAKEYLO_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APGAKEYLO_EL1);	break;
+	case APGAKEYHI_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APGAKEYHI_EL1);	break;
+	case APDBKEYLO_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APDBKEYLO_EL1);	break;
+	case APDBKEYHI_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APDBKEYHI_EL1);	break;
+	case APDAKEYLO_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APDAKEYLO_EL1);	break;
+	case APDAKEYHI_EL1:	_vcpu_write_sys_reg(vcpu, val, SYS_APDAKEYHI_EL1);	break;
+	case MDSCR_EL1:		_vcpu_write_sys_reg(vcpu, val, SYS_MDSCR_EL1);		break;
+	default:
+		WARN(true, "%s: failed to resolve %x", __func__,  reg);
+	}
+}
+
+void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, enum vcpu_sysreg reg)
+{
+	struct sr_loc loc = {};
+
+	locate_register(vcpu, reg, &loc);
+
+	if (unlikely(loc.loc == SR_LOC_INVALID)) {
+		WARN(true, "%s: failed to locate %u", __func__,  reg);
+		return;
+	}
+
+	if (loc.loc == SR_LOC_SPECIAL) {
+		write_special_sr(vcpu, val, reg);
+		return;
+	}
+
+	write_sr_to_vcpu(vcpu, val, reg);
+}
+
+u64 vcpu_read_host_sys_reg(const struct kvm_vcpu *vcpu, int reg)
+{
+	switch (reg) {
+	case SYS_ICH_LR0_EL2:	return vcpu->arch.sae_block.ic_regs.ich_lrn_el2[0];
+	case SYS_ICH_LR1_EL2:	return vcpu->arch.sae_block.ic_regs.ich_lrn_el2[1];
+	case SYS_ICH_LR2_EL2:	return vcpu->arch.sae_block.ic_regs.ich_lrn_el2[2];
+	case SYS_ICH_LR3_EL2:	return vcpu->arch.sae_block.ic_regs.ich_lrn_el2[3];
+	case SYS_ICH_HCR_EL2:	return vcpu->arch.sae_block.ic_regs.ich_hcr_el2;
+	case SYS_ICH_AP0R0_EL2:	return vcpu->arch.sae_block.ic_regs.ich_ap0r0_el2;
+	case SYS_ICH_AP1R0_EL2:	return vcpu->arch.sae_block.ic_regs.ich_ap1r0_el2;
+	case SYS_ICH_VMCR_EL2:	return vcpu->arch.sae_block.ic_regs.ich_vmcr_el2;
+	case SYS_VSESR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_VSESR_EL2);
+	case SYS_HCR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HCR_EL2);
+	case SYS_CPTR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_CPTR_EL2);
+	case SYS_MDCR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_MDCR_EL2);
+	case SYS_HCRX_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HCRX_EL2);
+	case SYS_HFGRTR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HFGRTR_EL2);
+	case SYS_HFGWTR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HFGWTR_EL2);
+	case SYS_HDFGWTR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HDFGWTR_EL2);
+	case SYS_HDFGRTR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HDFGRTR_EL2);
+	case SYS_HFGITR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_HFGITR_EL2);
+	case SYS_CNTHCTL_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_CNTHCTL_EL2);
+	case SYS_ICC_SRE_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_ICC_SRE_EL2);
+	case SYS_VMPIDR_EL2:	return _vcpu_read_sys_reg(vcpu, SYS_VMPIDR_EL2);
+	default:
+		WARN(true, "%s wants to read non-host register %x", __func__, reg);
+		return SR_INVALID;
+	}
+}
+
+void vcpu_write_host_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
+{
+	switch (reg) {
+	case SYS_ICH_LR0_EL2:	vcpu->arch.sae_block.ic_regs.ich_lrn_el2[0] = val;	break;
+	case SYS_ICH_LR1_EL2:	vcpu->arch.sae_block.ic_regs.ich_lrn_el2[1] = val;	break;
+	case SYS_ICH_LR2_EL2:	vcpu->arch.sae_block.ic_regs.ich_lrn_el2[2] = val;	break;
+	case SYS_ICH_LR3_EL2:	vcpu->arch.sae_block.ic_regs.ich_lrn_el2[3] = val;	break;
+	case SYS_ICH_HCR_EL2:	vcpu->arch.sae_block.ic_regs.ich_hcr_el2 = val;		break;
+	case SYS_ICH_AP0R0_EL2:	vcpu->arch.sae_block.ic_regs.ich_ap0r0_el2 = val;	break;
+	case SYS_ICH_AP1R0_EL2:	vcpu->arch.sae_block.ic_regs.ich_ap1r0_el2 = val;	break;
+	case SYS_ICH_VMCR_EL2:	vcpu->arch.sae_block.ic_regs.ich_vmcr_el2 = val;	break;
+	case SYS_VSESR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_VSESR_EL2);		break;
+	case SYS_HCR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HCR_EL2);		break;
+	case SYS_CPTR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_CPTR_EL2);		break;
+	case SYS_MDCR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_MDCR_EL2);		break;
+	case SYS_HCRX_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HCRX_EL2);		break;
+	case SYS_HFGRTR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HFGRTR_EL2);		break;
+	case SYS_HFGWTR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HFGWTR_EL2);		break;
+	case SYS_HDFGWTR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HDFGWTR_EL2);	break;
+	case SYS_HDFGRTR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HDFGRTR_EL2);	break;
+	case SYS_HFGITR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_HFGITR_EL2);		break;
+	case SYS_CNTHCTL_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_CNTHCTL_EL2);	break;
+	case SYS_ICC_SRE_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_ICC_SRE_EL2);	break;
+	case SYS_VMPIDR_EL2:	_vcpu_write_sys_reg(vcpu, val, SYS_VMPIDR_EL2);		break;
+	default:
+		WARN(true, "%s wants to write non-host register %x", __func__, reg);
+	}
+}
+
+static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
+			       const struct sys_reg_desc *rd,
+			       u64 val)
+{
+	u8 debugver = SYS_FIELD_GET(ID_AA64DFR0_EL1, DebugVer, val);
+	u8 pmuver = SYS_FIELD_GET(ID_AA64DFR0_EL1, PMUVer, val);
+
+	if (pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF)
+		return -EINVAL;
+
+	/*
+	 * ID_AA64DFR0_EL1.DebugVer is one of those awkward fields with a
+	 * nonzero minimum safe value.
+	 */
+	if (debugver < ID_AA64DFR0_EL1_DebugVer_IMP)
+		return -EINVAL;
+
+	return set_id_reg(vcpu, rd, val);
+}
+
+static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
+			       const struct sys_reg_desc *rd, u64 user_val)
+{
+	/* Fail the guest's request to disable the AA64 ISA at EL{0,1,2} */
+	if (!FIELD_GET(ID_AA64PFR0_EL1_EL0, user_val) ||
+	    !FIELD_GET(ID_AA64PFR0_EL1_EL1, user_val) ||
+	    (vcpu_has_nv(vcpu) && !FIELD_GET(ID_AA64PFR0_EL1_EL2, user_val)))
+		return -EINVAL;
+
+	return set_id_reg(vcpu, rd, user_val);
+}
+
+int arm64_check_features(struct kvm_vcpu *vcpu,
+			 const struct sys_reg_desc *rd,
+			 u64 val)
+{
+	u32 id = reg_to_encoding(rd);
+	u64 host_val;
+	u64 old_val;
+
+	/*
+	 * This is a very minimal implementation to sanitise only the craziest
+	 * shenanigans we could get from userspace. The final goal is to share
+	 * the sanitisation with arm as well but this needs access to arm
+	 * (core) kernel code for which there is no suitable solution yet. TODO
+	 */
+
+	/*
+	 * If the register is RAZ we know the only safe value is 0.
+	 */
+	if (sysreg_visible_as_raz(vcpu, rd))
+		return val ? -E2BIG : 0;
+
+	host_val = kvm_arm_host_sys_reg_by_id(id);
+
+	switch (id) {
+	case SYS_ID_AA64MMFR0_EL1:
+		/* Forbid PRANGE values we do not know about */
+		if (SYS_FIELD_GET(ID_AA64MMFR0_EL1, PARANGE, host_val) >
+		    ID_AA64MMFR0_EL1_PARANGE_56)
+			return -E2BIG;
+		break;
+	case SYS_CTR_EL0:
+		/* forbid upgrading from VIPT to PIPT */
+		old_val = read_id_reg(vcpu, rd);
+		if (SYS_FIELD_GET(CTR_EL0, L1Ip, old_val) == CTR_EL0_L1Ip_VIPT &&
+		    SYS_FIELD_GET(CTR_EL0, L1Ip, val) == CTR_EL0_L1Ip_PIPT)
+			return -E2BIG;
+		break;
+	}
+	return 0;
+}
+
+static u64 __ro_after_init boot_cpu_midr_val;
+static u64 __ro_after_init boot_cpu_revidr_val;
+static u64 __ro_after_init boot_cpu_aidr_val;
+
+static void init_imp_id_regs(void)
+{
+	boot_cpu_midr_val = kvm_arm_host_sys_reg_by_name(MIDR_EL1);
+	boot_cpu_revidr_val = kvm_arm_host_sys_reg_by_name(REVIDR_EL1);
+	boot_cpu_aidr_val = 0xC0FFEE; // TODO qaaf support needed.
+}
+
+u64 reset_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	switch (reg_to_encoding(r)) {
+	case SYS_MIDR_EL1:
+		return boot_cpu_midr_val;
+	case SYS_REVIDR_EL1:
+		return boot_cpu_revidr_val;
+	case SYS_AIDR_EL1:
+		return boot_cpu_aidr_val;
+	default:
+		KVM_BUG_ON(1, vcpu->kvm);
+		return 0;
+	}
+}
+
+bool access_imp_id_reg(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+		       const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p, r);
+
+	/*
+	 * Return the VM-scoped implementation ID register values if userspace
+	 * has made them writable.
+	 */
+	if (test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &vcpu->kvm->arch.flags))
+		return access_id_reg(vcpu, p, r);
+
+	switch (reg_to_encoding(r)) {
+	case SYS_REVIDR_EL1:
+		p->regval = boot_cpu_revidr_val; //no old api to conform to?
+		break;
+	case SYS_AIDR_EL1:
+		p->regval = boot_cpu_aidr_val;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	return true;
+}
+
+static int get_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd, u64 *val)
+{
+	*val = vcpu->arch.mpidr;
+	return 0;
+}
+
+static int set_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd, u64 val)
+{
+	vcpu->arch.mpidr = val;
+	return 0;
+}
+
+static u64 reset_midr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	_vcpu_write_sys_reg(vcpu, boot_cpu_midr_val, SYS_MIDR_EL1);
+	return boot_cpu_midr_val;
+}
+
+static u64 reset_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	u64 oslsr = r->val;
+
+	set_oslsr_el1(vcpu, r, oslsr);
+	return oslsr;
+}
+
+static int arch_timer_set_user(struct kvm_vcpu *vcpu,
+			       const struct sys_reg_desc *rd,
+			       u64 val)
+{
+	switch (reg_to_encoding(rd)) {
+	case SYS_CNTVCT_EL0:
+		vcpu->arch.sae_block.gpto = ptff_qagto(val);
+		return 0;
+	case SYS_CNTPCT_EL0:
+		return 0;
+	}
+
+	__vcpu_assign_sys_reg(vcpu, rd->reg, val);
+	return 0;
+}
+
+static int arch_timer_get_user(struct kvm_vcpu *vcpu,
+			       const struct sys_reg_desc *rd,
+			       u64 *val)
+{
+	switch (reg_to_encoding(rd)) {
+	case SYS_CNTVCT_EL0:
+		*val = ptff_qagpt(vcpu->arch.sae_block.gpto);
+		break;
+	case SYS_CNTPCT_EL0:
+		*val = ptff_qagpt(vcpu->arch.sae_block.gpto);
+		break;
+	default:
+		*val = __vcpu_sys_reg(vcpu, rd->reg);
+	}
+
+	return 0;
+}
+
+#define TIMER_REG(name) { \
+	SYS_DESC(SYS_##name),			\
+	.reset = reset_val,			\
+	.reg = name,				\
+	.get_user = arch_timer_get_user,	\
+	.set_user = arch_timer_set_user,	\
+}
+
+/*
+ * Architected system registers.
+ * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
+ */
+static const struct sys_reg_desc sys_reg_descs[] = {
+	/* Op0 = 2 */
+	{ SYS_DESC(SYS_OSLAR_EL1), trap_oslar_el1 },
+	{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1, reset_oslsr_el1, OSLSR_EL1,
+	  OSLSR_EL1_OSLM_IMPLEMENTED, NULL, set_oslsr_el1 },
+
+	/* Op0 = 3 */
+	/* Op1 = 0 */
+	/* CRn = 0 */
+	/* CRm = 0 */
+
+	//should not trap, right?
+	{ SYS_DESC(SYS_MIDR_EL1), NULL, reset_midr, 0, GENMASK_ULL(31, 0),
+	  get_id_reg, set_imp_id_reg },
+	{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1, 0, get_mpidr,
+	  set_mpidr },
+	IMPLEMENTATION_ID(REVIDR_EL1, GENMASK_ULL(63, 0)),
+
+	/*
+	 * ID regs: all ID_SANITISED() entries here must have corresponding
+	 * entries in arm64_ftr_regs[].
+	 */
+
+	/* AArch64 mappings of the AArch32 ID registers */
+	/* CRm=1 */
+	ID_HIDDEN(ID_PFR0_EL1),
+	ID_HIDDEN(ID_PFR1_EL1),
+	ID_HIDDEN(ID_DFR0_EL1),
+	ID_HIDDEN(ID_AFR0_EL1),
+	ID_HIDDEN(ID_MMFR0_EL1),
+	ID_HIDDEN(ID_MMFR1_EL1),
+	ID_HIDDEN(ID_MMFR2_EL1),
+	ID_HIDDEN(ID_MMFR3_EL1),
+
+	/* CRm=2 */
+	ID_HIDDEN(ID_ISAR0_EL1),
+	ID_HIDDEN(ID_ISAR1_EL1),
+	ID_HIDDEN(ID_ISAR2_EL1),
+	ID_HIDDEN(ID_ISAR3_EL1),
+	ID_HIDDEN(ID_ISAR4_EL1),
+	ID_HIDDEN(ID_ISAR5_EL1),
+	ID_HIDDEN(ID_MMFR4_EL1),
+	ID_HIDDEN(ID_ISAR6_EL1),
+
+	/* CRm=3 */
+	ID_HIDDEN(MVFR0_EL1),
+	ID_HIDDEN(MVFR1_EL1),
+	ID_HIDDEN(MVFR2_EL1),
+	ID_UNALLOCATED(3, 3),
+	ID_HIDDEN(ID_PFR2_EL1),
+	ID_HIDDEN(ID_DFR1_EL1),
+	ID_HIDDEN(ID_MMFR5_EL1),
+	ID_UNALLOCATED(3, 7),
+
+	/* AArch64 ID registers */
+	/* CRm=4 */
+	ID_FILTERED(ID_AA64PFR0_EL1, id_aa64pfr0_el1,
+		    ~(ID_AA64PFR0_EL1_AMU | ID_AA64PFR0_EL1_MPAM |
+		      ID_AA64PFR0_EL1_SVE | ID_AA64PFR0_EL1_RAS |
+		      ID_AA64PFR0_EL1_GIC | ID_AA64PFR0_EL1_AdvSIMD |
+		      ID_AA64PFR0_EL1_FP)),
+	ID_WRITABLE(ID_AA64PFR1_EL1,
+		    ~(ID_AA64PFR1_EL1_PFAR | ID_AA64PFR1_EL1_DF2 |
+		      ID_AA64PFR1_EL1_MTEX | ID_AA64PFR1_EL1_THE |
+		      ID_AA64PFR1_EL1_GCS | ID_AA64PFR1_EL1_MTE_frac |
+		      ID_AA64PFR1_EL1_NMI | ID_AA64PFR1_EL1_RNDR_trap |
+		      ID_AA64PFR1_EL1_SME | ID_AA64PFR1_EL1_RES0 |
+		      ID_AA64PFR1_EL1_MPAM_frac | ID_AA64PFR1_EL1_RAS_frac |
+		      ID_AA64PFR1_EL1_MTE)),
+	ID_WRITABLE(ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_FPMR),
+	ID_UNALLOCATED(4, 3),
+	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
+	ID_HIDDEN(ID_AA64SMFR0_EL1),
+	ID_UNALLOCATED(4, 6),
+	ID_WRITABLE(ID_AA64FPFR0_EL1, ~ID_AA64FPFR0_EL1_RES0),
+
+	/* CRm=5 */
+	/*
+	 * Prior to FEAT_Debugv8.9, the architecture defines context-aware
+	 * breakpoints (CTX_CMPs) as the highest numbered breakpoints (BRPs).
+	 * KVM does not trap + emulate the breakpoint registers, and as such
+	 * cannot support a layout that misaligns with the underlying hardware.
+	 * While it may be possible to describe a subset that aligns with
+	 * hardware, just prevent changes to BRPs and CTX_CMPs altogether for
+	 * simplicity.
+	 *
+	 * See DDI0487K.a, section D2.8.3 Breakpoint types and linking
+	 * of breakpoints for more details.
+	 */
+	ID_FILTERED(ID_AA64DFR0_EL1, id_aa64dfr0_el1,
+		    ID_AA64DFR0_EL1_DoubleLock_MASK |
+			    ID_AA64DFR0_EL1_WRPs_MASK |
+			    ID_AA64DFR0_EL1_PMUVer_MASK |
+			    ID_AA64DFR0_EL1_DebugVer_MASK),
+	ID_SANITISED(ID_AA64DFR1_EL1),
+	ID_UNALLOCATED(5, 2),
+	ID_UNALLOCATED(5, 3),
+	ID_HIDDEN(ID_AA64AFR0_EL1),
+	ID_HIDDEN(ID_AA64AFR1_EL1),
+	ID_UNALLOCATED(5, 6),
+	ID_UNALLOCATED(5, 7),
+
+	/* CRm=6 */
+	ID_WRITABLE(ID_AA64ISAR0_EL1, ~ID_AA64ISAR0_EL1_RES0),
+	ID_WRITABLE(ID_AA64ISAR1_EL1,
+		    ~(ID_AA64ISAR1_EL1_GPI | ID_AA64ISAR1_EL1_GPA |
+		      ID_AA64ISAR1_EL1_API | ID_AA64ISAR1_EL1_APA)),
+	ID_WRITABLE(ID_AA64ISAR2_EL1,
+		    ~(ID_AA64ISAR2_EL1_RES0 | ID_AA64ISAR2_EL1_APA3 |
+		      ID_AA64ISAR2_EL1_GPA3)),
+	ID_WRITABLE(ID_AA64ISAR3_EL1,
+		    (ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_FAMINMAX)),
+	ID_UNALLOCATED(6, 4),
+	ID_UNALLOCATED(6, 5),
+	ID_UNALLOCATED(6, 6),
+	ID_UNALLOCATED(6, 7),
+
+	/* CRm=7 */
+	ID_FILTERED(ID_AA64MMFR0_EL1, id_aa64mmfr0_el1,
+		    ~(ID_AA64MMFR0_EL1_RES0 | ID_AA64MMFR0_EL1_ASIDBITS)),
+	ID_WRITABLE(ID_AA64MMFR1_EL1,
+		    ~(ID_AA64MMFR1_EL1_RES0 | ID_AA64MMFR1_EL1_HCX |
+		      ID_AA64MMFR1_EL1_TWED | ID_AA64MMFR1_EL1_XNX |
+		      ID_AA64MMFR1_EL1_VH | ID_AA64MMFR1_EL1_VMIDBits)),
+	ID_WRITABLE(ID_AA64MMFR2_EL1,
+		    ~(ID_AA64MMFR2_EL1_RES0 | ID_AA64MMFR2_EL1_EVT |
+		      ID_AA64MMFR2_EL1_FWB | ID_AA64MMFR2_EL1_IDS |
+		      ID_AA64MMFR2_EL1_NV | ID_AA64MMFR2_EL1_CCIDX)),
+	ID_WRITABLE(ID_AA64MMFR3_EL1,
+		    (ID_AA64MMFR3_EL1_TCRX | ID_AA64MMFR3_EL1_S1PIE |
+		     ID_AA64MMFR3_EL1_S1POE)),
+	ID_WRITABLE(ID_AA64MMFR4_EL1, ID_AA64MMFR4_EL1_NV_frac),
+	ID_UNALLOCATED(7, 5),
+	ID_UNALLOCATED(7, 6),
+	ID_UNALLOCATED(7, 7),
+
+	/* CRn = 1 */
+	{ SYS_DESC(SYS_SCTLR_EL1), NULL, reset_val, SCTLR_EL1, 0x00C50078 },
+	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
+
+	/* CRn = 2 */
+	{ SYS_DESC(SYS_TTBR0_EL1), access_rw, reset_val, TTBR0_EL1, 0 },
+	{ SYS_DESC(SYS_TTBR1_EL1), access_rw, reset_val, TTBR1_EL1, 0 },
+	{ SYS_DESC(SYS_TCR_EL1), access_rw, reset_val, TCR_EL1, 0 },
+
+	{ SYS_DESC(SYS_PMMIR_EL1), trap_raz_wi },
+	/* CRn = 10 */
+	{ SYS_DESC(SYS_MAIR_EL1), NULL, reset_unknown, MAIR_EL1 },
+
+	/* CRn = 12 */
+	{ SYS_DESC(SYS_VBAR_EL1), access_rw, reset_val, VBAR_EL1, 0 },
+
+	/* CRn = 13 */
+	{ SYS_DESC(SYS_TPIDR_EL1), NULL, reset_unknown, TPIDR_EL1 },
+
+	/* Op1 = 1 */
+	/* CRn = 0 */
+	/* CRm = 0 */
+	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
+	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
+	  ~CLIDR_EL1_RES0, .set_user = set_clidr },
+	IMPLEMENTATION_ID(AIDR_EL1, GENMASK_ULL(63, 0)),
+	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
+	ID_FILTERED(CTR_EL0, ctr_el0,
+		    CTR_EL0_DIC_MASK | CTR_EL0_IDC_MASK |
+			    CTR_EL0_DminLine_MASK | CTR_EL0_L1Ip_MASK |
+			    CTR_EL0_IminLine_MASK),
+
+	{ SYS_DESC(SYS_CNTFRQ_EL0), NULL, reset_val, CNTFRQ_EL0, 0x3B9ACA00 },
+	{ SYS_DESC(SYS_CNTVCT_EL0), .get_user = arch_timer_get_user,
+	  .set_user = arch_timer_set_user },
+	TIMER_REG(CNTP_CTL_EL0),
+	TIMER_REG(CNTP_CVAL_EL0),
+	TIMER_REG(CNTV_CTL_EL0),
+	TIMER_REG(CNTV_CVAL_EL0),
+
+};
+
+/*
+ * kvm_handle_sys_reg -- handles a system instruction or mrs/msr instruction
+ *			 trap on a guest execution
+ * @vcpu: The VCPU pointer
+ */
+int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
+{
+	const struct sys_reg_desc *desc = NULL;
+	struct sys_reg_params params;
+	unsigned long esr = kvm_vcpu_get_esr(vcpu);
+	int Rt = kvm_vcpu_sys_get_rt(vcpu);
+
+	trace_kvm_handle_sys_reg(esr);
+
+	params = esr_sys64_to_params(esr);
+	params.regval = vcpu_get_reg(vcpu, Rt);
+
+	/* System registers have Op0=={2,3}, as per DDI487 J.a C5.1.2 */
+	if (params.Op0 == 2 || params.Op0 == 3)
+		desc = find_reg(&params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	else
+		WARN(true, "system instruction handling not supported");
+
+	if (!desc) {
+		if (!(params.Op0 == 3 && (params.CRn & 0b1011) == 0b1011))
+			print_sys_reg_msg(&params,
+					  "Unsupported guest access at: %lx\n",
+					  *vcpu_pc(vcpu));
+		kvm_inject_undefined(vcpu);
+		return 1;
+	} else {
+		perform_access(vcpu, &params, desc);
+	}
+
+	/* Read from system register? */
+	if (!params.is_write &&
+	    (params.Op0 == 2 || params.Op0 == 3))
+		vcpu_set_reg(vcpu, Rt, params.regval);
+
+	return 1;
+}
+
+void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long i;
+
+	for (i = 0; i < ARRAY_SIZE(sys_reg_descs); i++) {
+		const struct sys_reg_desc *r = &sys_reg_descs[i];
+
+		if (!r->reset)
+			continue;
+
+		if (is_vm_ftr_id_reg(reg_to_encoding(r))) {
+			reset_vm_ftr_id_reg(vcpu, r);
+			/*
+			 * Even VM only regs are stored in the save area of the vcpu
+			 * and need a meaningful initial value. Call reset because of this.
+			 */
+			r->reset(vcpu, r);
+		} else if (is_vcpu_ftr_id_reg(reg_to_encoding(r))) {
+			reset_vcpu_ftr_id_reg(vcpu, r);
+		} else {
+			r->reset(vcpu, r);
+		}
+	}
+	set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags);
+}
+
+int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu,
+			    const struct kvm_one_reg *reg)
+{
+	return __kvm_arm_sys_reg_get_reg(vcpu, reg, ARRAY_SIZE(sys_reg_descs),
+					 sys_reg_descs);
+}
+
+int __init kvm_sys_reg_table_init(void)
+{
+	init_imp_id_regs();
+
+	bool valid = check_sysreg_table(sys_reg_descs,
+					ARRAY_SIZE(sys_reg_descs), false);
+
+	if (!valid)
+		return -EINVAL;
+
+	return 0;
+}
+
+unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu)
+{
+	return __kvm_arm_num_sys_reg_descs(vcpu, ARRAY_SIZE(sys_reg_descs),
+					   sys_reg_descs);
+}
+
+int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	return __kvm_arm_copy_sys_reg_indices(vcpu, uindices, 
+					      ARRAY_SIZE(sys_reg_descs),
+					      sys_reg_descs);
+}
+
+int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu,
+			    const struct kvm_one_reg *reg)
+{
+	return __kvm_arm_sys_reg_set_reg(vcpu, reg, ARRAY_SIZE(sys_reg_descs),
+					 sys_reg_descs);
+}
+
+/*
+ * Perform last adjustments to the ID registers that are implied by the
+ * configuration outside of the ID regs themselves, as well as any
+ * initialisation that directly depend on these ID registers (such as
+ * RES0/RES1 behaviours). This is not the place to configure traps though.
+ *
+ * Because this can be called once per CPU, changes must be idempotent.
+ */
+int kvm_finalize_sys_regs(struct kvm_vcpu *vcpu)
+{
+	/* TODO GIC finalization */
+	return 0;
+}
diff --git a/arch/s390/kvm/arm64/trace.h b/arch/s390/kvm/arm64/trace.h
new file mode 100644
index 000000000000..015f380207ab
--- /dev/null
+++ b/arch/s390/kvm/arm64/trace.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(_TRACE_ARM64_KVM_S390_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ARM64_KVM_S390_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm
+
+TRACE_EVENT(kvm_handle_sys_reg,
+	TP_PROTO(unsigned long esr),
+	TP_ARGS(esr),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,	esr)
+	),
+
+	TP_fast_assign(
+		__entry->esr = esr;
+	),
+
+	TP_printk("ESR 0x%08lx", __entry->esr)
+);
+
+#endif /* _TRACE_ARM64_KVM_S390_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../arch/s390/kvm/arm64
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/virt/kvm/arm64/Makefile.kvm b/virt/kvm/arm64/Makefile.kvm
index c5e1db570a09..9a3df2446b8b 100644
--- a/virt/kvm/arm64/Makefile.kvm
+++ b/virt/kvm/arm64/Makefile.kvm
@@ -10,4 +10,5 @@ shared-arm64-obj := \
 	$(KVM_ARM64)/handle_exit.o \
 	$(KVM_ARM64)/mmio.o \
 	$(KVM_ARM64)/reset.o \
+	$(KVM_ARM64)/sys_regs.o \
 
-- 
2.53.0

