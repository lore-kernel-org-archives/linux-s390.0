Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1244657E1;
	Tue, 28 Apr 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391843; cv=none; b=YCliqlrUHGhXpFzbA2TSsDe6LavRqUDJFpuWUtQc/jldxj89VE6b63F3JqjymjCPT5Ivub4yNplhLCLAMOgyQ+FrN798HwWMNfSu+5w/KQrIcq+LxDj/GjSQvZFIb35EvHQpobbxrg9l1J0EU5eyZRBk6Ssi2Zc2XPqrYa9KL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391843; c=relaxed/simple;
	bh=IoHjUKAQrbpL1a2uEuyJba+T/cIjuMUeAm04llb9WA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiT5bQUdLee7Tac+kD5MiTCQvIINsyBblAxBrsCKfs11GM3c2EGzn/asdAw1K5dZ8/xuPuFk+/DCJK+ACu8v6Vxu53c7/hZEGMriwxDfnFo1lrFCdnv0sMYH4Iwa4a9BpIaLlhKmtji9EqXUgqZVFw5UYCdzgYhyzScipD36DMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Egq64HTN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Egq64HTN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7EBCi3232750;
	Tue, 28 Apr 2026 15:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ssxB9ttKcZy3V010a
	Or0tZ6kAZldIkZy3Sbi/wUS9A0=; b=Egq64HTNJbjHWUnVi18zE19C8VKfS6mZ7
	JuY1U42AZG6KYYZIX17jWymKkVBUjRAT7Iulf/u18nflgJzkYlvoow3reKuYEFHT
	2ah7wX7cXMIIZKZG0EafzXD6Co0E1vspGbPaX5aZj5DjIlqpZXLfPPGAqaIoMY+2
	QMuEx/aqrEAQVzFsV6A6P8K4ci2cuhGPCeOvCs3aaFoFK7zLKzBkY6NFkoh5nDiI
	TtknMoaudIdQXOqHr/9GUQUmQ2tFDENOU7/B8U7mhe2tiutJvlKXBHxL6+024uxo
	j/mCw7nqU84smweac7BCSV5vxEmsifLY1aKkWzVYYv2eJDFyk+WhQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jnd1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrp7O027730;
	Tue, 28 Apr 2026 15:56:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamya554-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuTEb38338942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3615A20040;
	Tue, 28 Apr 2026 15:56:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEFEB20043;
	Tue, 28 Apr 2026 15:56:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:28 +0000 (GMT)
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
Subject: [PATCH v2 16/28] KVM: S390: Refactor gmap
Date: Tue, 28 Apr 2026 17:56:08 +0200
Message-ID: <20260428155622.1361364-17-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX71olzm5S02hI
 eUlO+NKZ+LJsRkgAZvxV3F/c4HT+bFXV7DP5/LZYcfhKFEjmKYdqToojQhWqUlcMPOOi5O5xbjx
 e4R+escdSxEYTgNvyMfEMIkgN8P1Tbg8O4j04qXDAeDUeMnKHuS3g4y1fMEYiCHSkGK+2wnGa3X
 wJPHGCsmpvgmhfky+4Q8aaDyfJtY0TKrqhLAdPHBv6jOsSit4MMZJ/iI+cROqTZNNf6pW7ROK9I
 EUhVg3n95odNtXdSsUyEJfGsBMOGTHnORsa7gPyEdomB8L7Jy3aWt7fVfIYcU3ujHxLZPLs9Ev9
 uQfJzLhkb87tpZI3QWxR8itywU21Y0hZr+7gyAgWy/lD16eCX9I1FAzHg70gBtmqWhin5eczvSM
 UknO8KnviwDAoWGxZcD6P5bX5gsHwlEWKtvuqNVJ7SV+rNizB6JmwhKGUEkayenM6lcT2nMI38l
 tSEn8WjyMeJh62Echew==
X-Proofpoint-GUID: K8S9LxFVv-lfDSO6LmVgGtC5W1MvFBb-
X-Proofpoint-ORIG-GUID: K8S9LxFVv-lfDSO6LmVgGtC5W1MvFBb-
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f0d8b1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=3XjMhRVa3_fGsOFpM9YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280151

