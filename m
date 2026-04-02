Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769643630A4;
	Thu,  2 Apr 2026 04:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103751; cv=none; b=XRjuJmeOlm7vudbs1K9ffwSVkJnuFVPGmD6K0VTiIGrBSHO4pMF5t/+fUdrO7pvk9K2CxLB56QKKhcB8gmgzcQXDL24KmbneXpift9StHoMZ19pgHFu/LuIgslB3ixfPb6HOZQdioEZ4dRayKuonSJKeJok1OIq+Iulm00+eTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103751; c=relaxed/simple;
	bh=k26vLeD2QgzEqC0UnKB+PoFjwz/rML1rV+5HZDHHT4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyCbl/Qmv7X65VX4o2G+jmeOguffBqXO6g+ZLCiM4CRw6QA7Zg/r12ZOMXMmmAs3TXMwguA6BaAMBoFmZEcdYk8nz/US8k0XugU0N/TB7Dkq6EOGD75JcAfeklnbUkDxxaT5V5lhtZ6FZYuLpeg4mZiU8cE1tFVe0kkfRrnZDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ilyAI0pf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ilyAI0pf"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631Jfn173676159;
	Thu, 2 Apr 2026 04:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9mOTGC9GPo+WPTn7r
	0qaWTWOQjW7rFCZLtJ4PYnqd54=; b=ilyAI0pfdH9T3IAdK+8jzNTlAoPfp/g1T
	TWkvLysiwlqvL+PCIMg8oubVwHNl27Z+byT9o0++rmQel+XdxwEJfsUejy/Bnc8V
	CT5Cr228twpPQ8EKX1camLTW9FlJbmbN+4pVXi3eECkvKTwwNhCEy4HyiFPPwqXz
	ziWcsxbNK8OQjrdGJ7YStmBPhJd4fbYDlj0uJHhoSFOwssUh+ADAB3GXWWf/gqcL
	77SLABy2ho8BpBGIfAPXhwWfLGy4OK0PrfpGYDvoOGZPO0b7SR2DohQPoy9pRgSy
	3cPObsSTGAOla2kelmWsOgFjTpWL8ea60TUz6kCbQeRTD4h+HUBTg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msabrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6321UKj4030947;
	Thu, 2 Apr 2026 04:21:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk0edx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LQjp55247178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA5AB20043;
	Thu,  2 Apr 2026 04:21:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8656E2004F;
	Thu,  2 Apr 2026 04:21:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:26 +0000 (GMT)
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
Subject: [PATCH v1 02/27] KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio
Date: Thu,  2 Apr 2026 06:20:58 +0200
Message-ID: <20260402042125.3948963-3-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cdeecb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=VFmQUFSrCZiC7oI7mJkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfX7pOq5HtFrfSz
 YCmmDxJdORVt5YVAJv3a9HnJc0W0yIBMW/Fys8yXignuutF1vpvstnPbdfO2xQibJkkbh6OZi82
 C8Qx/pF5iIN4CoLxZpJZSFZr/zV8HMGkK24GQbQzapR0VK6aMjGbCyc5HVacTO6WHmeP8e18dJA
 b/wHIKAMJvuQYfe2Gr8Hsd8TaHs4EJATbxty0PFA3AT9jlaIJFZTgkKXFtAl7vXJ/Qa7BN2V3Ks
 kJeAf9f24OjzVkhtUgq2BMIay5VRmy7683xncp6XkHkEwIvB/dEq7QDmbv5UVXAa65jMmt/qUn3
 rpehEtqY18J/eZmoKe2HmtptdvUb9jrDqVlucdgNkHkHjrdwLhKBg5eL6yZ6BolfB0Kgn/Ln2Hu
 dd081cxfzwuwOkiozeoDIAB9PV/3hKK2SrCIOXQKWmRPhWfeWWtjOsI1kUoJaKoO6piZjcPfIY3
 Z+CewsJQlQEy8ySd1lw==
X-Proofpoint-GUID: 5I24hyJiqx5xc0-Em5Rb1QuQEZPb3Z9-
X-Proofpoint-ORIG-GUID: 5I24hyJiqx5xc0-Em5Rb1QuQEZPb3Z9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020034

