Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FAA44BCA5;
	Tue, 28 Apr 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392145; cv=none; b=IXzyemFRpLufaUStU05RwaO6UQHtyKWbzJbIefDPF9FLUXFepIcoujR6q33gWuAgRfNiyQuoV1BuUdcOH68E+qWnrMH4HjqGkDUNfVF+3m75+d1QPpoari77PSjyuevWP47OXGqjX6tFDznG+HZXJV04YG49nikhkkdFax6bd9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392145; c=relaxed/simple;
	bh=+f0KqIhjRhXOPmuitjWWVv++bWQPI5OwaQw+syV3y0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oxw12hbDt2JJtIik4dp+hO5De7mAbR8g6fwkN7v16eFZlOMzfYVxkSIQt2bG0RFTU/EL3ACUx+w+NYHLJlb5N5h0iqwvDs0NlUs3cHzgy1Y0ZPJf507lgjNcjmTHkEprFXJsida6C6pB2qM1z1fxCgM/3TEQv22hJFe43/g8tGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SY98I+Am; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SY98I+Am"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S5FNtS3403831;
	Tue, 28 Apr 2026 15:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6c/Fp/jpEE9cZYBMv
	rLH6hn5SkLHCeHUEGgTw3DiLKU=; b=SY98I+AmfTPeSbn2KPhNj6ezdE4jQYmyv
	/pUlVywDouwrMc+9bhDfe0sUuNJUfGlWGlEIaSTL8YuUPxlOyjGzyB7IElxCzMRl
	QO1SNvT/kBH6s2hiAY/rTEDWjVaKK+XXpbT8i7TGGzQZOQH8eA9OERuSXb813yE1
	WuRIpTUnWTA9rQcRiKeC6csSdPsm5+PWr7E7KNEMNyvii34I3664CMsLHQmWtFcR
	9hLglrJZPgL7otr19CMsjfL6PJl30j1Ukj9o0YFlamqPuVhrDrKRiO7+lVucJyps
	1gdg3w9p/G7aCf6J6mGIoogbcqy8vfedj/kFPAgqZR2BqoSoqAdAQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1dw7ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrqbv032245;
	Tue, 28 Apr 2026 15:56:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9eha9wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuOEc31064564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E149920040;
	Tue, 28 Apr 2026 15:56:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FEB82004E;
	Tue, 28 Apr 2026 15:56:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:23 +0000 (GMT)
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
Subject: [PATCH v2 02/28] KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio
Date: Tue, 28 Apr 2026 17:55:54 +0200
Message-ID: <20260428155622.1361364-3-seiden@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 4AExZImwdh1VmXa2t2TWkBTn_cRzsh9d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX5OP/9ZYYnWd8
 IecjsIj8jRJI1O5JrYPfTJoP7Mjch6AHQPbTXlCQ4ZMjaK/Fw7z+39ot9MVTy/aJWttvss/7k4F
 LqmyXDKUaQ+kfnztzAk8+XV2iNW6Dfr5bPoPS5B218kC6g3FGw/uEmNwyY4Ch8dTLcAhnasYx9h
 vRLQqucpuLD3q0jxkbGFElGsRfHyDrEZKZzw//QgWNY6sDt8hz2r0x8eoci8HClpgDUpWW+xFB6
 npE1FQbzYwC+L/Bh3w0DNIVocDKtVb4Rs2K5yjV0OifpCzIq7h1Xz0nRU0JRyZcc2rK7qL34iCz
 CrFBMTqXqQyjRP4s0rkdw50Ld7qZiREIwJJXYkYu8V2QjroWU89qogw5iv7dMQQbz0YpEypGz1+
 PLJN3M7m+A3n7lmXmwbYHp5ADw9HYzw0GKVJv0uO7AvNgyBaFJ9LTUptEmM8aNe2gxs8ITBCd08
 v/2MnmRyIOv42u476JA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f0d8ae cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=F3h6bpqdNsQVt9IYVBUA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: 4AExZImwdh1VmXa2t2TWkBTn_cRzsh9d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

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
 arch/x86/kvm/vmx/nested.h  |  4 ++--
 drivers/vfio/vfio_main.c   |  8 +-------
 include/linux/kvm_host.h   |  8 ++++----
 include/linux/kvm_types.h  | 22 ++++++++++++++++++++++
 virt/kvm/kvm_main.c        | 27 ++++++---------------------
 6 files changed, 36 insertions(+), 35 deletions(-)

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
index d1bbc42d484a..cb6eaabd64ce 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -436,7 +436,6 @@ EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm, struct module *kvm_module)
 {
 	void (*pfn)(struct kvm *kvm);
-	bool (*fn)(struct kvm *kvm);
 	bool ret;
 
 	lockdep_assert_held(&device->dev_set->lock);
@@ -451,12 +450,7 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm, struc
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
index 6b76e7a6f4c2..5163b541c82d 100644
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
@@ -1062,8 +1064,6 @@ static inline void kvm_irqfd_exit(void)
 int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module);
 void kvm_exit(void);
 
-void kvm_get_kvm(struct kvm *kvm);
-bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
@@ -1073,7 +1073,7 @@ static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
 	as_id = array_index_nospec(as_id, KVM_MAX_NR_ADDRESS_SPACES);
 	return srcu_dereference_check(kvm->memslots[as_id], &kvm->srcu,
 			lockdep_is_held(&kvm->slots_lock) ||
-			!refcount_read(&kvm->users_count));
+			!refcount_read(&kvm->rc.users_count));
 }
 
 static inline struct kvm_memslots *kvm_memslots(struct kvm *kvm)
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..4cb68c71a13c 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -33,6 +33,7 @@
 
 #include <linux/mutex.h>
 #include <linux/spinlock_types.h>
+#include <linux/refcount.h>
 
 struct kvm;
 struct kvm_async_pf;
@@ -140,6 +141,27 @@ struct kvm_vcpu_stat_generic {
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
+	return refcount_inc_not_zero(&rc->users_count);
+}
+
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __KVM_TYPES_H__ */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9093251beb39..6e3796814da7 100644
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
@@ -1153,7 +1153,8 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	if (r)
 		goto out_err_no_irq_routing;
 
-	refcount_set(&kvm->users_count, 1);
+	BUILD_BUG_ON(offsetof(struct kvm, rc) != 0);
+	refcount_set(&kvm->rc.users_count, 1);
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		for (j = 0; j < 2; j++) {
@@ -1223,7 +1224,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 out_err_no_disable:
 	kvm_arch_destroy_vm(kvm);
 out_err_no_arch_destroy_vm:
-	WARN_ON_ONCE(!refcount_dec_and_test(&kvm->users_count));
+	WARN_ON_ONCE(!refcount_dec_and_test(&kvm->rc.users_count));
 	for (i = 0; i < KVM_NR_BUSES; i++)
 		kfree(kvm_get_bus_for_destruction(kvm, i));
 	kvm_free_irq_routing(kvm);
@@ -1316,25 +1317,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
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
@@ -1348,7 +1333,7 @@ EXPORT_SYMBOL_GPL(kvm_put_kvm);
  */
 void kvm_put_kvm_no_destroy(struct kvm *kvm)
 {
-	WARN_ON(refcount_dec_and_test(&kvm->users_count));
+	WARN_ON(refcount_dec_and_test(&kvm->rc.users_count));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_put_kvm_no_destroy);
 
-- 
2.51.0