Refactor gmap code such that a second s390 (host) KVM implementation can
use the gmap code as well. Move relevant definitions into the shared
kvm_host.h. Move mmu code and traces from s390 to gmap.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h      |   9 ++
 arch/s390/include/asm/kvm_host_s390.h |  11 +-
 arch/s390/kvm/gmap/Makefile           |   2 +-
 arch/s390/kvm/gmap/faultin.c          |  11 +-
 arch/s390/kvm/gmap/gmap.c             |  11 +-
 arch/s390/kvm/gmap/gmap.h             |  11 ++
 arch/s390/kvm/gmap/mmu.c              | 154 ++++++++++++++++++++++++++
 arch/s390/kvm/gmap/trace-gmap.h       |  59 ++++++++++
 arch/s390/kvm/s390/s390.c             | 116 +------------------
 arch/s390/kvm/s390/s390.h             |  16 +++
 arch/s390/kvm/s390/trace.h            |  14 ---
 11 files changed, 272 insertions(+), 142 deletions(-)
 create mode 100644 arch/s390/kvm/gmap/mmu.c
 create mode 100644 arch/s390/kvm/gmap/trace-gmap.h

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 6ff643ac0d15..1c20168a3ef5 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -5,4 +5,13 @@
 
 #include <asm/kvm_host_s390.h>
 
+#define PGM_PROTECTION			0x04
+#define PGM_ADDRESSING			0x05
+#define PGM_SEGMENT_TRANSLATION		0x10
+#define PGM_PAGE_TRANSLATION		0x11
+#define PGM_ASCE_TYPE			0x38
+#define PGM_REGION_FIRST_TRANS		0x39
+#define PGM_REGION_SECOND_TRANS		0x3a
+#define PGM_REGION_THIRD_TRANS		0x3b
+
 #endif
diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 2d62a8ff8008..c528d7600bed 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -153,8 +153,7 @@ struct kvm_vcpu_stat {
 #define PGM_OPERATION			0x01
 #define PGM_PRIVILEGED_OP		0x02
 #define PGM_EXECUTE			0x03
-#define PGM_PROTECTION			0x04
-#define PGM_ADDRESSING			0x05
+/* 0x04 & 0x05 defined in kvm_host.h */
 #define PGM_SPECIFICATION		0x06
 #define PGM_DATA			0x07
 #define PGM_FIXED_POINT_OVERFLOW	0x08
@@ -165,8 +164,7 @@ struct kvm_vcpu_stat {
 #define PGM_HFP_EXPONENT_UNDERFLOW	0x0d
 #define PGM_HFP_SIGNIFICANCE		0x0e
 #define PGM_HFP_DIVIDE			0x0f
-#define PGM_SEGMENT_TRANSLATION		0x10
-#define PGM_PAGE_TRANSLATION		0x11
+/* 0x10 & 0x11 defined in kvm_host.h */
 #define PGM_TRANSLATION_SPEC		0x12
 #define PGM_SPECIAL_OPERATION		0x13
 #define PGM_OPERAND			0x15
@@ -196,10 +194,7 @@ struct kvm_vcpu_stat {
 #define PGM_STACK_SPECIFICATION		0x32
 #define PGM_STACK_TYPE			0x33
 #define PGM_STACK_OPERATION		0x34
-#define PGM_ASCE_TYPE			0x38
-#define PGM_REGION_FIRST_TRANS		0x39
-#define PGM_REGION_SECOND_TRANS		0x3a
-#define PGM_REGION_THIRD_TRANS		0x3b
+/* 0x38 - 0x3b defined in kvm_host.h */
 #define PGM_SECURE_STORAGE_ACCESS	0x3d
 #define PGM_NON_SECURE_STORAGE_ACCESS	0x3e
 #define PGM_SECURE_STORAGE_VIOLATION	0x3f
diff --git a/arch/s390/kvm/gmap/Makefile b/arch/s390/kvm/gmap/Makefile
index 21967ed88877..140914c5c14f 100644
--- a/arch/s390/kvm/gmap/Makefile
+++ b/arch/s390/kvm/gmap/Makefile
@@ -2,4 +2,4 @@
 
 GMAP ?= ../gmap
 
-kvm-y += $(GMAP)/dat.o $(GMAP)/gmap.o $(GMAP)/faultin.o
+kvm-y += $(GMAP)/dat.o $(GMAP)/gmap.o $(GMAP)/faultin.o $(GMAP)/mmu.o
diff --git a/arch/s390/kvm/gmap/faultin.c b/arch/s390/kvm/gmap/faultin.c
index e37cd18200f5..26b7d4cb1e86 100644
--- a/arch/s390/kvm/gmap/faultin.c
+++ b/arch/s390/kvm/gmap/faultin.c
@@ -9,10 +9,15 @@
 #include <linux/kvm_host.h>
 
 #include "gmap.h"
-#include "trace.h"
 #include "faultin.h"
-
-bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu);
+#ifdef KVM_S390_ARM64
+#include "arm.h"
+#else
+#include "s390.h"
+#endif
+
+#define CREATE_TRACE_POINTS
+#include "trace-gmap.h"
 
 /*
  * kvm_s390_faultin_gfn() - handle a dat fault.
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 6fa76658f64c..ffe8c5a765f1 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -21,14 +21,13 @@
 
 #include "dat.h"
 #include "gmap.h"
+#ifdef KVM_S390_ARM64
+#include "arm.h"
+#else
 #include "s390.h"
+#endif
 #include "faultin.h"
 
-static inline bool kvm_s390_is_in_sie(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.sie_block->prog0c & PROG_IN_SIE;
-}
-
 static int gmap_limit_to_type(gfn_t limit)
 {
 	if (!limit)
@@ -253,6 +252,7 @@ int s390_replace_asce(struct gmap *gmap)
 
 bool _gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end, bool hint)
 {
+#ifndef KVM_S390_ARM64
 	struct kvm *kvm = gmap->kvm;
 	struct kvm_vcpu *vcpu;
 	gfn_t prefix_gfn;
@@ -271,6 +271,7 @@ bool _gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end, bool hint)
 			kvm_s390_sync_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu);
 		}
 	}
+#endif /* ifdef KVM_S390_ARM64 */
 	return true;
 }
 
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index 238487554c18..863873bfb422 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -250,4 +250,15 @@ static inline bool gmap_is_shadow_valid(struct gmap *sg, union asce asce, int ed
 	return sg->guest_asce.val == asce.val && sg->edat_level == edat_level;
 }
 
+int gmap_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log);
+int gmap_prepare_memory_region(struct kvm *kvm,
+			       const struct kvm_memory_slot *old,
+			       struct kvm_memory_slot *new,
+			       enum kvm_mr_change change);
+void gmap_commit_memory_region(struct kvm *kvm,
+			       struct kvm_memory_slot *old,
+			       const struct kvm_memory_slot *new,
+			       enum kvm_mr_change change);
+bool gmap_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
+
 #endif /* ARCH_KVM_GMAP_GMAP_H */