From: Paolo Bonzini <pbonzini@redhat.com>

Right now, KVM and VFIO are using symbol_get to access each other's
symbols because of a circular reference between the modules, as well
as to avoid loading them unnecessarily.

However, usage of symbol_get is mostly deprecated and there are just a
handful of users left. In the case of VFIO, in particular, the
functions it calls can be made inline. Start with kvm_get_kvm_safe, for
which it is trivial to do so.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c |  2 +-
 arch/x86/kvm/vmx/nested.h  |  4 ++--
 drivers/vfio/vfio_main.c   | 10 +---------
 include/linux/kvm_host.h   |  9 +++++----
 include/linux/kvm_types.h  | 24 ++++++++++++++++++++++++
 virt/kvm/kvm_main.c        | 26 +++++---------------------
 6 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 9c26038f6b77..a88686b5db24 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1136,7 +1136,7 @@ void kvm_tdp_mmu_invalidate_roots(struct kvm *kvm,
 	 * being destroyed in an error path of KVM_CREATE_VM.
 	 */
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING) &&
-	    refcount_read(&kvm->users_count) && kvm->created_vcpus)
+	    refcount_read(&kvm->rc.users_count) && kvm->created_vcpus)
 		lockdep_assert_held_write(&kvm->mmu_lock);
 
 	/*
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 213a448104af..2c83fc905698 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -58,7 +58,7 @@ bool nested_vmx_check_io_bitmaps(struct kvm_vcpu *vcpu, unsigned int port,
 static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
 {
 	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
-			    !refcount_read(&vcpu->kvm->users_count));
+			    !refcount_read(&vcpu->kvm->rc.users_count));
 
 	return to_vmx(vcpu)->nested.cached_vmcs12;
 }
@@ -66,7 +66,7 @@ static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
 static inline struct vmcs12 *get_shadow_vmcs12(struct kvm_vcpu *vcpu)
 {
 	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
-			    !refcount_read(&vcpu->kvm->users_count));
+			    !refcount_read(&vcpu->kvm->rc.users_count));
 
 	return to_vmx(vcpu)->nested.cached_shadow_vmcs12;
 }
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index b1b753889a77..42f515519d87 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -437,7 +437,6 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm,
 			      struct module *kvm_module)
 {
 	void (*pfn)(struct kvm *kvm);
-	bool (*fn)(struct kvm *kvm);
 	bool ret;
 
 	lockdep_assert_held(&device->dev_set->lock);
@@ -452,14 +451,7 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm,
 	if (WARN_ON(!pfn))
 		return;
 
-	fn = symbol_get(kvm_get_kvm_safe);
-	if (WARN_ON(!fn)) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
-
-	ret = fn(kvm);
-	symbol_put(kvm_get_kvm_safe);
+	ret = kvm_get_kvm_safe(kvm);
 	if (!ret) {
 		symbol_put(kvm_put_kvm);
 		return;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6b76e7a6f4c2..dc18ee99bba4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -767,6 +767,9 @@ struct kvm_memslots {
 };
 
 struct kvm {
+	/* Must be the first field, see function definitions in kvm_types.h.  */
+	struct kvm_refcount rc;
+
 #ifdef KVM_HAVE_MMU_RWLOCK
 	rwlock_t mmu_lock;
 #else
@@ -830,7 +833,6 @@ struct kvm {
 	struct list_head ioeventfds;
 	struct kvm_vm_stat stat;
 	struct kvm_arch arch;
-	refcount_t users_count;
 #ifdef CONFIG_KVM_MMIO
 	struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
 	spinlock_t ring_lock;
@@ -876,6 +878,7 @@ struct kvm {
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
 };
+static_assert(offsetof(struct kvm, rc) == 0);
 
 #define kvm_err(fmt, ...) \
 	pr_err("kvm [%i]: " fmt, task_pid_nr(current), ## __VA_ARGS__)
@@ -1062,8 +1065,6 @@ static inline void kvm_irqfd_exit(void)
 int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module);
 void kvm_exit(void);
 
-void kvm_get_kvm(struct kvm *kvm);
-bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
@@ -1073,7 +1074,7 @@ static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
 	as_id = array_index_nospec(as_id, KVM_MAX_NR_ADDRESS_SPACES);
 	return srcu_dereference_check(kvm->memslots[as_id], &kvm->srcu,
 			lockdep_is_held(&kvm->slots_lock) ||
-			!refcount_read(&kvm->users_count));
+			!refcount_read(&kvm->rc.users_count));
 }
 
 static inline struct kvm_memslots *kvm_memslots(struct kvm *kvm)
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..add7cc2016e8 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -33,6 +33,7 @@
 
 #include <linux/mutex.h>
 #include <linux/spinlock_types.h>
