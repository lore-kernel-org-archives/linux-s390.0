Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8447AF57;
	Mon,  6 Jul 2026 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328000; cv=none; b=EQEC5NRQ9NVKgkgjmg/gBeONJtX2/f4JfhoW71M/71Uj4BgDqAp98o/SsBUyA7IH8G5Vuh+sy9pfIyk6ypR5ZkX+Tz1uJ/J7m21wIUYPoG51YfsbuEkptWDc7w5kbcDO8J1lYRe0Lzf6VXja5usu6P2IYa+V82ylKyIH+DBXkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328000; c=relaxed/simple;
	bh=mqiS5aSaWMKynGmIRqp2ymuzP6rEI7l6eDAztPt3R1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6LOf9mazY3CupEZ+5co1n+ajUpBj0qi2lGGJkqDiUEFbDvQcyOBLxqrD8YLHvCq+e+UpIjxB3lsnqlskXunT2Z+DeQJTXJQKQ8fZunTpZ72dRCculSILDq16lHyzkzYmo5cIJzKp+zQP75BZj2YyFaMf9v+nxOjMz3A477Z+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hVSbvk4O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hVSbvk4O"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIB0u2197638;
	Mon, 6 Jul 2026 08:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JpRU5vt7wAJQzevQK
	aTpoOcbRFrsCSYXn8x81ut9OOM=; b=hVSbvk4OA2lfqQ9QVw1NcG0vFkiQ4+i60
	C36FgdtkEDSqwYWjH8AIsd8E2aVOlXOfNWIW1HGbYMOgVjrQvXMGcX5xzyYJQjHx
	uTCTPmB/zcnYy4sFQ7IHIq3Wa8/6etY1HBlgz9HrAEtX+UFNouo8GtbkU3eq+bMh
	goAfF164fwTJapYWCCfsLx8onmBkgtUWHCkRLdDHOBd7SWEu6fLAVn4f6V1G6Hd1
	33CvxQf6A7tZcdi1WmgSFHflmc4/WYsys+DnycXu2QoXjkGnR1vwQdfvcizxHUvH
	oVcpnky10NZLeYcOjQMActQQIpokjo4O8SH6dBGTA8TwBXnbgOh4Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4ghes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nfwA022527;
	Mon, 6 Jul 2026 08:52:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4qdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qUW854133244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBE7D2004D;
	Mon,  6 Jul 2026 08:52:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 591AC2004B;
	Mon,  6 Jul 2026 08:52:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:30 +0000 (GMT)
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
Subject: [PATCH v4 02/27] KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio
Date: Mon,  6 Jul 2026 10:52:02 +0200
Message-ID: <20260706085229.979525-3-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: T4XyaJ__YLchZ8iUPwf1W69cbURpTj8E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXygubl0jDAdAX
 b9ZfPZUXetTpX24jXf2A5XqLvT2jcKqqJRtbNaUMG3ocWV81XTUJOdlGjOoNmXtMDz7rnUAWEmA
 IeIP9Ldl3MNqjhXZpXEfLwI1SIns92GUTqc0kk2PAkO0db02l/6G8PYNzQ4w28/sd+ce+K3Wk0p
 H9IIG75Cc6y+0Ida+SEZ3vyHPUP9q7UpSoEAaLUBD3Wrt5bqBuCOEvjjaWiUrBXfCudAjGfcMgB
 tQKFs3ZY23VOPOiQ5C0TAQr1ZzGIJ+lRMTDWsgqT+6yO70Y1QY24QuhSC2lfI5CzfUknlQRqVIp
 +0/UjqB6XXg/iL88Ay5s3ZBZXt7y75O3xYZwxOtnLyS0wBxOAQeDuzMOlbAhNIsuyilO9NASlw5
 ewyKZdl8ux+HXdAmBa3ZGhLZn9Af87BQJLg1mjV86KCtfL7tChViM9VUk4ZWxhUdvE/fMPVCXQR
 yzGkAlWVag1DRvXx40Q==
X-Proofpoint-ORIG-GUID: T4XyaJ__YLchZ8iUPwf1W69cbURpTj8E
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b6cd6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=F3h6bpqdNsQVt9IYVBUA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXyDssGfXhxfFE
 jIm/yJ71aMS349+xL6uSqjEflGJiBZx+wXd93B3m3nqtGH7KUFxDb1XPnwkhojk51ZFpZmiolKI
 JWh0PmCREVyRM+L9JrBuY8YTevrQXWA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

From: Paolo Bonzini <pbonzini@redhat.com>

Right now, KVM and VFIO are using symbol_get to access each other's
symbols because of a circular reference between the modules, as well
as to avoid loading them unnecessarily.

However, usage of symbol_get is mostly deprecated and there are just a
handful of users left.  In the case of VFIO, in particular, the
functions it calls can be made inline.  Start with kvm_get_kvm_safe,
for which it is trivial to do so.

