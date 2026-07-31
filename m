Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBCA436BEB;
	Fri, 31 Jul 2026 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503389; cv=none; b=Lo4kld8eulQuK7meWLzVKUR8sQdg2ToQQyKjQpDfbgJ1H2g+G2jTmXCa9rAtX68Fd7y8QuOtXlUYffQKbHLp+KYPjBFXqtRD/pjCuWgTZmaPWQrRreOmXJ36NgcHgR1Tj+oC2SJW+Cm8xNEnzUhgDi+qnHWlqalmNcG+pnTmISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503389; c=relaxed/simple;
	bh=U5u8pYFuHc/djL1v1FJKF9JUCL7PuXIG+oJyyfvuIeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1VNCVmXVuTOHsT1lFonD4hkFJv8owDqGGBM97zI5wAAfeYowsX6SAy5Yhmx8zrMpAyV+YC3UQ8XhchBv7NS0wa8kb7dM0n87DNiraZ3Go9k+rFEFz6RQNRuKGvu0sgYG5GUunCpDjHB572vCIXzE69a116QGcHvdPV4v8zv+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=frDF2RPB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="frDF2RPB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlqkH1672879;
	Fri, 31 Jul 2026 13:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+/cIZB99tNNHsA1yP
	m1ALPIKiBsU5KwAtU/YTeR4q00=; b=frDF2RPBBz5k1cn79IGSJoBwch4nkqZHF
	qzVnxn/GX4Wv2En/6kUmLLbdACK3ZIEm4A/4buvktOH+GzdjqrtynCzaUcnup4gX
	dda9VxZfPJD/tAA2ih8XrJmtnVNUWJd82mXHHOxymEc/S+zt87CLOsQn+2P1CWm0
	92NYyQLNGg9dbVS01N2fLjcrrd0DK2P1cn0z0tSxx1l5KXarKopc/cxf6RkkHlfV
	37UcsEotXgq8tQFBmxzW5KiCPfL1NkyDEejub8hnfNdCFPJQ6ybBiPY00XTDAC5t
	KCnE6jjvMRGmmu33eO4wuvDQcZ+x0MblSFeX9LnPN4d6C+V8wrrcA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p43c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCQEsc026828;
	Fri, 31 Jul 2026 13:09:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqtca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD9FEL29819580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAA1220040;
	Fri, 31 Jul 2026 13:09:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 423ED2004B;
	Fri, 31 Jul 2026 13:09:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:15 +0000 (GMT)
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
Subject: [PATCH v5 28/31] KVM: s390: arm64: Implement vm/vcpu create destroy.
Date: Fri, 31 Jul 2026 15:08:56 +0200
Message-ID: <20260731130902.654679-29-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX1FOtXYcI6HXT
 2+DdQkpg+3PacJfvEGZSQFmpyzSmZWY1idioaDe7UfVq7IIEVVh5hfyG6Fb/PcR4RFXzZkypdF1
 7cBsNIEwQFKIiFPa8XC7sw4kXvqfNXs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXzN8c3D7I/mjq
 HXLG7BRqy6TQBstTuYn1Io8Eyr29hNs51eMbMlCI/vutykHzppl6pnuc5qKJcKnAiB0aKHwct6M
 LKTFhaF+mhIEaCf8LrrIQyvzrLwvQ5eVOJL7S4YgdAlELft0f4Ld1NuWiKT7bYO2fWnxym5BED4
 Brh6/7LaJnQOI9M0iLcgrHYUmzqMqTBjbRDVi4ZECR/Q+u6RfYsYGi5YTZjZZarjZa82dXMk6Sq
 6CtR1vcdA3Ge2j9PIIRbRGE1PgUSKba/sHhFESS1OFd7ii9yQu5atu2bqzFPSt5XelfoIx0CMzP
 O/pKuE+C17mnLq+fMV0aUjnei9ai7Oitz9YTl/Qc7sLZRL+G2uUcoI9L1BQ6OWhWNy3TIuXXR54
 ehgdKmI55DR+VKC/PrZxDtQVd5KfXmCaZ63jjnr5aYJkXp6XwETGR8/zdsbNq5YFr8HDxcVsblV
 ujJ6CPFs9l8qtrZBq2A==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6c9e84 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=uRPWEXon6BnYHkcjmioA:9
