Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D264657EE;
	Tue, 28 Apr 2026 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391839; cv=none; b=IuzSEUY0LG0xrdGvop7nFtliNu1onaCBQE+od2tN7GmyfguP0jUrIYVg4RFxKz5R0P48LDIfVlWsxEmY3IDCSbRZtbua5AAUGoFxn6pUMeWQ7cWNH5wTpqJe9LwT0exsC0plkXO0wmv/lO4/dRpeaa4NQJzHM+D7s16LIM3KphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391839; c=relaxed/simple;
	bh=3ApLBVjX6sU3g6TFoPt/JAe7K3vgGelCDSB0+/0cpNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyGEKak2AcfuvYrFaT82FLrvNnQxVgwd5G8SDy02k9bBjYpYKvcWOBtb/p1AfD885gPKdC/EjZsYXIDpa7RUnZTRG3aolowXbhGoC3k1F1G27rY9+Loz3vkOkT43nwG9l4RgcwJJJNmq/ApajpRtnA+YT4P8dbG7/9xWbvEmqzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QyXruvgK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QyXruvgK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S5amwp3291685;
	Tue, 28 Apr 2026 15:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+m6JZiatKFpFBFLKp
	vk3K++1nuaoJKHmPHcm8L6odjM=; b=QyXruvgKFpRfQdSY2EUaBIERa704r7mWI
	WEU5fl8Rj0AdtVkxaonkZ0WFaE1lcx1zK+5oU6Y/IjdcorMLoVppfXwLlZw/9D16
	C5HkJrCyojlW82I3bb1yHzgJIXvrTX0Bul4FG9cVeAmMQWEBQvWwXcg45pi8QNCh
	2mx/6OlDdcSjufDSUT6TzCbXi34eYpKTz0iqtz0ZIMKi+ukYowyDCnXI5MhqFjvU
	caZlihvl3gu+WsnuHJ7oPUORqCHMwDZpByZ9i+eZ7N6ECmErmIyzMt+jku+PAiK5
	rAbIG8If0xkvRexj4jTd7B80e0tRzlILXKzDpD/IgACtHLu9PaN5w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jnd23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrrL6006567;
	Tue, 28 Apr 2026 15:56:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqagyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuWa031785562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F55720043;
	Tue, 28 Apr 2026 15:56:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E15B2004B;
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
Subject: [PATCH v2 25/28] KVM: s390: arm64: Implement vm/vcpu create destroy.
Date: Tue, 28 Apr 2026 17:56:17 +0200
Message-ID: <20260428155622.1361364-26-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfXyQV2wId11wVH
 W8Wx536UtheXTJua1A5GrekEnh32R88Ixm61eazYCxsRHVy1aUo9DkDtF5S8f3FWUs2mkCVhny2
 3Mu7G2ZegHYdCav1r3BOJx4bMqSMqccEQYTwrGlBsPKMPGCy8cSGbZXWZZOtpS11qie2e9SePK3
 3JuZrIK55YC16wu9sA2RVxIG5VoB/DcrTdkKIxAUTLBk3hWNvgqW0FfYwx6x6WPBqO2QNRZYtcV
 0b+zCSi26SfJO7OIIebS8OahG5ifKu54HuCUl0CYFva/iq80qotkffAiKgjOuCOgBnfWakW0sO2
 DE7nWayU9A/UlePcSkepivQ9+/vjy+gVjC5ylB/z4sBmLQVpIqLXdJkrVhYQK5gtOkL0vXSAkd/
 wtSeBk5LA3kggyqq0SOJvGLyFiGGxgwtn7nd/n9J08LGTMPiU1T28FI1BhfyWBqmjDglPY+WiEE
 J5TI8XK8YG7K5GXQJPQ==
X-Proofpoint-GUID: PcFjex6moab0NfC9Uprxk_Vpj7DjQyFC
X-Proofpoint-ORIG-GUID: PcFjex6moab0NfC9Uprxk_Vpj7DjQyFC
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f0d8b5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=RC2V8De_2s-pDU17uugA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280151

Implement init and destroy IOCTLS for vcpu and vm.
Implement arch vm IOCTL. Use s390 gmap.

Co-developed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c | 161 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/arm.h |  54 +++++++++++++
 2 files changed, 215 insertions(+)

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 8f94eb8fe288..77bc4a8841df 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -8,7 +8,10 @@
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
 
+#include <gmap.h>
+
 #include "arm.h"
+#include "reset.h"
 
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 {
@@ -41,6 +44,61 @@ static u64 kvm_max_guest_address(void)
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
+	snprintf(debug_name, sizeof(debug_name), "kvm-arm64-%u", current->pid);
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
@@ -52,6 +110,13 @@ long kvm_arch_dev_ioctl(struct file *filp,
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
@@ -62,10 +127,39 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
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
+	VM_EVENT(vcpu->kvm, 3, "create cpu %d at 0x%p, sae block at 0x%p, satellite at 0x%p",
+		 vcpu->vcpu_id, vcpu, &vcpu->arch.sae_block, &vcpu->arch.save_area);
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
 void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
 }
@@ -103,6 +197,52 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 	return 0;
 }
 
+int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
+			       struct kvm_dirty_log *log)
+{
+	return gmap_get_dirty_log(kvm, log);
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
+	return gmap_prepare_memory_region(kvm, old, new, change);
+}
+
+void kvm_arch_commit_memory_region(struct kvm *kvm,
+				   struct kvm_memory_slot *old,
+				   const struct kvm_memory_slot *new,
+				   enum kvm_mr_change change)
+{
+	gmap_commit_memory_region(kvm, old, new, change);
+}
+
+bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return gmap_unmap_gfn_range(kvm->arch.gmap, range->slot, range->start, range->end);
+}
+
+bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return gmap_test_age_gfn(kvm, range);
+}
+
 void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 					     struct kvm_memory_slot *slot,
 					     gfn_t gfn_offset,
@@ -110,6 +250,27 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 {
 }
 
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
index a3db254462c0..df6a9099a864 100644
--- a/arch/s390/kvm/arm64/arm.h
+++ b/arch/s390/kvm/arm64/arm.h
@@ -4,4 +4,58 @@
 
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
+static __always_inline bool kvm_s390_is_in_sie(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
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
-- 
2.51.0

