Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA64399FB;
	Fri, 31 Jul 2026 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503395; cv=none; b=GbDN3YCp4/l72KPrIremqZywiLOJGEX0H3YI8kYQlbNjQvTI1tRj3PW3u1T7fnED8LlpsNzykuLEJX112hdnjGpf0SPzb1xTsc5QXYDAjCWOtXpWZ7EgMpSnsU+rgYV+Ng4gD8PpnFEyMw9ucDo4VC8qZsIamMLRacWT6JrldPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503395; c=relaxed/simple;
	bh=foUWQGjWi+gaGptgegHNJEwZbgYd/JW/mjqzVHEMSak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxD+RMy+9iogx4GradGR+35K6xYGA/vyqdEl5jqVmoHSVaTlQNDcAQBrlAF+KgHdWMU95cf+7//XiO86HlRYsdZDqjNRqvfqkzDaPDe4Nj4rBDpq7/NfxeUzeKLSrNCum76ZnlInnn+dZm2t6PlX3XGfIOZGm6Fb54ApVJzFWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gvN7AfJS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gvN7AfJS"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlYZD1765217;
	Fri, 31 Jul 2026 13:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ILe1dRkZtRVAxMCaB
	VCcApvKGLuy0jK34rt6Fw2SQX8=; b=gvN7AfJS3RD+lY4yuFlTfX48jDrch2vRA
	/z5KTZuWBp4yeNnDJexyuhr4Qcn1SJqANq/FyYj39MgF02qarKJr8Qb1ua4kb6Tk
	gEYKCPth6Zx6TYopUWsFmbH1cQjQDMzvADlJs5s1xn6XnVbzMf9tHPim57zHj2lJ
	gzMdqFeOczRP5lps+LuCpO1qYJqFcHK+AqGQJlq99Qq6Pu5o22DbdtMBzCuQ7eiD
	M+eHKc0pApGBE0U8tla1b3dWUcq+COMf6K566Kso4+z57Tg3iIYy8KMkngQGpd71
	DswvIJsnfC21hLeq9t6fnTVxAtXufbvUAt/UkD/fiIRU+VhpLvuZQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y565u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuOHC021766;
	Fri, 31 Jul 2026 13:09:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwg43k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD9B1950135412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DFE020040;
	Fri, 31 Jul 2026 13:09:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0FE52004B;
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
Subject: [PATCH v5 18/31] KVM: s390: gmap: Move storage key and CMMA code to kvm/s390
Date: Fri, 31 Jul 2026 15:08:46 +0200
Message-ID: <20260731130902.654679-19-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: UTzjk0zZWBMJCe5Pdkkb4VzoktwNzmgy
X-Proofpoint-ORIG-GUID: 6VLgfxXqWy4hl5ym2MEQa2k-NwaD8KMK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX+nbagoTK28+T
 BMHKxMtKbRGau31xB0aLorxcwpeIY71hQJKCe6cgpw4PcDOrPIQrH9Ubll7kGA1V0DkWB2QV/Wc
 /ofXpOf2DxhwnqOo32Y9ssjfl229MUo=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6c9e80 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=gLUulVKEJhMzuiw3ne4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX9vRKaqzcrjvU
 dDAytiDpHhIjH8AHrvEy1wsvUI94Q7dTNs3B5Tl1IrdmfN7RyOAT5TsnjTyAmeejpmE0FVphkwp
 tG51sheJQwHXG6i6ESEbT3RVw2NCN2aw63ll7xfLgbKoHy30csgCdXkyw4lnObuqhH5Jm4/LPlO
 aRgh55k4q3PqepvnDej411xvrpkA2vfG/SEyGDAwDes0do/JE1L6gqcPZooyLPen8TaY9RjIitN
 2lBtPQz+tDjM32vi8Qos9Jr2i5gBRrKHXVS5pfJ3xkVEQEA6e8M21IUXwzRRnYAqW3mSXhpTyXn
 gkxwWdw0GBjT14TxPlAs5Z6bQuNbaEGwl3JM7F4+GNdxoF+799qwIrzqU8c/tzaoAoBccaWqk1j
 o0VN42N/wsJMQgO+4DK9hau0OvFsaPeMP/gP6tRYMnbncbzkMNoGX4x7EkrVWOR6HRPZS0Qli4R
 pgE+wMp4G833AZb+tpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Extract storage key and CMMA functionality from kvm/gmap to kvm/s390.
This enables other KVM implementations to use gmap without implementing
storage key or CMMA handling which only makes sense for s390 guests.

No functional changes.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c    | 500 -----------------------------------
 arch/s390/kvm/gmap/dat.h    |   7 -
 arch/s390/kvm/gmap/gmap.c   |  77 ------
 arch/s390/kvm/gmap/gmap.h   |  11 -
 arch/s390/kvm/s390/Makefile |   1 +
 arch/s390/kvm/s390/dat.c    | 506 ++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/s390/gmap.c   |  84 ++++++
 arch/s390/kvm/s390/s390.h   |  23 ++
 8 files changed, 614 insertions(+), 595 deletions(-)
 create mode 100644 arch/s390/kvm/s390/dat.c
 create mode 100644 arch/s390/kvm/s390/gmap.c

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index ed4259d17629..1ac6457de498 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -613,229 +613,6 @@ long _dat_walk_gfn_range(gfn_t start, gfn_t end, union asce asce,
 	return dat_crste_walk_range(start, min(end, asce_end(asce)), table, &walk);
 }
 
