Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981342;
	b=0Mve6g+w6X6HPWHaJ1FQkhpp3TNnJ2EwfwZnzInjhg8B1/lc47t2f8CF/rijGOcsLzjc
	 WQMNjXanBfpXQ+aYvU417bXqhoizyA1aFCoUfLJ9cVUYdzVaFKqawQy/P9/tsSCoBcMCI
	 JD0dsxlZB0OIXQsK+rYBkHjiDXmv8S1i+p5WS6odwz12sRQH29MC/gkAhlPaY9AGsMi0i
	 7iRcGg1m2093ys/vwgJUUqYNuFE1eah7hP6JNIcbZP67LdI8N5axaJ7QFJjLcZWlwKxzx
	 sb2ODceyQoI21SsHQ9cbHyGJn9cIDC2sKbC54XPdY1SUnKrZTAgmny7KQeMGYyDc6Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981342;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=adbfHST+aOaKOV4p2WQmNGUBDTlMlQMrMglqJwoLH5Y=;
	b=PqHNeERTHSyZKVhZiLe9Lt3KvFJuctC26GPGE2KqvnmzCff9to3YbQ/Ue/eFA1mDGMxO
	 jsP8Rmce3XUSN5R78MYuZs0okvac3qMcZJmWrdPai0vxF/KXZkSN2ylHQ3Cyt2oUesHET
	 MSJfjr+xq6wd7AjDJQyZo9A/Uz+A+uQBICgn1I1b1BmZABOtWmR6eR+J3ZTQZx9dtxE8O
	 AyfghfD3E1OU4AOmprkDBkLop2fiSr970YPPIbTZ7h4kl4ViW6l9X2zIc1xYcG3fQYLKW
	 IBkZKTJgP88umxspPPHsp6qB9J1GOekgr+kh914ye9+DQ1GMlamaCLjHil3nTqo8nmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NMzNqY9T;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4F60A381F;
	Fri,  6 Nov 2026 16:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EE4F60A381F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NMzNqY9T
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEBGh2656386;
	Fri, 6 Nov 2026 16:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=adbfHS
	T+aOaKOV4p2WQmNGUBDTlMlQMrMglqJwoLH5Y=; b=NMzNqY9TLec/TCzrY1lMPQ
	Z/gPpqzRWU9Vhfng0cy6A7ipOA15PK5bbScf4fEsC98tcBDfWg6KJCMySJnPBDJr
	/H9Cp2y53RnIaOcj4WroOHF7VUFEh44I011DB3blmxgs6srGtBEWS+o3L1UcFMN9
	kbO19PcInvrqBn8TCZvS5Y3gK2U0f23vOIB4ABYg0+ICnrI2brkiA9R0SgjLrdfe
	26v2iIh7kjLtPhJXyl4PrukesBBInC1ZyNTXD+KO4xgKrVOUBvpEfx3c/NNYsnei
	GriLn9NsDj6l5hFGd00lAQp8f3cAeX+QEE/I6CwG/zoVKNKh4LgWH7hbWZNKVf0Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc5ety-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4sGx3476029;
	Fri, 6 Nov 2026 16:08:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmress0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8Kdw41812234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 907A820067;
	Fri,  6 Nov 2026 16:08:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20A7720063;
	Fri,  6 Nov 2026 16:08:20 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:20 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:49 +0100
Subject: [PATCH v3 16/23] KVM: s390: arm64: Implement arm sysreg managing
 infrastructure
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
Message-Id: <20261106-sysreg-v3-16-75e95980fb10@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfXyeCBKMewpKXe
 NhlMwUEWKu8ZrPQm+8/1qw+MVlzrvXHFV6D9IinFrXhiKSMeWNEMd7v5uUqkLwN1yQzW/UAUSK7
 MCNdgXQ+UfoP8r3IYmrKOKuyEeXrnxk=
X-Proofpoint-GUID: oPhYjjpmNbeEZhykmkFlCxVEHqQnp5qI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX3b+YCntKFm2Y
 jQs2Rc2qp4fXLL0PXJEKV1iX3gnU/WL+wduJuLKaQDh4EtqvdrbeCgEUonA2G4crkOhQdckeSG4
 aSez9zo5oXRoDnTkGaecI7Yosf8WgJLEW1fTft+45LavCQrubgup92k07Y3IWTd7bLagX7EAPxM
 /fyEmRYP7GnOTJa6blXzooT0divb9kpDd4a2eYDpdPior/EQ4hmTUWO8XibmzHLx9UwMCw8KbMY
 tqD45dSDeVyhlHIKFelHIqk4ENdWAkDafZND8RBY+C8Advp6MbnIIp6+KCn7YCUePuONOiC5p7T
 KMsRThSrV0SIsizG4uDzCeJM91MNWlrAq8Fmv6KccP7BgJ7ANoFdeT43/7I5gTbBMDqyhKfjzJ4
 cAScXld3t6N9JwJGn4hcS8TC5LEQMqcMIDOgn6lEl/U1vmr2PyXl03+Y7uTiGdoICmL046bGGQO
 sde/xkmSQRmMD/f53sQ==
