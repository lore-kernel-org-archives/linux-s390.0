Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E237CD30;
	Thu,  2 Apr 2026 04:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103757; cv=none; b=aH/cFGCoQwOeCE/ylg8Ma8LHc3ggZaBn/b47MoodMkcCXTG8qLRHeLIpgillyYUEwALDccd7juTHl0FYwm8FRgIWLT7RXSHdHU+o5OdkCeN3MwFYxal7qAqvvjJY6Wi7Mw1wP4xm+k0DIspwL/GaRKZVxJfW/4VxWJQXwEeMYeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103757; c=relaxed/simple;
	bh=9KkiwKCHqsUuu8eSYdOSpx6S1qnQcrr22a6UX6XyWXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8+tx3xpSc/2awUpcuywarFiep8WL2Ah3yCS0qs03RtQ0mF3DMDohlx/A/yn4vK0dUfeqzY67o+/NH/KG3SHJwSITMfAo58XxSi3k0d6A33WvKhK2W44rpho9MzW6jBgyBvXylp69tQurtEqX/5ikvfxb12YMO3xDOaIcmiToFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IRo6mDJc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IRo6mDJc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631IfKxM3065805;
	Thu, 2 Apr 2026 04:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dt+YtqfXxbHQF/K0M
	gf12RHhGLVKWjqW7AsrXE4nIng=; b=IRo6mDJc5f1MX7TdjLc88iHCGkuBBY+Gt
	zb9+L5ic4w9HXHVzfSvm6VdLVjEVkhnrVVOKHaerTyH8S0beLroP0nHvlrZGJ6tG
	wITeu0wtKYC5ipa5M3ovMFP0sisf11jy4pGmp22OJbB6tZSUVq/U/+q0QDAtLAf1
	JIYkZPK9m49Ut8YR0mBl8VFzN8pW9v63YJGtWBoAXmx3UTK3nvf7dv0DyjNDKjtx
	1aMXI72f7fZb4eGm+d8ZQqeqHDu26HPDE8mU30izg2ENCehZN/rQTI2Hr1jd/PRz
	Fd0/v+vDrmBO3Q1KSAhxOXSpYojYxWbJ9bQQTepCcwdwCmNGiFxkw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcjed6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63217hvT013897;
	Thu, 2 Apr 2026 04:21:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkrhf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LZNJ30540302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B57AC2004D;
	Thu,  2 Apr 2026 04:21:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C3902004E;
	Thu,  2 Apr 2026 04:21:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:35 +0000 (GMT)
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
Subject: [PATCH v1 26/27] KVM: s390: arm64: Implement basic page fault handler
Date: Thu,  2 Apr 2026 06:21:22 +0200
Message-ID: <20260402042125.3948963-27-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cdeed4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Nic9AFD9ymdCC7qNTNsA:9
X-Proofpoint-GUID: FnsNHAl1_Vy_i2fNa--orAR7Aro7SDaE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfX6EugStXgVOIF
 KGx0GCEqbKnCdBNjCD3f9z3VEszSW1UQUBfyZlavid46R3hJARWmgxCwykzWGrKlTlWmiSeRRQX
 l8DZmjK0wNnzMp1ckiTn4IZocaIqHJaX2CayY2G87blkzf+sR6wJI5mQp0D3OAEhnXnb8v0cJtz
 YXnFxtPfQoNKmULPrHPF5v6zvlI1bEN6Mc7vVZb1snZyUZmZidSqrCAUWvXrokaFJKmQmdvTbNX
 2tg2vKGK36oF55xp+QLREBcYG3AJcOjfju3wOudGPD7EVuMORt/bMTzdUEjcMv/3gX0UsvWXDFl
 RnH/9IIMPZ6oMulp41DXrxfCS+9ve3lWr4MMiJ/wFcuZ1j+usMusnd9Xc5ExPGMLWrNjTCIWx6g
 dNW1RwoahDSBONoMIy2NmoKH1gCO1HMm74plBrOO/oJ6/KxJNL5hVtlfXO4OeTOFC3jmPfC88Ia
 xa3N8QwjshgMRNmOzvw==
X-Proofpoint-ORIG-GUID: FnsNHAl1_Vy_i2fNa--orAR7Aro7SDaE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020034

Add host functionality to page in guest memory. If the guest does
something unexpected or illegal exit to userspace which very likely has
to stop guest execution. This behaviour will be changed to guest error
injects once all sysregs are accessible for the host.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c         |   1 +
 arch/s390/kvm/arm64/handle_exit.c |   2 +
 arch/s390/kvm/arm64/mmu.c         | 153 ++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 arch/s390/kvm/arm64/mmu.c

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 71562a0c438c..5bd6914b484d 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -435,6 +435,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 				  vcpu->arch.sae_block.vir);
 			ret = -EINVAL;
 			break;
+		case SAE_ICPTR_HOST_ACCESS_EXCEPTION:
 		case SAE_ICPTR_SYNCHRONOUS_EXCEPTION:
 			ret = handle_trap_exceptions(vcpu);
 			break;
diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/handle_exit.c
index 89933a604876..debe8aa12c7c 100644
--- a/arch/s390/kvm/arm64/handle_exit.c
+++ b/arch/s390/kvm/arm64/handle_exit.c
@@ -46,5 +46,7 @@ static int handle_hvc(struct kvm_vcpu *vcpu)
 
 exit_handle_fn arm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
+	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
+	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_HVC64]	= handle_hvc,
 };
diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
new file mode 100644
index 000000000000..6499d82a5d5c
--- /dev/null
+++ b/arch/s390/kvm/arm64/mmu.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kvm_host.h>
+
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_mmu.h>
+
+#include "faultin.h"
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
+int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
+{
+	struct kvm_memory_slot *memslot;
+	bool translation = false;
+	phys_addr_t fault_ipa;
+	unsigned long esr;
+	unsigned long hva;
+	bool write_fault;
+	bool writable;
+	bool is_iabt;
+	int ret;
+	gfn_t gfn;
+	int idx;
+
+	esr = kvm_vcpu_get_esr(vcpu);
+	fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
+	is_iabt = kvm_vcpu_trap_is_iabt(vcpu);
+
+	switch (kvm_vcpu_fault_pic(vcpu)) {
+	/* expected cases: */
+	case PGM_ASCE_TYPE:
+	case PGM_REGION_FIRST_TRANS:
+	case PGM_REGION_SECOND_TRANS:
+	case PGM_REGION_THIRD_TRANS:
+	case PGM_SEGMENT_TRANSLATION:
+	case PGM_PAGE_TRANSLATION:
+		translation = true;
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
+	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva);
+	if (!ret)
+		ret = 1;
+out_unlock:
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	return ret;
+}
-- 
2.51.0

