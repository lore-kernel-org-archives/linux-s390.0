Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F73A0B2E;
	Mon, 31 Aug 2026 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188185; cv=none; b=G+WYuYbVsoSysfXYBz5GflQ20TqnBYYVZqy8+KR/MI2SA0C9JA4rZctGyboX8shd9S1GG8mYE0EhGhuUFyEA1wN0CzTw0iNUZ7WIGxaXD3SkjrfPoBqQZ/9fa4bRVrclWChjg3DKQegn5x2/P3f4ws2pCS+d9g4UiOtsPVDSP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188185; c=relaxed/simple;
	bh=MDy70TKP6HE8m3XN3lYflVgomg3D/ilC+HKcvrORHPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUpo6OtuJLP7PojIOdG7AwNkolmd+PyloCPdMbQuPbWJrYl+kSEoRJ1UaOh1BZPYPHD3mGeIyaYUo2SL+GFPdDMhLGrVgUmdV3uTl1kyB9p6CUq5ecjkTrFfjUVcoe1YEgrLP2w3KL2NiOe/j5vWy3scnZwY4knsHbNfPB9c2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hfOeQJy4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hfOeQJy4"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ1rC2525384;
	Mon, 31 Aug 2026 14:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hZj6L00r16Ld/duyR
	N4VQu9y2dS+h1/B12DwQRXxKNA=; b=hfOeQJy4OVUALvZwr+Dl7ERGm/qM2jN/j
	tcOyX430sZmA8tH01LrtBq1Ii/Yicova58tT31tO1ONHerug7msgUanJUx+/e1Y5
	JJV1ZgOwowqRJFrlC5rGh8uuzqCWpp9TBA99p8amv4rTJRyaJNZW+/6UMipV/ie9
	5vVP7Jh/XW/fIkhoOxEPyAz3IVsCR35zN9oLKRNbv5uQ+qwloDBkkZbttIy/jYEC
	x/1iSciw42y/hKRaPtRB1KuzUbhdYy63xeZ2j4RJplMz0E8r4kgfWe/x0ffyzRNv
	WhA7GlkZv85Nd7896cfMImjqfjXeYfioN5jBFo8hKQxF3ypBYSppg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54j0t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfkbe015618;
	Mon, 31 Aug 2026 14:55:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq6ncb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtikR27001522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EF4420040;
	Mon, 31 Aug 2026 14:55:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 174D22004D;
	Mon, 31 Aug 2026 14:55:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:44 +0000 (GMT)
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
Subject: [PATCH v2 14/20] KVM: s390: arm64: Integrate sysreg into the host
Date: Mon, 31 Aug 2026 16:55:29 +0200
Message-ID: <20260831145536.913567-15-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX83waOl6NXYHh
 xNIi7I3/BRkB0exUnccYW3wqM0DgSetvx62vnmIOJzTAhnpaWzQSF4f+prKwkpMoKo0IcyMJKah
 SnwyqBQtZrYFewYhw728pDUvM97Y/MDd/P9NPByetAWOtJyJBSxXckUiL3QTX8aj6qLOuVs++uy
 RKQyDNpzaDsqyhUBmSddOMwGa40rs8KtjcDSU3yGCyoa/XS+siA3jReA9Xz28HAt3sUYFyV8+2v
 pRjhwbRiWj6hjXDSCmM0ZhBhJz576CgkjLrmJoHmpGblVWD1q1QH609T4DZ/MgHfU0z6J7Y1xf8
 26B3JKIEyLq+HBAsyzODcwTWmdUG+wkBa2KQnk4Y7/ZECMveDOH20iXMK/jEYYmPrYmdoRYvYpo
 ccxkxf9+8JobAlhC/UzkbnseccRGGeyyHzvW11Dy2dTD/8N68WngyayvdCaEeBu6eIcpC093F3X
 eimLok7pPuo2C/f64lQ==
