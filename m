Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73E3F44CF;
	Fri, 29 May 2026 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069911; cv=none; b=dX8ox0A+wvveuBcgdvp1toCI4xszf3i5BQG7xOQ2arj4y+UsiAmHwGgach5fdbVoXq6wqRTa1O9qLwLGpoZ40lGfXRE5Pb2JBDXSCNddFF9Q/GD7h2xGXOK9kwlAmrE4XOjestPJaXq+fIkdxVmW8/CT+RmMVY181hkJCPof79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069911; c=relaxed/simple;
	bh=XIS2pqMjCeEeNq5CiUKhMaYLSz3W2f/T95gIiGw8cQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOKh6pgDWewOFiIISPeDKM1kx2AyEoTU3Cv+nSom9ZHs8jd8SVOXO4De0XeFBelwDZ+YpK3IINpI8DMoXfSXwkZ2fwkkDK0lZ++t9NMiGr4GGQI5Kx59wcMrg8sG004R69qNgy0V44bRR4X6OKkEUkUNnkHaMJfszGOiHxNLh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e1tNJrSw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e1tNJrSw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TF3eh91684641;
	Fri, 29 May 2026 15:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+36V7ZUBNjRAZUsCf
	Bj4UqwwkobG+Tzi02DWJd+13NE=; b=e1tNJrSw6/y0NSQwdXYHdy/HiYOFUCcvc
	S9eBZLjwrd2lwZBMOdxa+HngifO1wTh2Gw4E/e6LzTpQtaMdQe8L1Qt1fV6eNgI8
	2fkCqdkXPLkV2ciaLzBgw+tCBiwiRUFmp6WK7LNdbSsPTDiWiv4y6y8/aEO1ACyJ
	N9tvZ5No8koDtCR3MxOBoh/3XVs+vOJpUnjU1Od4aJ2/+04srAmMFWzJraTbfvVi
	zl5ysFL4a08jvWNdq67emGHyZiONZ34IjaoWKaqroCSifv2DXLja0lpmGuWWd+4j
	9LM+VLWzKmX4Rk0oxmexZ7LQMYhMuAtksZxz5dDVMMmS2BiyyWPcw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884mbrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFd6J2022954;
	Fri, 29 May 2026 15:51:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc8eux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFosri45089226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:50:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9336D2004B;
	Fri, 29 May 2026 15:50:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A0CF2004E;
	Fri, 29 May 2026 15:50:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:50:54 +0000 (GMT)
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
Subject: [PATCH v3 10/27] KVM: arm64: Make some arm64 KVM code shareable
Date: Fri, 29 May 2026 17:50:24 +0200
Message-ID: <20260529155050.2902245-11-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155050.2902245-1-seiden@linux.ibm.com>
References: <20260529155050.2902245-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19b5e7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=vbCobAosysR5EIkJmscA:9
X-Proofpoint-ORIG-GUID: yzewnLrDrmjUbAGzVV099JV2Vw2pCY-z
X-Proofpoint-GUID: yzewnLrDrmjUbAGzVV099JV2Vw2pCY-z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfXwktMpbHARlx4
 aZvcJR4d1iZHwS1aqZILjZu8xIy114cmb9GI2VP37gFh3PTac1929ePHl8ktdsNtWdHUjO6UdGO
 LBpEDgh6nf6c/9a5F/J5a2Ry1tcbggfdTdLdf6Ma8jHKsVp7AYgKPQOnJuZ+f2voiZfUm2llhqx
 I+IW9U5ciZgVPGtFIzZp/3uy+cYi7jBio3MOsGWoC/Cw7OAobC2X/5K1CWeuj0LEWmzOvCEofiJ
 BHQzbxukl64LEBY44eRrClSAmW5fkbfqgHBS3ZhVmU35ebL2IHPKm3/ahi5X83CQOQHWV522XeV
 nR40DGHHY0Xlx15YapeDrhvp2hZHO+QDerOY++yGANcr+nThMxHdcCxGLBKQUvrkCE6SOCZIz/K
 HiyMAfpri8wmxPwmnE3cgdbY/JT87vc3WQL8tSYqqABQnngod5R3rKd7qgBHgNifIZgSVZ8/mFK
 b6kNvP45PTzs4sARxwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

Support sharing architecture-agnostic KVM-arm64 code between different
architectures. Introduce a new directory virt/kvm/arm64 which holds
arm64-KVM code that can be used by multiple architectures implementing
the arm64-KVM API.

