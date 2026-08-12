Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA9946AA67;
	Wed, 12 Aug 2026 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549055; cv=none; b=Vm2OC03cfhkTBFbwRxknv7xMD5fQM/QT5Po3mUs8b4gVbq6A45IBu1Q2YXma53yX/Bxm6Ls+jwewg1qdTCR6nluWJl+DFJ+N64eii7pgw7fsnXQi+Fw48TBBem6QjFdRlyvOlghXqewORo9RTnByyZFfPKNUccHi++DT5Gbcf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549055; c=relaxed/simple;
	bh=CDJvkD+GorJY/rKrFLmD2OdCkEr3Y/CnwuB4T8ljRIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaNchgVKupU6d1ZizzX3tSqJNtASkZMvPdSJUXO+uHWlD4EmmDT1P52bdz5ksSIvrUC/ZWXUF2eZTcV3MHoUGuUe4YMtPTDGP6rzFwX81Fic8L/WxYqsOkwyXTqirRv+GpE5AS+8M0a3wPOwXPPBAJrIcsDAI56/6ehx9n07RIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M4avp7S9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M4avp7S9"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1fY13640434;
	Wed, 12 Aug 2026 15:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rjtUUE8j1yKxyJ0dd
	NpLv7+uS88vcpzyl7hxEatF5Es=; b=M4avp7S9iR2an/fxSleMz5R4Oor9Rs1Mk
	du0CxsYi+v61bhBWMM8wTaEoa0Wh64gDOykshiPQ/WiTe8HNw4VLK+Bgd7QHMm4G
	V/VR5CiVcEAqWYBkzSBl4cpQ6ycCKmqTi1UNAVthp3Xqd2klZMsiTjbOO+vUbTR7
	+KTmsU8/xlrO+rtALwDPtegLXEMCwKn27BEBiyJ5506jLCsKbZBCYV6ELxAcpbQC
	cU2tco8Wm1XplTpiBF3o2z/KJDh9YCxa24PC8kwzv9+aykPdjRZKhLMU1N70K5l4
	PIu2xB9m/0ht7DArb3ap8+Q8LmEkfg9/26oIyQ1PtDsURQVXKnqHw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9k7cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQMVh023731;
	Wed, 12 Aug 2026 15:36:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gejgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFadkm29425948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8496920049;
	Wed, 12 Aug 2026 15:36:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33EA62004E;
	Wed, 12 Aug 2026 15:36:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:39 +0000 (GMT)
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
Subject: [PATCH v6 19/33] KVM: s390: gmap: Make storage keys optional
Date: Wed, 12 Aug 2026 17:36:15 +0200
Message-ID: <20260812153631.3376090-20-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: 7ngys5bZeOtxKlkLS41mjg3JW7x3c-f5
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c930c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=FRKyy_LW2YnNPCwhDngA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX8LJtQPw+e1KN
 qEkM6X2axqYusjzmt6zbgGyCIvD4CyUj2ZD2i9g5nuUSM+GpbK+l9cKMf7UnSLyFvq9TYDSKL0L
 hRZg3x+MRdn1fll9YtY3r2yk+NwB4lNNPu8wwydOrzfdkjbgX3d2qlXsUsLAsC/8ZKv5wkMFNL6
 X+PS2CUmskEuZi/ZLlogLmmacQkviY8GAx4UWCoXMu1HPjOJoIyj4sV9kwXBcArB7LmiMJtxrNc
 6Uh5ZcO4JVfBnF0aDWaFMKryHIWnWgKUPXTGnNrINasspufGsrRrBP/zde0OCwMGq3btLcIeVZ8
 ELievFHWZwSLMWByyffBR0JpR/YC7JnQ+k6ipiggQOVZjK1rZiy6cIyHgsJ5ShHNuHJLZ3w4dSz
 xD7tiVqoNiJR8IZ1J6P+i27r5tbZbPzESWWH3wl5BXyI4IvO5UQKb0uewBRGdPkUKNT8D/RfpBb
 XJgT+izaCScI9iX4oYA==
X-Proofpoint-ORIG-GUID: XfalMYnwlJHB6WT6HGLeUI0P_9VDHTU-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfXwG4CNAm4Mg//
 yJzGuH1Btr+DKWxsFjWoFh1DA6Rkr4TIPZipQcqkCFTY56xVEbR9TpxZyhT2gkGWj6iaU5CX2V1
 kUDCwq5pZohbiPDQga+crvhd0LkaQis=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120126

Guard guest storage key handling behind `KVM_S390_MANAGES_S390_GUEST`.
This enables other KVM implementations to use gmap without implementing
storage key infrastructure. Define KVM_S390_MANAGES_S390_GUEST to 1 for
KVM hosts managing s390 guests (in kvm_host_s390.h). A KVM
implementation not implementing those features must define
KVM_S390_MANAGES_S390_GUEST to 0 in its kvm_host_<guest_arch>.h.

