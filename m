Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FF842DFF5;
	Fri, 31 Jul 2026 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503383; cv=none; b=d/SpJXqMxGKDVoGem4rB5NbiZtNIurSPuoluXUOgRbdHMsEE6Sm25o1/JtraN+0D7jwZ8Ar9HtGFFnJ8fTnf2UWDDUF1W5gycSjtgFFELN5AyoJ/8eNpZmnzShkRk0gcOXdeZz8hCOhhFQOjptZKVW7VekNMM0c993/wr94Uhws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503383; c=relaxed/simple;
	bh=bT2VAim9nPTUmRy0y+g1ie7DdKvxUu69Iys7Xq3d2IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4JN+QpyWIK0Pvdr3Wl1Hxc7LQs4XTxVj06/KnGe0J0T9RBOzyBeQWWjsfqRcjua17gi5XkE4e7GlMFAgzswA0lk7EoGJitWwSea+GGoaF0Fx/Kxj7qNQ5EfWKSrg5UF+2nIUtpW+k+kpaJm6haFZlUG+sBFaegwXZVWD//4BXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fh6QLlNd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fh6QLlNd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBm9AF1671732;
	Fri, 31 Jul 2026 13:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pLfR4PknkK0B2DHzN
	DYzQZRzuf7xrRVnikz3SrnDfmY=; b=fh6QLlNd5JFOaJSwaIQVHP6lDf0zZLT9a
	fCpJ6SmXWdOodl2x/uYfG4h9/0ogXR4T1pRJUESGByEdsDMFyAKNQYMrbOlfm/Ii
	NrMoTh/nXNTC2glrodjQkH6NTZt35Vkn6y2sGjXcuz0XrXy0tNRbCN47t8wO0FTU
	lBOuTJcDYAg+INOOb8FJKyCFX2L7+Lzx0PWPE655/SqBuMlHVyEnrxQxYCaTArfg
	FxUHI8XWSsqUYmYBzqWjE2KILONlEKbq9laJbFXh1PEJT5RTtBLDXbyn2ZyvGxzb
	7obq6F5x5fjPDYeFkEoIzxwxBpdxpGgdEWjhqZai4LrWU1wiAjtgg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjm3vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCQEfW026835;
	Fri, 31 Jul 2026 13:09:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqtbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD97Vn28901792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 917FA20040;
	Fri, 31 Jul 2026 13:09:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 302BB2004B;
	Fri, 31 Jul 2026 13:09:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:07 +0000 (GMT)
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
Subject: [PATCH v5 10/31] arm64: Prepare sharing arm64 headers with s390
Date: Fri, 31 Jul 2026 15:08:38 +0200
Message-ID: <20260731130902.654679-11-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX2eJw/fiNewsM
 Yls4UqKBZ4Nkcf7HU6UYBzrI4tv/S3HW2+UdZSqlMV/Zq6IxaC0gSZGAU3UUvhOhsqZHZe9fQ28
 svxfE1CPAM7SEUtDokCT6evTIkY/6gQ=
X-Proofpoint-GUID: NtIJFbUyn--iL_wXaWoDIxBrkb9yjPRo
X-Proofpoint-ORIG-GUID: B8kbB1CfCkO0oPOaBFXJ-wBn_TT1LSHy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX2uL3drOmh+xp
 4EEk/h3pFI8LRvQrclVEcEyfOtwXmi3k9LtBdxnG+SOMfaDbcLwgVMfX3TxP+e9IEl9NWISVFpq
 9f5FYuv9TiS/RgoAvdnsxOHWhyqYrNyg1M/FMtxkouu6FuCwVK8cC8ZhH7G4+rM5LrfBb07okc1
 ORIwF5QA2VU+ZWNzF1FMnrOGOzLTxQuVWOK8pKZQM5UdoxTQgjRn5//JH/OXOCpcwpl6hbdhtOv
 5nCrSwCy+gNN7Dvgelz4/X14LTV5iS9AwK/2WJda9+BeaHAc0NK+icKpmG6fRvLSycBjP7JldEx
 rSLF5Lh97d8dqS4AigsosCBXDRq65Q8HQs+K8CPQ3fByhChuYXOmeUNI6Uq6JgqL4qGUnzhYarh
 J2pN1HZsaJMa+m6rudMza9MyS640FifGVhQ+FMTm30ftvuZd5NguB0XNPTuQE+6ImHnJqMVeAFF
 XH5cnmU4KHRYHFPppgg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6c9e7d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=CvB7ObVER1VTR8-vp5wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310096

Prepare the sharing of arm64 headers with s390 by moving a few
definitions inside headers to reduce the number of shared markers.
Clean up some includes to further streamline the sharing of headers.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/esr.h         |  4 +-
 arch/arm64/include/asm/kvm_arm.h     |  5 ++-
 arch/arm64/include/asm/kvm_emulate.h |  5 ++-
 arch/arm64/include/asm/kvm_host.h    | 59 ++++++++++++++--------------
 arch/arm64/include/asm/sysreg.h      |  2 +-
 5 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index f816f5d77f1a..da085c83b57e 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -7,7 +7,7 @@
 #ifndef __ASM_ESR_H
 #define __ASM_ESR_H
 
-#include <asm/memory.h>
+#include <asm/brk-imm.h>
 #include <asm/sysreg.h>
 
 #define ESR_ELx_EC_UNKNOWN	UL(0x00)