Additionally, to improve portability slightly modify core_reg_addr to
use functions instead of direct field accesses.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 MAINTAINERS                               |   1 +
 arch/arm64/kvm/Makefile                   |   5 +-
 arch/arm64/kvm/arm.c                      |  48 ----
 arch/arm64/kvm/guest.c                    | 292 ---------------------
 arch/arm64/kvm/handle_exit.c              |  52 +---
 arch/arm64/kvm/trace_arm.h                |  25 --
 include/kvm/arm64/guest.h                 |   5 +-
 include/kvm/arm64/handle_exit.h           |  14 +
 include/kvm/arm64/kvm_host.h              |   9 +
 virt/kvm/arm64/Makefile.kvm               |  12 +
 virt/kvm/arm64/arm.c                      |  54 ++++
 virt/kvm/arm64/guest.c                    | 302 ++++++++++++++++++++++
 virt/kvm/arm64/handle_exit.c              |  54 ++++
 {arch/arm64/kvm => virt/kvm/arm64}/mmio.c |   1 +
 virt/kvm/arm64/trace.h                    |  42 +++
 15 files changed, 500 insertions(+), 416 deletions(-)
 create mode 100644 include/kvm/arm64/handle_exit.h
 create mode 100644 virt/kvm/arm64/Makefile.kvm
 create mode 100644 virt/kvm/arm64/arm.c
 create mode 100644 virt/kvm/arm64/guest.c
 create mode 100644 virt/kvm/arm64/handle_exit.c
 rename {arch/arm64/kvm => virt/kvm/arm64}/mmio.c (99%)
 create mode 100644 virt/kvm/arm64/trace.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 311fcfde9b11..3a07a707ec28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14080,6 +14080,7 @@ F:	arch/arm64/include/uapi/asm/kvm*
 F:	include/kvm/arm64/
 F:	include/uapi/arch/arm64/asm/kvm*
 F:	arch/arm64/kvm/
+F:	virt/kvm/arm64/
 F:	include/kvm/arm_*
 F:	tools/testing/selftests/kvm/*/arm64/
 F:	tools/testing/selftests/kvm/arm64/
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 59612d2f277c..5b4a8d002fc9 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -6,6 +6,7 @@
 ccflags-y += -I $(src)
 
 include $(srctree)/virt/kvm/Makefile.kvm
+include $(srctree)/virt/kvm/arm64/Makefile.kvm
 
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(CONFIG_KVM) += hyp/
@@ -13,7 +14,7 @@ obj-$(CONFIG_KVM) += hyp/
 CFLAGS_sys_regs.o += -Wno-override-init
 CFLAGS_handle_exit.o += -Wno-override-init
 
-kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
+kvm-y += arm.o mmu.o psci.o hypercalls.o pvtime.o \
 	 inject_fault.o va_layout.o handle_exit.o config.o \
 	 guest.o debug.o reset.o sys_regs.o stacktrace.o \
 	 vgic-sys-reg-v3.o fpsimd.o pkvm.o \
@@ -26,6 +27,8 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o vgic/vgic-v3-nested.o \
 	 vgic/vgic-v5.o
 
+kvm-y += $(shared-arm64-obj)
+
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
 kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 04a4ef1c7f06..929b8e6eae9a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1567,54 +1567,6 @@ unsigned long system_supported_vcpu_features(void)
 	return features;
 }
 
-static int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
-					const struct kvm_vcpu_init *init)
-{
-	unsigned long features = init->features[0];
-	int i;
-
-	if (features & ~KVM_VCPU_VALID_FEATURES)
-		return -ENOENT;
-
-	for (i = 1; i < ARRAY_SIZE(init->features); i++) {
-		if (init->features[i])
-			return -ENOENT;
-	}
-
-	if (features & ~system_supported_vcpu_features())
-		return -EINVAL;
-
-	/*
-	 * For now make sure that both address/generic pointer authentication
-	 * features are requested by the userspace together.
-	 */
-	if (test_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, &features) !=
-	    test_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, &features))
-		return -EINVAL;
-
-	if (!test_bit(KVM_ARM_VCPU_EL1_32BIT, &features))
-		return 0;
-
-	/* MTE is incompatible with AArch32 */
-	if (kvm_has_mte(vcpu->kvm))
-		return -EINVAL;
-
-	/* NV is incompatible with AArch32 */
-	if (test_bit(KVM_ARM_VCPU_HAS_EL2, &features))
-		return -EINVAL;
-
-	return 0;
-}
-
-static bool kvm_vcpu_init_changed(struct kvm_vcpu *vcpu,
-				  const struct kvm_vcpu_init *init)
-{
-	unsigned long features = init->features[0];
-
-	return !bitmap_equal(vcpu->kvm->arch.vcpu_features, &features,
-			     KVM_VCPU_MAX_FEATURES);
-}
-
 static int kvm_setup_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 557c380ffa37..161840c357e0 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -64,250 +64,6 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