-int dat_get_storage_key(union asce asce, gfn_t gfn, union skey *skey)
-{
-	union crste *crstep;
-	union pgste pgste;
-	union pte *ptep;
-	int rc;
-
-	skey->skey = 0;
-	rc = dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
-	if (rc)
-		return rc;
-
-	if (!ptep) {
-		union crste crste;
-
-		crste = READ_ONCE(*crstep);
-		if (!crste.h.fc || !crste.s.fc1.pr)
-			return 0;
-		skey->skey = page_get_storage_key(large_crste_to_phys(crste, gfn));
-		return 0;
-	}
-	pgste = pgste_get_lock(ptep);
-	if (ptep->h.i) {
-		skey->acc = pgste.acc;
-		skey->fp = pgste.fp;
-	} else {
-		skey->skey = page_get_storage_key(pte_origin(*ptep));
-	}
-	skey->r |= pgste.gr;
-	skey->c |= pgste.gc;
-	pgste_set_unlock(ptep, pgste);
-	return 0;
-}
-
-static void dat_update_ptep_sd(union pgste old, union pgste pgste, union pte *ptep)
-{
-	if (pgste.acc != old.acc || pgste.fp != old.fp || pgste.gr != old.gr || pgste.gc != old.gc)
-		__atomic64_or(_PAGE_SD, &ptep->val);
-}
-
-int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
-			union skey skey, bool nq)
-{
-	union pgste pgste, old;
-	union crste *crstep;
-	union pte *ptep;
-	int rc;
-
-	rc = dat_entry_walk(mc, gfn, asce, DAT_WALK_LEAF_ALLOC, TABLE_TYPE_PAGE_TABLE,
-			    &crstep, &ptep);
-	if (rc)
-		return rc;
-
-	if (!ptep) {
-		page_set_storage_key(large_crste_to_phys(*crstep, gfn), skey.skey, !nq);
-		return 0;
-	}
-
-	old = pgste_get_lock(ptep);
-	pgste = old;
-
-	pgste.acc = skey.acc;
-	pgste.fp = skey.fp;
-	pgste.gc = skey.c;
-	pgste.gr = skey.r;
-
-	if (!ptep->h.i) {
-		union skey old_skey;
-
-		old_skey.skey = page_get_storage_key(pte_origin(*ptep));
-		pgste.hc |= old_skey.c;
-		pgste.hr |= old_skey.r;
-		old_skey.c = old.gc;
-		old_skey.r = old.gr;
-		skey.r = 0;
-		skey.c = 0;
-		page_set_storage_key(pte_origin(*ptep), skey.skey, !nq);
-	}
-
-	dat_update_ptep_sd(old, pgste, ptep);
-	pgste_set_unlock(ptep, pgste);
-	return 0;
-}
-
-static bool page_cond_set_storage_key(phys_addr_t paddr, union skey skey, union skey *oldkey,
-				      bool nq, bool mr, bool mc)
-{
-	oldkey->skey = page_get_storage_key(paddr);
-	if (oldkey->acc == skey.acc && oldkey->fp == skey.fp &&
-	    (oldkey->r == skey.r || mr) && (oldkey->c == skey.c || mc))
-		return false;
-	page_set_storage_key(paddr, skey.skey, !nq);
-	return true;
-}
-
-int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gfn_t gfn,
-			     union skey skey, union skey *oldkey, bool nq, bool mr, bool mc)
-{
-	union pgste pgste, old;
-	union crste *crstep;
-	union skey prev;
-	union pte *ptep;
-	int rc;
-
-	rc = dat_entry_walk(mmc, gfn, asce, DAT_WALK_LEAF_ALLOC, TABLE_TYPE_PAGE_TABLE,
-			    &crstep, &ptep);
-	if (rc)
-		return rc;
-
-	if (!ptep)
-		return page_cond_set_storage_key(large_crste_to_phys(*crstep, gfn), skey, oldkey,
-						 nq, mr, mc);
-
-	old = pgste_get_lock(ptep);
-	pgste = old;
-
-	rc = 1;
-	pgste.acc = skey.acc;
-	pgste.fp = skey.fp;
-	pgste.gc = skey.c;
-	pgste.gr = skey.r;
-
-	if (!ptep->h.i) {
-		rc = page_cond_set_storage_key(pte_origin(*ptep), skey, &prev, nq, mr, mc);
-		pgste.hc |= prev.c;
-		pgste.hr |= prev.r;
-		prev.c |= old.gc;
-		prev.r |= old.gr;
-	} else {
-		prev.acc = old.acc;
-		prev.fp = old.fp;
-		prev.c = old.gc;
-		prev.r = old.gr;
-	}
-	if (oldkey)
-		*oldkey = prev;
-
-	dat_update_ptep_sd(old, pgste, ptep);
-	pgste_set_unlock(ptep, pgste);
-	return rc;
-}
-
-int dat_reset_reference_bit(union asce asce, gfn_t gfn)
-{
-	union pgste pgste, old;
-	union crste *crstep;
-	union pte *ptep;
-	int rc;
-
-	rc = dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
-	if (rc)
-		return rc;
-
-	if (!ptep) {
-		union crste crste = READ_ONCE(*crstep);
-
-		if (!crste.h.fc || !crste.s.fc1.pr)
-			return 0;
-		return page_reset_referenced(large_crste_to_phys(*crstep, gfn));
-	}
-	old = pgste_get_lock(ptep);
-	pgste = old;
-
-	if (!ptep->h.i) {
-		rc = page_reset_referenced(pte_origin(*ptep));
-		pgste.hr = rc >> 1;
-	}
-	rc |= (pgste.gr << 1) | pgste.gc;
-	pgste.gr = 0;
-
-	dat_update_ptep_sd(old, pgste, ptep);
-	pgste_set_unlock(ptep, pgste);
-	return rc;
-}
-
-static long dat_reset_skeys_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	union pgste pgste;
-
-	pgste = pgste_get_lock(ptep);
-	pgste.acc = 0;
-	pgste.fp = 0;
-	pgste.gr = 0;
-	pgste.gc = 0;
-	if (ptep->s.pr)
-		page_set_storage_key(pte_origin(*ptep), PAGE_DEFAULT_KEY, 1);
-	pgste_set_unlock(ptep, pgste);
-
-	if (need_resched())
-		return next;
-	return 0;
-}
-
-static long dat_reset_skeys_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	phys_addr_t addr, end, origin = crste_origin_large(*crstep);
-
-	if (!crstep->h.fc || !crstep->s.fc1.pr)
-		return 0;
-
-	addr = ((max(gfn, walk->start) - gfn) << PAGE_SHIFT) + origin;
-	end = ((min(next, walk->end) - gfn) << PAGE_SHIFT) + origin;
-	while (ALIGN(addr + 1, _SEGMENT_SIZE) <= end)
-		addr = sske_frame(addr, PAGE_DEFAULT_KEY);
-	for ( ; addr < end; addr += PAGE_SIZE)
-		page_set_storage_key(addr, PAGE_DEFAULT_KEY, 1);
-
-	if (need_resched())
-		return next;
-	return 0;
-}
-
-long dat_reset_skeys(union asce asce, gfn_t start)
-{
-	const struct dat_walk_ops ops = {
-		.pte_entry = dat_reset_skeys_pte,
-		.pmd_entry = dat_reset_skeys_crste,
-		.pud_entry = dat_reset_skeys_crste,
-	};
-
-	return _dat_walk_gfn_range(start, asce_end(asce), asce, &ops, DAT_WALK_IGN_HOLES, NULL);
-}
-
 struct slot_priv {
 	unsigned long token;
 	struct kvm_s390_mmu_cache *mc;
@@ -1048,280 +825,3 @@ int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
 	return 0;
 }
 