X-Proofpoint-ORIG-GUID: oPhYjjpmNbeEZhykmkFlCxVEHqQnp5qI
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aedfb79 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=nBs_sfs49TsxDi_5ZZ8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

Implement the infrastructures for the s390 host to read and write the
arm64 guest system register. The host can access and modify (non-id)
system registers through the new instructions EASR/SASR or their
multiple variant. Guest accesses to ID registers are trapped and handled
by KVM. KVM gets the data form the result of QAAF and sanitizes it using
the shared infrastructure with arm64.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/arm64/kvm_hyp.h      |  18 +
 arch/s390/include/arm64/kvm_nested.h   |   5 +
 arch/s390/include/arm64/sys_regs.h     |   9 +
 arch/s390/include/asm/kvm_host_arm64.h | 205 ++++++++-
 arch/s390/kvm/arm64/Makefile           |   4 +-
 arch/s390/kvm/arm64/Makefile.gen       |   3 +-
 arch/s390/kvm/arm64/spectre.c          |  51 +++
 arch/s390/kvm/arm64/sys_regs.c         | 815 +++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/trace.h            |  50 ++
 arch/s390/tools/Makefile.arm64h        |   4 +
 10 files changed, 1161 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/arm64/kvm_hyp.h b/arch/s390/include/arm64/kvm_hyp.h
new file mode 100644
index 000000000000..e425b7c3c80d
--- /dev/null
+++ b/arch/s390/include/arm64/kvm_hyp.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __S390_ARM64_KVM_HYP_H__
+#define __S390_ARM64_KVM_HYP_H__
+
+#include <linux/compiler.h>
+
+static __always_inline bool has_vhe(void)
+{
+	return true;
+}
+
+static __always_inline bool is_protected_kvm_enabled(void)
+{
+	return false;
+}
+
+#endif /* __S390_ARM64_KVM_HYP_H__ */
diff --git a/arch/s390/include/arm64/kvm_nested.h b/arch/s390/include/arm64/kvm_nested.h
index e950b1a10c41..9c02ac5c62cc 100644
--- a/arch/s390/include/arm64/kvm_nested.h
+++ b/arch/s390/include/arm64/kvm_nested.h
@@ -8,4 +8,9 @@ static inline bool vcpu_has_nv(const struct kvm_vcpu *vcpu)
 	return false;
 }
 
+static inline u64 limit_nv_id_reg(struct kvm *kvm, u32 id, u64 val)
+{
+	return val;
+}
+
 #endif /* ASM_KVM_NESTED_H */
diff --git a/arch/s390/include/arm64/sys_regs.h b/arch/s390/include/arm64/sys_regs.h
new file mode 100644
index 000000000000..dafb090ee1af
--- /dev/null
+++ b/arch/s390/include/arm64/sys_regs.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __S390_ARM64_SYS_REGS_H__
+#define __S390_ARM64_SYS_REGS_H__
+
+#include <arm64/cputype.h>
+#include <arm64/sys_regs-gen.h>
+
+#endif /* __S390_ARM64_SYS_REGS_H__ */
diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 9afe37f6696c..35b6d8972359 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -3,6 +3,7 @@
 #define ASM_KVM_HOST_ARM64_H
 
 #include <linux/bug.h>
+#include <linux/bitfield.h>
 
 #include <asm/kvm_host_types.h>
 #include <asm/debug.h>
@@ -10,6 +11,7 @@
 #define vcpu_gp_regs(v)		((v)->arch.sae_block.gpr)
 enum vcpu_sysreg;
 
+#include <arm64/cputype.h>
 #include <arm64/kvm_host.h>
 #include <arm64/ptrace.h>
 
@@ -41,7 +43,12 @@ bool cpus_have_final_cap(unsigned int num);
 #define KVM_IRQCHIP_NUM_PINS 1
 #define irqchip_in_kernel(_k) false
 
