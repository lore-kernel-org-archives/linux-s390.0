Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFE73E0C4C;
	Fri, 29 May 2026 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069903; cv=none; b=N68IasB8gRX8yMZzAk/G3mvj7qw8HmchMWDvaOq2xF1dl59lFuxctKib/DZvdxe6A1J+Kl5HsLugyB4QryX7H9afEA3hzpwThsflk08eHZnWRSFoilflEzk6b/NZ66G9XebvTdXfupopkZJKGY0GCkDB//o16PjMJdTraqpJHOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069903; c=relaxed/simple;
	bh=WiuASR+7EeivS7tCLhe8ZET+IBFa79wXu0mkpIavKt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wcvc40YfUCWW3afWjuvcx3QSyCtwBKAef/QFgxuwQ27gr3L6XYJj7KfnKGUEyVRqoJQZwj2OtwIo1xrvSCHx342hcDZLqQrT8wl9CqNA+BwRZwk1cHSziAvduX9Y9LEpcIMGZLOKxf5PKXfSMGAVV8yiw5Ir9a2fFeDdHEaZ89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JTLEqKe/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JTLEqKe/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFBXRX1468203;
	Fri, 29 May 2026 15:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mLKXzUx8y1/hdsM3n
	9eU/lplZiabjlywmzoOKP5Uw1I=; b=JTLEqKe/tuZBL1nHq2v2YJPH8/7by5fLL
	RJyZw2t8XHrBy9e9aMpvuXbA1yeG+5NlL35XAiCLEkyqemFZ8mfjhMV4KbSfOFId
	sUFSoOirU74ta6UU9REA6NbFDX7LbvbyCfcB+Zx7QtL2mpPwNw1P7HvTC/XU6wcH
	QBDNxQKK4FWFolMiOH8tlG9RDwE/wYN07Ug5WW/UfWtWEWzKlDDSb8qkzuzE1/CF
	ECDZ+nctE5UkjKsXZZRqNBqchn5op3530C7qyLJ+lCv0iG+eFt7R6Tn/8dVpLd2A
	MhmMjG72k5i508YoYaH5/gxLZS6m4Goo7GgBykeuup4KQkIqdRPqg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886mb5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFd5HC012278;
	Fri, 29 May 2026 15:51:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgeum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFoxr641288038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:50:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 365DC20043;
	Fri, 29 May 2026 15:50:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7CCB2005A;
	Fri, 29 May 2026 15:50:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:50:58 +0000 (GMT)
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
Subject: [PATCH v3 23/27] KVM: s390: arm64: Implement required functions
Date: Fri, 29 May 2026 17:50:37 +0200
Message-ID: <20260529155050.2902245-24-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: m0z0nq37zDWnVhfKbAtJg7ydYJhAoODQ
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a19b5ea cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=JEk9-RCT-MC-l0ff1-cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX9JgpVRODEdv+
 27D1JwMKVDAQfRuYBJ+m+F0syIDfUrX1ZC/IKtWgjm9ACUdjYY8mCNr0KMXnrjxg6zf9nK218Mn
 DEht9O+kgwINMJC9m/G98amoJaLg2KD3ulpJyORCuJW8dU6suVRReB2ybCTqaKiu8BBXc2vb/N8
 SyQCNERc6jrsYq0C26mpM9YBzyG1f7v2gcPTIDLfs+40vmo/MhEeTNrT/u9BWOBygLz+V+ZMV/z
 Gz1NAeWwJDScZgsUgZlGJ9dwr8baULCCbU+6iznSlsjpwe7NckO11oBEg7Su97u3RYu3hE8kDRB
 MmrafB5CTcPKp279agqOHtdysHGGcTuloLKi/ZpR9T/+3YIUfOu99ky+zvDci3OKe3W/vlrDjPK
 mK6JwVxgr+EWmVnGctHEyja3SKj+LJ2/7i5FJsA/7O0qL6I+DQkUpt0IK9ow4rzm0YrfRPomliX
 pZnn9VSlQbNWsK1PjJw==
X-Proofpoint-ORIG-GUID: m0z0nq37zDWnVhfKbAtJg7ydYJhAoODQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

Implement the mostly trivial functions that the shared arm64 (kvm)
headers oblige s390 to implement.

Implement a very basic smccc handler that (non-compliantly) is just able
to stop a vcpu.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_emulate.h | 131 ++++++++++++++++++++++++++++
 arch/s390/include/asm/kvm_mmu.h     |  12 +++
 arch/s390/include/asm/kvm_nested.h  |  13 +++
 arch/s390/kvm/arm64/handle_exit.c   |  50 +++++++++++
 arch/s390/kvm/arm64/inject_fault.c  |  21 +++++
 5 files changed, 227 insertions(+)
 create mode 100644 arch/s390/include/asm/kvm_emulate.h
 create mode 100644 arch/s390/include/asm/kvm_mmu.h
 create mode 100644 arch/s390/include/asm/kvm_nested.h
 create mode 100644 arch/s390/kvm/arm64/handle_exit.c
 create mode 100644 arch/s390/kvm/arm64/inject_fault.c

diff --git a/arch/s390/include/asm/kvm_emulate.h b/arch/s390/include/asm/kvm_emulate.h
new file mode 100644
index 000000000000..93b9e777b51e
--- /dev/null
+++ b/arch/s390/include/asm/kvm_emulate.h
@@ -0,0 +1,131 @@
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
+	vcpu->arch.hcr_elz = HCR_E2H | HCR_RW | HCR_AMO | HCR_IMO | HCR_FMO |
+			     HCR_PTW;
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
2.53.0