-/**
- * dat_perform_essa() - Perform ESSA actions on the PGSTE.
- * @asce: The asce to operate on.
- * @gfn: The guest page frame to operate on.
- * @orc: The specific action to perform, see the ESSA_SET_* macros.
- * @state: The storage attributes to be returned to the guest.
- * @dirty: Returns whether the function dirtied a previously clean entry.
- *
- * Context: Called with kvm->mmu_lock held.
- *
- * Return:
- * * %1 if the page state has been altered and the page is to be added to the CBRL
- * * %0 if the page state has been altered, but the page is not to be added to the CBRL
- * * %-1 if the page state has not been altered and the page is not to be added to the CBRL
- */
-int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *state, bool *dirty)
-{
-	union crste *crstep;
-	union pgste pgste;
-	union pte *ptep;
-	int res = 0;
-
-	if (dat_entry_walk(NULL, gfn, asce, 0, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep)) {
-		*state = (union essa_state) { .exception = 1 };
-		return -1;
-	}
-
-	pgste = pgste_get_lock(ptep);
-
-	*state = (union essa_state) {
-		.content = (ptep->h.i << 1) + (ptep->h.i && pgste.zero),
-		.nodat = pgste.nodat,
-		.usage = pgste.usage,
-		};
-
-	switch (orc) {
-	case ESSA_GET_STATE:
-		res = -1;
-		break;
-	case ESSA_SET_STABLE:
-		pgste.usage = PGSTE_GPS_USAGE_STABLE;
-		pgste.nodat = 0;
-		break;
-	case ESSA_SET_UNUSED:
-		pgste.usage = PGSTE_GPS_USAGE_UNUSED;
-		if (ptep->h.i)
-			res = 1;
-		break;
-	case ESSA_SET_VOLATILE:
-		pgste.usage = PGSTE_GPS_USAGE_VOLATILE;
-		if (ptep->h.i)
-			res = 1;
-		break;
-	case ESSA_SET_POT_VOLATILE:
-		if (!ptep->h.i) {
-			pgste.usage = PGSTE_GPS_USAGE_POT_VOLATILE;
-		} else if (pgste.zero) {
-			pgste.usage = PGSTE_GPS_USAGE_VOLATILE;
-		} else if (!pgste.gc) {
-			pgste.usage = PGSTE_GPS_USAGE_VOLATILE;
-			res = 1;
-		}
-		break;
-	case ESSA_SET_STABLE_RESIDENT:
-		pgste.usage = PGSTE_GPS_USAGE_STABLE;
-		/*
-		 * Since the resident state can go away any time after this
-		 * call, we will not make this page resident. We can revisit
-		 * this decision if a guest will ever start using this.
-		 */
-		break;
-	case ESSA_SET_STABLE_IF_RESIDENT:
-		if (!ptep->h.i)
-			pgste.usage = PGSTE_GPS_USAGE_STABLE;
-		break;
-	case ESSA_SET_STABLE_NODAT:
-		pgste.usage = PGSTE_GPS_USAGE_STABLE;
-		pgste.nodat = 1;
-		break;
-	default:
-		WARN_ONCE(1, "Invalid ORC!");
-		res = -1;
-		break;
-	}
-	/* If we are discarding a page, set it to logical zero. */
-	pgste.zero = res == 1;
-	if (orc > 0) {
-		*dirty = !pgste.cmma_d;
-		pgste.cmma_d = 1;
-	}
-
-	pgste_set_unlock(ptep, pgste);
-
-	return res;
-}
-
-static long dat_reset_cmma_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	union pgste pgste;
-
-	pgste = pgste_get_lock(ptep);
-	pgste.usage = 0;
-	pgste.nodat = 0;
-	pgste.cmma_d = 0;
-	pgste_set_unlock(ptep, pgste);
-	if (need_resched())
-		return next;
-	return 0;
-}
-
-long dat_reset_cmma(union asce asce, gfn_t start)
-{
-	const struct dat_walk_ops dat_reset_cmma_ops = {
-		.pte_entry = dat_reset_cmma_pte,
-	};
-
-	return _dat_walk_gfn_range(start, asce_end(asce), asce, &dat_reset_cmma_ops,
-				   DAT_WALK_IGN_HOLES, NULL);
-}
-
-struct dat_get_cmma_state {
-	gfn_t start;
-	gfn_t end;
-	unsigned int count;
-	u8 *values;
-	atomic64_t *remaining;
-};
-
-static long __dat_peek_cmma_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	struct dat_get_cmma_state *state = walk->priv;
-	union pgste pgste;
-
-	pgste = pgste_get_lock(ptep);
-	state->values[gfn - walk->start] = pgste.usage | (pgste.nodat << 6);
-	pgste_set_unlock(ptep, pgste);
-	state->end = next;
-
-	return 0;
-}
-
-static long __dat_peek_cmma_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	struct dat_get_cmma_state *state = walk->priv;
-
-	if (crstep->h.i)
-		state->end = min(walk->end, next);
-	return 0;
-}
-
-int dat_peek_cmma(gfn_t start, union asce asce, unsigned int *count, u8 *values)
-{
-	const struct dat_walk_ops ops = {
-		.pte_entry = __dat_peek_cmma_pte,
-		.pmd_entry = __dat_peek_cmma_crste,
-		.pud_entry = __dat_peek_cmma_crste,
-		.p4d_entry = __dat_peek_cmma_crste,
-		.pgd_entry = __dat_peek_cmma_crste,
-	};
-	struct dat_get_cmma_state state = { .values = values, };
-	int rc;
-
-	rc = _dat_walk_gfn_range(start, start + *count, asce, &ops, DAT_WALK_DEFAULT, &state);
-	*count = state.end >= start ? state.end - start : 0;
-	/* Return success if at least one value was saved, otherwise an error. */
-	return (rc == -EFAULT && *count > 0) ? 0 : rc;
-}
-
-static long __dat_get_cmma_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	struct dat_get_cmma_state *state = walk->priv;
-	union pgste pgste;
-
-	if (state->start != -1) {
-		if ((gfn - state->end) > KVM_S390_MAX_BIT_DISTANCE)
-			return 1;
-		if (gfn - state->start >= state->count)
-			return 1;
-	}
-
-	if (!READ_ONCE(*pgste_of(ptep)).cmma_d)
-		return 0;
-
-	pgste = pgste_get_lock(ptep);
-	if (pgste.cmma_d) {
-		if (state->start == -1)
-			state->start = gfn;
-		pgste.cmma_d = 0;
-		atomic64_dec(state->remaining);
-		state->values[gfn - state->start] = pgste.usage | pgste.nodat << 6;
-		state->end = next;
-	}
-	pgste_set_unlock(ptep, pgste);
-	return 0;
-}
-
-int dat_get_cmma(union asce asce, gfn_t *start, unsigned int *count, u8 *values, atomic64_t *rem)
-{
-	const struct dat_walk_ops ops = { .pte_entry = __dat_get_cmma_pte, };
-	struct dat_get_cmma_state state = {
-		.remaining = rem,
-		.values = values,
-		.count = *count,
-		.start = -1,
-	};
-
-	_dat_walk_gfn_range(*start, asce_end(asce), asce, &ops, DAT_WALK_IGN_HOLES, &state);
-	/* If no dirty pages were found, wrap around and continue searching */
-	if (*start && state.start == -1)
-		_dat_walk_gfn_range(0, *start, asce, &ops, DAT_WALK_IGN_HOLES, &state);
-
-	if (state.start == -1) {
-		*count = 0;
-	} else {
-		*count = state.end - state.start;
-		*start = state.start;
-	}
-
-	return 0;
-}
-
-struct dat_set_cmma_state {
-	unsigned long mask;
-	const u8 *bits;
-};
-
-static long __dat_set_cmma_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	struct dat_set_cmma_state *state = walk->priv;
-	union pgste pgste, tmp;
-
-	tmp.val = (state->bits[gfn - walk->start] << 24) & state->mask;
-
-	pgste = pgste_get_lock(ptep);
-	pgste.usage = tmp.usage;
-	pgste.nodat = tmp.nodat;
-	pgste_set_unlock(ptep, pgste);
-
-	return 0;
-}
-
-/**
- * dat_set_cmma_bits() - Set CMMA bits for a range of guest pages.
- * @mc: Cache used for allocations.
- * @asce: The ASCE of the guest.
- * @gfn: The guest frame of the fist page whose CMMA bits are to set.
- * @count: How many pages need to be processed.
- * @mask: Which PGSTE bits should be set.
- * @bits: Points to an array with the CMMA attributes.
- *
- * This function sets the CMMA attributes for the given pages. If the input
- * buffer has zero length, no action is taken, otherwise the attributes are
- * set and the mm->context.uses_cmm flag is set.
- *
- * Each byte in @bits contains new values for bits 32-39 of the PGSTE.
- * Currently, only the fields NT and US are applied.
- *
- * Return: %0 in case of success, a negative error value otherwise.
- */
-int dat_set_cmma_bits(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
-		      unsigned long count, unsigned long mask, const uint8_t *bits)
-{
-	const struct dat_walk_ops ops = { .pte_entry = __dat_set_cmma_pte, };
-	struct dat_set_cmma_state state = { .mask = mask, .bits = bits, };
-	union crste *crstep;
-	union pte *ptep;
-	gfn_t cur;
-	int rc;
-
-	for (cur = ALIGN_DOWN(gfn, _PAGE_ENTRIES); cur < gfn + count; cur += _PAGE_ENTRIES) {
-		rc = dat_entry_walk(mc, cur, asce, DAT_WALK_ALLOC, TABLE_TYPE_PAGE_TABLE,
-				    &crstep, &ptep);
-		if (rc)
-			return rc;
-	}
-	return _dat_walk_gfn_range(gfn, gfn + count, asce, &ops, DAT_WALK_IGN_HOLES, &state);
-}
diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 711ae2f96107..e6fd201ec9b9 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -532,13 +532,6 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gfn_t gfn, union asce asce, in
 void dat_free_level(struct crst_table *table, bool owns_ptes);
 struct crst_table *dat_alloc_crst_sleepable(unsigned long init);
 int dat_set_asce_limit(struct kvm_s390_mmu_cache *mc, union asce *asce, int newtype);