-#define __ctxt_sys_reg(ctx, reg) NULL
+#define __ctxt_sys_reg(ctx, reg)					\
+	({								\
+		BUILD_BUG_ON(!__builtin_constant_p(reg));		\
+		___ctxt_sys_reg(ctx, reg);				\
+	})
+
 struct kvm_cpu_context {
 	/*
 	 * These are just for 32 bit, which we don't have, making them RES0.
@@ -53,6 +60,10 @@ struct kvm_cpu_context {
 	u64	spsr_fiq;
 
 	__vector128 __aligned(16) vregs[32];
+
+	/* shadowed sysregs to comply with arm64 infrastructure */
+	u64 elr_el1;
+	u64 spsr_el1;
 };
 
 struct kvm_vcpu_arch {
@@ -60,10 +71,19 @@ struct kvm_vcpu_arch {
 	struct kvm_sae_save_area save_area;
 	struct kvm_cpu_context ctxt;
 
+	/* Guest system registers not part of save area or ID registers */
+	u64 sys_reg_clidr_el1;
+	u64 sys_reg_csselr_el1;
+	/* Per-vcpu CCSIDR override or NULL */
+	u32 *ccsidr;
+
 	u32 host_acrs[NUM_ACRS];
 
 	/* Hypervisor Configuration Register */
 	u64 hcr_el2;
+	u64 hcrx_el2;
+
+	u64 mpidr;
 
 	/* Configuration flags, set once and for all before the vcpu can run */
 	u8 cflags;
@@ -113,6 +133,9 @@ struct kvm_vcpu_stat {
 #define vcpu_has_sve(_vcpu) false
 #define vcpu_has_ptrauth(_vcpu) false
 
+#define kvm_has_fpmr(kvm) \
+	 kvm_has_feat((kvm), ID_AA64PFR2_EL1, FPMR, IMP)
+
 struct kvm_arch_memory_slot {
 };
 
@@ -131,6 +154,9 @@ struct kvm_arch {
 	DECLARE_BITMAP(vcpu_features, KVM_VCPU_MAX_FEATURES);
 
 	unsigned long mem_limit;
+
+	/* Per-VM ID register storage */
+	struct kvm_vm_id_regs id_regs;
 };
 
 static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
@@ -219,4 +245,181 @@ static inline void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)
 
 #define kvm_supports_32bit_el0() false
 
+#define __vcpu_sys_reg(__vcpu, __reg) \
+	vcpu_read_sys_reg(__vcpu, __reg)
+
+#define __vcpu_assign_sys_reg(__vcpu, __reg, __val) \
+	vcpu_write_sys_reg(__vcpu, __val, __reg)
+
+#define __vcpu_rmw_sys_reg(v, r, op, val)				\
+	do {								\
+		u64 __v = vcpu_read_sys_reg(v, r);			\
+		__v op (val);						\
+		vcpu_write_sys_reg(v, __v, r);				\
+	} while (0)
+
+/**
+ * _vcpu_read_sys_reg() - read a guest sysreg with easr
+ * @C: vcpu to read from; if loaded, may only be called from its own thread
+ * @R: sysreg id; must be readable by easr; must be compile time constant
+ *
+ *   if SYSREGS_ON_CPU: proceed with flags = 0
+ *   otherwise:         proceed with flags = EASR_FLAG_SA
+ *
+ */
+#define _vcpu_read_sys_reg(C, R) \
+	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
+		KVM_BUG_ON(vcpu_is_loaded(C) && smp_processor_id() != (C)->cpu, (C)->kvm); \
+		(vcpu_is_loaded(C)) \
+			? __vcpu_read_sr((C), (R), 0) \
+			: __vcpu_read_sr((C), (R), EASR_FLAG_SA); })
+
+/**
+ * _vcpu_write_sys_reg() - write a guest sysreg with sasr
+ *
+ * @C: vcpu to write to; if loaded, may only be called from its own thread
+ * @V: value to write
+ * @R: sysreg id; must be writable by sasr; must be compile time constant
+
+ *   if SYSREGS_ON_CPU: proceed with flags = 0
+ *   otherwise:         proceed with flags = SASR_FLAG_INITIALIZED
+ */
+#define _vcpu_write_sys_reg(C, V, R) \
+	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
+		KVM_BUG_ON(vcpu_is_loaded(C) && smp_processor_id() != (C)->cpu, (C)->kvm); \
+		(vcpu_is_loaded(C)) \
+			? __vcpu_write_sr((C), (V), (R), 0) \
+			: __vcpu_write_sr((C), (V), (R), SASR_FLAG_INITIALIZED); })
+
+#define __vcpu_read_sr(C, R, F) \
+	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
+		BUILD_BUG_ON(!__builtin_constant_p((F))); \
+		easr((R), &(C)->arch.save_area, (F)); })
+
+#define __vcpu_write_sr(C, V, R, F) \
+	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
+		BUILD_BUG_ON(!__builtin_constant_p((F))); \
+		sasr((R), (V), &(C)->arch.save_area, (F)); })
+
+#define SR_GROUP(NAME, ...)	\
+	__##NAME##_BEGIN__, __after_##NAME##_BEGIN__ = __##NAME##_BEGIN__ - 1,	\
+	__VA_ARGS__								\
+	__##NAME##_END__, __after_##NAME##_END__ = __##NAME##_END__ - 1
+
+/** enum vcpu_sysreg - available guest sysregs
+ *
+ * Contains all arm64 guest-system register supported by s390.
+ */
+enum vcpu_sysreg {
+	__INVALID_SYSREG__, /* 0 is reserved as an invalid value */
+
+	/* EL 0,1 Register from state description in order of appearance */
+	SR_GROUP(STATE_DESC,
+	CNTP_CTL_EL0,
+	CNTV_CTL_EL0,
+	CONTEXTIDR_EL1,
+	SP_EL1,
+	),
+
+	/* EL 0,1 Register requiring special handling. */
+	SR_GROUP(SPECIAL,
+	CSSELR_EL1,
+	CLIDR_EL1,
+	MPIDR_EL1,
+	ELR_EL1,
+	SPSR_EL1,
+	),
+
+	/* EL 0,1 register from save area in order of appearance */
+	SR_GROUP(SAVE_AREA,
+	ACTLR_EL1,
+	AFSR0_EL1,
+	AFSR1_EL1,
+	CNTFRQ_EL0,
+	CNTP_CVAL_EL0,
+	CNTV_CVAL_EL0,
+	DISR_EL1,
+	MIDR_EL1,
+	OSLSR_EL1,
+	PAR_EL1,
+	OSLAR_EL1,
+	SCTLR_EL1,
+	CPACR_EL1,
+	VBAR_EL1,
+	ESR_EL1,
+	TCR_EL1,
+	MAIR_EL1,
+	TTBR0_EL1,
+	TTBR1_EL1,
+	FAR_EL1,
+	TPIDR_EL0,
+	TPIDR_EL1,
+	TPIDRRO_EL0,
+	CNTKCTL_EL1,
+	ZCR_EL1,
+	SCXTNUM_EL0,
+	SCXTNUM_EL1,
+	APIBKEYLO_EL1,
+	APIBKEYHI_EL1,
+	APIAKEYLO_EL1,
+	APIAKEYHI_EL1,
+	APGAKEYLO_EL1,
+	APGAKEYHI_EL1,
+	APDBKEYLO_EL1,
+	APDBKEYHI_EL1,
+	APDAKEYLO_EL1,
+	APDAKEYHI_EL1,
+	MDSCR_EL1,
+	),
+
+	NR_SYS_REGS /* Nothing after this line! */
+};
+
+static __always_inline u64 *___ctxt_sys_reg(struct kvm_cpu_context *ctxt,
+					    const enum vcpu_sysreg reg)
+{
+	switch (reg) {
+	case ELR_EL1:
+		return &ctxt->elr_el1;
+	case SPSR_EL1:
+		return &ctxt->spsr_el1;
+	default:
+		BUG();
+		break;
+	}
+}
+
+void vcpu_write_host_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg);
+u64 vcpu_read_host_sys_reg(const struct kvm_vcpu *vcpu, int reg);
+
+#define kvm_debug_handle_oslar(_v, _val) /* debug not implemented yet*/
+
+#define kvm_vm_has_ran_once(kvm)					\
+	(test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &(kvm)->arch.flags))
+
+#define kvm_id_regs_final(kvm)						\
+	test_bit(KVM_ARCH_FLAG_ID_REGS_FINAL, &(kvm)->arch.flags)
+
+static inline u8 kvm_arm_pmu_get_pmuver_limit(void)
+{
+	return 0;
+}
+
+int __init kvm_sys_reg_table_init(void);
+
+static inline bool system_supports_poe(void)
+{
+	return false;
+}
+
+static inline bool vgic_host_has_gicv3(void)
+{
+	return false;
+}
+
+static inline bool vgic_host_has_gicv5(void)
+{
+	return false;
+}
+
 #endif /* ASM_KVM_HOST_ARM64_H */
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index e75b38071f8a..24ac6f6f6278 100644
--- a/arch/s390/kvm/arm64/Makefile
+++ b/arch/s390/kvm/arm64/Makefile
@@ -18,7 +18,9 @@ kvm-arm64-local := \
 	mmio.o \
 	mmu.o \
 	qaaf.o \
