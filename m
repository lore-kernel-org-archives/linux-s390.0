Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4D2EFD9B;
	Tue, 23 Jun 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228823; cv=none; b=q6FUOVvkMX4wVeVED8tow+U8eq7GRGY5Wd0GQtHIp4LN3rq/dQcxyrZqfcrK5kwbHh8HiWtdGl8YOUUnA8AJVF/dQ0Y8yi8JXfxABwVjNT+Kr+R70C3GS8eT+psiiaC74T9NXEgxo8Fo7DK2/HAn7JzrBeN8UvivBGowskBEKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228823; c=relaxed/simple;
	bh=ja26aSc5tSJEcwteC27pHRAygzutmFEn1DtTtQqGt2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hknw6B7UpNeMKi4rS9Y+nx2Wma+E6hGIx540mlxhRP3cFQnER6W3HA1F4rDFXwxZZTSyE2XhHTQy/p87fa/gcrn8hcWdWOLg3doVuzhWcEXpIqZQMWAdGmng/kVsIXosN5pQfTtCIL7zLFoVS4Lzpq7kigz4LTb36Gyo3yh/TK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pty9YuFV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pty9YuFV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmlUa1858081;
	Tue, 23 Jun 2026 15:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xo/FVgFIhgSiCSZV3
	ArhRNZJ2F1zOHAPHrUuMOZHHOg=; b=pty9YuFVuiiDOo+9RqNxgzSheGTuwQAEq
	oofmAtXjyHfK/un8Axbh1Kg3h2eVqdjMbwM2kjnAl81agDSO1prpRFTge/AHNSPj
	wQsex7U9zePnuFJcMKYaxn14HQLoumEXu20UCYiHzPcsOrlBb+flrQuWRC8UzHim
	ukr0J0oZZLNC54o4tPpjEbvHnx7yBBQaiyCh0YXVEED1LskdpDa9RPnXHNswa762
	Kps+BCnmyOemLvyn/gbpmmxvEl222ZrCLQE67LoEBn7SxTncJJHL4aSnZByu9L+3
	N9Auko9Zq1WwtcLlmsLsqQT5jV+2Zs50snDTzLiCxa/fqBM0bfJXg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hqmpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NFJgqC012510;
	Tue, 23 Jun 2026 15:33:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vykq6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NFXX8q37290468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 15:33:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 369A620040;
	Tue, 23 Jun 2026 15:33:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F319D20043;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v6 07/10] KVM: s390: Fix cmma dirty tracking
Date: Tue, 23 Jun 2026 17:33:28 +0200
Message-ID: <20260623153331.233784-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623153331.233784-1-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YznVnE2Hnn6fbvEoaRtL5iA-SJFkyDwP
X-Proofpoint-GUID: YznVnE2Hnn6fbvEoaRtL5iA-SJFkyDwP
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3aa751 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=noO423_1rYK2RU5-1PUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX6JqhDFgLSgoL
 ja7T5YlTe7xTZRz3tZcfJiYEyKeZ/B6hwW2Jwm2LBJTUX5qngf4hGhnriusl/u80BJl+wzEVPE0
 ITAEHdv11aLSGP+bBArPdenLmONZYmVuj36yLCb845ZkJDpyiGOaW4QK6Bhjgaq9EmYUAK94d01
 Rtl5NdnAXnxQVWb4gNHmotKKALXUemD2DZHKqcPYj1MQNKrh8qF1BZOLsAjDP49yXQUQF8kPbSq
 xtok0b514ixJWSZQaIPCq1azCD+WjZGqFmkRg3KzJKGO99wQfe/hTRmgRHR1XadX7+jeiWtlpxR
 21eNUMVjJbNAPS/i4FQQcdmX5h1x+cGEo61emHTP1/RDM1DqbeeDuZkhQ8EW/QwbTMAYjh4zlyG
 MN5K5Sc7z1jTb2oilftkW2/auJdrjtK0xu5TGm08NfR0r2Va8IMScYx9AQn53y/D74ViPGsOK65
 nfPJXPgV+BMYGuch7vg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfXxjREIOWzhnbC
 3qYLNfYQibEW0XNqtup04F9z7PuIniuwulrXUV/79OO2q6ENgCMXMby51J9yCQsiJjTRVyghBQp
 eezCCGcyykNaDtRRedsjipkO0qJScjw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230126

It is possible that some guest memory areas have not been touched yet
when starting migration mode, and thus have no ptes allocated. Only
existing and allocated ptes should count toward the total of dirty cmma
entries.

