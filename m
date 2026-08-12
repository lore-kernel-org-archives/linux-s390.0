Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF753470425;
	Wed, 12 Aug 2026 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549040; cv=none; b=iKOM4efebxIDaKlcwlhlZEilQUkhEsZgKmuaA+Vmt8IhgkhrLCgpqCovfNRg0AoaKxsk7C4jQ5QKWrBG6ELbYt5r8K2VaAeSvl/yng1sLi2xMDGWWTXfreXu4/u0tDwuIWe3O0L6XumBWS4jr9QRrVIcN9bgcyRDOQyhnOzh7nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549040; c=relaxed/simple;
	bh=ylZ12ONA0BRyx/2IlkL8HKefq+dPZbQP9gWF/D36g60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DokJgBhWZimK8RgxU9KT0HuNDvT7aFrUBHEBkzakxqIrZ6tRQjTaEOQJim88EQ+jLMN4X2Jp4/SI8WPQUhtiYlJQnbSL4OeKbs0ZLe1AenWKV8NDsodzicHm/wESk011jBUyToGZQUqrAIDYzuLEyOuwf2HA5p+W0X0c8CJWNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NYhOztxV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NYhOztxV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1RsU3686399;
	Wed, 12 Aug 2026 15:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=i1Iw5QCf5DqXqBr20
	R8kUd7tujRZmrVCexv0lf7uwAI=; b=NYhOztxV5228n6I6vlSGC6cIQCoZtOtcO
	hq3q2Ag95raRmVc40O+RJWzksukhEZvMRq3oWC0GdN8mBPUETEwZkjX235gj5v49
	TpOU4H1NJRKYQm3OHjub6hRpeFrDIZoaYfU7wWfMURSsB13465gBAI64FQghWxGL
	xpbdVHIBZvbYBB/7bf92bAw0DfCL+Dmky38p7CMnuwoZ0FXIszIIyl57vywXfwo/
	EZ/tC/fjDhIgPFNKpWMNeuTSSGicKPRvmv+hsgCxVqT0Hp4Z5cV0w0RDstH3VwV+
	C75veuksqSvpsJ6vgWf/4mrw8h5mNin6xyg1wnDA4wItACzH+QhRA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9u9u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQKsP012299;
	Wed, 12 Aug 2026 15:36:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq6utf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFadNn36438298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E8BB20040;
	Wed, 12 Aug 2026 15:36:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAB012004D;
	Wed, 12 Aug 2026 15:36:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:38 +0000 (GMT)
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
Subject: [PATCH v6 18/33] KVM: s390: Prepare gmap for a second KVM implementation
Date: Wed, 12 Aug 2026 17:36:14 +0200
Message-ID: <20260812153631.3376090-19-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfXxODMZ/ojjEKL
 0uizNULYMmZSJE9kDlHRe9Gvi42N0H4XYXSpXu33sjjV/hNM5gxrVvb/E5jxSD7WtklpmIQb0hS
 jwgZot27XopiIEYwchD5kgE0mrHC3eLi5nK5wBSky/QEc5Pt8VCiIphbUwO2GjA0ojoGBNGbPI8
 s1IPgmMu8O7a3qq7RewU3gHeg4VvoiJbeu9HT+AOl7rMBRJ3D0LNPwktO64QkzyR5I34UUfwSJd
 V6iCmh4CvKsXqtrl9xdAqUHlzx8YxpEKE6F145cU/bzEenJdtcDdI/M25HINWtjtMS8CN4kFsbK
 UhHQd/zlBoAm3R3V91yeIwno6192wLpDAZmVfqjviqMtUSC9owxbtnQ++zBrZk0muRNM8PUahoJ
 D65NZsaavCNzfo6kHTmoKNE7vWcN3zomxsGkfCGaUi65OaD4Lq8Nuyy+3bcbJ2cjFB7yV5A+CPJ
 ei9M5yR9V0WO6xdnz3A==
X-Proofpoint-ORIG-GUID: y22NoNWYfaxloMbjhhszp18qEJ1oZqN-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX7n79Xn9drciy
 04g/RWTNDBipN/uZ6v/qiE+zkPMkneO7mxrKM3OgvdD7AlvOM1uFuPGyUo42MfDrxRKQy7qfc9D
 itX7zppOFrpVqP2EwqZFMR3DVnHxXSY=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c930c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=G2WYc9OQ16fb5gd5Pq8A:9
