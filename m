Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A642C508;
	Fri, 31 Jul 2026 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503381; cv=none; b=jTnggUOY1eDuFEIKVgjRHojwJQHPT2Mkl8vuU0heCQONemkezI6s8AanZG4yBfWi66bqFkqaX5Zlj9QPoyFMrXBf6jZ1CaNdfp19SRdKrYFP0yO/4o6cOya3YvJVPPxFghQS/9mpMXlUm8Ukw5xdv+KfpIEy6Meq4ejmr1wpgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503381; c=relaxed/simple;
	bh=BkUE/e4gfk1CRG0u7zBrEAc7F81M+RQXK1WK30UI+E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHJtbtN3pf5l3P7x8KCjAT78eMA+oHAyZHAm9WO6G6oL+oq14Tln0ALend0f5B6bKZ2CO/rRhGvwbgwZBkUHvvgShx1O8xF6ZGqZgDUG1EmUvjZ1BxOCH44UBI57wKHkMh8J8dRcYDFA1qKBPZZjdKvxQETg7DBzgDd3GWCAh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o6AMEJpr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o6AMEJpr"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBldjA1730400;
	Fri, 31 Jul 2026 13:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JKmK/xOF2rYfFCDDz
	B9ScTAqZe25huI7PolZxZ5u69I=; b=o6AMEJprqgPDzsux1hABe4ojWcV1Kd0UG
	4Vzm9vmaSHdAWr0JKXlk+5CQgYMBDhC7IdYvoQaZ1f3LuXHGOkp9hllRkHNRgG/L
	5l8IIOiYHf9wu80iX3b6rOeZXiL+QLBvBj8oP8ndPkkEf61pTs1M/q/wpYywEupr
	r8fUMq8jh31Vtu8+MBMycLn0W7py0nyGAtVqAG4m1h8odsRjOQ5SMwC5siTgn7Go
	+XaPUmnT1xX46w4o3R7xYHa2gc2FRpcRrFURBeNoEipzTkgv/P+vLxNI2bg9pF5q
	VXypXN1zeHrJ5OlVeIxO961I34lqVixXxvr3VE86duV1ww6d/JAHQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7w4m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCQEsY026828;
	Fri, 31 Jul 2026 13:09:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqtby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD9Bj250135414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB1FF20040;
	Fri, 31 Jul 2026 13:09:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44AC320043;
	Fri, 31 Jul 2026 13:09:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:11 +0000 (GMT)
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
Subject: [PATCH v5 19/31] KVM: s390: gmap: Move prefix handling to kvm/s390
Date: Fri, 31 Jul 2026 15:08:47 +0200
Message-ID: <20260731130902.654679-20-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: jmbg_IUaJhgEWwTs7p6F0H2czEl_h1lr
X-Proofpoint-ORIG-GUID: Wcl7-u5EVBgteko2dK6MwurjdXbtNLex
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX0Nd9DjaUMJq1
 Zf6vtoNhpzjGnuAvELovmjR4zJz4sSvVIyfBNGDJcQbB4u6b2Vhzn5Ojz+nRH0ZTptioQiVIIz1
 8WZy9lIzqwkc0atwgMM4GtXveRa+5JCpOEMhmPNmGvIL86xBugfrVVV1RvW1qJJH0uUBm2E/B45
 AVEA+N9fYvrnL89u/sbGauQuvjHHR/1XbMMuaV4m1/z6hjfaAZ1U99UzTK5LqDPz/sBFRZvonJf
 Q8XmpkOYu2Oq4m8qz83mBSUfHxRXAoUV7S/AWHMc0CAl7cUS9hv4FVYDiVwVyWrQkEmgGy0nrIF
 85qgiFDZYW4MsAxFOQUcNwVya7ilNJvedi7PmR/0QVBzCjrmCl+/VRliEQhtAKpLRHcS+90UPNx
 JkZ9pAlfRNM+9jZZLND2nqG8maKSW+tkSMO8kbZiTEQ1YU/6RgbjsbQoWmxjh5/ePy+8nJcnQOU
 g6rVTbDxveAeMkBrmiw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6c9e7f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=4SwaMfgYKtkue4rGTFgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX2SqBLmgj3JDN
 4jwCnM55PiHBDB99DYBZCcdRcScyts97tkVyAA3exp7ysiuel1YbaD5lTj7/ziEVIV7QbmxIz/z
 9SnDYvPgTzmtq8XL1AlZRUz0i/tko8k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310096

Move code handling prefix page tracking from kvm/gmap to kvm/s390. This
enables other KVM implementations to use gmap without implementing
prefix handling. The prefix tracking is turned on if
KVM_S390_GUEST_HAS_PREFIX is defined.