When starting migration mode, enable the migration_mode flag
immediately, so that any subsequent ESSA will trap in the host and
cause cmma_dirty_pages to be increased as needed.
Subsequently, set the cmma_d bit on all existing cmma-clean PGSTEs,
increasing cmma_dirty_pages as needed. Skipping cmma-dirty pages
prevents double counting.

Conversely, when disabling migration mode, set cmma_dirty_pages to 0
and clear the cmma_d bit in all existing PGSTEs.

The invariant is that when migration mode is off, no PGSTE has its
cmma_d bit set, and cmma_dirty_pages is 0. kvm->slots_lock protects
kvm_s390_vm_start_migration() and kvm_s390_vm_stop_migration() from
each other and from kvm_s390_get_cmma_bits().

Also fix dat_get_cmma() to properly wrap around if the first attempt
reached the end of guest memory without finding cmma-dirty pages.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c      |  3 +++
 arch/s390/kvm/gmap.c     | 31 ++++++++++++++++++++++++----
 arch/s390/kvm/gmap.h     | 12 ++++++++++-
 arch/s390/kvm/kvm-s390.c | 44 ++++++++++++++++++++++++++++++++--------
 arch/s390/kvm/priv.c     |  2 +-
 5 files changed, 77 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index cffac7782c4b..0ad4ebc80eba 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -1253,6 +1253,9 @@ int dat_get_cmma(union asce asce, gfn_t *start, unsigned int *count, u8 *values,
 	};
 
 	_dat_walk_gfn_range(*start, asce_end(asce), asce, &ops, DAT_WALK_IGN_HOLES, &state);
+	/* If no dirty pages were found, wrap around and continue searching */
+	if (*start && state.start == -1)
+		_dat_walk_gfn_range(0, *start, asce, &ops, DAT_WALK_IGN_HOLES, &state);
 
 	if (state.start == -1) {
 		*count = 0;
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index e6e786811db8..0f944944badf 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1073,23 +1073,46 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 	return 0;
 }
 
+static long __set_cmma_clean_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	union pgste pgste;
+
+	pgste = pgste_get_lock(ptep);
+	pgste.cmma_d = 0;
+	pgste_set_unlock(ptep, pgste);
+
+	if (need_resched())
+		return next;
+	return 0;
+}
+
 static long __set_cmma_dirty_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
-	__atomic64_or(PGSTE_CMMA_D_BIT, &pgste_of(ptep)->val);
+	union pgste pgste;
+
+	pgste = pgste_get_lock(ptep);
+	if (!pgste.cmma_d)
+		atomic64_inc(walk->priv);
+	pgste.cmma_d = 1;
+	pgste_set_unlock(ptep, pgste);
+
 	if (need_resched())
 		return next;
 	return 0;
 }
 
-void gmap_set_cmma_all_dirty(struct gmap *gmap)
+void _gmap_set_cmma_all(struct gmap *gmap, bool dirty)
 {
-	const struct dat_walk_ops ops = { .pte_entry = __set_cmma_dirty_pte, };
+	const struct dat_walk_ops ops = {
+		.pte_entry = dirty ? __set_cmma_dirty_pte : __set_cmma_clean_pte,
+	};
 	gfn_t gfn = 0;
 
 	do {
 		scoped_guard(read_lock, &gmap->kvm->mmu_lock)
 			gfn = _dat_walk_gfn_range(gfn, asce_end(gmap->asce), gmap->asce, &ops,
-						  DAT_WALK_IGN_HOLES, NULL);
+						  DAT_WALK_IGN_HOLES,
+						  &gmap->kvm->arch.cmma_dirty_pages);
 		cond_resched();
 	} while (gfn);
 }
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 5374f21aaf8d..39cb2ee1eede 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -103,7 +103,7 @@ int gmap_pv_destroy_range(struct gmap *gmap, gfn_t start, gfn_t end, bool interr
 int gmap_insert_rmap(struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn, int level);
 int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn,
 		      kvm_pfn_t pfn, int level, bool wr);
-void gmap_set_cmma_all_dirty(struct gmap *gmap);
+void _gmap_set_cmma_all(struct gmap *gmap, bool dirty);
 void _gmap_handle_vsie_unshadow_event(struct gmap *parent, gfn_t gfn);
 struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 				union asce asce, int edat_level);
@@ -167,6 +167,16 @@ static inline bool gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end)
 	return _gmap_unmap_prefix(gmap, gfn, end, false);
 }
 
