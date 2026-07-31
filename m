Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C14399F7;
	Fri, 31 Jul 2026 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503392; cv=none; b=dlvTWB7pPB2IB3gbXfcn/hPiKLoHhQMk9R4pf6xRDQdW3gpL8/rW6g78fjlaPlt68de9csyBHLVZXFFeuJs7u+ssD1tgZHBqwOxmQZdnpcrFNj7/SvNiFlNM8z7BX0y7oHbWUTC5AK5Kf7lEfOwNgFvWy1LaH2X0c2fNmDG/BRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503392; c=relaxed/simple;
	bh=xuar8b5F+yPAqjPzqeMpgD+QsrKjykO039X3XloK3hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/hWJay6/1LfnnUJ5o/Tk4+M9GAZjR8p3F2Hu3viNASmTnF6tlOt0cAkgKjeABNi9qeuTwKWUluIynEh6Ea1cKBlz0LMBtmnLTIG+9SqjnK8w7PRg/f7ztHcRDcRWtKsD4gkx3eZ9tbihAZDQibYalQ8LYKhUx/gN6OBvLGKbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JAEnBZ7v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JAEnBZ7v"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlpqK4072834;
	Fri, 31 Jul 2026 13:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OkQi6lJzRSxxgmKxz
	ZVpGy+2ug0rjm50rJIvLb7+IaU=; b=JAEnBZ7vcUXz8JHUoCIoTibVbTSee/r5q
	MLS8XdxJ0Whfq/gEn2w7ul4gtp7FOCMPwdmlVH/UsPBr419LjaAHovOHiFX4SD7c
	XcCRC/V3Ti5UPb50Xf/1wgE+Up3gCdufiEXPB9PuhoKY+fP0iHX4UxAQs1QaOS1/
	8cIRn4eOG7MK7BkvFR0iPBG2WcrLvH09QsaTxuSlSJ6VFwguDoREgyDskOWlOqa9
	P9CS1dHweOqDClqQKXDm++5ZZoppgIaFgxCRn+BidAuhBP1lJ5PEmPIMNhlnVGyW
	/6XewKsIEiIRAflgbq8sQ46H7PUlY/xrRKw0TFB0rN+viiX7e4IgA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw2pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuP3j021771;
	Fri, 31 Jul 2026 13:09:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwg43t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD9Gst38600980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E76220040;
	Fri, 31 Jul 2026 13:09:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 361CC2004B;
	Fri, 31 Jul 2026 13:09:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:16 +0000 (GMT)
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
Subject: [PATCH v5 30/31] KVM: s390: arm64: Implement basic page fault handler
Date: Fri, 31 Jul 2026 15:08:58 +0200
Message-ID: <20260731130902.654679-31-seiden@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: CX6u7hOgM2lahaeGUIyNgM2spVhXnfPT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX2m7sBHGlQ4Zx
 rKq8pTy+bMlC76IQs+6sBPj9xcxaElELkdOHNC1YzAmiSZ6rVf8fMDq0o3TDX7ZeO/7J69Ort40
 QrZfLgM3YGrK9pBkj81yyilnFAgKZEAJJywGJSVe5OXEKfRuXY5boilAyMk6gvOqphSyLYuxIzd
 hCAcBAdBPoQW6s7mvkYcJIimj4xsh5c02+QcnpMp+uBpewnWXXyaB7crfwMxP9Ov/RrPCiholjC
 jbI8aVMHCL88BNyULDmcqEh4Bk5kQakTKlgE4tChTNgUoH4OxbeUc9r8XCFkN4ubPxYlRLETUgH
 WP+bgOX+IuSF4hrm7+UFwEUEc3p9TsQbeshzeLJVtUoC+nDUOV/CsMtMyT3AoVDE6GmrKbR/dNc
 qMbe5WavFkl+NDBsSJDBNtxQrDCzwnHDNeVDFeMTjQ1bk9juuDT2Qmam5i2gfbS0477qnMxvwUG
 Bj+JK3ObrTjrhmtg1cg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXxlcopMCDNssT
 v4mHwZtuiOTkNRzLOrhqi5mVj0ZrVViRKdFVj635Akla2JT8Xlb0U2xBMVd0pp1OBMKxCuXElys
 an51/Use5CVeoy2626oim5SniSFNg5o=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9e84 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=SwCwYoEPLhOQ47qcL8QA:9