-int dat_get_storage_key(union asce asce, gfn_t gfn, union skey *skey);
-int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
-			union skey skey, bool nq);
-int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gfn_t gfn,
-			     union skey skey, union skey *oldkey, bool nq, bool mr, bool mc);
-int dat_reset_reference_bit(union asce asce, gfn_t gfn);
-long dat_reset_skeys(union asce asce, gfn_t start);
 
 unsigned long dat_get_ptval(struct page_table *table, struct ptval_param param);
 void dat_set_ptval(struct page_table *table, struct ptval_param param, unsigned long val);
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 9ae55a1d6f09..c4ed40ea3475 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -945,39 +945,6 @@ void gmap_split_huge_pages(struct gmap *gmap)
 	} while (start);
 }
 
-static int _gmap_enable_skeys(struct gmap *gmap)
-{
-	gfn_t start = 0;
-	int rc;
-
-	if (uses_skeys(gmap))
-		return 0;
-
-	set_bit(GMAP_FLAG_USES_SKEYS, &gmap->flags);
-	rc = gmap_helper_disable_cow_sharing();
-	if (rc) {
-		clear_bit(GMAP_FLAG_USES_SKEYS, &gmap->flags);
-		return rc;
-	}
-
-	do {
-		scoped_guard(write_lock, &gmap->kvm->mmu_lock)
-			start = dat_reset_skeys(gmap->asce, start);
-		cond_resched();
-	} while (start);
-	return 0;
-}
-
-int gmap_enable_skeys(struct gmap *gmap)
-{
-	int rc;
-
-	mmap_write_lock(gmap->kvm->mm);
-	rc = _gmap_enable_skeys(gmap);
-	mmap_write_unlock(gmap->kvm->mm);
-	return rc;
-}
-
 static long _destroy_pages_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
 	if (!ptep->s.pr)