-static bool core_reg_offset_is_vreg(u64 off)
-{
-	return off >= KVM_REG_ARM_CORE_REG(fp_regs.vregs) &&
-		off < KVM_REG_ARM_CORE_REG(fp_regs.fpsr);
-}
-
-static u64 core_reg_offset_from_id(u64 id)
-{
-	return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
-}
-
-static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
-{
-	int size;
-
-	switch (off) {
-	case KVM_REG_ARM_CORE_REG(regs.regs[0]) ...
-	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
-	case KVM_REG_ARM_CORE_REG(regs.sp):
-	case KVM_REG_ARM_CORE_REG(regs.pc):
-	case KVM_REG_ARM_CORE_REG(regs.pstate):
-	case KVM_REG_ARM_CORE_REG(sp_el1):
-	case KVM_REG_ARM_CORE_REG(elr_el1):
-	case KVM_REG_ARM_CORE_REG(spsr[0]) ...
-	     KVM_REG_ARM_CORE_REG(spsr[KVM_NR_SPSR - 1]):
-		size = sizeof(__u64);
-		break;
-
-	case KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]) ...
-	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
-		size = sizeof(__uint128_t);
-		break;
-
-	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
-	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
-		size = sizeof(__u32);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	if (!IS_ALIGNED(off, size / sizeof(__u32)))
-		return -EINVAL;
-
-	/*
-	 * The KVM_REG_ARM64_SVE regs must be used instead of
-	 * KVM_REG_ARM_CORE for accessing the FPSIMD V-registers on
-	 * SVE-enabled vcpus:
-	 */
-	if (vcpu_has_sve(vcpu) && core_reg_offset_is_vreg(off))
-		return -EINVAL;
-
-	return size;
-}
-
-static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
-{
-	u64 off = core_reg_offset_from_id(reg->id);
-	int size = core_reg_size_from_offset(vcpu, off);
-
-	if (size < 0)
-		return NULL;
-
-	if (KVM_REG_SIZE(reg->id) != size)
-		return NULL;
-
-	switch (off) {
-	case KVM_REG_ARM_CORE_REG(regs.regs[0]) ...
-	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
-		off -= KVM_REG_ARM_CORE_REG(regs.regs[0]);
-		off /= 2;
-		return &vcpu->arch.ctxt.regs.regs[off];
-
-	case KVM_REG_ARM_CORE_REG(regs.sp):
-		return &vcpu->arch.ctxt.regs.sp;
-
-	case KVM_REG_ARM_CORE_REG(regs.pc):
-		return &vcpu->arch.ctxt.regs.pc;
-
-	case KVM_REG_ARM_CORE_REG(regs.pstate):
-		return &vcpu->arch.ctxt.regs.pstate;
-
-	case KVM_REG_ARM_CORE_REG(sp_el1):
-		return __ctxt_sys_reg(&vcpu->arch.ctxt, SP_EL1);
-
-	case KVM_REG_ARM_CORE_REG(elr_el1):
-		return __ctxt_sys_reg(&vcpu->arch.ctxt, ELR_EL1);
-
-	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_EL1]):
-		return __ctxt_sys_reg(&vcpu->arch.ctxt, SPSR_EL1);
-
-	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_ABT]):
-		return &vcpu->arch.ctxt.spsr_abt;
-
-	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_UND]):
-		return &vcpu->arch.ctxt.spsr_und;
-
-	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_IRQ]):
-		return &vcpu->arch.ctxt.spsr_irq;
-
-	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_FIQ]):
-		return &vcpu->arch.ctxt.spsr_fiq;
-
-	case KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]) ...
-	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
-		off -= KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]);
-		off /= 4;
-		return &vcpu->arch.ctxt.fp_regs.vregs[off];
-
-	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
-		return &vcpu->arch.ctxt.fp_regs.fpsr;
-
-	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
-		return &vcpu->arch.ctxt.fp_regs.fpcr;
-
-	default:
-		return NULL;
-	}
-}
-
-static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
-{
-	/*
-	 * Because the kvm_regs structure is a mix of 32, 64 and
-	 * 128bit fields, we index it as if it was a 32bit
-	 * array. Hence below, nr_regs is the number of entries, and
-	 * off the index in the "array".
-	 */
-	__u32 __user *uaddr = (__u32 __user *)(unsigned long)reg->addr;
-	int nr_regs = sizeof(struct kvm_regs) / sizeof(__u32);
-	void *addr;
-	u32 off;
-
-	/* Our ID is an index into the kvm_regs struct. */
-	off = core_reg_offset_from_id(reg->id);
-	if (off >= nr_regs ||
-	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
-		return -ENOENT;
-
-	addr = core_reg_addr(vcpu, reg);
-	if (!addr)
-		return -EINVAL;
-
-	if (copy_to_user(uaddr, addr, KVM_REG_SIZE(reg->id)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
-{
-	__u32 __user *uaddr = (__u32 __user *)(unsigned long)reg->addr;
-	int nr_regs = sizeof(struct kvm_regs) / sizeof(__u32);
-	__uint128_t tmp;
-	void *valp = &tmp, *addr;
-	u64 off;
-	int err = 0;
-
-	/* Our ID is an index into the kvm_regs struct. */
-	off = core_reg_offset_from_id(reg->id);
-	if (off >= nr_regs ||
-	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
-		return -ENOENT;
-
-	addr = core_reg_addr(vcpu, reg);
-	if (!addr)
-		return -EINVAL;
-
-	if (KVM_REG_SIZE(reg->id) > sizeof(tmp))
-		return -EINVAL;
-
-	if (copy_from_user(valp, uaddr, KVM_REG_SIZE(reg->id))) {
-		err = -EFAULT;
-		goto out;
-	}
-
-	if (off == KVM_REG_ARM_CORE_REG(regs.pstate)) {
-		u64 mode = (*(u64 *)valp) & PSR_AA32_MODE_MASK;
-		switch (mode) {
-		case PSR_AA32_MODE_USR:
-			if (!kvm_supports_32bit_el0())
-				return -EINVAL;
-			break;
-		case PSR_AA32_MODE_FIQ:
-		case PSR_AA32_MODE_IRQ:
-		case PSR_AA32_MODE_SVC:
-		case PSR_AA32_MODE_ABT:
-		case PSR_AA32_MODE_UND:
-		case PSR_AA32_MODE_SYS:
-			if (!vcpu_el1_is_32bit(vcpu))
-				return -EINVAL;
-			break;
-		case PSR_MODE_EL2h:
-		case PSR_MODE_EL2t:
-			if (!vcpu_has_nv(vcpu))
-				return -EINVAL;
-			fallthrough;
-		case PSR_MODE_EL0t:
-		case PSR_MODE_EL1t:
-		case PSR_MODE_EL1h:
-			if (vcpu_el1_is_32bit(vcpu))
-				return -EINVAL;
-			break;
-		default:
-			err = -EINVAL;
-			goto out;
-		}
-	}
-
-	memcpy(addr, valp, KVM_REG_SIZE(reg->id));
-
-	if (*vcpu_cpsr(vcpu) & PSR_MODE32_BIT) {
-		int i, nr_reg;
-
-		switch (*vcpu_cpsr(vcpu) & PSR_AA32_MODE_MASK) {
-		/*
-		 * Either we are dealing with user mode, and only the
-		 * first 15 registers (+ PC) must be narrowed to 32bit.
-		 * AArch32 r0-r14 conveniently map to AArch64 x0-x14.
-		 */
-		case PSR_AA32_MODE_USR:
-		case PSR_AA32_MODE_SYS:
-			nr_reg = 15;
-			break;
-
-		/*
-		 * Otherwise, this is a privileged mode, and *all* the
-		 * registers must be narrowed to 32bit.
-		 */
-		default:
-			nr_reg = 31;
-			break;
-		}
-
-		for (i = 0; i < nr_reg; i++)
-			vcpu_set_reg(vcpu, i, (u32)vcpu_get_reg(vcpu, i));
-
-		*vcpu_pc(vcpu) = (u32)*vcpu_pc(vcpu);
-	}
-out:
-	return err;
-}
-
 #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
 #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
 #define vq_present(vqs, vq) (!!((vqs)[vq_word(vq)] & vq_mask(vq)))
@@ -545,54 +301,6 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	return -EINVAL;
 }
 
-static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
-				 u64 __user *uindices)
-{
-	unsigned int i;
-	int n = 0;
-
-	for (i = 0; i < sizeof(struct kvm_regs) / sizeof(__u32); i++) {
-		u64 reg = KVM_REG_ARM64 | KVM_REG_ARM_CORE | i;
-		int size = core_reg_size_from_offset(vcpu, i);
-
-		if (size < 0)
-			continue;
-
-		switch (size) {
-		case sizeof(__u32):
-			reg |= KVM_REG_SIZE_U32;
-			break;
-
-		case sizeof(__u64):
-			reg |= KVM_REG_SIZE_U64;
-			break;
-
-		case sizeof(__uint128_t):
-			reg |= KVM_REG_SIZE_U128;
-			break;
-
-		default:
-			WARN_ON(1);
-			continue;
-		}
-
-		if (uindices) {
-			if (put_user(reg, uindices))
-				return -EFAULT;
-			uindices++;
-		}
-
-		n++;
-	}
-
-	return n;
-}
-
-static unsigned long num_core_regs(const struct kvm_vcpu *vcpu)
-{
-	return copy_core_reg_indices(vcpu, NULL);
-}
-
 static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
 {
 	const unsigned int slices = vcpu_sve_slices(vcpu);
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 54aedf93c78b..512912d2db9f 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -24,11 +24,11 @@
 
 #include <kvm/arm_hypercalls.h>
 
+#include <kvm/arm64/handle_exit.h>
+
 #define CREATE_TRACE_POINTS
 #include "trace_handle_exit.h"
 
-typedef int (*exit_handle_fn)(struct kvm_vcpu *);
-
 static void kvm_handle_guest_serror(struct kvm_vcpu *vcpu, u64 esr)
 {
 	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(NULL, esr))
@@ -213,17 +213,6 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
-{
-	u64 esr = kvm_vcpu_get_esr(vcpu);
-
-	kvm_pr_unimpl("Unknown exception class: esr: %#016llx -- %s\n",
-		      esr, esr_get_class_string(esr));
-
-	kvm_inject_undefined(vcpu);
-	return 1;
-}
-
 /*
  * Guest access to SVE registers should be routed to this handler only
  * when the system doesn't support SVE.
@@ -373,7 +362,7 @@ static int handle_other(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static exit_handle_fn arm_exit_handlers[] = {
+exit_handle_fn arm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
 	[ESR_ELx_EC_WFx]	= kvm_handle_wfx,
 	[ESR_ELx_EC_CP15_32]	= kvm_handle_cp15_32,
@@ -404,41 +393,6 @@ static exit_handle_fn arm_exit_handlers[] = {
 	[ESR_ELx_EC_GCS]	= kvm_handle_gcs,
 };
 
-static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
-{
-	u64 esr = kvm_vcpu_get_esr(vcpu);
-	u8 esr_ec = ESR_ELx_EC(esr);
-
-	return arm_exit_handlers[esr_ec];
-}
-
-/*
- * We may be single-stepping an emulated instruction. If the emulation
- * has been completed in the kernel, we can return to userspace with a
- * KVM_EXIT_DEBUG, otherwise userspace needs to complete its
- * emulation first.
- */
-static int handle_trap_exceptions(struct kvm_vcpu *vcpu)
-{
-	int handled;
-
-	/*
-	 * See ARM ARM B1.14.1: "Hyp traps on instructions
-	 * that fail their condition code check"
-	 */
-	if (!kvm_condition_valid(vcpu)) {
-		kvm_incr_pc(vcpu);
-		handled = 1;
-	} else {
-		exit_handle_fn exit_handler;
-
-		exit_handler = kvm_get_exit_handler(vcpu);
-		handled = exit_handler(vcpu);
-	}
-
-	return handled;
-}
-
 /*
  * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
  * proper exit to userspace.
diff --git a/arch/arm64/kvm/trace_arm.h b/arch/arm64/kvm/trace_arm.h
index 9c60f6465c78..40c656937136 100644
--- a/arch/arm64/kvm/trace_arm.h
+++ b/arch/arm64/kvm/trace_arm.h
@@ -136,31 +136,6 @@ TRACE_EVENT(kvm_mmio_emulate,
 		  __entry->vcpu_pc, __entry->instr, __entry->cpsr)
 );
 
-TRACE_EVENT(kvm_mmio_nisv,
-	TP_PROTO(unsigned long vcpu_pc, unsigned long esr,
-		 unsigned long far, unsigned long ipa),
-	TP_ARGS(vcpu_pc, esr, far, ipa),
-
-	TP_STRUCT__entry(
-		__field(	unsigned long,	vcpu_pc		)
-		__field(	unsigned long,	esr		)
-		__field(	unsigned long,	far		)
-		__field(	unsigned long,	ipa		)
-	),
-
-	TP_fast_assign(
-		__entry->vcpu_pc		= vcpu_pc;
-		__entry->esr			= esr;
-		__entry->far			= far;
-		__entry->ipa			= ipa;
-	),
-
-	TP_printk("ipa %#016lx, esr %#016lx, far %#016lx, pc %#016lx",
-		  __entry->ipa, __entry->esr,
-		  __entry->far, __entry->vcpu_pc)
-);
-
-
 TRACE_EVENT(kvm_set_way_flush,
 	    TP_PROTO(unsigned long vcpu_pc, bool cache),
 	    TP_ARGS(vcpu_pc, cache),
diff --git a/include/kvm/arm64/guest.h b/include/kvm/arm64/guest.h
index fa67d992e8fd..ac042ed71157 100644
--- a/include/kvm/arm64/guest.h
+++ b/include/kvm/arm64/guest.h
@@ -4,7 +4,10 @@
 #define __KVM_ARM64_GUEST_H__
 
 /* Implemented by virt/kvm/arm64/guest.c */
-unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
+int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+int copy_core_reg_indices(const struct kvm_vcpu *vcpu, u64 __user *uindices);
+unsigned long num_core_regs(const struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM64_GUEST_H__ */
diff --git a/include/kvm/arm64/handle_exit.h b/include/kvm/arm64/handle_exit.h
new file mode 100644
index 000000000000..9f3f41eaf3ac
--- /dev/null
+++ b/include/kvm/arm64/handle_exit.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef KVM_ARM64_HANDLE_EXIT_H
+#define KVM_ARM64_HANDLE_EXIT_H
+
+#include <linux/kvm_host.h>
+
+typedef int (*exit_handle_fn)(struct kvm_vcpu *);
+extern exit_handle_fn arm_exit_handlers[ESR_ELx_EC_MAX + 1];
+
+int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu);
+exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu);
+int handle_trap_exceptions(struct kvm_vcpu *vcpu);
+
+#endif /* KVM_ARM64_HANDLE_EXIT_H */
diff --git a/include/kvm/arm64/kvm_host.h b/include/kvm/arm64/kvm_host.h
index ef4f4d44ac39..d1eccbe44c50 100644
--- a/include/kvm/arm64/kvm_host.h
+++ b/include/kvm/arm64/kvm_host.h
@@ -28,6 +28,12 @@ struct vcpu_reset_state {
 	bool		reset;
 };
 
+/* Implemented in virt/kvm/arm64/arm.c */
+int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
+				 const struct kvm_vcpu_init *init);
+bool kvm_vcpu_init_changed(struct kvm_vcpu *vcpu,
+			   const struct kvm_vcpu_init *init);
+
 /* MMIO helpers */
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
 unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
@@ -102,4 +108,7 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 /* Unhandled SEAs are taken to userspace */
 #define KVM_ARCH_FLAG_EXIT_SEA				11
 
+/* Implemented in architecture specific code */
+unsigned long system_supported_vcpu_features(void);
+
 #endif /* __KVM_ARM64_KVM_HOST_H */
diff --git a/virt/kvm/arm64/Makefile.kvm b/virt/kvm/arm64/Makefile.kvm
new file mode 100644
index 000000000000..ac969bf1c016
--- /dev/null
+++ b/virt/kvm/arm64/Makefile.kvm
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Kernel-based Virtual Machine modules for arm64 guests
+#
+KVM_ARM64 ?= $(KVM)/arm64
+
+shared-arm64-obj := \
+	$(KVM_ARM64)/arm.o \
+	$(KVM_ARM64)/guest.o \
+	$(KVM_ARM64)/handle_exit.o \
+	$(KVM_ARM64)/mmio.o \
+
diff --git a/virt/kvm/arm64/arm.c b/virt/kvm/arm64/arm.c
new file mode 100644
index 000000000000..b47adef65e5f
--- /dev/null
+++ b/virt/kvm/arm64/arm.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/preempt.h>
+#include <linux/kvm_host.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_mmu.h>
+
+int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
+				 const struct kvm_vcpu_init *init)
+{
+	unsigned long features = init->features[0];
+	int i;
+
+	if (features & ~KVM_VCPU_VALID_FEATURES)
+		return -ENOENT;
+
+	for (i = 1; i < ARRAY_SIZE(init->features); i++) {
+		if (init->features[i])
+			return -ENOENT;
+	}
+
+	if (features & ~system_supported_vcpu_features())
+		return -EINVAL;
+
+	/*
+	 * For now make sure that both address/generic pointer authentication
+	 * features are requested by the userspace together.
+	 */
+	if (test_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, &features) !=
+	    test_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, &features))
+		return -EINVAL;
+
+	if (!test_bit(KVM_ARM_VCPU_EL1_32BIT, &features))
+		return 0;
+
+	/* MTE is incompatible with AArch32 */
+	if (kvm_has_mte(vcpu->kvm))
+		return -EINVAL;
+
+	/* NV is incompatible with AArch32 */
+	if (test_bit(KVM_ARM_VCPU_HAS_EL2, &features))
+		return -EINVAL;
+
+	return 0;
+}
+
+bool kvm_vcpu_init_changed(struct kvm_vcpu *vcpu,
+			   const struct kvm_vcpu_init *init)
+{
+	unsigned long features = init->features[0];
+
+	return !bitmap_equal(vcpu->kvm->arch.vcpu_features, &features,
+			     KVM_VCPU_MAX_FEATURES);
+}
diff --git a/virt/kvm/arm64/guest.c b/virt/kvm/arm64/guest.c
new file mode 100644
index 000000000000..83e33e0143b9
--- /dev/null
+++ b/virt/kvm/arm64/guest.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm_host.h>
+#include <linux/kvm.h>
+#include <asm/pstate.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_nested.h>
+#include <asm/sigcontext.h>
+
+#include <kvm/arm64/guest.h>
+
+static bool core_reg_offset_is_vreg(u64 off)
+{
+	return off >= KVM_REG_ARM_CORE_REG(fp_regs.vregs) &&
+		off < KVM_REG_ARM_CORE_REG(fp_regs.fpsr);
+}
+
+static u64 core_reg_offset_from_id(u64 id)
+{
+	return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
+}
+
+static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
+{
+	int size;
+
+	switch (off) {
+	case KVM_REG_ARM_CORE_REG(regs.regs[0]) ...
+	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
+	case KVM_REG_ARM_CORE_REG(regs.sp):
+	case KVM_REG_ARM_CORE_REG(regs.pc):
+	case KVM_REG_ARM_CORE_REG(regs.pstate):
+	case KVM_REG_ARM_CORE_REG(sp_el1):
+	case KVM_REG_ARM_CORE_REG(elr_el1):
+	case KVM_REG_ARM_CORE_REG(spsr[0]) ...
+	     KVM_REG_ARM_CORE_REG(spsr[KVM_NR_SPSR - 1]):
+		size = sizeof(__u64);
+		break;
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]) ...
+	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
+		size = sizeof(__uint128_t);
+		break;
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
+	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
+		size = sizeof(__u32);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (!IS_ALIGNED(off, size / sizeof(__u32)))
+		return -EINVAL;
+
+	/*
+	 * The KVM_REG_ARM64_SVE regs must be used instead of
+	 * KVM_REG_ARM_CORE for accessing the FPSIMD V-registers on
+	 * SVE-enabled vcpus:
+	 */
+	if (vcpu_has_sve(vcpu) && core_reg_offset_is_vreg(off))
+		return -EINVAL;
+
+	return size;
+}
+
+static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	u64 off = core_reg_offset_from_id(reg->id);
+	int size = core_reg_size_from_offset(vcpu, off);
+
+	if (size < 0)
+		return NULL;
+
+	if (KVM_REG_SIZE(reg->id) != size)
+		return NULL;
+
+	switch (off) {
+	case KVM_REG_ARM_CORE_REG(regs.regs[0]) ...
+	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
+		off -= KVM_REG_ARM_CORE_REG(regs.regs[0]);
+		off /= 2;
+		return &vcpu_gp_regs(vcpu)->regs[off];
+
+	case KVM_REG_ARM_CORE_REG(regs.sp):
+		return &vcpu_gp_regs(vcpu)->sp;
+
+	case KVM_REG_ARM_CORE_REG(regs.pc):
+		return vcpu_pc(vcpu);
+
+	case KVM_REG_ARM_CORE_REG(regs.pstate):
+		return &vcpu_gp_regs(vcpu)->pstate;
+
+	case KVM_REG_ARM_CORE_REG(sp_el1):
+		return __ctxt_sys_reg(&vcpu->arch.ctxt, SP_EL1);
+
+	case KVM_REG_ARM_CORE_REG(elr_el1):
+		return __ctxt_sys_reg(&vcpu->arch.ctxt, ELR_EL1);
+
+	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_EL1]):
+		return __ctxt_sys_reg(&vcpu->arch.ctxt, SPSR_EL1);
+
+	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_ABT]):
+		return &vcpu->arch.ctxt.spsr_abt;
+
+	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_UND]):
+		return &vcpu->arch.ctxt.spsr_und;
+
+	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_IRQ]):
+		return &vcpu->arch.ctxt.spsr_irq;
+
+	case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_FIQ]):
+		return &vcpu->arch.ctxt.spsr_fiq;
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]) ...
+	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
+		off -= KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]);
+		off /= 4;
+		return &vcpu->arch.ctxt.fp_regs.vregs[off];
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
+		return &vcpu->arch.ctxt.fp_regs.fpsr;
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
+		return &vcpu->arch.ctxt.fp_regs.fpcr;
+
+	default:
+		return NULL;
+	}
+}
+
+int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	/*
+	 * Because the kvm_regs structure is a mix of 32, 64 and
+	 * 128bit fields, we index it as if it was a 32bit
+	 * array. Hence below, nr_regs is the number of entries, and
+	 * off the index in the "array".
+	 */
+	__u32 __user *uaddr = (__u32 __user *)(unsigned long)reg->addr;
+	int nr_regs = sizeof(struct kvm_regs) / sizeof(__u32);
+	void *addr;
+	u32 off;
+
+	/* Our ID is an index into the kvm_regs struct. */
+	off = core_reg_offset_from_id(reg->id);
+	if (off >= nr_regs ||
+	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
+		return -ENOENT;
+
+	addr = core_reg_addr(vcpu, reg);
+	if (!addr)
+		return -EINVAL;
+
+	if (copy_to_user(uaddr, addr, KVM_REG_SIZE(reg->id)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	__u32 __user *uaddr = (__u32 __user *)(unsigned long)reg->addr;
+	int nr_regs = sizeof(struct kvm_regs) / sizeof(__u32);
+	__uint128_t tmp;
+	void *valp = &tmp, *addr;
+	u64 off;
+	int err = 0;
+
+	/* Our ID is an index into the kvm_regs struct. */
+	off = core_reg_offset_from_id(reg->id);
+	if (off >= nr_regs ||
+	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
+		return -ENOENT;
+
+	addr = core_reg_addr(vcpu, reg);
+	if (!addr)
+		return -EINVAL;
+
+	if (KVM_REG_SIZE(reg->id) > sizeof(tmp))
+		return -EINVAL;
+
+	if (copy_from_user(valp, uaddr, KVM_REG_SIZE(reg->id))) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	if (off == KVM_REG_ARM_CORE_REG(regs.pstate)) {
+		u64 mode = (*(u64 *)valp) & PSR_AA32_MODE_MASK;
+
+		switch (mode) {
+		case PSR_AA32_MODE_USR:
+			if (!kvm_supports_32bit_el0())
+				return -EINVAL;
+			break;
+		case PSR_AA32_MODE_FIQ:
+		case PSR_AA32_MODE_IRQ:
+		case PSR_AA32_MODE_SVC:
+		case PSR_AA32_MODE_ABT:
+		case PSR_AA32_MODE_UND:
+		case PSR_AA32_MODE_SYS:
+			if (!vcpu_el1_is_32bit(vcpu))
+				return -EINVAL;
+			break;
+		case PSR_MODE_EL2h:
+		case PSR_MODE_EL2t:
+			if (!vcpu_has_nv(vcpu))
+				return -EINVAL;
+			fallthrough;
+		case PSR_MODE_EL0t:
+		case PSR_MODE_EL1t:
+		case PSR_MODE_EL1h:
+			if (vcpu_el1_is_32bit(vcpu))
+				return -EINVAL;
+			break;
+		default:
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	memcpy(addr, valp, KVM_REG_SIZE(reg->id));
+
+	if (*vcpu_cpsr(vcpu) & PSR_MODE32_BIT) {
+		int i, nr_reg;
+
+		switch (*vcpu_cpsr(vcpu) & PSR_AA32_MODE_MASK) {
+		/*
+		 * Either we are dealing with user mode, and only the
+		 * first 15 registers (+ PC) must be narrowed to 32bit.
+		 * AArch32 r0-r14 conveniently map to AArch64 x0-x14.
+		 */
+		case PSR_AA32_MODE_USR:
+		case PSR_AA32_MODE_SYS:
+			nr_reg = 15;
+			break;
+
+		/*
+		 * Otherwise, this is a privileged mode, and *all* the
+		 * registers must be narrowed to 32bit.
+		 */
+		default:
+			nr_reg = 31;
+			break;
+		}
+
+		for (i = 0; i < nr_reg; i++)
+			vcpu_set_reg(vcpu, i, (u32)vcpu_get_reg(vcpu, i));
+
+		*vcpu_pc(vcpu) = (u32)*vcpu_pc(vcpu);
+	}
+out:
+	return err;
+}
+
+int copy_core_reg_indices(const struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	unsigned int i;
+	int n = 0;
+
+	for (i = 0; i < sizeof(struct kvm_regs) / sizeof(__u32); i++) {
+		u64 reg = KVM_REG_ARM64 | KVM_REG_ARM_CORE | i;
+		int size = core_reg_size_from_offset(vcpu, i);
+
+		if (size < 0)
+			continue;
+
+		switch (size) {
+		case sizeof(__u32):
+			reg |= KVM_REG_SIZE_U32;
+			break;
+
+		case sizeof(__u64):
+			reg |= KVM_REG_SIZE_U64;
+			break;
+
+		case sizeof(__uint128_t):
+			reg |= KVM_REG_SIZE_U128;
+			break;
+
+		default:
+			WARN_ON(1);
+			continue;
+		}
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+
+		n++;
+	}
+
+	return n;
+}
+
+unsigned long num_core_regs(const struct kvm_vcpu *vcpu)
+{
+	return copy_core_reg_indices(vcpu, NULL);
+}
diff --git a/virt/kvm/arm64/handle_exit.c b/virt/kvm/arm64/handle_exit.c
new file mode 100644
index 000000000000..7c2eff026d08
--- /dev/null
+++ b/virt/kvm/arm64/handle_exit.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm_host.h>
+
+#include <asm/esr.h>
+#include <asm/kvm_emulate.h>
+
+#include <kvm/arm64/handle_exit.h>
+
+int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
+{
+	u64 esr = kvm_vcpu_get_esr(vcpu);
+
+	kvm_pr_unimpl("Unknown exception class: esr: %#016llx -- %s\n",
+		      esr, esr_get_class_string(esr));
+
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
+{
+	u64 esr = kvm_vcpu_get_esr(vcpu);
+	u8 esr_ec = ESR_ELx_EC(esr);
+
+	return arm_exit_handlers[esr_ec];
+}
+
+/*
+ * We may be single-stepping an emulated instruction. If the emulation
+ * has been completed in the kernel, we can return to userspace with a
+ * KVM_EXIT_DEBUG, otherwise userspace needs to complete its
+ * emulation first.
+ */
+int handle_trap_exceptions(struct kvm_vcpu *vcpu)
+{
+	int handled;
+
+	/*
+	 * See ARM ARM B1.14.1: "Hyp traps on instructions
+	 * that fail their condition code check"
+	 */
+	if (!kvm_condition_valid(vcpu)) {
+		kvm_incr_pc(vcpu);
+		handled = 1;
+	} else {
+		exit_handle_fn exit_handler;
+
+		exit_handler = kvm_get_exit_handler(vcpu);
+		handled = exit_handler(vcpu);
+	}
+
+	return handled;
+}
diff --git a/arch/arm64/kvm/mmio.c b/virt/kvm/arm64/mmio.c
similarity index 99%
rename from arch/arm64/kvm/mmio.c
rename to virt/kvm/arm64/mmio.c
index e2285ed8c91d..438a554ec1ed 100644
--- a/arch/arm64/kvm/mmio.c
+++ b/virt/kvm/arm64/mmio.c
@@ -8,6 +8,7 @@
 #include <asm/kvm_emulate.h>
 #include <trace/events/kvm.h>
 
+#define CREATE_TRACE_POINTS
 #include "trace.h"
 
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data)
diff --git a/virt/kvm/arm64/trace.h b/virt/kvm/arm64/trace.h
new file mode 100644
index 000000000000..0814000b7749
--- /dev/null
+++ b/virt/kvm/arm64/trace.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#if !defined(__KVM_ARM64_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
+#define __KVM_ARM64_TRACE_H__
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../virt/kvm/arm64
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(kvm_mmio_nisv,
+	TP_PROTO(unsigned long vcpu_pc, unsigned long esr,
+		 unsigned long far, unsigned long ipa),
+	TP_ARGS(vcpu_pc, esr, far, ipa),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	vcpu_pc		)
+		__field(	unsigned long,	esr		)
+		__field(	unsigned long,	far		)
+		__field(	unsigned long,	ipa		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc		= vcpu_pc;
+		__entry->esr			= esr;
+		__entry->far			= far;
+		__entry->ipa			= ipa;
+	),
+
+	TP_printk("ipa %#016lx, esr %#016lx, far %#016lx, pc %#016lx",
+		  __entry->ipa, __entry->esr,
+		  __entry->far, __entry->vcpu_pc)
+);
+
+#endif /* __KVM_ARM64_TRACE_H__ */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.53.0