No functional changes besides the new guard.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h | 2 ++
 arch/s390/kvm/gmap/dat.c              | 2 ++
 arch/s390/kvm/gmap/dat.h              | 4 ++++
 arch/s390/kvm/gmap/gmap.c             | 3 +++
 arch/s390/kvm/gmap/gmap.h             | 6 ++++++
 5 files changed, 17 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 22e8d7c4a755..cd692f8fb764 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -32,6 +32,8 @@
 
 #define KVM_INTERNAL_MEM_SLOTS 1
 
+#define KVM_S390_MANAGES_S390_GUEST 1
+
 /*
  * These seem to be used for allocating ->chip in the routing table, which we
  * don't use. 1 is as small as we can get to reduce the needed memory. If we
diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index 3f2d6e8902d7..f4e142995367 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -613,6 +613,7 @@ long _dat_walk_gfn_range(gfn_t start, gfn_t end, union asce asce,
 	return dat_crste_walk_range(start, min(end, asce_end(asce)), table, &walk);
 }
 
+#if KVM_S390_MANAGES_S390_GUEST
 int dat_get_storage_key(union asce asce, gfn_t gfn, union skey *skey)
 {
 	union crste *crstep;
@@ -839,6 +840,7 @@ long dat_reset_skeys(union asce asce, gfn_t start)
 
 	return _dat_walk_gfn_range(start, asce_end(asce), asce, &ops, DAT_WALK_IGN_HOLES, NULL);
 }
+#endif /* KVM_S390_MANAGES_S390_GUEST */
 
 struct slot_priv {
 	unsigned long token;
diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 87108f51228e..2cc072168810 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -9,6 +9,7 @@
 #ifndef ARCH_KVM_GMAP_DAT_H
 #define ARCH_KVM_GMAP_DAT_H
 
+#include <linux/kvm_host.h>
 #include <linux/radix-tree.h>
 #include <linux/refcount.h>
 #include <linux/io.h>
@@ -532,6 +533,8 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, in
 void dat_free_level(struct crst_table *table, bool owns_ptes);
 struct crst_table *dat_alloc_crst_sleepable(unsigned long init);
 int dat_set_asce_limit(struct kvm_s390_mmu_cache *mc, union asce *asce, int newtype);
+
+#if KVM_S390_MANAGES_S390_GUEST
 int dat_get_storage_key(union asce asce, gfn_t gfn, union skey *skey);
 int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
 			union skey skey, bool nq);
@@ -539,6 +542,7 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
 			     union skey skey, union skey *oldkey, bool nq, bool mr, bool mc);
 int dat_reset_reference_bit(union asce asce, gfn_t gfn, union skey *skey);
 long dat_reset_skeys(union asce asce, gfn_t start);
+#endif /* KVM_S390_MANAGES_S390_GUEST */
 
 unsigned long dat_get_ptval(struct page_table *table, struct ptval_param param);
 void dat_set_ptval(struct page_table *table, struct ptval_param param, unsigned long val);
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index b5b920392378..c1b0e2572818 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -944,6 +944,8 @@ void gmap_split_huge_pages(struct gmap *gmap)
 	} while (start);
 }
 
+#if KVM_S390_MANAGES_S390_GUEST
+
 static int _gmap_enable_skeys(struct gmap *gmap)
 {
 	gfn_t start = 0;
@@ -975,6 +977,7 @@ int gmap_enable_skeys(struct gmap *gmap)
 	mmap_write_unlock(gmap->kvm->mm);
 	return rc;
 }
+#endif /* KVM_S390_MANAGES_S390_GUEST */
 
 static long _destroy_pages_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index c54c35e47d6d..328a81c72c7a 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -10,6 +10,8 @@
 #ifndef ARCH_KVM_GMAP_GMAP_H
 #define ARCH_KVM_GMAP_GMAP_H
 
+#include <linux/kvm_host.h>
+
 #include "dat.h"
 
 /**
@@ -98,7 +100,11 @@ int gmap_set_limit(struct gmap *gmap, gfn_t limit);
 int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t *gaddr);
 int gmap_ucas_map(struct gmap *gmap, gfn_t p_gfn, gfn_t c_gfn, unsigned long count);
 void gmap_ucas_unmap(struct gmap *gmap, gfn_t c_gfn, unsigned long count);
+
+#if KVM_S390_MANAGES_S390_GUEST
 int gmap_enable_skeys(struct gmap *gmap);
+#endif /* KVM_S390_MANAGES_S390_GUEST */
+
 int gmap_pv_destroy_range(struct gmap *gmap, gfn_t start, gfn_t end, bool interruptible);
 int gmap_insert_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn,
 		     gfn_t r_gfn, int level);
-- 
2.53.0