@@ -435,7 +435,7 @@
 #define ESR_ELx_IT_GCSPOPX		7
 
 #ifndef __ASSEMBLER__
-#include <asm/types.h>
+#include <linux/types.h>
 
 static inline unsigned long esr_brk_comment(unsigned long esr)
 {
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 3f9233b5a130..a99d8de99961 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -7,10 +7,11 @@
 #ifndef __ARM64_KVM_ARM_H__
 #define __ARM64_KVM_ARM_H__
 
+#include <linux/const.h>
+#include <linux/bits.h>
+#include <linux/types.h>
 #include <asm/esr.h>
-#include <asm/memory.h>
 #include <asm/sysreg.h>
-#include <asm/types.h>
 
 /*
  * Because I'm terribly lazy and that repainting the whole of the KVM
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 4ef4a77aaa8e..45b3f98f0c7e 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -44,11 +44,12 @@ enum exception_type {
 bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
 void kvm_skip_instr32(struct kvm_vcpu *vcpu);
 
+int kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, u64 addr);
+int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr);
+
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr);
-int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr);
 int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr);
-int kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, u64 addr);
 void kvm_inject_size_fault(struct kvm_vcpu *vcpu);
 
 static inline int kvm_inject_sea_dabt(struct kvm_vcpu *vcpu, u64 addr)
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4a23d3662d6b..875fc7c3366b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -56,6 +56,36 @@
 #define KVM_REQ_MAP_L1_VNCR_EL2		KVM_ARCH_REQ(10)
 #define KVM_REQ_VGIC_PROCESS_UPDATE	KVM_ARCH_REQ(11)
 
+/*
+ * If we encounter a data abort without valid instruction syndrome
+ * information, report this to user space.  User space can (and
+ * should) opt in to this feature if KVM_CAP_ARM_NISV_TO_USER is
+ * supported.
+ */
+#define KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER	0
+/* Memory Tagging Extension enabled for the guest */
+#define KVM_ARCH_FLAG_MTE_ENABLED			1
+/* At least one vCPU has ran in the VM */
+#define KVM_ARCH_FLAG_HAS_RAN_ONCE			2
+/* The vCPU feature set for the VM is configured */
+#define KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED		3
+/* PSCI SYSTEM_SUSPEND enabled for the guest */
+#define KVM_ARCH_FLAG_SYSTEM_SUSPEND_ENABLED		4
+/* VM counter offset */
+#define KVM_ARCH_FLAG_VM_COUNTER_OFFSET			5
+/* Timer PPIs made immutable */
+#define KVM_ARCH_FLAG_TIMER_PPIS_IMMUTABLE		6
+/* Initial ID reg values loaded */
+#define KVM_ARCH_FLAG_ID_REGS_INITIALIZED		7
+/* Fine-Grained UNDEF initialised */
+#define KVM_ARCH_FLAG_FGU_INITIALIZED			8
+/* SVE exposed to guest */
+#define KVM_ARCH_FLAG_GUEST_HAS_SVE			9
+/* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace */
+#define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS		10
+/* Unhandled SEAs are taken to userspace */
+#define KVM_ARCH_FLAG_EXIT_SEA				11
+
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 				     KVM_DIRTY_LOG_INITIALLY_SET)
 
@@ -338,35 +368,6 @@ struct kvm_arch {
 	/* Protects VM-scoped configuration data */
 	struct mutex config_lock;
 
-	/*
-	 * If we encounter a data abort without valid instruction syndrome
-	 * information, report this to user space.  User space can (and
-	 * should) opt in to this feature if KVM_CAP_ARM_NISV_TO_USER is
-	 * supported.
-	 */
-#define KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER	0
-	/* Memory Tagging Extension enabled for the guest */
-#define KVM_ARCH_FLAG_MTE_ENABLED			1
-	/* At least one vCPU has ran in the VM */
-#define KVM_ARCH_FLAG_HAS_RAN_ONCE			2
-	/* The vCPU feature set for the VM is configured */
-#define KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED		3
-	/* PSCI SYSTEM_SUSPEND enabled for the guest */
-#define KVM_ARCH_FLAG_SYSTEM_SUSPEND_ENABLED		4
-	/* VM counter offset */
-#define KVM_ARCH_FLAG_VM_COUNTER_OFFSET			5
-	/* Timer PPIs made immutable */
-#define KVM_ARCH_FLAG_TIMER_PPIS_IMMUTABLE		6
-	/* Initial ID reg values loaded */
-#define KVM_ARCH_FLAG_ID_REGS_INITIALIZED		7
-	/* Fine-Grained UNDEF initialised */
-#define KVM_ARCH_FLAG_FGU_INITIALIZED			8
-	/* SVE exposed to guest */
-#define KVM_ARCH_FLAG_GUEST_HAS_SVE			9
-	/* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace */
-#define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS		10
-	/* Unhandled SEAs are taken to userspace */
-#define KVM_ARCH_FLAG_EXIT_SEA				11
 	unsigned long flags;
 
 	/* VM-wide vCPU feature set */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1aa601c95188..ab205f9db94a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1263,6 +1263,6 @@
 		 FIELD_PREP(reg##_##field##_MASK,	\
 			    SYS_FIELD_VALUE(reg, field, val))
 
-#endif
+#endif /* __ASSEMBLER__ */
 
 #endif	/* __ASM_SYSREG_H */
-- 
2.53.0

