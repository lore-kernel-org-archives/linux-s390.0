Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72B4DB56B;
	Mon,  6 Jul 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328013; cv=none; b=jwOwJ5XOaT5WKaTbMRqGXQu636CLOAksYuqKrxlJFYcHi/pBiR3105biYc/NT5+AiSScOqOsAOMGM7H65tF1W8oSlZILA3o4ELk1RR4z62ize+6qkPawXdQPX36TYJcEMCsTiubSyoRz6de+tejQ6L8HBpy5c3vmRcUcLO132aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328013; c=relaxed/simple;
	bh=ytoVC9ObPJO2h2iOEvzlq9KFTJnSE+rkcI9s4n7s8cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5Ntzj7PpkySxKR4jAFZjlaDJzR8ZhjU8/Dildh4RNd4WsoXEaNC7cl99/yLxT82eQ4Djn7ehFNKQ2c409kQlh4HbkrqNYn6A4/rdq3mxxTgK6k1OHZQ0Nrghvdjnmy3HS2FPQSCIUtwSLjpjJkNqUAO8mzoM6ap5thxAv+PKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C017Kw2D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C017Kw2D"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIPpa2304097;
	Mon, 6 Jul 2026 08:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WJ1DgvlbVQDOCiykA
	nAvYUJF0dXKBmZH19QD9OLzes4=; b=C017Kw2DBK8OfjxlKDW1cv+sZTSZgEIEF
	Fk1G3h/ohYVadP4AkpSar8Y3z1hXJzor9dVYmqQ6s9ewbydAr1wu67oxflqN14TP
	lX4RP2rTEZe4lAnvAoWZJxkCS0qfsXhQJDSgoNoe7P8VDqZBjLCjdyC12HLOP8JH
	lQUxbg4wpyUnzJJZXS7+Hg/8RLiSMcf4ur1K2ImORxh6B0irtl+G8KmmWnI3OypP
	pk0ciSuX2GsU6f6uki4vX+dh7eu0ac9uLjBQ50P6jJDJ9YmkmERqdLB3U2UEqx78
	AKpZpseosttwCQZunzmXFYDQqaZB0uIzdZbnjT1moy+FolowKxvRQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3gk88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nc8H023208;
	Mon, 6 Jul 2026 08:52:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvvyhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qf9I32440780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07FE020040;
	Mon,  6 Jul 2026 08:52:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 993B42004E;
	Mon,  6 Jul 2026 08:52:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:40 +0000 (GMT)
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
Subject: [PATCH v4 26/27] KVM: s390: arm64: Implement basic page fault handler
Date: Mon,  6 Jul 2026 10:52:26 +0200
Message-ID: <20260706085229.979525-27-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4b6ce1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Rlh8LM2epgzb96jMsLsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX7WqFNLh4AJ3y
 /DXNdWDSZ9mqdQQ0ICqS9c6GwtjsrXLWUErKMj+DYwc5LY9vbJhn7sR4sqw6H2tc7MewSgcYwmU
 eOQ7k0sMljkKnaE7h7KSWercBu1nkfs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXyb1V3fngxLWi
 d/InoXkuF53dT2kUKRdFRPZqIn8ivsCOm+frlJ04JjaSnyxy0m+iP87Fx6RDQ4jKTvaO7RM2CcI
 GTqwI6eSw47wj8zpRjorXyltQYF1Qrz2qz+OOxB/9M7rg8vpfuQUPdgC94IzXe9MIPXe0dH1Ubt
 Y7H1uALlA3lW1rR/lnow6aomm2Bml1CS19xdn3+Wo2LPP5kFE0XLYVvi1kZ+FGWIRf+h4x1+Sgm
 mqKmtHYO6a9I7X5w5crOdndS5E2X5a1sV4Rst7aVYQsgLcgCdml4s0uiKFg0crJsy9sFToneApN
 q4eg/WSn/wCru/79R6U2647Yeok+Q3Ev/28hCehNbDl4QDhGt4zjseXN8bXjIn7mnRL3ib3YO7U
 miZZTjhs5xIxVZUMd+RjCii/rFl7pRfSdM60zJ61qk7GhhwwxAEq8ZAqdunoajZOtRnd0s3oXCK
 T3FXp8Wg8mMtae0fyFA==
X-Proofpoint-ORIG-GUID: CZMSNUYCy7xhAcyFpTqNKe9JbL0WYb0O
X-Proofpoint-GUID: CZMSNUYCy7xhAcyFpTqNKe9JbL0WYb0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

Add host functionality to page in guest memory. If the guest does
something unexpected or illegal exit to userspace abort guest execution.
This behaviour will be changed to guest error injects once all sysregs
are accessible for the host.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/handle_exit.c |   2 +
 arch/s390/kvm/arm64/mmio.c        |  12 ++
 arch/s390/kvm/arm64/mmu.c         | 178 ++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 arch/s390/kvm/arm64/mmio.c
 create mode 100644 arch/s390/kvm/arm64/mmu.c

diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/handle_exit.c
index 1cd19506b133..96a45483e5b6 100644
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
index 000000000000..cfddfe322196
--- /dev/null
+++ b/arch/s390/kvm/arm64/mmio.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kvm_host.h>
+#include <linux/bitfield.h>
+
+#include <arm64/kvm_emulate.h>
+#include <arm64/kvm_mmu.h>
+#include <arm64/sysreg.h>
+
+#define __INCL_GEN_ARM_FILE
+#include "generated/mmio.inc"
+#undef __INCL_GEN_ARM_FILE
diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
new file mode 100644
index 000000000000..d5acabd762ba
--- /dev/null
+++ b/arch/s390/kvm/arm64/mmu.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kvm_host.h>
+
+#include <arm64/kvm_emulate.h>
+#include <arm64/kvm_mmu.h>
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
-- 
2.53.0

