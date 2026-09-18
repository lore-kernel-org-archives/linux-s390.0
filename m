Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E1502D6E;
	Fri, 18 Sep 2026 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738330; cv=none; b=ivyXe+JgM+7s2ZMq3WqVVZL4cIzv6UG1ZkHjpNmNNMkXJa07FtcAhtjpzlFvtf9oXnLHkI4q0AbJknS0ezjkI/5xf4ihMnjk7bNhovdaWo94dDv+5iPNRUoc8Ia6x4EcSSAQXTgJ93rrzVAOmFH4EEmzUSP8uAN6PGHQckN4x7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738330; c=relaxed/simple;
	bh=Igtzo4ZAUIMeboL6nvyBrtJqL9yWgkgj4eJjqsdq29U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=db9/ZfPCo7s/VGq20O5FIuhL5+3FW+AgRZ/Niw6f2m9PT9gyJJMvMVT4hlm0JzUgUnPOChI2pMMuJ91HAS2Ct3q3F0NhJjtwf/XiLSlTlyz6M2tmYCO1j3mQLvCJaFobW+s2bcwmfiNM/Fw/a4Z08kmPhqKecrsgJopk9H7Ud5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yvcs7m2m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yvcs7m2m"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA2l6Q990974;
	Fri, 18 Sep 2026 13:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5bWhfVzPu4VzVsjkF
	HOH8+kBpuzeVEALF5mZdRzVS3g=; b=Yvcs7m2mPcaL4er6SXqRfrF+OSi60lVpn
	4GL8hBoVJat0psJ47d+EnWMt68FnsXro3XEuV0o9HTDDOLjqD88SXPusAagPetBe
	MCqZdcUpxiE4n8zZLm6C6c9B6lgchymNumGvYrSkrK0A+d2CdIM2cv+Ngfl049RW
	gx7OWYmchS+0p1wImAY1MjGMYYQvSKTRuwTFuDXE94VT5nDjvFFlYipU1d9Fgqdb
	6FG3fQ7GxY73XBvUHS5YSUPmD/hHSMXXRzlMkdnNTqxK9bDoceWqwFOKx34lsnBw
	d3MexrA/gZPOuAxegyjzHAjB+rkTRMc934PaQoxKm3YZszagcCcsQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvfnpy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNqTH1684357;
	Fri, 18 Sep 2026 13:31:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gs4tv8bhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDVHFM46137662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F03720040;
	Fri, 18 Sep 2026 13:31:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC0ED2004E;
	Fri, 18 Sep 2026 13:31:16 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:16 +0000 (GMT)
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
Subject: [PATCH v8 25/29] KVM: s390: arm64: Implement vm/vcpu create destroy.
Date: Fri, 18 Sep 2026 15:31:02 +0200
Message-ID: <20260918133107.1042730-26-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918133107.1042730-1-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX+K1rinIdeTY9
 02Q6k4YrZwdbbngpeJiz0TGmTV6ZXVYuUEjulBbhY58GRm7iXcaoL60OFq3rceayhIRBYPaOYpN
 RESjeZpU4r08JQo5bmLMmieAFkSWXlM=
X-Proofpoint-ORIG-GUID: zoJtj4toVrlQv0NpegjIckOIa5du2B0e
X-Proofpoint-GUID: PpcavBm1dfhW-jrFxw7F1hP_znZDr0lZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfXwrVppTzFj6ij
 y3SXfzpekz0t5ZT9v26gG31x5HNFRZE8McG8uAMMRzrHGtNQ/JvN4zjqVjET06SnJJA1BPahEAv
 cbfrcKz3VysW5tyMNS2K36tevAYRpJwFV39MgVWq4SDWNcZK3Z70HorkP1maSnfUB3Eq4mmERoU
 XGmt40Ewyqftb1G8xBPImwh5JO79UanYYiCNMPJaUPSYWefje7r7F+z2Pg7obAN6B9MtdFGVLjR
 vfqqhnNlkb4i24rWwdkO8IEjGolR5Vw55db53Y9BjaZ9okMbDkb1ySwjldkoujdHQhLGNIMqMjQ
 rkWOG4UkPkYGn0cEY6bpmAcYR4dDZ27o+YzvxdXFLrfn8hgYRWuRzK9u9luc19qboKli2HBvQDd
 yzUibEufhHcAr9XFNLgZyAGDakAEpGyuumuzCaxjfZUirCPslVKYxZ/KR3MmKiGU3O/ax5HmP8Q
 3Askq5/efpA9eVf4I1w==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad3d2c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=5OF_qzzL2_CoOl6HhsoA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180184

