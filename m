Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581B4307BC;
	Fri, 31 Jul 2026 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503385; cv=none; b=IXJ6Qt1o4ohzrpSjnIkSe21xK3nhh0joxNpztdBM5eJaNfQcB2/x/MJLjqSXeuqDorISUu1DPVKdAVskVAyObZGXdcHI/sX1pyoQI44begRp2obelzmWEFYxfCVSXFGK7W/lUo8QZkDzYq5soW1evCkcdjLvTYm3fugLCwV5jus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503385; c=relaxed/simple;
	bh=k8qWIPC+nf2zNigosgflpfUb+to9u7y5psEgmPKnBKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyeadlY1OrmFvhvy1p4GJS3GrRw3yntv1RiIS7HoKSDFPR7KD7kLRHrFiHZ94PsoT2N2xm6lvBkRltpqf3MjGxE4XyRnQmuxjL+NkiW1utba0rI1DI6h0P8G8yyOJBzJUUYlThFldLgl787qKu2SINFuxJGNBeenwkCH3gNwuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dFOyKlqi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dFOyKlqi"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmC6r1732219;
	Fri, 31 Jul 2026 13:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QWZn+Q7nTgF3D3UTi
	WJxf4taxphpUYdOHuAoPhIH858=; b=dFOyKlqiu58NU2/rTKKiRexgYxW2AtdSB
	nLTsqI2CEWOJg5MkeKuBj2++/JWzCt+/M3c2O6a5VHMD1YyznSxGUDlSkl8wsxKz
	pNslJl4zA0p9spEE3/cZw0w3wM8OXG2R/qDxVmJmUTHiJuOS2+64nmpdKxUhZDDn
	moJhWzrfMpeXdAnpT49oGWWFcZK2gEEX5bDZzOtDxLHabLhDrZ1irguLggnZTAo2
	la2q7jt9uCO8JL667B/vqYgkdrGaB+rOt7mzfJGQ9/CpdHaMml8Nld7kr1rr2h7+
	Ng8mQDjzJSIso7Qu1sCENvqRKL93J89p7v0GODWaluTfxtmacLjEQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7w4ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuHVr026404;
	Fri, 31 Jul 2026 13:09:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhqw79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD9AfT32637360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA19920040;
	Fri, 31 Jul 2026 13:09:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 506C120043;
	Fri, 31 Jul 2026 13:09:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:10 +0000 (GMT)
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
Subject: [PATCH v5 17/31] KVM: s390: Prepare gmap for a second KVM implementation
Date: Fri, 31 Jul 2026 15:08:45 +0200
Message-ID: <20260731130902.654679-18-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: X-sIKNlfr6TaEdkBYNs_EZgl62fvN4od
X-Proofpoint-ORIG-GUID: 5DovtgPzdI6E0CuIWomXw-E0L6r-RNeF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX1JatzVhlt1qY
 7MtsgWG7Jt9pJw/C9s77rDhe8FKKfCmHkQhBIPXcabuol6lNsfCzdY8E9rwO3KmCZPjHrP4eIBp
 +JYc7GP6k1m5qv3lYHDxi6nU62D5r3BPaqZVhqJwE3POw/OO5acXWLlkIeTsPTjNgBiVjSw5RLM
 20TwdVra8tIzlD9a4DN/WiPWbt1XyhK5CuHz8w+fgHoEdinkEboUoztHsD5mb0E9pG7AIlsJnmx
 GhYC+udvoSb9A4hZcpYv6ac5w+vozbNMsZ/6AZc9P7mVMYYhewHiX2jMs15f2q8vKJ5glyKI1/n
 sOfp8nh6WNfnTb0r4e6O9874Kzjf0T7zkG7o2031RbkStovMc/8KB0D65WpRYkordFz7DMntG1z
 iZswK7dRO+NcdFeeAQ2fwPHSxXl1la0PZI9iVBhjE+/jLhgDKr2MAbKOThjE9eXcwHwPNLFeRMm
 JN9Eh65MKBzUw8LUAXw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6c9e7f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=_uJ2qFJvUlpRL0NV2hwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX2EF4VS/hhWJc
 gvmGI0wGW+ztU3qdYCRDm4gTf7sIR+BsgK6P8IYI0llm9NKoUXFp6B1/JEImq/41CySjx+2IVfy
 MzMO6FHR8u3dUcCNK2Wfkygy140D0Yc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310096