While at it, move the function from kvm_host.h to kvm_types.h.
Unlike e.g. drivers/s390/crypto/vfio_ap_ops.c, there's no need for
VFIO to know any implementation details of KVM, and struct kvm
can be treated as an opaque type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Alex Williamson <alex@shazbot.org>
---
 arch/x86/kvm/mmu/tdp_mmu.c |  2 +-
 arch/x86/kvm/svm/sev.c     |  2 +-
 arch/x86/kvm/vmx/nested.h  |  4 ++--
 drivers/vfio/vfio_main.c   |  8 +-------
 include/linux/kvm_host.h   |  8 ++++----
 include/linux/kvm_types.h  | 24 ++++++++++++++++++++++++
 virt/kvm/kvm_main.c        | 29 +++++++----------------------
 7 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index c1cbae65d239..913edd9403e5 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1089,7 +1089,7 @@ void kvm_tdp_mmu_invalidate_roots(struct kvm *kvm,
 	 * being destroyed in an error path of KVM_CREATE_VM.
 	 */
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING) &&
-	    refcount_read(&kvm->users_count) && kvm->created_vcpus)
+	    refcount_read(&kvm->rc.users_count) && kvm->created_vcpus)
 		lockdep_assert_held_write(&kvm->mmu_lock);
 
 	/*
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 427229347876..f588129f7a4f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -115,7 +115,7 @@ static __always_inline void kvm_lockdep_assert_sev_lock_held(struct kvm *kvm)
 	 * Querying SEV+ support is safe if there are no other references, i.e.
 	 * if concurrent initialization of SEV+ is impossible.
 	 */
-	if (!refcount_read(&kvm->users_count))
+	if (!refcount_read(&kvm->rc.users_count))
 		return;
 
 	/*
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 6d6cd5904ddf..a4647859fe1f 100644
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
index 8289aca97b6b..b7b8b45f1cec 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -452,7 +452,6 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm,
 			      struct module *kvm_module)
 {
 	void (*pfn)(struct kvm *kvm);
-	bool (*fn)(struct kvm *kvm);
 	bool ret;
 
 	lockdep_assert_held(&device->dev_set->lock);
@@ -467,12 +466,7 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm,
 	if (WARN_ON(!pfn))
 		goto out_put_mod;
 
-	fn = symbol_get(kvm_get_kvm_safe);
-	if (WARN_ON(!fn))
-		goto out_put_sym;
-
-	ret = fn(kvm);
-	symbol_put(kvm_get_kvm_safe);
+	ret = kvm_get_kvm_safe(kvm);
 	if (!ret)
 		goto out_put_sym;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec82d3..015d02018109 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -768,6 +768,9 @@ struct kvm_memslots {
 };
 
 struct kvm {
+	/* Must be the first field, see function definitions in kvm_types.h.  */
+	struct kvm_refcount rc;
+
 #ifdef KVM_HAVE_MMU_RWLOCK
 	rwlock_t mmu_lock;
 #else
@@ -831,7 +834,6 @@ struct kvm {
 	struct list_head ioeventfds;
 	struct kvm_vm_stat stat;
 	struct kvm_arch arch;
-	refcount_t users_count;
 #ifdef CONFIG_KVM_MMIO
 	struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
 	spinlock_t ring_lock;
@@ -1070,8 +1072,6 @@ static inline void kvm_irqfd_exit(void)
 int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module);
 void kvm_exit(void);
 
-void kvm_get_kvm(struct kvm *kvm);
-bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
@@ -1081,7 +1081,7 @@ static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
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
index e44c20c04961..7dec697ce35a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1089,7 +1089,7 @@ static inline struct kvm_io_bus *kvm_get_bus_for_destruction(struct kvm *kvm,
 							     enum kvm_bus idx)
 {
 	return rcu_dereference_protected(kvm->buses[idx],
-					 !refcount_read(&kvm->users_count));
+					 !refcount_read(&kvm->rc.users_count));
 }
 
 static int kvm_enable_virtualization(void);
@@ -1146,7 +1146,8 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	if (r)
 		goto out_err_no_irq_routing;
 
-	refcount_set(&kvm->users_count, 1);
+	BUILD_BUG_ON(offsetof(struct kvm, rc) != 0);
+	refcount_set(&kvm->rc.users_count, 1);
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		for (j = 0; j < 2; j++) {
@@ -1216,7 +1217,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 out_err_no_disable:
 	kvm_arch_destroy_vm(kvm);
 out_err_no_arch_destroy_vm:
-	WARN_ON_ONCE(!refcount_dec_and_test(&kvm->users_count));
+	WARN_ON_ONCE(!refcount_dec_and_test(&kvm->rc.users_count));
 	for (i = 0; i < KVM_NR_BUSES; i++)
 		kfree(kvm_get_bus_for_destruction(kvm, i));
 	kvm_free_irq_routing(kvm);
@@ -1309,25 +1310,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
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
@@ -1341,7 +1326,7 @@ EXPORT_SYMBOL_GPL(kvm_put_kvm);
  */
 void kvm_put_kvm_no_destroy(struct kvm *kvm)
 {
-	WARN_ON(refcount_dec_and_test(&kvm->users_count));
+	WARN_ON(refcount_dec_and_test(&kvm->rc.users_count));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_put_kvm_no_destroy);
 
@@ -3520,7 +3505,7 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
 	if (WARN_ON_ONCE(vcpu && vcpu->kvm != kvm))
 		return;
 
-	WARN_ON_ONCE(!vcpu && refcount_read(&kvm->users_count) &&
+	WARN_ON_ONCE(!vcpu && refcount_read(&kvm->rc.users_count) &&
 		     !kvm_arch_allow_write_without_running_vcpu(kvm));
 #endif
 
-- 
2.53.0