Implement init and destroy IOCTLS for vcpu and vm.
Implement arch vm IOCTL. Use s390 gmap and gmap plumbing.
Implement function (stubs) required by gamp.

Co-developed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c       | 189 ++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/arm.h       |  14 +++
 arch/s390/kvm/gmap/faultin.c    |   5 +
 arch/s390/kvm/gmap/gmap.c       |   4 +
 arch/s390/kvm/gmap/kvm_mmu.c    |   4 +
 arch/s390/kvm/gmap/trace_gmap.h |  13 +++
 6 files changed, 229 insertions(+)

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 8b056fc836d7..446070fea29f 100644
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
@@ -51,6 +56,83 @@ static u64 kvm_max_guest_address(void)
 	return ALIGN_DOWN(max_addr + 1, SZ_1G) - 1;
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
+	kvm->arch.mem_limit = kvm->arch.guest_phys_size;
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
@@ -62,6 +144,13 @@ long kvm_arch_dev_ioctl(struct file *filp,
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
@@ -72,10 +161,43 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 	return 0;
 }
 
+int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sae_block *sae_block = &vcpu->arch.sae_block;
+	struct kvm_sae_save_area *save_area = &vcpu->arch.save_area;
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
+	sae_block->msl = vcpu->kvm->arch.mem_limit - 1;
+	sae_block->save_area = virt_to_phys(save_area);
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
@@ -101,6 +223,73 @@ static unsigned long system_supported_vcpu_features(void)
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
index b38eb44c11fe..c743595506fa 100644
--- a/arch/s390/kvm/arm64/arm.h
+++ b/arch/s390/kvm/arm64/arm.h
@@ -2,6 +2,20 @@
 #ifndef ARCH_S390_KVM_ARM64_H
 #define ARCH_S390_KVM_ARM64_H
 
+#include <linux/compiler_attributes.h>
+#include <linux/kvm_host.h>
+
+#define VM_EVENT(d_kvm, d_loglevel, d_string, d_args...)			\
+	debug_sprintf_event((d_kvm)->arch.dbf, d_loglevel,			\
+			    __stringify(KVM_DEV_NAME) ": " d_string "\n",	\
+			    d_args)
+
+#define VCPU_EVENT(d_vcpu, d_loglevel, d_string, d_args...)				\
+	debug_sprintf_event((d_vcpu)->kvm->arch.dbf, d_loglevel,			\
+		__stringify(KVM_DEV_NAME) " %02d[%016llx-%016llx]: " d_string "\n",	\
+		(d_vcpu)->vcpu_id, (d_vcpu)->arch.sae_block.pstate,			\
+		(d_vcpu)->arch.sae_block.pc, d_args)
+
 static __always_inline int kvm_is_ucontrol(struct kvm *kvm)
 {
 	return 0;
diff --git a/arch/s390/kvm/gmap/faultin.c b/arch/s390/kvm/gmap/faultin.c
index 1dc79807012c..2e93bd563d5c 100644
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
index 4968330e9553..b7071f50f7ad 100644
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
index b08b8229bb6f..a26a16193467 100644
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
diff --git a/arch/s390/kvm/gmap/trace_gmap.h b/arch/s390/kvm/gmap/trace_gmap.h
index 78d26dae59f9..1dce3ef3b0d9 100644
--- a/arch/s390/kvm/gmap/trace_gmap.h
+++ b/arch/s390/kvm/gmap/trace_gmap.h
@@ -13,6 +13,18 @@
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace_gmap
 
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
@@ -23,6 +35,7 @@
 #define __KVM_PRINT \
 	__entry->pswmask,\
 	__entry->pswaddr
+#endif
 
 TRACE_EVENT(kvm_s390_major_guest_pfault,
 	    TP_PROTO(struct kvm_vcpu *vcpu),
-- 
2.53.0