X-Proofpoint-GUID: 5o6TiX6gLmV2inZaFeRrlE0sF8m1Bqk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126

Refactor gmap code such that a second s390 (host) KVM implementation can
use the gmap code as well. Move mmu code from s390 to gmap so the other
KVM implementation can use it as well.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/gmap/Makefile  |   2 +-
 arch/s390/kvm/gmap/kvm_mmu.c | 133 +++++++++++++++++++++++++++++++++++
 arch/s390/kvm/gmap/kvm_mmu.h |  18 +++++
 arch/s390/kvm/s390/s390.c    | 126 ++++-----------------------------
 arch/s390/kvm/s390/s390.h    |   8 +++
 5 files changed, 175 insertions(+), 112 deletions(-)
 create mode 100644 arch/s390/kvm/gmap/kvm_mmu.c
 create mode 100644 arch/s390/kvm/gmap/kvm_mmu.h

diff --git a/arch/s390/kvm/gmap/Makefile b/arch/s390/kvm/gmap/Makefile
index 3a4f8df11622..dd4ef062c536 100644
--- a/arch/s390/kvm/gmap/Makefile
+++ b/arch/s390/kvm/gmap/Makefile
@@ -2,4 +2,4 @@
 
 GMAP ?= ../gmap
 
-gmap-y += $(GMAP)/dat.o $(GMAP)/gmap.o $(GMAP)/faultin.o
+gmap-y += $(GMAP)/dat.o $(GMAP)/gmap.o $(GMAP)/faultin.o $(GMAP)/kvm_mmu.o
diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
new file mode 100644
index 000000000000..b08b8229bb6f
--- /dev/null
+++ b/arch/s390/kvm/gmap/kvm_mmu.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kvm_types.h>
+#include <linux/kvm_host.h>
+
+#include "s390.h"
+#include "gmap.h"
+#include "dat.h"
+#include "kvm_mmu.h"
+
+/*
+ * Get (and clear) the dirty memory log for a memory slot.
+ */
+int s390_kvm_mmu_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
+{
+	int r;
+	unsigned long n;
+	struct kvm_memory_slot *memslot;
+	int is_dirty;
+
+	if (kvm_is_ucontrol(kvm))
+		return -EINVAL;
+
+	mutex_lock(&kvm->slots_lock);
+
+	r = -EINVAL;
+	if (log->slot >= KVM_USER_MEM_SLOTS)
+		goto out;
+
+	r = kvm_get_dirty_log(kvm, log, &is_dirty, &memslot);
+	if (r)
+		goto out;
+
+	/* Clear the dirty log */
+	if (is_dirty) {
+		n = kvm_dirty_bitmap_bytes(memslot);
+		memset(memslot->dirty_bitmap, 0, n);
+	}
+	r = 0;
+out:
+	mutex_unlock(&kvm->slots_lock);
+	return r;
+}
+
+int s390_kvm_mmu_prepare_memory_region(struct kvm *kvm,
+				       const struct kvm_memory_slot *old,
+				       struct kvm_memory_slot *new,
+				       enum kvm_mr_change change)
+{
+	if (kvm_is_ucontrol(kvm) && new && new->id < KVM_USER_MEM_SLOTS)
+		return -EINVAL;
+
+	/* When we are protected, we should not change the memory slots */
+	if (kvm_s390_pv_get_handle(kvm))
+		return -EINVAL;
+
+	if (change != KVM_MR_DELETE && change != KVM_MR_FLAGS_ONLY) {
+		/*
+		 * A few sanity checks. The memory in userland is ok to be
+		 * fragmented into various different vmas. It is okay to mmap()
+		 * and munmap() stuff in this slot after doing this call at any
+		 * time.
+		 */
+		if (new->userspace_addr & ~PAGE_MASK)
+			return -EINVAL;
+		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
+			return -EINVAL;
+		if (!asce_contains_gfn(kvm->arch.gmap->asce, new->base_gfn + new->npages - 1))
+			return -EINVAL;
+	}
+
+	if (!kvm_s390_is_migration_mode(kvm))
+		return 0;
+
+	/*
+	 * Turn off migration mode when:
+	 * - userspace creates a new memslot with dirty logging off,
+	 * - userspace modifies an existing memslot (MOVE or FLAGS_ONLY) and
+	 *   dirty logging is turned off.
+	 * Migration mode expects dirty page logging being enabled to store
+	 * its dirty bitmap.
+	 */
+	if (change != KVM_MR_DELETE &&
+	    !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
+		WARN(kvm_s390_vm_stop_migration(kvm),
+		     "Failed to stop migration mode");
+
+	return 0;
+}
+
+void s390_kvm_mmu_commit_memory_region(struct kvm *kvm,
+				       struct kvm_memory_slot *old,
+				       const struct kvm_memory_slot *new,
+				       enum kvm_mr_change change)
+{
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	int rc = 0;
+
+	guard(mutex)(&kvm->slots_arch_lock);
+
+	if (change == KVM_MR_FLAGS_ONLY)
+		return;
+
+	mc = kvm_s390_new_mmu_cache();
+	if (!mc) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	scoped_guard(write_lock, &kvm->mmu_lock) {
+		kvm_s390_update_cmma_dirty(kvm, old);
+		switch (change) {
+		case KVM_MR_DELETE:
+			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
+			break;
+		case KVM_MR_MOVE:
+			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
+			if (rc)
+				break;
+			fallthrough;
+		case KVM_MR_CREATE:
+			rc = dat_create_slot(mc, kvm->arch.gmap->asce, new->base_gfn, new->npages);
+			break;
+		case KVM_MR_FLAGS_ONLY:
+			break;
+		default:
+			WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
+		}
+	}
+out:
+	if (rc)
+		pr_warn("failed to commit memory region\n");
+}
diff --git a/arch/s390/kvm/gmap/kvm_mmu.h b/arch/s390/kvm/gmap/kvm_mmu.h
new file mode 100644
index 000000000000..cdbd390bd33c
--- /dev/null
+++ b/arch/s390/kvm/gmap/kvm_mmu.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ARCH_KVM_GMAP_KVM_MMU_H
+#define ARCH_KVM_GMAP_KVM_MMU_H
+
+#include <linux/kvm_host.h>
+
+int s390_kvm_mmu_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log);
+int s390_kvm_mmu_prepare_memory_region(struct kvm *kvm,
+				       const struct kvm_memory_slot *old,
+				       struct kvm_memory_slot *new,
+				       enum kvm_mr_change change);
+void s390_kvm_mmu_commit_memory_region(struct kvm *kvm,
+				       struct kvm_memory_slot *old,
+				       const struct kvm_memory_slot *new,
+				       enum kvm_mr_change change);
+
+#endif /* ARCH_KVM_GMAP_KVM_MMU_H */
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index ff09ffc10f0d..1d0d94f000f7 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -55,6 +55,7 @@
 #include "gmap.h"
 #include "faultin.h"
 #include "pci.h"