diff --git a/arch/s390/kvm/gmap/mmu.c b/arch/s390/kvm/gmap/mmu.c
new file mode 100644
index 000000000000..2d81466e49cb
--- /dev/null
+++ b/arch/s390/kvm/gmap/mmu.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kvm_types.h>
+#include <linux/kvm_host.h>
+
+#ifdef KVM_S390_ARM64
+#include "arm.h"
+#else
+#include "s390.h"
+#endif
+#include "gmap.h"
+#include "dat.h"
+
+/*
+ * Get (and clear) the dirty memory log for a memory slot.
+ */
+int gmap_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
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
+int gmap_prepare_memory_region(struct kvm *kvm,
+			       const struct kvm_memory_slot *old,
+			       struct kvm_memory_slot *new,
+			       enum kvm_mr_change change)
+{
+	gpa_t size;
+
+	if (kvm_is_ucontrol(kvm) && new->id < KVM_USER_MEM_SLOTS)
+		return -EINVAL;
+
+	/* When we are protected, we should not change the memory slots */
+	if (kvm_s390_pv_get_handle(kvm))
+		return -EINVAL;
+
+	if (change != KVM_MR_DELETE && change != KVM_MR_FLAGS_ONLY) {
+		/*
+		 * A few sanity checks. We can have memory slots which have to be
+		 * located/ended at a segment boundary (1MB). The memory in userland is
+		 * ok to be fragmented into various different vmas. It is okay to mmap()
+		 * and munmap() stuff in this slot after doing this call at any time
+		 */
+
+		if (new->userspace_addr & 0xffffful)
+			return -EINVAL;
+
+		size = new->npages * PAGE_SIZE;
+		if (size & 0xffffful)
+			return -EINVAL;
+
+		if ((new->base_gfn * PAGE_SIZE) + size > kvm->arch.mem_limit)
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
+void gmap_commit_memory_region(struct kvm *kvm,
+			       struct kvm_memory_slot *old,
+			       const struct kvm_memory_slot *new,
+			       enum kvm_mr_change change)
+{
+	struct kvm_s390_mmu_cache *mc = NULL;
+	int rc = 0;
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
+	kvm_s390_free_mmu_cache(mc);
+}
+
+/**
+ * gmap_test_age_gfn() - test young
+ * @kvm: the kvm instance
+ * @range: the range of guest addresses whose young status needs to be cleared
+ *
+ * Context: called by KVM common code without holding the kvm mmu lock
+ * Return: true if any page in the given range is young, otherwise 0.
+ */
+bool gmap_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	scoped_guard(read_lock, &kvm->mmu_lock)
+		return dat_test_age_gfn(kvm->arch.gmap->asce, range->start, range->end);
+}
diff --git a/arch/s390/kvm/gmap/trace-gmap.h b/arch/s390/kvm/gmap/trace-gmap.h
new file mode 100644
index 000000000000..25f8a527fdde
--- /dev/null
+++ b/arch/s390/kvm/gmap/trace-gmap.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(GMAP_TRACE_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define GMAP_TRACE_KVM_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm
+#define TRACE_INCLUDE_PATH ../gmap
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace-gmap
+
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
+#define __KVM_FIELDS \
+	__field(unsigned long, pswmask) \
+	__field(unsigned long, pswaddr)
+#define __KVM_ASSIGN ({\
+	__entry->pswmask = vcpu->arch.sie_block->gpsw.mask; \
+	__entry->pswaddr = vcpu->arch.sie_block->gpsw.addr; \
+	})
+#define __KVM_PRINT \
+	__entry->pswmask,\
+	__entry->pswaddr
+#endif
+
+TRACE_EVENT(kvm_s390_major_guest_pfault,
+	    TP_PROTO(struct kvm_vcpu *vcpu),
+	    TP_ARGS(vcpu),
+
+	    TP_STRUCT__entry(
+		__field(int, id)
+		__KVM_FIELDS
+		),
+
+	    TP_fast_assign(
+		__entry->id = vcpu->vcpu_id;
+		__KVM_ASSIGN
+		),
+	    TP_printk("%02d[%016lx-%016lx]: major fault, maybe applicable for pfault",
+		__entry->id,
+		__KVM_PRINT
+		)
+	    );
+
+#endif /* GMAP_TRACE_KVM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 5bc23ebe7ee5..0e325b47d40e 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -734,33 +734,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu);
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
+	return gmap_get_dirty_log(kvm, log);
 }
 
 static void icpt_operexc_on_all_vcpus(struct kvm *kvm)
@@ -1195,7 +1169,7 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
  * Must be called with kvm->slots_lock to avoid races with ourselves and
  * kvm_s390_vm_start_migration.
  */
