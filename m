Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809344BC82;
	Tue, 28 Apr 2026 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392360; cv=none; b=b0rDozmCgNi/gZk12tiVrAQuqFCLC7x2cnGEZidfQapjkAGKygAHsnz2PazbOVf+ABYEV1Y304BiJtxfdj9lIcrfoW6DKMm9twxl/ATg7YW69krviszcYKpc5inQeht6mlHtx9tryoudA2peRY6T1FI8S8xbPpEQwBj/H6QXk8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392360; c=relaxed/simple;
	bh=wrJOjCr5+YjZZx79S6AslVJoyK63Gm2qxbkKT50b514=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNn+sBr7mBExfF4YDJ9XQN1o8NHdHauItv9EQInPf3m8wA8ynZccRWVp5AIdf8WgdiNLcFMqAa9gzFaryZt3sJ0ORi3AKrH3+bU+iF+74LS1houQS9SKa6sktXdzCTtmDp18Rr+fxRyn9p4UnwxqPU/sYDGinCD7e2aG0VDTD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E2vD7jL7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E2vD7jL7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6lGsP2931477;
	Tue, 28 Apr 2026 16:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F8yJNSf5A67F2lC9+
	9w/4zWziCJwZM0F3dAK373gZu0=; b=E2vD7jL75siB08ol4J5iM6whjqfdJqudO
	T1RHiYD3705F1YMRecJXRH9rGQ3UAokwDw7QFoTJS577hCfu+k8+/eG/E9CyCR9O
	zWZ3w766alCaVHPGYfGg68q8NjxKrMc+IMP8GvY/la/qBZn4YheoKsJPM6zOYlPX
	BUL9lD//zeQRyP8fSWyq0QFCnm4FH2T4nwyGGM7VeCE0kjT47HW0mJ7izXLUM4qa
	bEEOWeMPp6xvqhL60UZOo3TbTk1C4ZyRJDWJyhi+G0kKq9RgAIUMZQXQVmXXwlsw
	UvuJik7OLSOkVeRtAPAptWK0305Zr1K7XCYZ4/sYIKdS2HWOKEPGQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44pgq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrolm006520;
	Tue, 28 Apr 2026 16:05:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqajau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SG5Wuk51446040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 16:05:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3DB320040;
	Tue, 28 Apr 2026 16:05:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 841B52004B;
	Tue, 28 Apr 2026 16:05:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 16:05:32 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [RFC PATCH v2 14/28] KVM: s390: arm64: Implement required functions
Date: Tue, 28 Apr 2026 18:05:11 +0200
Message-ID: <20260428160527.1378085-15-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428160527.1378085-1-seiden@linux.ibm.com>
References: <20260428160527.1378085-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vXpLPaezA4gat85VkB865Hi2R3Y8zVnM
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f0dad1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=JEk9-RCT-MC-l0ff1-cA:9
X-Proofpoint-GUID: vXpLPaezA4gat85VkB865Hi2R3Y8zVnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfXwdQsKj5n2gat
 aZxPocmhOOPegIxdK2fidj7Je3oQOr98TEMYysXToCkjmxNIkFoGF6/IsqGHXEe2DXllswKvwCz
 OOC6wVFMZX7EYy6P9arI5s6wAsKLXqZYdmkevuYCN6JjaqTV0XfBzjjEIRaQzbWVh/WVTOJO5Ay
 OWg/jxk8qnoXZ67BV15B3qADK0E26/EZnMngh0fl4WdG6i6FoQBGODo+o8RHOhaFT0cY/05i8KQ
 GF+eCumms9oglumKCcX2TsJLXIXZi0IJ/+078Td8f1WB6U2Iw2tH50XjgylkkeGYjzDJNSMnFSX
 fIRMKbTcA7MIqYkEkjhpxf1Z80iL0njdnkzchq3TiipckCLwo7+/Mwq9UxcqmQWyfdkX0DwTx1J
 b+ZZzaX1PjXBqbGEoVMP/yvijb9apIy1Wdo0xnRweYvt9Jk17hn4PBvPtZ0ttF57AsY6xCmZoK5
 SxeSFwQTDrANW7eCTJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

Implement the mostly trivial functions that the shared arm64 (kvm)
headers oblige s390 to implement.