+static inline void gmap_set_cmma_all_dirty(struct gmap *gmap)
+{
+	_gmap_set_cmma_all(gmap, true);
+}
+
+static inline void gmap_set_cmma_all_clean(struct gmap *gmap)
+{
+	_gmap_set_cmma_all(gmap, false);
+}
+
 /**
  * pte_needs_unshadow() -- Check if the pte operations triggers unshadowing.
  * @oldpte: the previous value for the guest pte.
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fe0ae15e5ad0..91cf7a3c55c7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1187,13 +1187,13 @@ static void kvm_s390_sync_request_broadcast(struct kvm *kvm, int req)
 
 /*
  * Must be called with kvm->srcu held to avoid races on memslots, and with
- * kvm->slots_lock to avoid races with ourselves and kvm_s390_vm_stop_migration.
+ * kvm->slots_lock to avoid races with ourselves, kvm_s390_vm_stop_migration(),
+ * and kvm_s390_get_cmma_bits().
  */
 static int kvm_s390_vm_start_migration(struct kvm *kvm)
 {
 	struct kvm_memory_slot *ms;
 	struct kvm_memslots *slots;
-	unsigned long ram_pages = 0;
 	int bkt;
 
 	/* migration mode already enabled */
@@ -1210,28 +1210,54 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
 	kvm_for_each_memslot(ms, bkt, slots) {
 		if (!ms->dirty_bitmap)
 			return -EINVAL;
-		ram_pages += ms->npages;
 	}
-	/* mark all the pages as dirty */
+	/*
+	 * Set the flag and let KVM handle ESSA manually, potentially setting
+	 * the cmma_d bit in some PGSTEs and increasing cmma_dirty_pages.
+	 * At this point cmma_dirty_pages is still 0, and all existing PGSTEs
+	 * have their cmma_d bit set to 0.
+	 * Any newly allocated page table has its entries marked as cmma-clean,
+	 * which is fine because the CMMA values are not dirty.
+	 */
+	WRITE_ONCE(kvm->arch.migration_mode, 1);
+	/*
+	 * Mark all PGSTEs as cmma-dirty, increasing cmma_dirty_pages as needed,
+	 * but without double-counting pages that have become dirty on their own
+	 * in the meantime.
+	 * At this point some pages might have become dirty on their own already
+	 * and cmma_dirty_pages might therefore be non-zero.
+	 */
 	gmap_set_cmma_all_dirty(kvm->arch.gmap);
-	atomic64_set(&kvm->arch.cmma_dirty_pages, ram_pages);
-	kvm->arch.migration_mode = 1;
 	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_START_MIGRATION);
 	return 0;
 }
 
 /*
- * Must be called with kvm->slots_lock to avoid races with ourselves and
- * kvm_s390_vm_start_migration.
+ * Must be called with kvm->slots_lock to avoid races with ourselves,
+ * kvm_s390_vm_start_migration() and kvm_s390_get_cmma_bits().
  */
 static int kvm_s390_vm_stop_migration(struct kvm *kvm)
 {
 	/* migration mode already disabled */
 	if (!kvm->arch.migration_mode)
 		return 0;
-	kvm->arch.migration_mode = 0;
+	/*
+	 * Unset the flag and propagate to all vCPUs. From now on the cmma_d
+	 * bit will not be touched on any PGSTE.
+	 * At this point cmma_dirty_pages is possibly non-zero, and thus some
+	 * PGSTEs might have cmma_d set.
+	 */
+	WRITE_ONCE(kvm->arch.migration_mode, 0);
 	if (kvm->arch.use_cmma)
 		kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
+	/* Clear cmma_d on all existing PGSTEs and set cmma_dirty_pages to 0. */
+	gmap_set_cmma_all_clean(kvm->arch.gmap);
+	atomic64_set(&kvm->arch.cmma_dirty_pages, 0);
+	/*
+	 * At this point the system has the expected state: migration_mode is 0,
+	 * cmma_dirty_pages is 0, and all existing PGSTEs have their cmma_d bit
+	 * set to 0.
+	 */
 	return 0;
 }
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9bc6fd02ff77..ad0ddc433a73 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1236,7 +1236,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 						: ESSA_SET_STABLE_IF_RESIDENT))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	if (!vcpu->kvm->arch.migration_mode) {
+	if (!READ_ONCE(vcpu->kvm->arch.migration_mode)) {
 		/*
 		 * CMMA is enabled in the KVM settings, but is disabled in
 		 * the SIE block and in the mm_context, and we are not doing
-- 
2.54.0