No functional changes.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h |  2 ++
 arch/s390/kvm/gmap/dat.c              | 48 ---------------------------
 arch/s390/kvm/gmap/dat.h              |  1 -
 arch/s390/kvm/gmap/gmap.c             | 28 ----------------
 arch/s390/kvm/gmap/gmap.h             | 12 +------
 arch/s390/kvm/gmap/prefix.h           | 39 ++++++++++++++++++++++
 arch/s390/kvm/s390/dat.c              | 48 +++++++++++++++++++++++++++
 arch/s390/kvm/s390/gmap.c             | 29 ++++++++++++++++
 8 files changed, 119 insertions(+), 88 deletions(-)
 create mode 100644 arch/s390/kvm/gmap/prefix.h

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 9e4d7ed53078..cfd95df60130 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -32,6 +32,8 @@
 
 #define KVM_INTERNAL_MEM_SLOTS 1
 
+#define KVM_S390_GUEST_HAS_PREFIX
+
 /*
  * These seem to be used for allocating ->chip in the routing table, which we
  * don't use. 1 is as small as we can get to reduce the needed memory. If we
diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index 1ac6457de498..6252a7cd81a8 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -777,51 +777,3 @@ bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end)
 	return _dat_walk_gfn_range(start, end, asce, &test_age_ops, 0, NULL) > 0;
 }
 
-static long dat_set_pn_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	union crste newcrste, oldcrste;
-	int *n = walk->priv;
-
-	do {
-		oldcrste = READ_ONCE(*crstep);
-		if (!oldcrste.h.fc || oldcrste.h.i || oldcrste.h.p)
-			return 0;
-		if (oldcrste.s.fc1.prefix_notif)
-			break;
-		newcrste = oldcrste;
-		newcrste.s.fc1.prefix_notif = 1;
-	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, walk->asce));
-	*n = 2;
-	return 0;
-}
-
-static long dat_set_pn_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	int *n = walk->priv;
-	union pgste pgste;
-
-	pgste = pgste_get_lock(ptep);
-	if (!ptep->h.i && !ptep->h.p) {
-		pgste.prefix_notif = 1;
-		*n += 1;
-	}
-	pgste_set_unlock(ptep, pgste);
-	return 0;
-}
-
-int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
-{
-	static const struct dat_walk_ops ops = {
-		.pte_entry = dat_set_pn_pte,
-		.pmd_entry = dat_set_pn_crste,
-		.pud_entry = dat_set_pn_crste,
-	};
-
-	int n = 0;
-
-	_dat_walk_gfn_range(gfn, gfn + 2, asce, &ops, DAT_WALK_IGN_HOLES, &n);
-	if (n != 2)
-		return -EAGAIN;
-	return 0;
-}
-
diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index e6fd201ec9b9..fb412bd07685 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -538,7 +538,6 @@ void dat_set_ptval(struct page_table *table, struct ptval_param param, unsigned
 
 int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end,
 		 u16 type, u16 param);
-int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn);
 bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end);
 
 int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *state, bool *dirty);
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index c4ed40ea3475..07915278ee98 100644
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
@@ -256,29 +251,6 @@ int s390_replace_asce(struct gmap *gmap)
 	return 0;
 }
 
-bool _gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end, bool hint)
-{
-	struct kvm *kvm = gmap->kvm;
-	struct kvm_vcpu *vcpu;
-	gfn_t prefix_gfn;
-	unsigned long i;
-
-	if (is_shadow(gmap))
-		return false;
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		/* Match against both prefix pages */
-		prefix_gfn = gpa_to_gfn(kvm_s390_get_prefix(vcpu));
-		if (prefix_gfn < end && gfn <= prefix_gfn + 1) {
-			if (hint && kvm_s390_is_in_sie(vcpu))
-				return false;
-			VCPU_EVENT(vcpu, 2, "gmap notifier for %llx-%llx",
-				   gfn_to_gpa(gfn), gfn_to_gpa(end));
-			kvm_s390_sync_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu);
-		}
-	}
-	return true;
-}
-
 struct clear_young_pte_priv {
 	struct gmap *gmap;
 	bool young;
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index c9cab8f60f62..28ab585db7e1 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -11,6 +11,7 @@
 #define ARCH_KVM_GMAP_GMAP_H
 
 #include "dat.h"
+#include "prefix.h"
 
 /**
  * enum gmap_flags - Flags of a gmap.
@@ -83,7 +84,6 @@ struct gmap_cache {
 	for (pos = (head); n = pos ? pos->next : NULL, pos; pos = n)
 
 int s390_replace_asce(struct gmap *gmap);
-bool _gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end, bool hint);
 bool gmap_age_gfn(struct gmap *gmap, gfn_t start, gfn_t end);
 bool gmap_unmap_gfn_range(struct gmap *gmap, struct kvm_memory_slot *slot, gfn_t start, gfn_t end);
 int gmap_try_fixup_minor(struct gmap *gmap, struct guest_fault *fault);
@@ -157,16 +157,6 @@ static inline void gmap_handle_vsie_unshadow_event(struct gmap *parent, gfn_t gf
 		_gmap_handle_vsie_unshadow_event(parent, gfn);
 }
 
-static inline bool gmap_mkold_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end)
-{
-	return _gmap_unmap_prefix(gmap, gfn, end, true);
-}
-
-static inline bool gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end)
-{
-	return _gmap_unmap_prefix(gmap, gfn, end, false);
-}
-
 /**
  * pte_needs_unshadow() -- Check if the pte operations triggers unshadowing.
  * @oldpte: the previous value for the guest pte.
diff --git a/arch/s390/kvm/gmap/prefix.h b/arch/s390/kvm/gmap/prefix.h
new file mode 100644
index 000000000000..f83b6c2c4afa
--- /dev/null
+++ b/arch/s390/kvm/gmap/prefix.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ARCH_KVM_GMAP_PREFIX_H
+#define ARCH_KVM_GMAP_PREFIX_H
+
+#include "asm/dat-bits.h"
+#include <linux/types.h>
+#include <linux/kvm_types.h>
+#include <linux/kvm_host.h>
+
+struct gmap;
+union asce;
+
+#ifdef KVM_S390_GUEST_HAS_PREFIX
+bool _gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end, bool hint);
+int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn);
+#else
+static inline bool _gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end, bool hint)
+{
+	return true;
+}
+
+static inline int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
+{
+	return 0;
+}
+#endif /* KVM_S390_GUEST_HAS_PREFIX */
+
+static inline bool gmap_mkold_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end)
+{
+	return _gmap_unmap_prefix(gmap, gfn, end, true);
+}
+
+static inline bool gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end)
+{
+	return _gmap_unmap_prefix(gmap, gfn, end, false);
+}
+
+#endif /* ARCH_KVM_GMAP_PREFIX_H */
diff --git a/arch/s390/kvm/s390/dat.c b/arch/s390/kvm/s390/dat.c
index ff2d6c1cf90e..a56b1523e6e4 100644
--- a/arch/s390/kvm/s390/dat.c
+++ b/arch/s390/kvm/s390/dat.c
@@ -504,3 +504,51 @@ int dat_set_cmma_bits(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
 	}
 	return _dat_walk_gfn_range(gfn, gfn + count, asce, &ops, DAT_WALK_IGN_HOLES, &state);
 }
