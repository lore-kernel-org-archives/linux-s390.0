Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E4F44A739;
	Mon,  6 Jul 2026 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327999; cv=none; b=WUPIY80pwAv81qdaGVd1ZmQvMyY2d9Q4xzbsVBVWmne3Lj8xyVIWgSKPinswmFL3Vw4oFkFI34gEc7P0swNJPK1LFXyC2Uz8//uh710EIv7XsR2jjhQCJloaCq//l25V1g16q47YHtx644ovuTe6g03zHGa0ToHPaomWkai7jHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327999; c=relaxed/simple;
	bh=LF42OOGL/SUxZPGINAxShaWHMGV37pzJwWyWvV9/6Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZzSq1l5hZriDK4GoGxTgQ8+POW/SiXLbmby7LBbTsfbGC057JOOafRXA70Rd+NdCf+JVI5jmg6dl9WikAZYu96f6SvFuENOxrXi90A5qONiOajbCL6tELlIoW0WVUHXzdt0tri12pUUS6oguxQ6h7ZpWj/t6Ip3v7kYuqYO9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jbjOKnyB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jbjOKnyB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MImOQ2428648;
	Mon, 6 Jul 2026 08:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TqdW9CIfesnywpcRq
	MH1wfrTMFIhIQpVQQ3eiTslO80=; b=jbjOKnyB2dfgvFPNLV/49KMC/EXegM9DQ
	mINEhoU1jO6Mb3KX05HTXyDIweGOUyDF/K9wGlRkpXjf3ewzdb6S/CWPNjcT1KJ0
	zqLMsPlyl+DyrlOCT4RAYk1bIUbUi/xsNUJygHt3Xtu5X5NrJ3lsuhQMlWPkXmLn
	6b1VAXqCFYL1oz+T1vHDEsWLW9jZN0+VL/3CwBtg7dgxBBpROTRE1BI0u0XF5IwC
	nbnA3WBIXbRDFI1QKVL8mEJAD1mCOfk5iooZHha1O+oKU1OSroC8v0/w6JF7SNzL
	GtXlgveDU2VOJwyFyjib5SBr3EZIzF2W5Rlt199AMODbnEwp1xglw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqgfqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nbav009549;
	Mon, 6 Jul 2026 08:52:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpw1be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qaEX50987284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4644B20040;
	Mon,  6 Jul 2026 08:52:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CECE720043;
	Mon,  6 Jul 2026 08:52:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:35 +0000 (GMT)
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
Subject: [PATCH v4 15/27] KVM: S390: Prepare gmap for a second KVM implementation
Date: Mon,  6 Jul 2026 10:52:15 +0200
Message-ID: <20260706085229.979525-16-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX85t+lNyJCMsT
 kJf+fIsqhixiZa+JS5s7wY92akoySmwpi7LYRsYQF5JOii1YEXKG7OsMyxQzUbEMU+Rd1EuLul+
 Hxf+n0qvYZ8qjjyo93FRUSCLcJDpprI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXzhxo9vbC6Tu0
 fPA3s5SVAAPK2g86O5Sk7f8iavu3GeScC/uEd4G/XSyMV9iRrdY0EQF2J9ktW4xUcSSS7NeJSul
 /JwRjSvuOzEjeREog+KkGtvpxLkm4YXpNz9/TG9sMlA+0KPRzBbVOHHdOjZiUCmhJDYwYecTiCd
 3oOKtAVEXgIbz3VzhzgV5H7tK8hugNpiFKMJzpVLcbAXF3oUQNdDUuzeC1O7yRVNxjW2y0k4PGM
 NxiXF19AfWUAdJiVD7wnhPCvDn6JOVJe6u1GcQT/bkaopl2Z1KmOeLc5MXiDktk5FAl/i8xyvev
 OgIorA8ByEBGvORz3MQ1lxnaDorvtRjzOkdRgPU8jeQ9mvQ4Uv6KjHeEFO1tyIn+24Jm+7g0iSa
 VLJ1wji1dkgyImgzbgLKLp3woTdyk3vZ9k1orhBLt1yIt1DQM0KvrzCfGneh1m+p430/6/8LxTq
 fvPU0qijgCU9c+t621g==