-	reset.o
+	reset.o \
+	spectre.o \
+	sys_regs.o
 
 kvm-arm64-obj := $(kvm-arm64-local)
 kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(kvm-y))
diff --git a/arch/s390/kvm/arm64/Makefile.gen b/arch/s390/kvm/arm64/Makefile.gen
index 9c33b068fab5..6c62ac412d57 100644
--- a/arch/s390/kvm/arm64/Makefile.gen
+++ b/arch/s390/kvm/arm64/Makefile.gen
@@ -7,7 +7,8 @@
 ARM64_CFILES := \
 	arm.c \
 	guest.c \
-	mmio.c
+	mmio.c \
+	sys_regs.c
 
 quiet_cmd_extract_inc = GEN     $@
       cmd_extract_inc = mkdir -p $(dir $@); \
diff --git a/arch/s390/kvm/arm64/spectre.c b/arch/s390/kvm/arm64/spectre.c
new file mode 100644
index 000000000000..d32b40b9f1bd
--- /dev/null
+++ b/arch/s390/kvm/arm64/spectre.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <arm64/spectre.h>
+#include <arm64/sysreg.h>
+
+#include "feature.h"
+
+enum mitigation_state arm64_get_spectre_v2_state(void)
+{
+	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+	enum mitigation_state ms = SPECTRE_VULNERABLE;
+
+	if (SYS_FIELD_GET(ID_AA64PFR0_EL1, CSV2, pfr0) >= ID_AA64PFR0_EL1_CSV2_IMP)
+		ms = SPECTRE_UNAFFECTED;
+
+	return ms;
+}
+
+enum mitigation_state arm64_get_meltdown_state(void)
+{
+	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+	enum mitigation_state ms = SPECTRE_VULNERABLE;
+
+	if (SYS_FIELD_GET(ID_AA64PFR0_EL1, CSV3, pfr0) >= ID_AA64PFR0_EL1_CSV3_IMP)
+		ms = SPECTRE_UNAFFECTED;
+
+	return ms;
+}
+
+enum mitigation_state arm64_get_spectre_v4_state(void)
+{
+	u64 pfr1 = read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);
+	/* TODO: assuming the core is affected by spectre v4 */
+	enum mitigation_state ms = SPECTRE_VULNERABLE;
+
+	if (SYS_FIELD_GET(ID_AA64PFR1_EL1, SSBS, pfr1) >= ID_AA64PFR1_EL1_SSBS_IMP)
+		ms = SPECTRE_MITIGATED;
+
+	return ms;
+}
+
+enum mitigation_state arm64_get_spectre_bhb_state(void)
+{
+	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+	enum mitigation_state ms = SPECTRE_VULNERABLE;
+
+	if (SYS_FIELD_GET(ID_AA64PFR0_EL1, CSV2, pfr0) >= ID_AA64PFR0_EL1_CSV2_CSV2_3)
+		ms = SPECTRE_UNAFFECTED;
+
+	return ms;
+}
diff --git a/arch/s390/kvm/arm64/sys_regs.c b/arch/s390/kvm/arm64/sys_regs.c
new file mode 100644
index 000000000000..b1d4335779c7
--- /dev/null
+++ b/arch/s390/kvm/arm64/sys_regs.c
@@ -0,0 +1,815 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm_host.h>
+#include <linux/printk.h>
+#include <linux/cpumask.h>
+
+#include <arm64/kvm_emulate.h>
+#include <arm64/sys_regs.h>
+#include <arm64/sysreg.h>
+#include <arm64/cputype.h>
+#include <arm64/cache.h>
+#include <arm64/kvm_nested.h>
+#include <arm64/spectre.h>
+#include <arm64/kvm_hyp.h>
+
+#include "feature.h"
+
+#include <kvm/arm_arch_timer.h>
+
+#include "trace.h"
+
+static int arm64_check_features(struct kvm_vcpu *vcpu,
+				const struct sys_reg_desc *rd, u64 val);
+static const struct sys_reg_desc sys_reg_descs[];
+static const size_t num_sys_reg_descs;
+static u64 __ro_after_init boot_cpu_midr_val;
+static u64 __ro_after_init boot_cpu_revidr_val;
+static u64 __ro_after_init boot_cpu_aidr_val;
+
+#define __INCL_GEN_ARM_FILE
+#include "generated/sys_regs.inc"
+#undef __INCL_GEN_ARM_FILE
+
+DEFINE_STATIC_KEY_FALSE(broken_cntvoff_key);
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
+#define SREG_RANGE(NAME) __##NAME##_BEGIN__ ... __##NAME##_END__ - 1
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
+	case ELR_EL1:		return vcpu->arch.ctxt.elr_el1;
+	case SPSR_EL1:		return vcpu->arch.ctxt.spsr_el1;
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
+	case CNTP_CTL_EL0:	vcpu->arch.sae_block.cntp_ctl = val;		break;
+	case CNTV_CTL_EL0:	vcpu->arch.sae_block.cntv_ctl = val;		break;
+	case CONTEXTIDR_EL1:	vcpu->arch.sae_block.contextidr_el1 = val;	break;
+	case SP_EL1:		vcpu->arch.sae_block.sp_el1 = val;		break;
+	case ELR_EL1:		vcpu->arch.ctxt.elr_el1 = val;			break;
+	case SPSR_EL1:		vcpu->arch.ctxt.spsr_el1 = val;			break;
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
+static int arm64_check_features(struct kvm_vcpu *vcpu,
+				const struct sys_reg_desc *rd, u64 val)
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
+	host_val = read_sanitised_ftr_reg(id);
+
+	switch (id) {
+	case SYS_ID_AA64MMFR0_EL1:
+		/* Forbid PARANGE values larger than the host supports */
+		if (SYS_FIELD_GET(ID_AA64MMFR0_EL1, PARANGE, val) >
+		    SYS_FIELD_GET(ID_AA64MMFR0_EL1, PARANGE, host_val))
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
+static void init_imp_id_regs(void)
+{
+	boot_cpu_midr_val = read_sanitised_ftr_reg(SYS_MIDR_EL1);
+	boot_cpu_revidr_val = read_sanitised_ftr_reg(SYS_REVIDR_EL1);
+	boot_cpu_aidr_val = read_sanitised_ftr_reg(SYS_AIDR_EL1);
+}
+
+static bool access_imp_id_reg(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			      const struct sys_reg_desc *r)
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
+		/* No historical ABI to preserve here */
+		p->regval = boot_cpu_revidr_val;
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
+static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+			 u64 val)
+{
+	u64 oslk;
+
+	/*
+	 * The only modifiable bit is the OSLK bit. Refuse the write if
+	 * userspace attempts to change any other bit in the register.
+	 */
+	if ((val ^ rd->val) & ~OSLSR_EL1_OSLK)
+		return -EINVAL;
+
+	/*
+	 * Redirect the write to the proper control register.
+	 * OSLSR is read-only
+	 */
+	oslk = SYS_FIELD_GET(OSLSR_EL1, OSLK, val);
+	__vcpu_assign_sys_reg(vcpu, OSLAR_EL1, SYS_FIELD_PREP(OSLAR_EL1, OSLK, oslk));
+	return 0;
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
+static int set_cntfrq(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd, u64 val)
+{
+	/*
+	 * reject the write if it disagrees with our view of CNTFRQ_EL0
+	 */
+	if (val != read_sanitised_ftr_reg(SYS_CNTFRQ_EL0))
+		return -EINVAL;
+	return 0;
+}
+
+static u64 reset_cntfrq(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	u64 cntfrq = read_sanitised_ftr_reg(SYS_CNTFRQ_EL0);
+
+	_vcpu_write_sys_reg(vcpu, cntfrq, SYS_CNTFRQ_EL0);
+	return cntfrq;
+}
+
+static int arch_timer_set_user(struct kvm_vcpu *vcpu,
+			       const struct sys_reg_desc *rd,
+			       u64 val)
+{
+	u64 gpto;
+
+	switch (reg_to_encoding(rd)) {
+	/* PTFF knows only one SAE guest counter offset */
+	case SYS_CNTVCT_EL0:
+	case SYS_CNTPCT_EL0:
+		gpto = ptff_qagto(val);
+		vcpu->arch.sae_block.gpto = gpto;
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
+	/* PTFF knows only one SAE guest counter offset */
+	case SYS_CNTVCT_EL0:
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
+#define GUEST_TIMER_REG(name) { \
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
+	{ SYS_DESC(SYS_MDSCR_EL1), access_rw, reset_val, MDSCR_EL1, 0 },
+	{ SYS_DESC(SYS_OSLAR_EL1), trap_oslar_el1 },
+	{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1, reset_oslsr_el1, OSLSR_EL1,
+	  OSLSR_EL1_OSLM_IMP, NULL, set_oslsr_el1 },
+
+	/* Op0 = 3 */
+	/* Op1 = 0 */
+	/* CRn = 0 */
+	/* CRm = 0 */
+
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
+	ID_FILTERED(ID_AA64PFR1_EL1, id_aa64pfr1_el1,
+		    ~(ID_AA64PFR1_EL1_PFAR | ID_AA64PFR1_EL1_DF2 |
+		      ID_AA64PFR1_EL1_MTEX | ID_AA64PFR1_EL1_THE |
+		      ID_AA64PFR1_EL1_GCS | ID_AA64PFR1_EL1_MTE_frac |
+		      ID_AA64PFR1_EL1_NMI | ID_AA64PFR1_EL1_RNDR_trap |
+		      ID_AA64PFR1_EL1_SME | ID_AA64PFR1_EL1_RES0 |
+		      ID_AA64PFR1_EL1_MPAM_frac | ID_AA64PFR1_EL1_RAS_frac |
+		      ID_AA64PFR1_EL1_MTE)),
+	ID_FILTERED(ID_AA64PFR2_EL1, id_aa64pfr2_el1,
+		    (ID_AA64PFR2_EL1_FPMR		|
+		     ID_AA64PFR2_EL1_MTEFAR		|
+		     ID_AA64PFR2_EL1_MTESTOREONLY	|
+		     ID_AA64PFR2_EL1_GCIE)),
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
+	ID_FILTERED(ID_AA64MMFR2_EL1, id_aa64mmfr2_el1,
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
+	{ SYS_DESC(SYS_ACTLR_EL1), access_rw, reset_val, ACTLR_EL1, 0 },
+	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
+	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0,
+	  .visibility = sve_visibility },
+
+	/* CRn = 2 */
+	{ SYS_DESC(SYS_TTBR0_EL1), access_rw, reset_val, TTBR0_EL1, 0 },
+	{ SYS_DESC(SYS_TTBR1_EL1), access_rw, reset_val, TTBR1_EL1, 0 },
+	{ SYS_DESC(SYS_TCR_EL1), access_rw, reset_val, TCR_EL1, 0 },
+
+	/* CRn = 5 */
+	{ SYS_DESC(SYS_AFSR0_EL1), access_rw, reset_unknown, AFSR0_EL1 },
+	{ SYS_DESC(SYS_AFSR1_EL1), access_rw, reset_unknown, AFSR1_EL1 },
+	{ SYS_DESC(SYS_ESR_EL1), access_rw, reset_unknown, ESR_EL1 },
+	/* CRn = 6 */
+	{ SYS_DESC(SYS_FAR_EL1), access_rw, reset_unknown, FAR_EL1 },
+	/* CRn = 7 */
+	{ SYS_DESC(SYS_PAR_EL1), access_rw, reset_unknown, PAR_EL1 },
+
+	{ SYS_DESC(SYS_PMMIR_EL1), trap_raz_wi },
+	/* CRn = 10 */
+	{ SYS_DESC(SYS_MAIR_EL1), NULL, reset_unknown, MAIR_EL1 },
+	{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LOREA_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LORN_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LORC_EL1), trap_loregion },
+	{ SYS_DESC(SYS_LORID_EL1), trap_loregion },
+
+	/* CRn = 12 */
+	{ SYS_DESC(SYS_VBAR_EL1), access_rw, reset_val, VBAR_EL1, 0 },
+
+	/* CRn = 13 */
+	{ SYS_DESC(SYS_CONTEXTIDR_EL1), access_rw, reset_val, CONTEXTIDR_EL1, 0 },
+	{ SYS_DESC(SYS_TPIDR_EL1), NULL, reset_unknown, TPIDR_EL1 },
+	{ SYS_DESC(SYS_SCXTNUM_EL1), access_rw, reset_unknown, SCXTNUM_EL1 },
+
+	/* CRn = 14 */
+	{ SYS_DESC(SYS_CNTKCTL_EL1), access_rw, reset_val, CNTKCTL_EL1, 0 },
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
+	/* Op1 = 3 */
+	/* CRn = 13 */
+	{ SYS_DESC(SYS_TPIDR_EL0), access_rw, reset_unknown, TPIDR_EL0 },
+	{ SYS_DESC(SYS_TPIDRRO_EL0), access_rw, reset_unknown, TPIDRRO_EL0 },
+	{ SYS_DESC(SYS_SCXTNUM_EL0), access_rw, reset_unknown, SCXTNUM_EL0 },
+
+	{ SYS_DESC(SYS_CNTFRQ_EL0), NULL, reset_cntfrq, CNTFRQ_EL0, .set_user = set_cntfrq },
+	{ SYS_DESC(SYS_CNTPCT_EL0), .get_user = arch_timer_get_user,
+	  .set_user = arch_timer_set_user },
+	{ SYS_DESC(SYS_CNTVCT_EL0), .get_user = arch_timer_get_user,
+	  .set_user = arch_timer_set_user },
+	GUEST_TIMER_REG(CNTP_CTL_EL0),
+	GUEST_TIMER_REG(CNTP_CVAL_EL0),
+	GUEST_TIMER_REG(CNTV_CTL_EL0),
+	GUEST_TIMER_REG(CNTV_CVAL_EL0),
+};
+
+static const size_t num_sys_reg_descs = ARRAY_SIZE(sys_reg_descs);
+
+/**
+ * kvm_reset_sys_regs - sets system registers to reset value
+ * @vcpu: The VCPU pointer
+ *
+ * This function finds the right table above and sets the registers on the
+ * virtual CPU struct to their architecturally defined reset values.
+ */
+void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long i;
+
+	for (i = 0; i < num_sys_reg_descs; i++) {
+		const struct sys_reg_desc *r = &sys_reg_descs[i];
+
+		if (!r->reset)
+			continue;
+
+		if (is_vm_ftr_id_reg(reg_to_encoding(r)))
+			reset_vm_ftr_id_reg(vcpu, r);
+		else if (is_vcpu_ftr_id_reg(reg_to_encoding(r)))
+			reset_vcpu_ftr_id_reg(vcpu, r);
+		else
+			r->reset(vcpu, r);
+	}
+
+	/*
+	 * kvm_reset_vcpu will override the save area with the QAAF GISRSA response
+	 * unconditionally, which clobbers the value of MIDR_EL1, so write it here.
+	 */
+	_vcpu_write_sys_reg(vcpu, boot_cpu_midr_val, SYS_MIDR_EL1);
+
+	set_bit(KVM_ARCH_FLAG_ID_REGS_INITIALIZED, &kvm->arch.flags);
+
+	if (kvm_vcpu_has_pmu(vcpu))
+		kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
+}
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
+		desc = find_reg(&params, sys_reg_descs, num_sys_reg_descs);
+	else
+		kvm_pr_unimpl("system instruction handling not supported");
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
+int __init kvm_sys_reg_table_init(void)
+{
+	init_imp_id_regs();
+
+	bool valid =
+		check_sysreg_table(sys_reg_descs, num_sys_reg_descs, false);
+
+	if (!valid)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int finalize_sys_regs(struct kvm *kvm)
+{
+	lockdep_assert_held(&kvm->arch.config_lock);
+
+	if (kvm_id_regs_final(kvm))
+		return 0;
+
+	if (!irqchip_in_kernel(kvm)) {
+		u64 val;
+
+		val = kvm_read_vm_id_reg(kvm, SYS_ID_AA64PFR0_EL1) & ~ID_AA64PFR0_EL1_GIC;
+		kvm_set_vm_id_reg(kvm, SYS_ID_AA64PFR0_EL1, val);
+		val = kvm_read_vm_id_reg(kvm, SYS_ID_AA64PFR2_EL1) & ~ID_AA64PFR2_EL1_GCIE;
+		kvm_set_vm_id_reg(kvm, SYS_ID_AA64PFR2_EL1, val);
+		val = kvm_read_vm_id_reg(kvm, SYS_ID_PFR1_EL1) & ~ID_PFR1_EL1_GIC;
+		kvm_set_vm_id_reg(kvm, SYS_ID_PFR1_EL1, val);
+	}
+
+	set_bit(KVM_ARCH_FLAG_ID_REGS_FINAL, &kvm->arch.flags);
+
+	return 0;
+}
+
+int kvm_vcpu_finalize_sys_regs(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	
+	guard(mutex)(&kvm->arch.config_lock);
+	return finalize_sys_regs(kvm);
+}
diff --git a/arch/s390/kvm/arm64/trace.h b/arch/s390/kvm/arm64/trace.h
index ee232c4f5a6d..2f0ac8aa7a06 100644
--- a/arch/s390/kvm/arm64/trace.h
+++ b/arch/s390/kvm/arm64/trace.h
@@ -4,6 +4,8 @@
 
 #include <linux/tracepoint.h>
 
+#include <arm64/sys_regs.h>
+
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm_arm64
 #undef TRACE_SYSTEM_VAR
@@ -90,6 +92,54 @@ TRACE_EVENT(kvm_guest_fault,
 		  __entry->hxfar, __entry->vcpu_pc)
 );
 