+
+static long dat_set_pn_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	union crste newcrste, oldcrste;
+	int *n = walk->priv;
+
+	do {
+		oldcrste = READ_ONCE(*crstep);
+		if (!oldcrste.h.fc || oldcrste.h.i || oldcrste.h.p)
+			return 0;
+		if (oldcrste.s.fc1.prefix_notif)
+			break;
+		newcrste = oldcrste;
+		newcrste.s.fc1.prefix_notif = 1;
+	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, walk->asce));
+	*n = 2;
+	return 0;
+}
+
+static long dat_set_pn_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	int *n = walk->priv;
+	union pgste pgste;
+
+	pgste = pgste_get_lock(ptep);
+	if (!ptep->h.i && !ptep->h.p) {
+		pgste.prefix_notif = 1;
+		*n += 1;
+	}
+	pgste_set_unlock(ptep, pgste);
+	return 0;
+}
+
+int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
+{
+	static const struct dat_walk_ops ops = {
+		.pte_entry = dat_set_pn_pte,
+		.pmd_entry = dat_set_pn_crste,
+		.pud_entry = dat_set_pn_crste,
+	};
+
+	int n = 0;
+
+	_dat_walk_gfn_range(gfn, gfn + 2, asce, &ops, DAT_WALK_IGN_HOLES, &n);
+	if (n != 2)
+		return -EAGAIN;
+	return 0;
+}
diff --git a/arch/s390/kvm/s390/gmap.c b/arch/s390/kvm/s390/gmap.c
index 83def0ed2284..b744992f0af1 100644
--- a/arch/s390/kvm/s390/gmap.c
+++ b/arch/s390/kvm/s390/gmap.c
@@ -3,6 +3,7 @@
 #include <linux/kvm_host.h>
 #include <asm/gmap_helpers.h>
 #include <gmap.h>
+#include <prefix.h>
 #include "s390.h"
 
 static int _gmap_enable_skeys(struct gmap *gmap)
@@ -82,3 +83,31 @@ void _gmap_set_cmma_all(struct gmap *gmap, bool dirty)
 	} while (gfn);
 }
 
+static inline bool kvm_s390_is_in_sie(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.sie_block->prog0c & PROG_IN_SIE;
+}
+
+bool _gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end, bool hint)
+{
+	struct kvm *kvm = gmap->kvm;
+	struct kvm_vcpu *vcpu;
+	gfn_t prefix_gfn;
+	unsigned long i;
+
+	if (is_shadow(gmap))
+		return false;
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		/* Match against both prefix pages */
+		prefix_gfn = gpa_to_gfn(kvm_s390_get_prefix(vcpu));
+		if (prefix_gfn < end && gfn <= prefix_gfn + 1) {
+			if (hint && kvm_s390_is_in_sie(vcpu))
+				return false;
+			VCPU_EVENT(vcpu, 2, "gmap notifier for %llx-%llx",
+				   gfn_to_gpa(gfn), gfn_to_gpa(end));
+			kvm_s390_sync_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu);
+		}
+	}
+	return true;
+}
+
-- 
2.53.0