+#include "kvm_mmu.h"
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -745,33 +746,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu);
 int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 			       struct kvm_dirty_log *log)
 {
-	int r;
-	unsigned long n;
-	struct kvm_memory_slot *memslot;
-	int is_dirty;
-
-	if (kvm_is_ucontrol(kvm))
-		return -EINVAL;
-
-	mutex_lock(&kvm->slots_lock);
-
-	r = -EINVAL;
-	if (log->slot >= KVM_USER_MEM_SLOTS)
-		goto out;
-
-	r = kvm_get_dirty_log(kvm, log, &is_dirty, &memslot);
-	if (r)
-		goto out;
-
-	/* Clear the dirty log */
-	if (is_dirty) {
-		n = kvm_dirty_bitmap_bytes(memslot);
-		memset(memslot->dirty_bitmap, 0, n);
-	}
-	r = 0;
-out:
-	mutex_unlock(&kvm->slots_lock);
-	return r;
+	return s390_kvm_mmu_get_dirty_log(kvm, log);
 }
 
 static void icpt_operexc_on_all_vcpus(struct kvm *kvm)
@@ -1266,7 +1241,7 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
  * Must be called with kvm->slots_arch_lock to avoid races with ourselves,
  * kvm_s390_vm_start_migration() and kvm_s390_get_cmma_bits().
  */