-static int kvm_s390_vm_stop_migration(struct kvm *kvm)
+int kvm_s390_vm_stop_migration(struct kvm *kvm)
 {
 	/* migration mode already disabled */
 	if (!kvm->arch.migration_mode)
@@ -5648,51 +5622,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	gpa_t size;
-
-	if (kvm_is_ucontrol(kvm) && new->id < KVM_USER_MEM_SLOTS)
-		return -EINVAL;
-
-	/* When we are protected, we should not change the memory slots */
-	if (kvm_s390_pv_get_handle(kvm))
-		return -EINVAL;
-
-	if (change != KVM_MR_DELETE && change != KVM_MR_FLAGS_ONLY) {
-		/*
-		 * A few sanity checks. We can have memory slots which have to be
-		 * located/ended at a segment boundary (1MB). The memory in userland is
-		 * ok to be fragmented into various different vmas. It is okay to mmap()
-		 * and munmap() stuff in this slot after doing this call at any time
-		 */
-
-		if (new->userspace_addr & 0xffffful)
-			return -EINVAL;
-
-		size = new->npages * PAGE_SIZE;
-		if (size & 0xffffful)
-			return -EINVAL;
-
-		if ((new->base_gfn * PAGE_SIZE) + size > kvm->arch.mem_limit)
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
+	return gmap_prepare_memory_region(kvm, old, new, change);
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
@@ -5700,42 +5630,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				const struct kvm_memory_slot *new,
 				enum kvm_mr_change change)
 {
-	struct kvm_s390_mmu_cache *mc = NULL;
-	int rc = 0;
-
-	if (change == KVM_MR_FLAGS_ONLY)
-		return;
-
-	mc = kvm_s390_new_mmu_cache();
-	if (!mc) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	scoped_guard(write_lock, &kvm->mmu_lock) {
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
-	kvm_s390_free_mmu_cache(mc);
-	return;
+	gmap_commit_memory_region(kvm, old, new, change);
 }
 
 /**
@@ -5748,8 +5643,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
  */
 bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	scoped_guard(read_lock, &kvm->mmu_lock)
-		return dat_test_age_gfn(kvm->arch.gmap->asce, range->start, range->end);
+	return gmap_test_age_gfn(kvm, range);
 }
 
 /**
diff --git a/arch/s390/kvm/s390/s390.h b/arch/s390/kvm/s390/s390.h
index ad1aeec40cae..3acb01690bf6 100644
--- a/arch/s390/kvm/s390/s390.h
+++ b/arch/s390/kvm/s390/s390.h
@@ -32,6 +32,11 @@ union kvm_s390_quad {
 	unsigned char one;
 };
 
+static inline bool kvm_s390_is_in_sie(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sie_block->prog0c & PROG_IN_SIE;
+}
+
 static inline void kvm_s390_fpu_store(struct kvm_run *run)
 {
 	fpu_stfpc(&run->s.regs.fpc);
@@ -588,6 +593,11 @@ static inline bool kvm_s390_cur_gmap_fault_is_write(void)
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
@@ -618,4 +628,10 @@ void kvm_s390_vcpu_pci_enable_interp(struct kvm *kvm);
  */
 extern unsigned int diag9c_forwarding_hz;
 
+/*
+ * Must be called with kvm->slots_lock to avoid races with ourselves and
+ * kvm_s390_vm_start_migration.
+ */
+int kvm_s390_vm_stop_migration(struct kvm *kvm);
+
 #endif
diff --git a/arch/s390/kvm/s390/trace.h b/arch/s390/kvm/s390/trace.h
index aa419eb6a0c8..97774fe09a85 100644
--- a/arch/s390/kvm/s390/trace.h
+++ b/arch/s390/kvm/s390/trace.h
@@ -45,20 +45,6 @@ TRACE_EVENT(kvm_s390_skey_related_inst,
 	    VCPU_TP_PRINTK("%s", "storage key related instruction")
 	);
 
-TRACE_EVENT(kvm_s390_major_guest_pfault,
-	    TP_PROTO(VCPU_PROTO_COMMON),
-	    TP_ARGS(VCPU_ARGS_COMMON),
-
-	    TP_STRUCT__entry(
-		    VCPU_FIELD_COMMON
-		    ),
-
-	    TP_fast_assign(
-		    VCPU_ASSIGN_COMMON
-		    ),
-	    VCPU_TP_PRINTK("%s", "major fault, maybe applicable for pfault")
-	);
-
 TRACE_EVENT(kvm_s390_pfault_init,
 	    TP_PROTO(VCPU_PROTO_COMMON, long pfault_token),
 	    TP_ARGS(VCPU_ARGS_COMMON, pfault_token),
-- 
2.51.0