Refactor gmap code such that a second s390 (host) KVM implementation can
use the gmap code as well. Move mmu code from s390 to gmap so the other
KVM implementation can use it as well.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/gmap/Makefile  |   2 +-
 arch/s390/kvm/gmap/kvm_mmu.c | 131 +++++++++++++++++++++++++++++++++++
 arch/s390/kvm/gmap/kvm_mmu.h |  18 +++++
 arch/s390/kvm/s390/s390.c    | 111 ++---------------------------
 arch/s390/kvm/s390/s390.h    |  11 +++
 5 files changed, 168 insertions(+), 105 deletions(-)
 create mode 100644 arch/s390/kvm/gmap/kvm_mmu.c
 create mode 100644 arch/s390/kvm/gmap/kvm_mmu.h

diff --git a/arch/s390/kvm/gmap/Makefile b/arch/s390/kvm/gmap/Makefile
index 21967ed88877..02b797f63ffb 100644
--- a/arch/s390/kvm/gmap/Makefile
+++ b/arch/s390/kvm/gmap/Makefile
@@ -2,4 +2,4 @@
 
 GMAP ?= ../gmap
 
-kvm-y += $(GMAP)/dat.o $(GMAP)/gmap.o $(GMAP)/faultin.o
+kvm-y += $(GMAP)/dat.o $(GMAP)/gmap.o $(GMAP)/faultin.o $(GMAP)/kvm_mmu.o
diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
new file mode 100644
index 000000000000..40fee79eb71f
--- /dev/null
+++ b/arch/s390/kvm/gmap/kvm_mmu.c
@@ -0,0 +1,131 @@
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
+			       const struct kvm_memory_slot *old,
+			       struct kvm_memory_slot *new,
+			       enum kvm_mr_change change)
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
diff --git a/arch/s390/kvm/gmap/kvm_mmu.h b/arch/s390/kvm/gmap/kvm_mmu.h
new file mode 100644
index 000000000000..4167eaec8f6f
--- /dev/null
+++ b/arch/s390/kvm/gmap/kvm_mmu.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ARCH_KVM_GMAP_MMU_H
+#define ARCH_KVM_GMAP_MMU_H
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
+#endif /* ARCH_KVM_GMAP_MMU_H */
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index f1962cf61cc1..87d4b25bc849 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -55,6 +55,7 @@
 #include "gmap.h"
 #include "faultin.h"
 #include "pci.h"
+#include "kvm_mmu.h"
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -746,33 +747,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu);
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
@@ -1268,7 +1243,7 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
  * Must be called with kvm->slots_lock to avoid races with ourselves,
  * kvm_s390_vm_start_migration() and kvm_s390_get_cmma_bits().
  */
-static int kvm_s390_vm_stop_migration(struct kvm *kvm)
+int kvm_s390_vm_stop_migration(struct kvm *kvm)
 {
 	/* migration mode already disabled */
 	if (!kvm->arch.migration_mode)
@@ -5753,45 +5728,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
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
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
@@ -5799,42 +5736,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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
+	s390_kvm_mmu_commit_memory_region(kvm, old, new, change);
 }
 
 /**
@@ -5857,7 +5759,8 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
  * * other error codes < 0 in case of other errors.
  * * otherwise a number > 0 of bytes that have been faulted in successfully.
  */
-long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu, struct kvm_pre_fault_memory *range)
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				    struct kvm_pre_fault_memory *range)
 {
 	struct guest_fault f = { .gfn = gpa_to_gfn(range->gpa), };
 	gpa_t end;
diff --git a/arch/s390/kvm/s390/s390.h b/arch/s390/kvm/s390/s390.h
index e144ca2e6d5e..9feb1fa66323 100644
--- a/arch/s390/kvm/s390/s390.h
+++ b/arch/s390/kvm/s390/s390.h
@@ -594,6 +594,11 @@ static inline bool kvm_s390_cur_gmap_fault_is_write(void)
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
@@ -624,4 +629,10 @@ void kvm_s390_vcpu_pci_enable_interp(struct kvm *kvm);
  */
 extern unsigned int diag9c_forwarding_hz;
 
+/*
+ * Must be called with kvm->slots_lock to avoid races with ourselves and
+ * kvm_s390_vm_start_migration.
+ */
+int kvm_s390_vm_stop_migration(struct kvm *kvm);
+
 #endif
-- 
2.53.0