X-Proofpoint-GUID: k8sd1qs-heYE6bAA979kOx7hE4ahHcsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Add host functionality to page in guest memory. If the guest does
something unexpected or illegal exit to userspace abort guest execution.
This behaviour will be changed to guest error injects once all sysregs
are accessible for the host.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/handle_exit.c |   2 +
 arch/s390/kvm/arm64/mmio.c        |  15 +++
 arch/s390/kvm/arm64/mmu.c         | 177 ++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/trace.h       |  24 ++++
 4 files changed, 218 insertions(+)
 create mode 100644 arch/s390/kvm/arm64/mmio.c
 create mode 100644 arch/s390/kvm/arm64/mmu.c

diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/handle_exit.c
index bbe0ea1ccd0e..9ba01ec66e34 100644
--- a/arch/s390/kvm/arm64/handle_exit.c
+++ b/arch/s390/kvm/arm64/handle_exit.c
@@ -55,6 +55,8 @@ static int handle_hvc(struct kvm_vcpu *vcpu)
 exit_handle_fn arm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
 	[ESR_ELx_EC_HVC64]	= handle_hvc,
+	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
+	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
 };
 
 /*
diff --git a/arch/s390/kvm/arm64/mmio.c b/arch/s390/kvm/arm64/mmio.c
new file mode 100644
index 000000000000..908a6b43ddf7
--- /dev/null
+++ b/arch/s390/kvm/arm64/mmio.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kvm_host.h>
+#include <linux/bitfield.h>
+
+#include <trace/events/kvm.h>
+
+#include <arm64/kvm_emulate.h>
+#include <arm64/sysreg.h>
+
+#include "trace.h"
+
+#define __INCL_GEN_ARM_FILE
+#include "generated/mmio.inc"
+#undef __INCL_GEN_ARM_FILE
diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
new file mode 100644
index 000000000000..71cd582f24ff
--- /dev/null
+++ b/arch/s390/kvm/arm64/mmu.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kvm_host.h>
+
+#include <arm64/kvm_emulate.h>
+
+#include <faultin.h>
+
+static inline bool kvm_s390_cur_gmap_fault_is_write(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sae_block.hai.pic == PGM_PROTECTION ||
+	       vcpu->arch.sae_block.hai.teid.fsi == TEID_FSI_STORE;
+}
+
+/*
+ * user_mem_abort() - handle a dat fault for the gmap of a vcpu
+ *
+ * Return: 0 on success, < 0 in case of error.
+ * Context: The mm lock must not be held before calling. May sleep.
+ */
+static int user_mem_abort(struct kvm_vcpu *vcpu, gpa_t fault_ipa,
+			  struct kvm_memory_slot *slot, hva_t hva)
+{
+	struct guest_fault f = { };
+	int ret;
+
+	if (kvm_s390_cur_gmap_fault_is_write(vcpu))
+		f.write_attempt = FOLL_WRITE;
+	f.gfn = gpa_to_gfn(fault_ipa);
+
+	ret = kvm_s390_faultin_gfn(vcpu, NULL, &f);
+	if (ret <= 0)
+		return ret;
+	if (ret == PGM_ADDRESSING)
+		/*
+		 * Without the relevant sysregs we cannot do anything for now.
+		 * Go back to userspace with an error. TODO sysreg handling
+		 */
+		return -ENOEXEC;
+	KVM_BUG_ON(ret, vcpu->kvm);
+	return -EINVAL;
+}
+
+static int kvm_handle_pic(struct kvm_vcpu *vcpu, bool *translation)
+{
+	switch (kvm_vcpu_fault_pic(vcpu)) {
+	/* expected cases: */
+	case PGM_ASCE_TYPE:
+	case PGM_REGION_FIRST_TRANS:
+	case PGM_REGION_SECOND_TRANS:
+	case PGM_REGION_THIRD_TRANS:
+	case PGM_SEGMENT_TRANSLATION:
+	case PGM_PAGE_TRANSLATION:
+		*translation = true;
+		break;
+	case PGM_PROTECTION:
+		break;
+	/* unexpected cases: */
+	case 0:
+		KVM_BUG(1, vcpu->kvm, "On MMU fault path but no fault occurred");
+		return -EFAULT;
+	default:
+		KVM_BUG(1, vcpu->kvm, "Unexpected program interrupt 0x%x, TEID 0x%016lx",
+			vcpu->arch.sae_block.hai.pic, vcpu->arch.sae_block.hai.teid.val);
+		send_sig(SIGSEGV, current, 0);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
+{
+	struct kvm_memory_slot *memslot;
+	bool translation = false;
+	phys_addr_t fault_ipa;
+	unsigned long esr;
+	unsigned long hva;
+	bool write_fault;
+	bool guest_size_err;
+	bool writable;
+	bool is_iabt;
+	int ret;
+	gfn_t gfn;
+	int idx;
+
+	esr = kvm_vcpu_get_esr(vcpu);
+	fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
+	is_iabt = kvm_vcpu_trap_is_iabt(vcpu);
+	guest_size_err = vcpu->arch.sae_block.icptr == SAE_ICPTR_GUEST_ADDRESS_SIZE;
+
+	if (guest_size_err) {
+		translation = true;
+	} else {
+		ret = kvm_handle_pic(vcpu, &translation);
+		if (ret)
+			return ret;
+	}
+
+	if (translation) {
+		/*
+		 * For both cases:
+		 * Without the relevant sysregs we cannot do anything for now.
+		 * Go back to userspace with an error. TODO sysreg handling
+		 */
+		if (fault_ipa >= BIT_ULL(get_kvm_ipa_limit()))
+			return -ENOEXEC;
+
+		if (fault_ipa >= kvm_phys_size(vcpu->kvm))
+			return -ENOEXEC;
+	}
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+
+	gfn = fault_ipa >> PAGE_SHIFT;
+
+	memslot = gfn_to_memslot(vcpu->kvm, gfn);
+	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
+	write_fault = kvm_is_write_fault(vcpu);
+	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
+		ret = -ENOEXEC;
+		/*
+		 * The guest has put either its instructions or its page-tables
+		 * somewhere it shouldn't have. Userspace won't be able to do
+		 * anything about this (there's no syndrome for a start).
+		 *
+		 * Without the relevant sysregs we cannot do anything for now.
+		 * Go back to userspace with an error. TODO sysreg handling
+		 */
+		if (is_iabt)
+			goto out_unlock;
+
+		if (kvm_vcpu_abt_iss1tw(vcpu)) {
+			/*
+			 * Without the relevant sysregs we cannot do anything for now.
+			 * Go back to userspace with an error. TODO sysreg handling
+			 */
+			goto out_unlock;
+		}
+
+		/*
+		 * Check for a cache maintenance operation. Assume the guest is
+		 * cautious and skip instruction
+		 */
+		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
+			kvm_incr_pc(vcpu);
+			ret = 1;
+			goto out_unlock;
+		}
+
+		/*
+		 * The IPA is reported as [MAX:12], so we need to
+		 * complement it with the bottom 12 bits from the
+		 * faulting VA. This is always 12 bits, irrespective
+		 * of the page size.
+		 */
+		fault_ipa |= kvm_vcpu_get_hfar(vcpu) & ((1 << 12) - 1);
+		ret = io_mem_abort(vcpu, fault_ipa);
+		goto out_unlock;
+	}
+
+	/* Userspace should not be able to register out-of-bounds IPAs */
+	VM_BUG_ON(fault_ipa >= kvm_phys_size(vcpu->kvm));
+	/*
+	 * Proper guest size faults have been injected.
+	 * In theory it's fine to have device memory higher than MSL,
+	 * even if not currently possible, but that would have been handled above.
+	 * So if we get here with a guest size intercept, we have a bug somewhere.
+	 */
+	VM_BUG_ON(guest_size_err);
+
+	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva);
+	if (!ret)
+		ret = 1;
+out_unlock:
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	return ret;
+}
diff --git a/arch/s390/kvm/arm64/trace.h b/arch/s390/kvm/arm64/trace.h
index 224670b80bb6..973054c5d11e 100644
--- a/arch/s390/kvm/arm64/trace.h
+++ b/arch/s390/kvm/arm64/trace.h
@@ -32,6 +32,30 @@ TRACE_EVENT(kvm_irq_line,
 		  __entry->type, __entry->vcpu_idx, __entry->irq_num, __entry->level)
 );
 
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
 #endif /* KVM_ARM64_TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.53.0