-static int kvm_s390_vm_stop_migration(struct kvm *kvm)
+int kvm_s390_vm_stop_migration(struct kvm *kvm)
 {
 	/* migration mode already disabled */
 	if (!kvm->arch.migration_mode)
@@ -5770,45 +5745,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	if (kvm_is_ucontrol(kvm) && new && new->id < KVM_USER_MEM_SLOTS)
-		return -EINVAL;
-
-	/* When we are protected, we should not change the memory slots */
-	if (kvm_s390_pv_get_handle(kvm))
-		return -EINVAL;
-
-	if (change != KVM_MR_DELETE && change != KVM_MR_FLAGS_ONLY) {
-		/*
-		 * A few sanity checks. The memory in userland is ok to be
-		 * fragmented into various different vmas. It is okay to mmap()
-		 * and munmap() stuff in this slot after doing this call at any
-		 * time.
-		 */
-		if (new->userspace_addr & ~PAGE_MASK)
-			return -EINVAL;
-		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
-			return -EINVAL;
-		if (!asce_contains_gfn(kvm->arch.gmap->asce, new->base_gfn + new->npages - 1))
-			return -EINVAL;
-	}
-
-	if (!kvm->arch.migration_mode)
-		return 0;
-
-	/*
-	 * Turn off migration mode when:
-	 * - userspace creates a new memslot with dirty logging off,
-	 * - userspace modifies an existing memslot (MOVE or FLAGS_ONLY) and
-	 *   dirty logging is turned off.
-	 * Migration mode expects dirty page logging being enabled to store
-	 * its dirty bitmap.
-	 */
-	if (change != KVM_MR_DELETE &&
-	    !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
-		WARN(kvm_s390_vm_stop_migration(kvm),
-		     "Failed to stop migration mode");
-
-	return 0;
+	return s390_kvm_mmu_prepare_memory_region(kvm, old, new, change);
 }
 
 static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
@@ -5824,55 +5761,22 @@ static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_
 	return 0;
 }
 
-void kvm_arch_commit_memory_region(struct kvm *kvm,
-				struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new,
-				enum kvm_mr_change change)
+void kvm_s390_update_cmma_dirty(struct kvm *kvm, struct kvm_memory_slot *old)
 {
 	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
-	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
-	int rc = 0;
 
-	guard(mutex)(&kvm->slots_arch_lock);
-
-	if (change == KVM_MR_FLAGS_ONLY)
-		return;
-
-	mc = kvm_s390_new_mmu_cache();
-	if (!mc) {
-		rc = -ENOMEM;
-		goto out;
+	if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
+		_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
+				    kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
+				    &kvm->arch.cmma_dirty_pages);
 	}
+}
 
-	scoped_guard(write_lock, &kvm->mmu_lock) {
-		if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
-			_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
-					    kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
-					    &kvm->arch.cmma_dirty_pages);
-		}
-
-		switch (change) {
-		case KVM_MR_DELETE:
-			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
-			break;
-		case KVM_MR_MOVE:
-			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
-			if (rc)
-				break;
-			fallthrough;
-		case KVM_MR_CREATE:
-			rc = dat_create_slot(mc, kvm->arch.gmap->asce, new->base_gfn, new->npages);
-			break;
-		case KVM_MR_FLAGS_ONLY:
-			break;
-		default:
-			WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
-		}
-	}
-out:
-	if (rc)
-		pr_warn("failed to commit memory region\n");
-	return;
+void kvm_arch_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *old,
+				   const struct kvm_memory_slot *new,
+				   enum kvm_mr_change change)
+{
+	s390_kvm_mmu_commit_memory_region(kvm, old, new, change);
 }
 
 /**
diff --git a/arch/s390/kvm/s390/s390.h b/arch/s390/kvm/s390/s390.h
index e144ca2e6d5e..d284a263ba70 100644
--- a/arch/s390/kvm/s390/s390.h
+++ b/arch/s390/kvm/s390/s390.h
@@ -472,6 +472,9 @@ int __kvm_s390_mprotect_many(struct gmap *gmap, gpa_t gpa, u8 npages, unsigned i
 			     unsigned long bits);
 
 bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu);
+void kvm_s390_update_cmma_dirty(struct kvm *kvm, struct kvm_memory_slot *old);
+int kvm_s390_vm_stop_migration(struct kvm *kvm);
+
 
 /* implemented in diag.c */
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
@@ -594,6 +597,11 @@ static inline bool kvm_s390_cur_gmap_fault_is_write(void)
 	return test_facility(75) && (current->thread.gmap_teid.fsi == TEID_FSI_STORE);
 }
 
+static __always_inline int kvm_s390_is_migration_mode(struct kvm *kvm)
+{
+	return kvm->arch.migration_mode;
+}
+
 /**
  * kvm_s390_vcpu_crypto_reset_all
  *
-- 
2.53.0