X-Proofpoint-GUID: -Z1VWjTKO5cBi3O0Cb_o2bfVtFLKZPNC
X-Proofpoint-ORIG-GUID: xIiEXqAYNsDd4VJaRvEDx8vBg--tVMqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Implement init and destroy IOCTLS for vcpu and vm.
Implement arch vm IOCTL. Use s390 gmap and gmap plumbing.

Co-developed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c       | 195 ++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/arm.h       |  51 +++++++++
 arch/s390/kvm/gmap/faultin.c    |   5 +
 arch/s390/kvm/gmap/gmap.c       |   4 +
 arch/s390/kvm/gmap/kvm_mmu.c    |   4 +
 arch/s390/kvm/gmap/trace-gmap.h |  13 +++
 6 files changed, 272 insertions(+)

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 8e17b7eef813..3f1bbbf38abe 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -8,6 +8,9 @@
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
 
+#include <gmap.h>
+#include <kvm_mmu.h>
+
 #include "arm.h"
 
 #define CREATE_TRACE_POINTS
@@ -19,6 +22,8 @@ static unsigned long system_supported_vcpu_features(void);
 #include "generated/arm.inc"
 #undef __INCL_GEN_ARM_FILE
 
+#define KVM_PHYS_SHIFT (40)
+
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
 	int ret;
@@ -53,6 +58,83 @@ static u64 kvm_max_guest_address(void)
 	return ALIGN_DOWN(max_addr + 1, 1 << 30) - 1;
 }
 
+static int kvm_gmap_init(struct kvm *kvm)
+{
+	struct crst_table *table;
+
+	kvm->arch.gmap = gmap_new(kvm, gpa_to_gfn(kvm->arch.guest_phys_size));
+
+	if (!kvm->arch.gmap)
+		return -ENOMEM;
+
+	/* arm64 (on s390) do not have pfault */
+	clear_bit(GMAP_FLAG_PFAULT_ENABLED, &kvm->arch.gmap->flags);
+	set_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &kvm->arch.gmap->flags);
+
+	table = dereference_asce(kvm->arch.gmap->asce);
+	crst_table_init((void *)table, _CRSTE_HOLE(table->crstes[0].h.tt).val);
+
+	return 0;
+}
+
+static int kvm_vm_type_ipa_size_shift(unsigned long type)
+{
+	int phys_shift;
+
+	phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
+	if (phys_shift) {
+		if (phys_shift > get_kvm_ipa_limit() ||
+		    phys_shift < ARM64_MIN_PARANGE_BITS)
+			return -EINVAL;
+	} else {
+		phys_shift = KVM_PHYS_SHIFT;
+		if (phys_shift > get_kvm_ipa_limit()) {
+			pr_warn_once("%s using unsupported default IPA limit\n",
+				     current->comm);
+			return -EINVAL;
+		}
+	}
+
+	return phys_shift;
+}
+
+int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
+{
+	char debug_name[32];
+	int ret;
+
+	if (type & ~KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
+		return -EINVAL;
+
+	ret = kvm_vm_type_ipa_size_shift(type);
+	if (ret < 0)
+		return ret;
+	kvm->arch.guest_phys_size = 1UL << ret;
+
+	mutex_init(&kvm->arch.config_lock);
+	bitmap_zero(kvm->arch.vcpu_features, KVM_VCPU_MAX_FEATURES);
+
+	snprintf(debug_name, sizeof(debug_name), "kvm-arm64-%u-%u",
+		 current->pid, get_random_u32());
+	kvm->arch.dbf = debug_register(debug_name, 32, 1, 7 * sizeof(long));
+	if (!kvm->arch.dbf)
+		return -ENOMEM;
+	debug_register_view(kvm->arch.dbf, &debug_sprintf_view);
+
+	ret = kvm_gmap_init(kvm);
+	if (ret)
+		goto out_err;
+	kvm->arch.mem_limit = kvm_max_guest_address();
+
+	VM_EVENT(kvm, 3, "vm created with type %lu", type);
+	return 0;
+
+out_err:
+	debug_unregister(kvm->arch.dbf);
+
+	return ret;
+}
+
 vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 {
 	return VM_FAULT_SIGBUS;
@@ -64,6 +146,13 @@ long kvm_arch_dev_ioctl(struct file *filp,
 	return -EINVAL;
 }
 
+void kvm_arch_destroy_vm(struct kvm *kvm)
+{
+	kvm_destroy_vcpus(kvm);
+	debug_unregister(kvm->arch.dbf);
+	kvm->arch.gmap = gmap_put(kvm->arch.gmap);
+}
+
 u32 get_kvm_ipa_limit(void)
 {
 	return fls64(kvm_max_guest_address() + 1) - 1;
@@ -74,10 +163,41 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 	return 0;
 }
 
+int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sae_block *sae_block = &vcpu->arch.sae_block;
+
+	spin_lock_init(&vcpu->arch.mp_state_lock);
+
+	/* Force users to call KVM_ARM_VCPU_INIT */
+	vcpu_clear_flag(vcpu, VCPU_INITIALIZED);
+
+	vcpu->arch.mc = kvm_s390_new_mmu_cache();
+	if (!vcpu->arch.mc)
+		return -ENOMEM;
+
+	sae_block->hbasce = vcpu->kvm->arch.gmap->asce.val;
+	sae_block->mso = 0L;
+	sae_block->msl = kvm_max_guest_address();
+
+	VM_EVENT(vcpu->kvm, 3,
+		 "create cpu %d at 0x%p, sae block at 0x%p, satellite at 0x%p",
+		 vcpu->vcpu_id, vcpu, &vcpu->arch.sae_block,
+		 &vcpu->arch.save_area);
+	return 0;
+}
+
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
 }
 
