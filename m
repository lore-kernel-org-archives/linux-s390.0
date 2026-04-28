Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2631B824;
	Tue, 28 Apr 2026 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391822; cv=none; b=PBt5VI64d+eLWDmDcQncQ5p2/eC6pLkBccEyMMUNCdW9vlcC5FlM00RjgIjJPr1HCTSPdm3/qgjYANUXSkssbaJdtD5yXD0yCZYKea8bProcD92qIQo3hlQqv/I/Ofozso7yPi424CFxy0MfysECpkK4383A4W4Xsi63stsHqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391822; c=relaxed/simple;
	bh=k/4f5X/miPNM51Im03YMDQ6DGnrXuj/EbwgqPS+/gc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqdltwhqX2gknGGmJhy2cSYFosiQOlGepl0liNleHd/zZ7bpQsQERwbJT7UFHE2CA8gVbv4uKP4zP9Vh0Pp3Y/c0v4hlb00OagLh0wg6XcqH6Q8FRlRrymHQD6BOi9Mc7enysQnGFYCM5txsICUJ2QOtKAz5MvqnmGEMk/ouuLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ISgi7R2o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ISgi7R2o"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S427e72713609;
	Tue, 28 Apr 2026 15:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qiNJZHzd0jXc2OG6W
	Kmf78aMkno/avXKkASrSNH713Y=; b=ISgi7R2oFE9b+mLqFz8ygMXoZ9os9GBTy
	j8fPqEt+Y2y1JRvBZE2WASisFQ4RbjSqsqXG5ARCkETgPlK/BvOjMYbkfaV/zjgx
	eUW+T3Cc/lQgePjDSWlSA30X6Q6N+a89cW881tex55kIXBYp2+pHGwLY/ev8o095
	Tcw2it7qrSJw7olWR4YKehIlidCGm+awDlQaIZSa+kZsStPzcrY1erSriHiohrvF
	MsKpMBDX5DEk61wIzvjmkEda7x+NeVw9PGhaZhdVEiBExPA+sFersNTwF+yaRZfv
	ze9EnOGBidIS4shjBaXFFZQS5/bnNesmoibIDJvwjB6QnEjmN4NnQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r6c9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrxOc002865;
	Tue, 28 Apr 2026 15:56:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk2d4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuXsp36897268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19C7F20040;
	Tue, 28 Apr 2026 15:56:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD6592004B;
	Tue, 28 Apr 2026 15:56:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:32 +0000 (GMT)
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
Subject: [PATCH v2 27/28] KVM: s390: arm64: Implement basic page fault handler
Date: Tue, 28 Apr 2026 17:56:19 +0200
Message-ID: <20260428155622.1361364-28-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428155622.1361364-1-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VwPikQ6NXIPHCeFvY7pgeebouXeYbOIy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX8TAhPthM1ljn
 OboUHfLUwuA1N/787+QZZRXVjezyR+j5e+tHdq6+MsAd3zaKZxgC6UiRsTOpaS0lP3Pr5EwlXGE
 Z2BkqhykWj6E5ACW4OR0xGoW4zwdpYaaQNNEyAT5QorpJMELJ94hckhccP2dJCBlGN8KjrU8HXg
 I28sf0ulVSk7HZcgakM3/FTQSUfZc2084d+OcnZB9ddw+NSSETX+M72aQ1NW3odzL2gvfwBGzIu
 pc2TAjozPlCWwWoaeSJGUZTKEMUngRZlVoQVPTHXL2vEaPdvwKvnMEH68vKhKxHN35hVaYIohbZ
 7QEU5SmCpMod13a2S7N/d0wgXWTrOKA5WKyvwM2m2xCMljAP5WvjEZt68bictAmDyJEOHTEgsP6
 0iOQ1HcY8IUfgy8F8INJPpbA8LLLEgoLUpKwjwqJyVqtU/1QlqK/Y74vmfp3D0cPuGtcJw7Y2XJ
 SvITgaiJMay7t2e3Z6Q==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f0d8b6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Rlh8LM2epgzb96jMsLsA:9
X-Proofpoint-ORIG-GUID: VwPikQ6NXIPHCeFvY7pgeebouXeYbOIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280151

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
 arch/s390/kvm/arm64/mmu.c         | 178 ++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 arch/s390/kvm/arm64/mmu.c

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index b629bef84eda..e15dad763847 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -429,6 +429,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
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
index 000000000000..8759cbafbaff
--- /dev/null
+++ b/arch/s390/kvm/arm64/mmu.c
@@ -0,0 +1,178 @@
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
-- 
2.51.0