X-Proofpoint-ORIG-GUID: tJCdN9neDzu5D4p0OxerZxvz8L9IVqTj
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9595f9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=30qWPLy4MGGtkCyviFsA:9
X-Proofpoint-GUID: uqPRVhf6yc6IcOA8yVkbMJz_j3dNcQaR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX48HNOtAxdHhE
 Zy7WNMP4niKvwWt6k9NBG8tuG5e1BncDheh/EWGmv3z52hpDC4/m2OalvOLoO666JxpD56gJT8W
 1gi4+TH60Kz4cSH7IMqvaiMEvie4ogQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Integrate the previously established system register managing
infrastructure into the host. Initialize sysregs during vcpu init.
Finalize sysregs on PID change, Initialize sysreg table on kvm init,
report availability to userspace and let userspace read&modify guest system
register.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h |  3 ++
 arch/s390/kvm/arm64/arm.c              | 27 +++++++++++++++++
 arch/s390/kvm/arm64/guest.c            | 12 +++++---
 arch/s390/kvm/arm64/handle_exit.c      |  1 +
 arch/s390/kvm/arm64/reset.c            | 42 ++++++++++++++++++++++++++
 5 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 65e5e0c48b07..0bf396ef54c2 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -156,6 +156,9 @@ struct kvm_arch {
 
 	/* Per-VM ID register storage */
 	struct kvm_vm_id_regs id_regs;
+
+	/* The EPD as it should be on all VCPUs. */
+	u64 epd;
 };
 
 static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index c573a3da5766..3a0bba6e0a06 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -16,6 +16,7 @@
 
 #include <arm64/kvm_emulate.h>
 #include <arm64/sysreg.h>
+#include <arm64/sys_regs.h>
 
 #include <gmap.h>
 #include <kvm_mmu.h>
@@ -136,6 +137,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		goto out_err;
 	kvm->arch.mem_limit = kvm->arch.guest_phys_size;
 
+	kvm->arch.epd = ptff_qagto(0);
+
 	VM_EVENT(kvm, 3, "vm created with type %lu", type);
 	return 0;
 
@@ -191,6 +194,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	sae_block->mso = 0L;
 	sae_block->msl = vcpu->kvm->arch.mem_limit;
 	sae_block->save_area = virt_to_phys(save_area);
+	sae_block->gpto = vcpu->kvm->arch.epd;
 
 	VM_EVENT(vcpu->kvm, 3,
 		 "create cpu %d at 0x%p, sae block at 0x%p, satellite at 0x%p",
@@ -259,6 +263,7 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
+	int ret;
 
 	if (!kvm_vcpu_initialized(vcpu))
 		return -ENOEXEC;
@@ -272,6 +277,10 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 	scoped_guard(mutex, &kvm->arch.config_lock)
 		set_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags);
 
+	ret = kvm_finalize_sys_regs(vcpu);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -390,10 +399,20 @@ static void arm_vcpu_run(struct kvm_vcpu *vcpu)
 	guest_state_enter_irqoff();
 	local_irq_enable();
 
+	vcpu_write_host_sys_reg(vcpu, vcpu->arch.hcr_elz, SYS_HCR_EL2);
+	vcpu_write_host_sys_reg(vcpu, vcpu->arch.hcrx_elz, SYS_HCRX_EL2);
+	vcpu_write_host_sys_reg(vcpu, vcpu->arch.mpidr, SYS_VMPIDR_EL2);
+
+	_vcpu_write_sys_reg(vcpu, vcpu->arch.ctxt.elr_el1, SYS_ELR_EL1);
+	_vcpu_write_sys_reg(vcpu, vcpu->arch.ctxt.spsr_el1, SYS_SPSR_EL1);
+
 	sae_block->icptr = 0;
 
 	sae64a(sae_block);
 
+	vcpu->arch.ctxt.elr_el1 = _vcpu_read_sys_reg(vcpu, SYS_ELR_EL1);
+	vcpu->arch.ctxt.spsr_el1 = _vcpu_read_sys_reg(vcpu, SYS_SPSR_EL1);
+
 	local_irq_disable();
 	guest_state_exit_irqoff();
 	guest_timing_exit_irqoff();