+TRACE_EVENT(kvm_handle_sys_reg,
+	TP_PROTO(unsigned long hsr),
+	TP_ARGS(hsr),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,	hsr)
+	),
+
+	TP_fast_assign(
+		__entry->hsr = hsr;
+	),
+
+	TP_printk("HSR 0x%08lx", __entry->hsr)
+);
+
+TRACE_EVENT(kvm_sys_access,
+	TP_PROTO(unsigned long vcpu_pc, struct sys_reg_params *params, const struct sys_reg_desc *reg),
+	TP_ARGS(vcpu_pc, params, reg),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,			vcpu_pc)
+		__field(bool,				is_write)
+		__field(const char *,			name)
+		__field(u8,				Op0)
+		__field(u8,				Op1)
+		__field(u8,				CRn)
+		__field(u8,				CRm)
+		__field(u8,				Op2)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc = vcpu_pc;
+		__entry->is_write = params->is_write;
+		__entry->name = reg->name;
+		__entry->Op0 = reg->Op0;
+		__entry->Op1 = reg->Op1;
+		__entry->CRn = reg->CRn;
+		__entry->CRm = reg->CRm;
+		__entry->Op2 = reg->Op2;
+	),
+
+	TP_printk("PC: %lx %s (%d,%d,%d,%d,%d) %s",
+		  __entry->vcpu_pc, __entry->name ?: "UNKN",
+		  __entry->Op0, __entry->Op1, __entry->CRn,
+		  __entry->CRm, __entry->Op2,
+		  str_write_read(__entry->is_write))
+);
+
 #endif /* KVM_ARM64_TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/s390/tools/Makefile.arm64h b/arch/s390/tools/Makefile.arm64h
index 88dcce26179c..9761b0bfcfbd 100644
--- a/arch/s390/tools/Makefile.arm64h
+++ b/arch/s390/tools/Makefile.arm64h
@@ -17,12 +17,16 @@ arm64uapi := $(objtree)/arch/$(ARCH)/include/generated/uapi/arm64
 # If the file does not contain any markers the whole file will be copied.
 ARM64_SHARED_HEADERS := \
 	brk-imm.h \
+	cache.h \
+	cputype.h \
 	esr.h \
 	kvm_arm.h \
 	kvm_emulate-gen.h \
 	kvm_host.h \
 	ptrace-gen.h \
 	sysreg-gen.h \
+	spectre.h \
+	kvm:sys_regs-gen.h \
 	uapi:hwcap.h \
 	uapi:kvm.h \
 	uapi:ptrace.h \

-- 
2.56.0