Implement a very basic smccc handler that (non-compliantly) is just able
to stop a vcpu.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_emulate.h | 135 ++++++++++++++++++++++++++++
 arch/s390/include/asm/kvm_mmu.h     |  12 +++
 arch/s390/include/asm/kvm_nested.h  |  13 +++
 arch/s390/kvm/arm64/handle_exit.c   |  50 +++++++++++
 arch/s390/kvm/arm64/inject_fault.c  |  21 +++++
 5 files changed, 231 insertions(+)
 create mode 100644 arch/s390/include/asm/kvm_emulate.h
 create mode 100644 arch/s390/include/asm/kvm_mmu.h
 create mode 100644 arch/s390/include/asm/kvm_nested.h
 create mode 100644 arch/s390/kvm/arm64/handle_exit.c
 create mode 100644 arch/s390/kvm/arm64/inject_fault.c

diff --git a/arch/s390/include/asm/kvm_emulate.h b/arch/s390/include/asm/kvm_emulate.h
new file mode 100644
index 000000000000..bf019005e137
--- /dev/null
+++ b/arch/s390/include/asm/kvm_emulate.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Emulation functionality for arm64 guests.
+ */
+
+#ifndef __S390_ARM64_KVM_EMULATE_H__
+#define __S390_ARM64_KVM_EMULATE_H__
+
+#include <asm/fault.h>
+#include <asm/ptrace.h>
+#include <linux/kvm_host.h>
+
+#include <kvm/arm64/kvm_arm.h>
+#include <kvm/arm64/kvm_emulate.h>
+
+static __always_inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcpu)
+{
+	return (unsigned long *)&vcpu->arch.sae_block.pc;
+}
+
+static __always_inline unsigned long *vcpu_cpsr(const struct kvm_vcpu *vcpu)
+{
+	return (unsigned long *)&vcpu->arch.sae_block.pstate;
+}
+
+static __always_inline unsigned long *vcpu_sp_el0(const struct kvm_vcpu *vcpu)
+{
+	return (unsigned long *)&vcpu->arch.sae_block.sp_el0;
+}
+
+static __always_inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static __always_inline u64 kvm_vcpu_get_esr(const struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sae_block.hai.esr_elz;
+}
+
+static __always_inline unsigned long kvm_vcpu_get_hfar(const struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sae_block.hai.far_elz;
+}
+
+static __always_inline phys_addr_t kvm_vcpu_get_fault_ipa(const struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sae_block.hai.teid.addr * PAGE_SIZE;
+}
+
+static inline u16 kvm_vcpu_fault_pic(const struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sae_block.hai.pic & PGM_INT_CODE_MASK;
+}
+
+/* Should be unreachable, arm64 on s390 does not claim KVM_CAP_ARM_NISV_TO_USER*/
+static inline unsigned long kvm_vcpu_dabt_iss_nisv_sanitized(const struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_get_esr(vcpu) & (ESR_ELx_CM | ESR_ELx_WNR);
+}
+
+static __always_inline
+bool kvm_vcpu_trap_is_permission_fault(const struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_fault_pic(vcpu) == PGM_PROTECTION;
+}
+
+static __always_inline bool kvm_condition_valid(const struct kvm_vcpu *vcpu)
+{
+	return true;
+}
+
+static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcr_elz = HCR_E2H | HCR_RW | HCR_PTW;
+	/* traps */
+	vcpu->arch.hcr_elz |= HCR_TSC | HCR_TID1 | HCR_TID2 | HCR_TID3 |
+			      HCR_TID4 | HCR_TID5 | HCR_TIDCP;
+}
+
+static inline unsigned long vcpu_get_vsesr(struct kvm_vcpu *vcpu)
+{
+	WARN(true, "not implemented, just feat RAS");
+
+	return 0L;
+}
+
+static inline void vcpu_set_vsesr(struct kvm_vcpu *vcpu, u64 vsesr)
+{
+	WARN(true, "not implemented, just feat RAS");
+}
+
+static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
+{
+	return (unsigned long *)&vcpu->arch.hcr_elz;
+}
+
+static inline bool vcpu_el2_tge_is_set(const struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline int kvm_vcpu_abt_gltl(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sae_block.hai.gltl;
+}
+
+static inline bool is_hyp_ctxt(const struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline bool is_nested_ctxt(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline bool vcpu_mode_priv(const struct kvm_vcpu *vcpu)
+{
+	u32 mode = *vcpu_cpsr(vcpu) & PSR_MODE_MASK;
+
+	return mode != PSR_MODE_EL0t;
+}
+
+#endif /* __S390_ARM64_KVM_EMULATE_H__ */
diff --git a/arch/s390/include/asm/kvm_mmu.h b/arch/s390/include/asm/kvm_mmu.h
new file mode 100644
index 000000000000..ac354fd5bac9
--- /dev/null
+++ b/arch/s390/include/asm/kvm_mmu.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KVM MMU for arm64 guests.
+ */
+#ifndef __S390_ARM64_KVM_MMU_H__
+#define __S390_ARM64_KVM_MMU_H__
+
+#include <linux/kvm_host.h>
+
+#include <kvm/arm64/kvm_mmu.h>
+
+#endif /* __S390_ARM64_KVM_MMU_H__ */
diff --git a/arch/s390/include/asm/kvm_nested.h b/arch/s390/include/asm/kvm_nested.h
new file mode 100644
index 000000000000..7158932e718b
--- /dev/null
+++ b/arch/s390/include/asm/kvm_nested.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Nested KVM for arm64 guests. (Not supported by s390)
+ */
+#ifndef ASM_KVM_NESTED_H
+#define ASM_KVM_NESTED_H
+
+static inline bool vcpu_has_nv(const struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+#endif /* ASM_KVM_NESTED_H */
diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/handle_exit.c
new file mode 100644
index 000000000000..89933a604876
--- /dev/null
+++ b/arch/s390/kvm/arm64/handle_exit.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kvm_host.h>
+
+#include <asm/esr.h>
+#include <asm/kvm_emulate.h>
+
+#include <kvm/arm64/handle_exit.h>
+
+#define PSCI_0_2_FN_SYSTEM_OFF		0x84000008
+#define PSCI_RET_NOT_SUPPORTED		-1
+#define PSCI_RET_INTERNAL_FAILURE	-6
+/*
+ * Temporary smc/hvc handler. Non-compliant implementation (features missing).
+ * Implements only system off so that test programs are able to end their execution
+ */
+static int kvm_smccc_call_handler(struct kvm_vcpu *vcpu)
+{
+	u32 func_id = vcpu_get_reg(vcpu, 0);
+	u64 val = PSCI_RET_NOT_SUPPORTED;
+	int ret = 1;
+
+	if (func_id == PSCI_0_2_FN_SYSTEM_OFF) {
+		spin_lock(&vcpu->arch.mp_state_lock);
+		WRITE_ONCE(vcpu->arch.mp_state.mp_state, KVM_MP_STATE_STOPPED);
+		spin_unlock(&vcpu->arch.mp_state_lock);
+		kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);
+		memset(&vcpu->run->system_event, 0,
+		       sizeof(vcpu->run->system_event));
+		vcpu->run->system_event.type = KVM_SYSTEM_EVENT_SHUTDOWN;
+		vcpu->run->system_event.ndata = 1;
+		vcpu->run->system_event.data[0] = 0;
+		vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
+		val = PSCI_RET_INTERNAL_FAILURE;
+		ret = 0;
+	}
+	vcpu_set_reg(vcpu, 0, val);
+
+	return ret;
+}
+
+static int handle_hvc(struct kvm_vcpu *vcpu)
+{
+	vcpu->stat.hvc_exit_stat++;
+	return kvm_smccc_call_handler(vcpu);
+}
+
+exit_handle_fn arm_exit_handlers[] = {
+	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
+	[ESR_ELx_EC_HVC64]	= handle_hvc,
+};
diff --git a/arch/s390/kvm/arm64/inject_fault.c b/arch/s390/kvm/arm64/inject_fault.c
new file mode 100644
index 000000000000..650c041efde2
--- /dev/null
+++ b/arch/s390/kvm/arm64/inject_fault.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/kvm_emulate.h>
+
+/**
+ * kvm_inject_undefined - inject an undefined instruction into the guest
+ * @vcpu: The vCPU in which to inject the exception
+ *
+ * It is assumed that this code is called from the VCPU thread and that the
+ * VCPU therefore is not currently executing guest code.
+ */
+void kvm_inject_undefined(struct kvm_vcpu *vcpu)
+{
+	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
+}
+
+int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
+{
+	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
+	return 1;
+}
-- 
2.51.0