+void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
+{
+	kvm_s390_free_mmu_cache(vcpu->arch.mc);
+
+	VCPU_EVENT(vcpu, 3, "%s", "free cpu");
+}
+
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
@@ -103,6 +223,81 @@ static unsigned long system_supported_vcpu_features(void)
 	return features;
 }
 
+int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
+			       struct kvm_dirty_log *log)
+{
+	return s390_kvm_mmu_get_dirty_log(kvm, log);
+}
+
+bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	scoped_guard(read_lock, &kvm->mmu_lock)
+		return gmap_age_gfn(kvm->arch.gmap, range->start, range->end);
+}
+
+void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
+{
+	gfn_t last_gfn = memslot->base_gfn + memslot->npages;
+
+	scoped_guard(read_lock, &kvm->mmu_lock)
+		gmap_sync_dirty_log(kvm->arch.gmap, memslot->base_gfn, last_gfn);
+}
+
+int kvm_arch_prepare_memory_region(struct kvm *kvm,
+				   const struct kvm_memory_slot *old,
+				   struct kvm_memory_slot *new,
+				   enum kvm_mr_change change)
+{
+	return s390_kvm_mmu_prepare_memory_region(kvm, old, new, change);
+}
+
+void kvm_arch_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *old,
+				   const struct kvm_memory_slot *new,
+				   enum kvm_mr_change change)
+{
+	s390_kvm_mmu_commit_memory_region(kvm, old, new, change);
+}
+
+bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return gmap_unmap_gfn_range(kvm->arch.gmap, range->slot, range->start, range->end);
+}
+
+bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	scoped_guard(read_lock, &kvm->mmu_lock)
+		return dat_test_age_gfn(kvm->arch.gmap->asce, range->start, range->end);
+}
+
+#ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				    struct kvm_pre_fault_memory *range)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* ifdef CONFIG_ */
+
+int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+
+	switch (ioctl) {
+	case KVM_ARM_PREFERRED_TARGET: {
+		struct kvm_vcpu_init init = {
+			.target = KVM_ARM_TARGET_GENERIC_V8,
+		};
+
+		if (copy_to_user(argp, &init, sizeof(init)))
+			return -EFAULT;
+
+		return 0;
+	}
+
+	default:
+		return -EINVAL;
+	}
+}
+
 bool kvm_arch_irqchip_in_kernel(struct kvm *kvm)
 {
 	return false;
diff --git a/arch/s390/kvm/arm64/arm.h b/arch/s390/kvm/arm64/arm.h
index a3db254462c0..2e33800525e9 100644
--- a/arch/s390/kvm/arm64/arm.h
+++ b/arch/s390/kvm/arm64/arm.h
@@ -2,6 +2,57 @@
 #ifndef ARCH_S390_KVM_ARM64_H
 #define ARCH_S390_KVM_ARM64_H
 
+#include <linux/kvm_host.h>
+
 #define KVM_DEV_NAME "kvm-arm64"
 
+#define VM_EVENT(d_kvm, d_loglevel, d_string, d_args...)\
+do { \
+	debug_sprintf_event((d_kvm)->arch.dbf, d_loglevel, KVM_DEV_NAME ": " d_string "\n", d_args); \
+} while (0)
+
+#define VCPU_EVENT(d_vcpu, d_loglevel, d_string, d_args...)			\
+	do {									\
+		debug_sprintf_event(						\
+			(d_vcpu)->kvm->arch.dbf, d_loglevel,			\
+			KVM_DEV_NAME " %02d[%016llx-%016llx]: " d_string "\n",	\
+			(d_vcpu)->vcpu_id, (d_vcpu)->arch.sae_block.pstate,	\
+			(d_vcpu)->arch.sae_block.pc, d_args);			\
+	} while (0)
+
+static __always_inline int kvm_is_ucontrol(struct kvm *kvm)
+{
+	return 0;
+}
+
+static __always_inline int __kvm_s390_pv_destroy_page(struct page *page)
+{
+	return 0;
+}
+
+static __always_inline void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, gpa_t start, gpa_t end)
+{
+}
+
+static __always_inline int kvm_s390_pv_get_handle(struct kvm *kvm)
+{
+	return 0;
+}
+
+static __always_inline int kvm_s390_is_migration_mode(struct kvm *kvm)
+{
+	return false;
+}
+
+static __always_inline bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+/* should never be called */
+static __always_inline int kvm_s390_vm_stop_migration(struct kvm *kvm)
+{
+	return -EINVAL;
+}
+
 #endif /* ARCH_S390_KVM_ARM64_H */