X-Proofpoint-GUID: 28BJJ9BV_fORYa8119BWQjESi6RtM5HT
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4b6cdb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=8VmVtdaW9wNMPsTfPeoA:9
X-Proofpoint-ORIG-GUID: 28BJJ9BV_fORYa8119BWQjESi6RtM5HT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

Refactor gmap code such that a second s390 (host) KVM implementation can
use the gmap code as well. Move relevant definitions into the shared
kvm_host.h. Move mmu code from s390 to gmap so the other KVM
implementation can use it as well.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h      |   9 ++
 arch/s390/include/asm/kvm_host_s390.h |  11 +-
 arch/s390/kvm/gmap/Makefile           |   2 +-
 arch/s390/kvm/gmap/faultin.c          |   1 -
 arch/s390/kvm/gmap/gmap.c             |   5 -
 arch/s390/kvm/gmap/gmap.h             |  15 ++
 arch/s390/kvm/gmap/mmu.c              | 193 ++++++++++++++++++++++++++
 arch/s390/kvm/s390/s390.c             | 134 ++----------------
 arch/s390/kvm/s390/s390.h             |  16 +++
 9 files changed, 245 insertions(+), 141 deletions(-)
 create mode 100644 arch/s390/kvm/gmap/mmu.c

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index e76ceee11ef5..33af8842a71c 100644
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
 #endif /* ASM_KVM_HOST_H */
diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 5293b0067422..7b7aa166cff7 100644
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
index 740415d494de..713914dc8eb2 100644
--- a/arch/s390/kvm/gmap/faultin.c
+++ b/arch/s390/kvm/gmap/faultin.c
@@ -11,7 +11,6 @@
 #include "gmap.h"
 #include "faultin.h"
 
-bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu);
 #define CREATE_TRACE_POINTS
 #include "trace-gmap.h"
 
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 8773aa34f107..a04e0a4355a0 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -24,11 +24,6 @@
 #include "s390.h"
 #include "faultin.h"
 
-static inline bool kvm_s390_is_in_sie(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.sie_block->prog0c & PROG_IN_SIE;
-}
-
 static int gmap_limit_to_type(gfn_t limit)
 {
 	if (!limit)
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index c54c35e47d6d..4ab7208f50ff 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -10,6 +10,8 @@
 #ifndef ARCH_KVM_GMAP_GMAP_H
 #define ARCH_KVM_GMAP_GMAP_H
 
+#include <linux/kvm_host.h>
+
 #include "dat.h"
 
 /**
@@ -330,4 +332,17 @@ static inline bool gmap_is_shadow_valid(struct gmap *sg, union asce asce, int ed
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
+long gmap_pre_fault_memory(struct kvm_vcpu *vcpu,
+			   struct kvm_pre_fault_memory *range);
+
 #endif /* ARCH_KVM_GMAP_GMAP_H */
diff --git a/arch/s390/kvm/gmap/mmu.c b/arch/s390/kvm/gmap/mmu.c
new file mode 100644
index 000000000000..5bb6609b974b
--- /dev/null
+++ b/arch/s390/kvm/gmap/mmu.c
@@ -0,0 +1,193 @@
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
+#include "faultin.h"
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
+
+/**
+ * gmap_pre_fault_memory() - pre-fault and link gmap dat tables
+ * @vcpu: the vcpu that shall appear to have generated the fault-in.
+ * @range: the range that needs to be faulted in.
+ *
+ * The first page of the given range is faulted in and the corresponding gmap
+ * page tables are created, as if the given vCPU had performed a read
+ * operation.
+ * If the range starts outside any memslots, an error is returned. An error is
+ * also returned for UCONTROL VMs, which should instead use the
+ * KVM_S390_VCPU_FAULT ioctl.
+ *
+ * Return:
+ * * %-ENOENT if the range lies outside of a memslot.
+ * * %-EINVAL in case of invalid state (for example if the VM is UCONTROL).
+ * * %-EIO if errors happen while faulting-in the page (will trigger a warning
+ *   in the caller).
+ * * other error codes < 0 in case of other errors.
+ * * otherwise a number > 0 of bytes that have been faulted in successfully.
+ */
+long gmap_pre_fault_memory(struct kvm_vcpu *vcpu, struct kvm_pre_fault_memory *range)
+{
+	struct guest_fault f = { .gfn = gpa_to_gfn(range->gpa), };
+	gpa_t end;
+	int rc;
+
+	if (kvm_is_ucontrol(vcpu->kvm))
+		return -EINVAL;
+
+	rc = kvm_s390_faultin_gfn(vcpu, NULL, &f);
+	if (rc == PGM_ADDRESSING)
+		return -ENOENT;
+	if (rc > 0)
+		return -EIO;
+	if (rc < 0)
+		return rc;
+
+	if (f.ptep)
+		return PAGE_SIZE;
+
+	end = ALIGN(range->gpa + PAGE_SIZE, f.crste_region3 ? _REGION3_SIZE : HPAGE_SIZE);
+	return min(range->size, end - range->gpa);
+}
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 26720ffcf5db..f89bad4e9e04 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -746,33 +746,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu);
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
@@ -1268,7 +1242,7 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
  * Must be called with kvm->slots_lock to avoid races with ourselves,
  * kvm_s390_vm_start_migration() and kvm_s390_get_cmma_bits().
  */