@@ -746,11 +765,19 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 
 static int __init kvm_s390_arm64_init(void)
 {
+	int ret;
+
 	if (!aef_info()->arm_guest_supp)
 		return -ENXIO;
 
 	kvm_init_qaaf();
 
+	ret = kvm_sys_reg_table_init();
+	if (ret) {
+		kvm_info("Error initializing system register tables");
+		return ret;
+	}
+
 	return kvm_init_with_dev(sizeof(struct kvm_vcpu), 0, THIS_MODULE,
 				 KVM_DEV_NAME, MISC_DYNAMIC_MINOR);
 }
diff --git a/arch/s390/kvm/arm64/guest.c b/arch/s390/kvm/arm64/guest.c
index 8b5ee9e79a4f..047460975936 100644
--- a/arch/s390/kvm/arm64/guest.c
+++ b/arch/s390/kvm/arm64/guest.c
@@ -4,6 +4,7 @@
 
 #include <arm64/kvm_emulate.h>
 #include <arm64/kvm_nested.h>
+#include <arm64/sys_regs.h>
 
 #define SVE_VQ_MIN	__SVE_VQ_MIN
 #define SVE_NUM_ZREGS	KVM_ARM64_SVE_NUM_ZREGS
@@ -60,12 +61,15 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 		return ret;
 	uindices += ret;
 
-	return 0;
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
@@ -78,7 +82,7 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_CORE:
 		return get_core_reg(vcpu, reg);
 	default:
-		return -EINVAL;
+		return kvm_arm_sys_reg_get_reg(vcpu, reg);
 	}
 }
 
@@ -92,7 +96,7 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_CORE:
 		return set_core_reg(vcpu, reg);
 	default:
-		return -EINVAL;
+		return kvm_arm_sys_reg_set_reg(vcpu, reg);
 	}
 }
 
diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/handle_exit.c
index 8b03e8ee5acf..b6cb4612675a 100644
--- a/arch/s390/kvm/arm64/handle_exit.c
+++ b/arch/s390/kvm/arm64/handle_exit.c
@@ -55,6 +55,7 @@ static int handle_hvc(struct kvm_vcpu *vcpu)
 static exit_handle_fn arm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
 	[ESR_ELx_EC_HVC64]	= handle_hvc,
+	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
 	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
 };
diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
index 0e162be1bcd5..74622ba6f081 100644
--- a/arch/s390/kvm/arm64/reset.c
+++ b/arch/s390/kvm/arm64/reset.c
@@ -5,6 +5,10 @@
 
 #include <arm64/kvm_emulate.h>
 #include <arm64/kvm_nested.h>
+#include <arm64/sys_regs.h>
+#include <arm64/sysreg.h>
+
+#include <clocksource/arm_arch_timer.h>
 
 bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 {
@@ -21,6 +25,39 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 			      HCR_EL2_TIDCP | HCR_EL2_TLOR;
 }
 
+static inline void vcpu_reset_hcrx(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcrx_elz = 0;
+	if (kvm_has_feat(vcpu->kvm, ID_AA64ISAR2_EL1, MOPS, IMP))
+		vcpu->arch.hcrx_elz |= HCRX_EL2_MSCEn;
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
 void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_reset_state reset_state;
@@ -43,9 +80,14 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 		vcpu_put(vcpu);
 
 	kvm_reset_vcpu_core(vcpu);
+	kvm_reset_sys_regs(vcpu);
 
 	/* Reset special registers */
 	vcpu_reset_hcr(vcpu);
+	vcpu_reset_hcrx(vcpu);
+	vcpu_reset_cptr(vcpu);
+	vcpu_reset_cnthctl(vcpu);
+	vcpu_reset_icc(vcpu);
 
 	if (reset_state.reset) {
 		*vcpu_pc(vcpu) = reset_state.pc;
-- 
2.53.0

