Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01B389DF0;
	Thu,  2 Apr 2026 04:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103780; cv=none; b=JIsuqLsrwQu7IL2JXEek3IY+cwABCOuyRVKohRhoiZM8HMqqo726y8sDTPFEigfMYAyjlpeA84Q4ytFo9HRiHPQYEbXz6QE9VLv5ujIoGxH08DynXBLnX8hFz1fWMWg0KbjZzwvhvMVgYeC5qBcc7mzHIFFrNOE7QXg7d1VmQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103780; c=relaxed/simple;
	bh=iEbWbXtn+p1reA8ffn2mAPn8n3eJE7YcqY3Ahor1J64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bR+UqXD6Hrd+BX8InYKWMMGKoHr1KwpPASDva64xoZrJUL3laC/TgK/GtICJs6sez1x7DdtvqOdnxAr8KIopBZ+/Q7R3uxB6BCTHdjMCOeaRa79sQSCB6gQDy8ZyG9R/J9+RWGoZkmwbqw/ZExxXxyAtZ1U3jbz/pTLUugmPyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fWNSwcrr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fWNSwcrr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632370g7367956;
	Thu, 2 Apr 2026 04:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9spkLSJNpWgki/FaB
	hYJAtNhpquMefNBpzVs8QMMlvk=; b=fWNSwcrrNh1DS5ffVgLVUiCAFwLnFqpUF
	rr1t6qokPYdIqeNJLiVa1laQV2K9VmvRDNp6/ferSyVIxlkB7Jh+J53DBWjzcKEJ
	FNU9gTF0AqXs3ATvKBElDBsvZFxdByu1UEgqeAw8hIdfFiiH3K7/DZ7k8wEULPsS
	kerFN4UieCz0oW0U3TcradDHziOLWJ9LJY221ou8OqrjZrmOUIw7mTkKjPfWfKKq
	++UhqgTbZvz4JrCDwxQJrLzs4REJXtWVNaHfCcWoJjTGRyWbmN4KszV5YmLhaWqC
	XzhQ3MiUzUhIDf0Ak7SIGcuzPopN5DYpwGnpgvKJgMURp+hFnQ8Eg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnu7t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631NEI0U021631;
	Thu, 2 Apr 2026 04:21:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasrsb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LYCO39846298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA02920040;
	Thu,  2 Apr 2026 04:21:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 581132004D;
	Thu,  2 Apr 2026 04:21:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:34 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH v1 23/27] KVM: s390: arm64: Implement required functions
Date: Thu,  2 Apr 2026 06:21:19 +0200
Message-ID: <20260402042125.3948963-24-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402042125.3948963-1-seiden@linux.ibm.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jERbivUGXYk7moeyGsAAmEICPLP-zLQa
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cdeed3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=JEk9-RCT-MC-l0ff1-cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfX1Kz7fKinvF9/
 2eYF7UR/I8j9mpn1scyCgyvDuUIfuT5Zu2tshw7LN1jxYKh4imyolKzjx4GEXHV+7Do0CWrnViz
 oETYAgDJCSwOIEJYalIqw+m3H6yp55KFJOFIdUHJKoEwTP735B+oSvaoOSNP5TW3ZgZl4txqdkc
 KPTbHpY0q2C04ak1DzuQwSaM1VbCMGHnIsGiUr1VXHRqAm28Y9Tgn6nXnE6D5ZRgXS67olxHETj
 W24iJkPjUMYPOUXCoPJLIObihXEDtJIb/RblQkBDIMigWkxlj+fNOxqA4dqaGLS4tceY/QxZNR6
 4oHivqG1z7l1vsHMtmeev7HrdGQ+5sV0BOjva3xN3IONk/tIrMkJmSKjb+50DwE0dFg9kCU4+qH
 foWAf4HC5cfNl0d69a/IXL9st2ncHTyyg9UAELCJ4jsizcN09u3cy9RLIYZe6KBWaMxEIEWKIR8
 fhM+ZQ1znu9dFf065tQ==
X-Proofpoint-ORIG-GUID: jERbivUGXYk7moeyGsAAmEICPLP-zLQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020034

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
 arch/s390/kvm/arm64/inject_fault.c  |  15 ++++
 5 files changed, 225 insertions(+)
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
index 000000000000..d4058c3f226e
--- /dev/null
+++ b/arch/s390/kvm/arm64/inject_fault.c
@@ -0,0 +1,15 @@
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
-- 
2.51.0

