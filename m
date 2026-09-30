Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08C53CA7F;
	Wed, 30 Sep 2026 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789730; cv=none; b=QDN8PQqEEj0RHd78dah/XWZkJYeAoht7gUDTMxnmteaUasllxsr61xUUUcBQEP2VsP0PXMlLVUnx59OPoLbK9x078FsBnx3TPx0/blOZ3JKQzzA0815Wqx1u/wOuddYx0zP/tLTfnZ6hneRQDx13/DFr/DSONTqclKFtos/L8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789730; c=relaxed/simple;
	bh=EM9NptUno0n3QzkWHY8v5l9kN9vajEh7kfk3IiC3D+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEh07byqH3ROiWMmE/7apfKMl/qrudem8OdsmxKoznX3NxenuX2xCYY3l1YsAqcr66OWl/uvQ5uubvFC4CmxL90QArk4cOIvVl59ggApD5XUHDxMY943d8PZcqbCxz0vPb0nItKLTAMWVLT2k3sG1SZkhe56/L3ox14m8ZP/XHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rZ3L3jo0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rZ3L3jo0"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5nd93166998;
	Wed, 30 Sep 2026 17:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9fA0JGsTq8eF6JI5S
	c/NDKiaV/rA/jTHVuxnnyyMSAQ=; b=rZ3L3jo0ceaCQuWUOWGi5lp5C63sxMjV2
	0ldYiyWXWeZoCQMa+ro8TWtjGwjzxxRGGZFsTRkR7FyiJNPhJaHyMnU8RxjTTiOl
	ISF8IoiXRlTKeuVQeUyv/pB4ZXWNpgUrhzzgFeT+qPt5GndEzOfyy+IPWFfgyz2t
	iV/OXLUCclR704/5hIUo5f6UPN95tESLk1IvW4SsAkWQN3joRxmHwfsLOk0UvAtG
	dhXYd4J2raA5EY3JtST/l3hHzp6dyVBpq3rUX/QsxYsP9krYmtQ+s7H2wbGTXRS4
	5EAdDITVRATqdR9SZws0LSmBWdzx4ZgI0e+4LSkgTUAZtTvOk2NVw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptdj6u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:35:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE3B9b3577012;
	Wed, 30 Sep 2026 17:35:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23mtn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYo3m49611096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CF8520067;
	Wed, 30 Sep 2026 17:34:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 226BC20063;
	Wed, 30 Sep 2026 17:34:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:50 +0000 (GMT)
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v9 23/24] KVM: s390: arm64: Implement basic page fault handler
Date: Wed, 30 Sep 2026 19:34:38 +0200
Message-ID: <20260930173441.66762-24-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173441.66762-1-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: X4u4SHsL50qES8AOz07BKU_YfSCIcMgS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX8QjB1Afe6aj5
 qOnm1i1YKqTWYhE9N2nozsrm81xHnAhs9IA/WPBL1ROF6Ndogb0b86mVONW3Uujm6caZANDLBCX
 o8ACD4fFhZ5S9eSW3SkBjX5PSShgRkVq9fl4GQruoZjP/L3ZE2cQvTZBM/7sSlJr/bJnY71nPml
 cx2VyB7koD1/r4oSiXomLJlFrE4edDYwmy0Clt6SDAnz9JgOERFvZKdg2+tP2WLiMqWpRBQAwsV
 1Cf1Y0XRheXBp7POIsz1l1CJ13WcmWOejjAG3bT1GRFAu/1P+mKcP2cP3waXpFijdE/ofauU6cG
 N4uC8l/iKmx8rnbgElvBpW63CGppo4uEtEfQPUCwOUQM5MgjSi2eSiYWch5fnZYqztCUoqK6zvZ
 sTIhFE8pU8Q2zukxIt0uNObOqGCEkEe9/TiTgaZQtwZYJi8MiY0Pz9gBhulVlpUxwdGAY61IT5p
 /+JLx9WiFiciruK5lvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfXzS09wJIXMQ93
 o9veDN4XhsOnSFdlipKwYEEjxo1KzEXW4LZbTnOkVlUh6AJxG3EzP+hscoiqhwx3sRyDEm0XVyL
 0+o5hUNBTjqAbwyXEgbzVSpnR/NZqMg=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abd4848 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=3pIEw1BXXd9wsrb1kXkA:9
X-Proofpoint-GUID: _0txshb6ax4UbcmBYMfJeUCJYeLMgAAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300070