@@ -1098,50 +1065,6 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 	return 0;
 }
 
-static long __set_cmma_clean_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	union pgste pgste;
-
-	pgste = pgste_get_lock(ptep);
-	pgste.cmma_d = 0;
-	pgste_set_unlock(ptep, pgste);
-
-	if (need_resched())
-		return next;
-	return 0;
-}
-
-static long __set_cmma_dirty_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	union pgste pgste;
-
-	pgste = pgste_get_lock(ptep);
-	if (!pgste.cmma_d)
-		atomic64_inc(walk->priv);
-	pgste.cmma_d = 1;
-	pgste_set_unlock(ptep, pgste);
-
-	if (need_resched())
-		return next;
-	return 0;
-}
-
-void _gmap_set_cmma_all(struct gmap *gmap, bool dirty)
-{
-	const struct dat_walk_ops ops = {
-		.pte_entry = dirty ? __set_cmma_dirty_pte : __set_cmma_clean_pte,
-	};
-	gfn_t gfn = 0;
-
-	do {
-		scoped_guard(read_lock, &gmap->kvm->mmu_lock)
-			gfn = _dat_walk_gfn_range(gfn, asce_end(gmap->asce), gmap->asce, &ops,
-						  DAT_WALK_IGN_HOLES,
-						  &gmap->kvm->arch.cmma_dirty_pages);
-		cond_resched();
-	} while (gfn);
-}
-
 static void gmap_unshadow_level(struct gmap *sg, gfn_t r_gfn, int level)
 {
 	unsigned long align = PAGE_SIZE;
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index c54c35e47d6d..c9cab8f60f62 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -104,7 +104,6 @@ int gmap_insert_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn
 		     gfn_t r_gfn, int level);
 int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn,
 		      kvm_pfn_t pfn, int level, bool wr);
-void _gmap_set_cmma_all(struct gmap *gmap, bool dirty);
 void _gmap_handle_vsie_unshadow_event(struct gmap *parent, gfn_t gfn);
 struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 				union asce asce, int edat_level);
@@ -198,16 +197,6 @@ static inline bool pte_needs_unshadow(union pte oldpte, union pte newpte, union
 	return !newpte.h.p || !newpte.s.pr;
 }
 