+#include <linux/refcount.h>
 
 struct kvm;
 struct kvm_async_pf;
@@ -140,6 +141,29 @@ struct kvm_vcpu_stat_generic {
 };
 
 #define KVM_STATS_NAME_SIZE	48
+
+struct kvm_refcount {
+	refcount_t users_count;
+};
+
+static inline void kvm_get_kvm(struct kvm *kvm)
+{
+	struct kvm_refcount *rc = (struct kvm_refcount *)kvm;
+
+	refcount_inc(&rc->users_count);
+}
+
+/*
+ * A safe version of kvm_get_kvm(), making sure the vm is not being destroyed.
+ * Return true if kvm referenced successfully, false otherwise.
+ */
+static inline bool kvm_get_kvm_safe(struct kvm *kvm)
+{
+	struct kvm_refcount *rc = (struct kvm_refcount *)kvm;
+
+	return refcount_inc_not_zero(&rc->users_count);
+}
+
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __KVM_TYPES_H__ */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9093251beb39..cb5e01f92503 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1099,7 +1099,7 @@ static inline struct kvm_io_bus *kvm_get_bus_for_destruction(struct kvm *kvm,
 							     enum kvm_bus idx)
 {
 	return rcu_dereference_protected(kvm->buses[idx],
-					 !refcount_read(&kvm->users_count));
+					 !refcount_read(&kvm->rc.users_count));
 }
 
 static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
@@ -1153,7 +1153,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	if (r)
 		goto out_err_no_irq_routing;
 
-	refcount_set(&kvm->users_count, 1);
+	refcount_set(&kvm->rc.users_count, 1);
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		for (j = 0; j < 2; j++) {
@@ -1223,7 +1223,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 out_err_no_disable:
 	kvm_arch_destroy_vm(kvm);
 out_err_no_arch_destroy_vm:
-	WARN_ON_ONCE(!refcount_dec_and_test(&kvm->users_count));
+	WARN_ON_ONCE(!refcount_dec_and_test(&kvm->rc.users_count));
 	for (i = 0; i < KVM_NR_BUSES; i++)
 		kfree(kvm_get_bus_for_destruction(kvm, i));
 	kvm_free_irq_routing(kvm);
@@ -1316,25 +1316,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	mmdrop(mm);
 }
 
-void kvm_get_kvm(struct kvm *kvm)
-{
-	refcount_inc(&kvm->users_count);
-}
-EXPORT_SYMBOL_GPL(kvm_get_kvm);
-
-/*
- * Make sure the vm is not during destruction, which is a safe version of
- * kvm_get_kvm().  Return true if kvm referenced successfully, false otherwise.
- */
-bool kvm_get_kvm_safe(struct kvm *kvm)
-{
-	return refcount_inc_not_zero(&kvm->users_count);
-}
-EXPORT_SYMBOL_GPL(kvm_get_kvm_safe);
-
 void kvm_put_kvm(struct kvm *kvm)
 {
-	if (refcount_dec_and_test(&kvm->users_count))
+	if (refcount_dec_and_test(&kvm->rc.users_count))
 		kvm_destroy_vm(kvm);
 }
 EXPORT_SYMBOL_GPL(kvm_put_kvm);
@@ -1348,7 +1332,7 @@ EXPORT_SYMBOL_GPL(kvm_put_kvm);
  */
 void kvm_put_kvm_no_destroy(struct kvm *kvm)
 {
-	WARN_ON(refcount_dec_and_test(&kvm->users_count));
+	WARN_ON(refcount_dec_and_test(&kvm->rc.users_count));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_put_kvm_no_destroy);
 
-- 
2.51.0