diff --git a/arch/s390/kvm/gmap/faultin.c b/arch/s390/kvm/gmap/faultin.c
index 740415d494de..800e129ca40c 100644
--- a/arch/s390/kvm/gmap/faultin.c
+++ b/arch/s390/kvm/gmap/faultin.c
@@ -10,6 +10,11 @@
 
 #include "gmap.h"
 #include "faultin.h"
+#ifdef KVM_S390_ARM64
+#include "arm.h"
+#else
+#include "s390.h"
+#endif
 
 bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu);
 #define CREATE_TRACE_POINTS
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 07915278ee98..492a12a3a449 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -21,7 +21,11 @@
 
 #include "dat.h"
 #include "gmap.h"
+#ifdef KVM_S390_ARM64
+#include "arm.h"
+#else
 #include "s390.h"
+#endif
 #include "faultin.h"
 
 static int gmap_limit_to_type(gfn_t limit)
diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
index 40fee79eb71f..88d2187375da 100644
--- a/arch/s390/kvm/gmap/kvm_mmu.c
+++ b/arch/s390/kvm/gmap/kvm_mmu.c
@@ -3,7 +3,11 @@
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
 
+#ifdef KVM_S390_ARM64
+#include "arm.h"
+#else
 #include "s390.h"
+#endif
 #include "gmap.h"
 #include "dat.h"
 #include "kvm_mmu.h"
diff --git a/arch/s390/kvm/gmap/trace-gmap.h b/arch/s390/kvm/gmap/trace-gmap.h
index 78559298932c..25f8a527fdde 100644
--- a/arch/s390/kvm/gmap/trace-gmap.h
+++ b/arch/s390/kvm/gmap/trace-gmap.h
@@ -10,6 +10,18 @@
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace-gmap
 
+#ifdef KVM_S390_ARM64
+#define __KVM_FIELDS \
+	__field(unsigned long, pstate) \
+	__field(unsigned long, pc)
+#define __KVM_ASSIGN ({\
+	__entry->pstate = vcpu->arch.sae_block.pstate; \
+	__entry->pc = vcpu->arch.sae_block.pc; \
+	})
+#define __KVM_PRINT \
+	__entry->pstate, \
+	__entry->pc
+#else
 #define __KVM_FIELDS \
 	__field(unsigned long, pswmask) \
 	__field(unsigned long, pswaddr)
@@ -20,6 +32,7 @@
 #define __KVM_PRINT \
 	__entry->pswmask,\
 	__entry->pswaddr
+#endif
 
 TRACE_EVENT(kvm_s390_major_guest_pfault,
 	    TP_PROTO(struct kvm_vcpu *vcpu),
-- 
2.53.0