-static inline void gmap_set_cmma_all_dirty(struct gmap *gmap)
-{
-	_gmap_set_cmma_all(gmap, true);
-}
-
-static inline void gmap_set_cmma_all_clean(struct gmap *gmap)
-{
-	_gmap_set_cmma_all(gmap, false);
-}
-
 static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, union pte newpte,
 					  union pgste pgste, gfn_t gfn, bool needs_lock)
 {
diff --git a/arch/s390/kvm/s390/Makefile b/arch/s390/kvm/s390/Makefile
index 354cb4c52635..1a1e8ce80400 100644
--- a/arch/s390/kvm/s390/Makefile
+++ b/arch/s390/kvm/s390/Makefile
@@ -8,6 +8,7 @@ ccflags-y := -I$(src) -I$(srctree)/arch/s390/kvm/gmap
 
 kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
 kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
+kvm-y += dat.o gmap.o
 
 kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
 
diff --git a/arch/s390/kvm/s390/dat.c b/arch/s390/kvm/s390/dat.c
new file mode 100644
index 000000000000..ff2d6c1cf90e
--- /dev/null
+++ b/arch/s390/kvm/s390/dat.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/page-states.h>
+
+#include "s390.h"
+
+int dat_get_storage_key(union asce asce, gfn_t gfn, union skey *skey)
+{
+	union crste *crstep;
+	union pgste pgste;
+	union pte *ptep;
+	int rc;
+
+	skey->skey = 0;
+	rc = dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
+	if (rc)
+		return rc;
+
+	if (!ptep) {
+		union crste crste;
+
+		crste = READ_ONCE(*crstep);
+		if (!crste.h.fc || !crste.s.fc1.pr)
+			return 0;
+		skey->skey = page_get_storage_key(large_crste_to_phys(crste, gfn));
+		return 0;
+	}
+	pgste = pgste_get_lock(ptep);
+	if (ptep->h.i) {
+		skey->acc = pgste.acc;
+		skey->fp = pgste.fp;
+	} else {
+		skey->skey = page_get_storage_key(pte_origin(*ptep));
+	}
+	skey->r |= pgste.gr;
+	skey->c |= pgste.gc;
+	pgste_set_unlock(ptep, pgste);
+	return 0;
+}
+
+static void dat_update_ptep_sd(union pgste old, union pgste pgste, union pte *ptep)
+{
+	if (pgste.acc != old.acc || pgste.fp != old.fp || pgste.gr != old.gr || pgste.gc != old.gc)
+		__atomic64_or(_PAGE_SD, &ptep->val);
+}
+
+int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
+			union skey skey, bool nq)
+{
+	union pgste pgste, old;
+	union crste *crstep;
+	union pte *ptep;
+	int rc;
+
+	rc = dat_entry_walk(mc, gfn, asce, DAT_WALK_LEAF_ALLOC, TABLE_TYPE_PAGE_TABLE,
+			    &crstep, &ptep);
+	if (rc)
+		return rc;
+
+	if (!ptep) {
+		page_set_storage_key(large_crste_to_phys(*crstep, gfn), skey.skey, !nq);
+		return 0;
+	}
+
+	old = pgste_get_lock(ptep);
+	pgste = old;
+
+	pgste.acc = skey.acc;
+	pgste.fp = skey.fp;
+	pgste.gc = skey.c;
+	pgste.gr = skey.r;
+
+	if (!ptep->h.i) {
+		union skey old_skey;
+
+		old_skey.skey = page_get_storage_key(pte_origin(*ptep));
+		pgste.hc |= old_skey.c;
+		pgste.hr |= old_skey.r;
+		old_skey.c = old.gc;
+		old_skey.r = old.gr;
+		skey.r = 0;
+		skey.c = 0;
+		page_set_storage_key(pte_origin(*ptep), skey.skey, !nq);
+	}
+
+	dat_update_ptep_sd(old, pgste, ptep);
+	pgste_set_unlock(ptep, pgste);
+	return 0;
+}
+
+static bool page_cond_set_storage_key(phys_addr_t paddr, union skey skey, union skey *oldkey,
+				      bool nq, bool mr, bool mc)
+{
+	oldkey->skey = page_get_storage_key(paddr);
+	if (oldkey->acc == skey.acc && oldkey->fp == skey.fp &&
+	    (oldkey->r == skey.r || mr) && (oldkey->c == skey.c || mc))
+		return false;
+	page_set_storage_key(paddr, skey.skey, !nq);
+	return true;
+}
+
+int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gfn_t gfn,
+			     union skey skey, union skey *oldkey, bool nq, bool mr, bool mc)
+{
+	union pgste pgste, old;
+	union crste *crstep;
+	union skey prev;
+	union pte *ptep;
+	int rc;
+
+	rc = dat_entry_walk(mmc, gfn, asce, DAT_WALK_LEAF_ALLOC, TABLE_TYPE_PAGE_TABLE,
+			    &crstep, &ptep);
+	if (rc)
+		return rc;
+
+	if (!ptep)
+		return page_cond_set_storage_key(large_crste_to_phys(*crstep, gfn), skey, oldkey,
+						 nq, mr, mc);
+
+	old = pgste_get_lock(ptep);
+	pgste = old;
+
+	rc = 1;
+	pgste.acc = skey.acc;
+	pgste.fp = skey.fp;
+	pgste.gc = skey.c;
+	pgste.gr = skey.r;
+
+	if (!ptep->h.i) {
+		rc = page_cond_set_storage_key(pte_origin(*ptep), skey, &prev, nq, mr, mc);
+		pgste.hc |= prev.c;
+		pgste.hr |= prev.r;
+		prev.c |= old.gc;
+		prev.r |= old.gr;
+	} else {
+		prev.acc = old.acc;
+		prev.fp = old.fp;
+		prev.c = old.gc;
+		prev.r = old.gr;
+	}
+	if (oldkey)
+		*oldkey = prev;
+
+	dat_update_ptep_sd(old, pgste, ptep);
+	pgste_set_unlock(ptep, pgste);
+	return rc;
+}
+
+int dat_reset_reference_bit(union asce asce, gfn_t gfn)
+{
+	union pgste pgste, old;
+	union crste *crstep;
+	union pte *ptep;
+	int rc;
+
+	rc = dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
+	if (rc)
+		return rc;
+
+	if (!ptep) {
+		union crste crste = READ_ONCE(*crstep);
+
+		if (!crste.h.fc || !crste.s.fc1.pr)
+			return 0;
+		return page_reset_referenced(large_crste_to_phys(*crstep, gfn));
+	}
+	old = pgste_get_lock(ptep);
+	pgste = old;
+
+	if (!ptep->h.i) {
+		rc = page_reset_referenced(pte_origin(*ptep));
+		pgste.hr = rc >> 1;
+	}
+	rc |= (pgste.gr << 1) | pgste.gc;
+	pgste.gr = 0;
+
+	dat_update_ptep_sd(old, pgste, ptep);
+	pgste_set_unlock(ptep, pgste);
+	return rc;
+}
+
+static long dat_reset_skeys_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	union pgste pgste;
+
+	pgste = pgste_get_lock(ptep);
+	pgste.acc = 0;
+	pgste.fp = 0;
+	pgste.gr = 0;
+	pgste.gc = 0;
+	if (ptep->s.pr)
+		page_set_storage_key(pte_origin(*ptep), PAGE_DEFAULT_KEY, 1);
+	pgste_set_unlock(ptep, pgste);
+
+	if (need_resched())
+		return next;
+	return 0;
+}
+
+static long dat_reset_skeys_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	phys_addr_t addr, end, origin = crste_origin_large(*crstep);
+
+	if (!crstep->h.fc || !crstep->s.fc1.pr)
+		return 0;
+
+	addr = ((max(gfn, walk->start) - gfn) << PAGE_SHIFT) + origin;
+	end = ((min(next, walk->end) - gfn) << PAGE_SHIFT) + origin;
+	while (ALIGN(addr + 1, _SEGMENT_SIZE) <= end)
+		addr = sske_frame(addr, PAGE_DEFAULT_KEY);
+	for ( ; addr < end; addr += PAGE_SIZE)
+		page_set_storage_key(addr, PAGE_DEFAULT_KEY, 1);
+
+	if (need_resched())
+		return next;
+	return 0;
+}
+
+long dat_reset_skeys(union asce asce, gfn_t start)
+{
+	const struct dat_walk_ops ops = {
+		.pte_entry = dat_reset_skeys_pte,
+		.pmd_entry = dat_reset_skeys_crste,
+		.pud_entry = dat_reset_skeys_crste,
+	};
+
+	return _dat_walk_gfn_range(start, asce_end(asce), asce, &ops, DAT_WALK_IGN_HOLES, NULL);
+}
+
+/**
+ * dat_perform_essa() - Perform ESSA actions on the PGSTE.
+ * @asce: The asce to operate on.
+ * @gfn: The guest page frame to operate on.
+ * @orc: The specific action to perform, see the ESSA_SET_* macros.
+ * @state: The storage attributes to be returned to the guest.
+ * @dirty: Returns whether the function dirtied a previously clean entry.
+ *
+ * Context: Called with kvm->mmu_lock held.
+ *
+ * Return:
+ * * %1 if the page state has been altered and the page is to be added to the CBRL
+ * * %0 if the page state has been altered, but the page is not to be added to the CBRL
+ * * %-1 if the page state has not been altered and the page is not to be added to the CBRL
+ */
+int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *state, bool *dirty)
+{
+	union crste *crstep;
+	union pgste pgste;
+	union pte *ptep;
+	int res = 0;
+
+	if (dat_entry_walk(NULL, gfn, asce, 0, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep)) {
+		*state = (union essa_state) { .exception = 1 };
+		return -1;
+	}
+
+	pgste = pgste_get_lock(ptep);
+
+	*state = (union essa_state) {
+		.content = (ptep->h.i << 1) + (ptep->h.i && pgste.zero),
+		.nodat = pgste.nodat,
+		.usage = pgste.usage,
+		};
+
+	switch (orc) {
+	case ESSA_GET_STATE:
+		res = -1;
+		break;
+	case ESSA_SET_STABLE:
+		pgste.usage = PGSTE_GPS_USAGE_STABLE;
+		pgste.nodat = 0;
+		break;
+	case ESSA_SET_UNUSED:
+		pgste.usage = PGSTE_GPS_USAGE_UNUSED;
+		if (ptep->h.i)
+			res = 1;
+		break;
+	case ESSA_SET_VOLATILE:
+		pgste.usage = PGSTE_GPS_USAGE_VOLATILE;
+		if (ptep->h.i)
+			res = 1;
+		break;
+	case ESSA_SET_POT_VOLATILE:
+		if (!ptep->h.i) {
+			pgste.usage = PGSTE_GPS_USAGE_POT_VOLATILE;
+		} else if (pgste.zero) {
+			pgste.usage = PGSTE_GPS_USAGE_VOLATILE;
+		} else if (!pgste.gc) {
+			pgste.usage = PGSTE_GPS_USAGE_VOLATILE;
+			res = 1;
+		}
+		break;
+	case ESSA_SET_STABLE_RESIDENT:
+		pgste.usage = PGSTE_GPS_USAGE_STABLE;
+		/*
+		 * Since the resident state can go away any time after this
+		 * call, we will not make this page resident. We can revisit
+		 * this decision if a guest will ever start using this.
+		 */
+		break;
+	case ESSA_SET_STABLE_IF_RESIDENT:
+		if (!ptep->h.i)
+			pgste.usage = PGSTE_GPS_USAGE_STABLE;
+		break;
+	case ESSA_SET_STABLE_NODAT:
+		pgste.usage = PGSTE_GPS_USAGE_STABLE;
+		pgste.nodat = 1;
+		break;
+	default:
+		WARN_ONCE(1, "Invalid ORC!");
+		res = -1;
+		break;
+	}
+	/* If we are discarding a page, set it to logical zero. */
+	pgste.zero = res == 1;
+	if (orc > 0) {
+		*dirty = !pgste.cmma_d;
+		pgste.cmma_d = 1;
+	}
+
+	pgste_set_unlock(ptep, pgste);
+
+	return res;
+}
+
+static long dat_reset_cmma_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	union pgste pgste;
+
+	pgste = pgste_get_lock(ptep);
+	pgste.usage = 0;
+	pgste.nodat = 0;
+	pgste.cmma_d = 0;
+	pgste_set_unlock(ptep, pgste);
+	if (need_resched())
+		return next;
+	return 0;
+}
+
+long dat_reset_cmma(union asce asce, gfn_t start)
+{
+	const struct dat_walk_ops dat_reset_cmma_ops = {
+		.pte_entry = dat_reset_cmma_pte,
+	};
+
+	return _dat_walk_gfn_range(start, asce_end(asce), asce, &dat_reset_cmma_ops,
+				   DAT_WALK_IGN_HOLES, NULL);
+}
+
+struct dat_get_cmma_state {
+	gfn_t start;
+	gfn_t end;
+	unsigned int count;
+	u8 *values;
+	atomic64_t *remaining;
+};
+
+static long __dat_peek_cmma_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	struct dat_get_cmma_state *state = walk->priv;
+	union pgste pgste;
+
+	pgste = pgste_get_lock(ptep);
+	state->values[gfn - walk->start] = pgste.usage | (pgste.nodat << 6);
+	pgste_set_unlock(ptep, pgste);
+	state->end = next;
+
+	return 0;
+}
+
+static long __dat_peek_cmma_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	struct dat_get_cmma_state *state = walk->priv;
+
+	if (crstep->h.i)
+		state->end = min(walk->end, next);
+	return 0;
+}
+
+int dat_peek_cmma(gfn_t start, union asce asce, unsigned int *count, u8 *values)
+{
+	const struct dat_walk_ops ops = {
+		.pte_entry = __dat_peek_cmma_pte,
+		.pmd_entry = __dat_peek_cmma_crste,
+		.pud_entry = __dat_peek_cmma_crste,
+		.p4d_entry = __dat_peek_cmma_crste,
+		.pgd_entry = __dat_peek_cmma_crste,
+	};
+	struct dat_get_cmma_state state = { .values = values, };
+	int rc;
+
+	rc = _dat_walk_gfn_range(start, start + *count, asce, &ops, DAT_WALK_DEFAULT, &state);
+	*count = state.end >= start ? state.end - start : 0;
+	/* Return success if at least one value was saved, otherwise an error. */
+	return (rc == -EFAULT && *count > 0) ? 0 : rc;
+}
+
+static long __dat_get_cmma_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	struct dat_get_cmma_state *state = walk->priv;
+	union pgste pgste;
+
+	if (state->start != -1) {
+		if ((gfn - state->end) > KVM_S390_MAX_BIT_DISTANCE)
+			return 1;
+		if (gfn - state->start >= state->count)
+			return 1;
+	}
+
+	if (!READ_ONCE(*pgste_of(ptep)).cmma_d)
+		return 0;
+
+	pgste = pgste_get_lock(ptep);
+	if (pgste.cmma_d) {
+		if (state->start == -1)
+			state->start = gfn;
+		pgste.cmma_d = 0;
+		atomic64_dec(state->remaining);
+		state->values[gfn - state->start] = pgste.usage | pgste.nodat << 6;
+		state->end = next;
+	}
+	pgste_set_unlock(ptep, pgste);
+	return 0;
+}
+
+int dat_get_cmma(union asce asce, gfn_t *start, unsigned int *count, u8 *values, atomic64_t *rem)
+{
+	const struct dat_walk_ops ops = { .pte_entry = __dat_get_cmma_pte, };
+	struct dat_get_cmma_state state = {
+		.remaining = rem,
+		.values = values,
+		.count = *count,
+		.start = -1,
+	};
+
+	_dat_walk_gfn_range(*start, asce_end(asce), asce, &ops, DAT_WALK_IGN_HOLES, &state);
+	/* If no dirty pages were found, wrap around and continue searching */
+	if (*start && state.start == -1)
+		_dat_walk_gfn_range(0, *start, asce, &ops, DAT_WALK_IGN_HOLES, &state);
+
+	if (state.start == -1) {
+		*count = 0;
+	} else {
+		*count = state.end - state.start;
+		*start = state.start;
+	}
+
+	return 0;
+}
+
+struct dat_set_cmma_state {
+	unsigned long mask;
+	const u8 *bits;
+};
+
+static long __dat_set_cmma_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	struct dat_set_cmma_state *state = walk->priv;
+	union pgste pgste, tmp;
+
+	tmp.val = (state->bits[gfn - walk->start] << 24) & state->mask;
+
+	pgste = pgste_get_lock(ptep);
+	pgste.usage = tmp.usage;
+	pgste.nodat = tmp.nodat;
+	pgste_set_unlock(ptep, pgste);
+
+	return 0;
+}
+
+/**
+ * dat_set_cmma_bits() - Set CMMA bits for a range of guest pages.
+ * @mc: Cache used for allocations.
+ * @asce: The ASCE of the guest.
+ * @gfn: The guest frame of the fist page whose CMMA bits are to set.
+ * @count: How many pages need to be processed.
+ * @mask: Which PGSTE bits should be set.
+ * @bits: Points to an array with the CMMA attributes.
+ *
+ * This function sets the CMMA attributes for the given pages. If the input
+ * buffer has zero length, no action is taken, otherwise the attributes are
+ * set and the mm->context.uses_cmm flag is set.
+ *
+ * Each byte in @bits contains new values for bits 32-39 of the PGSTE.
+ * Currently, only the fields NT and US are applied.
+ *
+ * Return: %0 in case of success, a negative error value otherwise.
+ */
+int dat_set_cmma_bits(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
+		      unsigned long count, unsigned long mask, const uint8_t *bits)
+{
+	const struct dat_walk_ops ops = { .pte_entry = __dat_set_cmma_pte, };
+	struct dat_set_cmma_state state = { .mask = mask, .bits = bits, };
+	union crste *crstep;
+	union pte *ptep;
+	gfn_t cur;
+	int rc;
+
+	for (cur = ALIGN_DOWN(gfn, _PAGE_ENTRIES); cur < gfn + count; cur += _PAGE_ENTRIES) {
+		rc = dat_entry_walk(mc, cur, asce, DAT_WALK_ALLOC, TABLE_TYPE_PAGE_TABLE,
+				    &crstep, &ptep);
+		if (rc)
+			return rc;
+	}
+	return _dat_walk_gfn_range(gfn, gfn + count, asce, &ops, DAT_WALK_IGN_HOLES, &state);
+}
diff --git a/arch/s390/kvm/s390/gmap.c b/arch/s390/kvm/s390/gmap.c
new file mode 100644
index 000000000000..83def0ed2284
--- /dev/null
+++ b/arch/s390/kvm/s390/gmap.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kvm_host.h>
+#include <asm/gmap_helpers.h>
+#include <gmap.h>
+#include "s390.h"
+
+static int _gmap_enable_skeys(struct gmap *gmap)
+{
+	gfn_t start = 0;
+	int rc;
+
+	if (uses_skeys(gmap))
+		return 0;
+
+	set_bit(GMAP_FLAG_USES_SKEYS, &gmap->flags);
+	rc = gmap_helper_disable_cow_sharing();
+	if (rc) {
+		clear_bit(GMAP_FLAG_USES_SKEYS, &gmap->flags);
+		return rc;
+	}
+
+	do {
+		scoped_guard(write_lock, &gmap->kvm->mmu_lock)
+			start = dat_reset_skeys(gmap->asce, start);
+		cond_resched();
+	} while (start);
+	return 0;
+}
+
+int gmap_enable_skeys(struct gmap *gmap)
+{
+	int rc;
+
+	mmap_write_lock(gmap->kvm->mm);
+	rc = _gmap_enable_skeys(gmap);
+	mmap_write_unlock(gmap->kvm->mm);
+	return rc;
+}
+
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
+static long __set_cmma_dirty_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	union pgste pgste;
+
+	pgste = pgste_get_lock(ptep);
+	if (!pgste.cmma_d)
+		atomic64_inc(walk->priv);
+	pgste.cmma_d = 1;
+	pgste_set_unlock(ptep, pgste);
+
+	if (need_resched())
+		return next;
+	return 0;
+}
+
+void _gmap_set_cmma_all(struct gmap *gmap, bool dirty)
+{
+	const struct dat_walk_ops ops = {
+		.pte_entry = dirty ? __set_cmma_dirty_pte : __set_cmma_clean_pte,
+	};
+	gfn_t gfn = 0;
+
+	do {
+		scoped_guard(read_lock, &gmap->kvm->mmu_lock)
+			gfn = _dat_walk_gfn_range(gfn, asce_end(gmap->asce), gmap->asce, &ops,
+						  DAT_WALK_IGN_HOLES,
+						  &gmap->kvm->arch.cmma_dirty_pages);
+		cond_resched();
+	} while (gfn);
+}
+
diff --git a/arch/s390/kvm/s390/s390.h b/arch/s390/kvm/s390/s390.h
index 9feb1fa66323..c846b7c6be93 100644
--- a/arch/s390/kvm/s390/s390.h
+++ b/arch/s390/kvm/s390/s390.h
@@ -635,4 +635,27 @@ extern unsigned int diag9c_forwarding_hz;
  */
 int kvm_s390_vm_stop_migration(struct kvm *kvm);
 
+/* implemented in dat.c */
+int dat_get_storage_key(union asce asce, gfn_t gfn, union skey *skey);
+int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
+			union skey skey, bool nq);
+int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gfn_t gfn,
+			     union skey skey, union skey *oldkey, bool nq, bool mr, bool mc);
+int dat_reset_reference_bit(union asce asce, gfn_t gfn);
+long dat_reset_skeys(union asce asce, gfn_t start);
+
+/* implemented in gmap.c */
+int gmap_enable_skeys(struct gmap *gmap);
+void _gmap_set_cmma_all(struct gmap *gmap, bool dirty);
+
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
 #endif
-- 
2.53.0