Add host functionality to page in guest memory. If the guest does
something unexpected or illegal exit to userspace abort guest execution.
This behaviour will be changed to guest error injects once all sysregs
are accessible for the host. Add pre-fault handler.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/handle_exit.c |   2 +
 arch/s390/kvm/arm64/mmio.c        |  15 +++
 arch/s390/kvm/arm64/mmu.c         | 200 ++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/trace.h       |  49 ++++++++
 4 files changed, 266 insertions(+)
 create mode 100644 arch/s390/kvm/arm64/mmio.c
 create mode 100644 arch/s390/kvm/arm64/mmu.c

diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/handle_exit.c
index dbf6edaeefaf..e0c7773c2165 100644
--- a/arch/s390/kvm/arm64/handle_exit.c
+++ b/arch/s390/kvm/arm64/handle_exit.c
@@ -62,6 +62,8 @@ static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
 static exit_handle_fn arm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
 	[ESR_ELx_EC_HVC64]	= handle_hvc,
+	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
+	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
 };
 
 static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
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
index 000000000000..3c1c8a2def73
--- /dev/null
+++ b/arch/s390/kvm/arm64/mmu.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kvm_host.h>
+
+#include <arm64/kvm_emulate.h>
+
+#include <faultin.h>
+
+#include "trace.h"
+
+static inline bool kvm_s390_cur_gmap_fault_is_write(struct kvm_vcpu *vcpu)
+{
+	return (vcpu->arch.sae_block.hai.pic & PGM_INT_CODE_MASK) == PGM_PROTECTION ||
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
+	unsigned long hva;
+	bool write_fault;
+	bool guest_size_err;
+	bool writable;
+	bool is_iabt;
+	int ret;
+	gfn_t gfn;
+
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
+		if (fault_ipa >= vcpu->kvm->arch.guest_phys_size)
+			return -ENOEXEC;
+	}
+
+	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_esr(vcpu),
+		      kvm_vcpu_get_hfar(vcpu), fault_ipa);
+
+	kvm_vcpu_srcu_read_lock(vcpu);
+
+	gfn = fault_ipa >> PAGE_SHIFT;
+
+	memslot = gfn_to_memslot(vcpu->kvm, gfn);
+	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
+	write_fault = kvm_s390_cur_gmap_fault_is_write(vcpu);
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
+	VM_BUG_ON(fault_ipa >= vcpu->kvm->arch.guest_phys_size);
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
+	kvm_vcpu_srcu_read_unlock(vcpu);
+	return ret;
+}
+
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu, struct kvm_pre_fault_memory *range)
+{
+	struct guest_fault f = { .gfn = gpa_to_gfn(range->gpa), };
+	gpa_t end;
+	int rc;
+
+	rc = kvm_s390_faultin_gfn(vcpu, NULL, &f);
+	if (rc == PGM_ADDRESSING)
+		return -ENOENT;
+	if (rc > 0)
+		return -EIO;
+	if (rc < 0)
+		return rc;
+
+	if (f.ptep)
+		return PAGE_SIZE;
+
+	end = ALIGN(range->gpa + PAGE_SIZE, f.crste_region3 ? _REGION3_SIZE : HPAGE_SIZE);
+	return min(range->size, end - range->gpa);
+}
diff --git a/arch/s390/kvm/arm64/trace.h b/arch/s390/kvm/arm64/trace.h
index 0380e45fba28..ee232c4f5a6d 100644
--- a/arch/s390/kvm/arm64/trace.h
+++ b/arch/s390/kvm/arm64/trace.h
@@ -41,6 +41,55 @@ TRACE_EVENT(kvm_exit,
 		  __entry->vcpu_pc)
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
+TRACE_EVENT(kvm_guest_fault,
+	TP_PROTO(unsigned long vcpu_pc, unsigned long hsr,
+		 unsigned long hxfar,
+		 unsigned long long ipa),
+	TP_ARGS(vcpu_pc, hsr, hxfar, ipa),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	vcpu_pc		)
+		__field(	unsigned long,	hsr		)
+		__field(	unsigned long,	hxfar		)
+		__field(   unsigned long long,	ipa		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc		= vcpu_pc;
+		__entry->hsr			= hsr;
+		__entry->hxfar			= hxfar;
+		__entry->ipa			= ipa;
+	),
+
+	TP_printk("ipa %#llx, hsr %#08lx, hxfar %#08lx, pc %#016lx",
+		  __entry->ipa, __entry->hsr,
+		  __entry->hxfar, __entry->vcpu_pc)
+);
+
 #endif /* KVM_ARM64_TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.53.0