-static int kvm_s390_vm_stop_migration(struct kvm *kvm)
+int kvm_s390_vm_stop_migration(struct kvm *kvm)
 {
 	/* migration mode already disabled */
 	if (!kvm->arch.migration_mode)
@@ -5751,45 +5725,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
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
+	return gmap_prepare_memory_region(kvm, old, new, change);
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
@@ -5797,42 +5733,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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
@@ -5855,28 +5756,10 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
  * * other error codes < 0 in case of other errors.
  * * otherwise a number > 0 of bytes that have been faulted in successfully.
  */
-long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu, struct kvm_pre_fault_memory *range)
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				    struct kvm_pre_fault_memory *range)
 {
-	struct guest_fault f = { .gfn = gpa_to_gfn(range->gpa), };
-	gpa_t end;
-	int rc;
-
-	if (kvm_is_ucontrol(vcpu->kvm))
-		return -EINVAL;
-
-	rc = kvm_s390_faultin_gfn(vcpu, NULL, &f);
-	if (rc == PGM_ADDRESSING)
-		return -ENOENT;
-	if (rc > 0)
-		return -EIO;
-	if (rc < 0)
-		return rc;
-
-	if (f.ptep)
-		return PAGE_SIZE;
-
-	end = ALIGN(range->gpa + PAGE_SIZE, f.crste_region3 ? _REGION3_SIZE : HPAGE_SIZE);
-	return min(range->size, end - range->gpa);
+	return gmap_pre_fault_memory(vcpu, range);
 }
 
 /**
@@ -5889,8 +5772,7 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu, struct kvm_pre_fault_
  */
 bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	scoped_guard(read_lock, &kvm->mmu_lock)
-		return dat_test_age_gfn(kvm->arch.gmap->asce, range->start, range->end);
+	return gmap_test_age_gfn(kvm, range);
 }
 
 /**
diff --git a/arch/s390/kvm/s390/s390.h b/arch/s390/kvm/s390/s390.h
index e144ca2e6d5e..aa2061007230 100644
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
@@ -594,6 +599,11 @@ static inline bool kvm_s390_cur_gmap_fault_is_write(void)
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
@@ -624,4 +634,10 @@ void kvm_s390_vcpu_pci_enable_interp(struct kvm *kvm);
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

