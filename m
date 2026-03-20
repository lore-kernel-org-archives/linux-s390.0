Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F263CFF69;
	Fri, 20 Mar 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023353; cv=none; b=BpR4eJppt520uxXl7sxPJVNsOvt+mgL+tL6RePdGyMtd67kroWU/pFC5HbP6YCt7sZVPc+OrwQzqBsU7siq3Pc/gxV8zZaerCatgkWAzdsAGQyvs0H0WfCK6Oqt0cKOImUkP7lm0eSAoXtGKZHkbcPQQgv30x6GOmDJ1V7Gby2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023353; c=relaxed/simple;
	bh=vCxHaPTJe4yqtPFTmAjuCn77Il9SYXklMHitFpm8R18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4etpA+ad7AFWvKKVeXkcFGlGrc3nZD/dX0hnAsctPtd18NQHZ7/0oquHsYy8FOClXKHowL9lqNXJecAXQmb3OQPLycOm7P8XiAdEAq9dF6Ky/d4JB5hpQyDlzIGTsxxyRdvWGrUxOeBcHRpoLULwKsRyqxuXYLyaLptyguSPMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kymePSSf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kymePSSf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8bUl52429037;
	Fri, 20 Mar 2026 16:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lIPOpCb+wzrQaX0K/
	fmgNVA+9F1GCJv0/JwPbMmICBE=; b=kymePSSf2j17tzExZfdyDfa06tm4jSrEa
	XxJocNBDG1Ltl+NLAfbX1GA6KtqnMC6cjmZEiOkOdnePMMvi7l/bOoOYZxazbUfe
	UaBwQiPcukojVSlra7BXRfIjob+SttZEqRXd0iiO1bIcucp/4Bj8BYTi/LA8eygW
	Y71oewdUL9RiAT5UqPkWaCZeVbh+lHtKjid+jbdcvAp6qvBtYDe+e3KD+myQoj+A
	8Q7YWjJT0JOGPNnB7bwfir1eirNKtHCPFYejptXFzHxn+GqZjHSkv69g5SZXMPlS
	wD0e2EFesLlUC/tkZnkZ8gwVbj4yAeKAKz5W2Wt6A2oArd7TEH1dw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybsmda8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KDTNYL028496;
	Fri, 20 Mar 2026 16:15:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1qmvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KGFgKh41288174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:15:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C24F220040;
	Fri, 20 Mar 2026 16:15:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9303220043;
	Fri, 20 Mar 2026 16:15:42 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 16:15:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 2/8] KVM: s390: Remove non-atomic dat_crstep_xchg()
Date: Fri, 20 Mar 2026 17:15:36 +0100
Message-ID: <20260320161542.202913-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320161542.202913-1-imbrenda@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bd72b3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=UWa3PdyAdGT8wWmJkKEA:9
X-Proofpoint-ORIG-GUID: nfUW8y-Ry1JSxumsqv2ufMAbXGpPlevW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEzMCBTYWx0ZWRfX7FIP+tAXFxnb
 WCJd/r8L43bM7eF1NekiOQbGIk91CwVRbbLXhuW17djOPulaIEgG6lu9BjQQ2zmCYo6VCxL4O+X
 2TiYOcCHmL9jTRL+07lj9pF7A32BlZVrMTa/K/vQXXk143bQnkDg1LcXrO7cRQlvHDaR3d0s3hf
 2WKIdakVgOhfcURWIU4+2reHmKet+/1q5a6GdfQlrXLv3z5kBIPgfrN/SdCzq2fRRcVM/lULKxR
 ogzQL+lEtrdHB0hJtfZgZF5PB4buHgcG3UbpcUW4fglJamSw2y/xE/qdFaUU5cpgwzhCoebD8C3
 34ecz+BGn7OA+at1T3JoeLBZSbY5A7Y/GGPBF82iDxv3pVzaqIJa1nwtHyS5aT/CQpJkCe2rEXA
 E4jqPWBc1Ar+K1sXijzqCiDBZte9utf4guMh/X1FCTj0MS7eVpSH6asYqug5wP/HoqZqgETAO35
 nkBZ95hxGbxQBwuZOgA==
X-Proofpoint-GUID: nfUW8y-Ry1JSxumsqv2ufMAbXGpPlevW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200130

In practice dat_crstep_xchg() is racy and hard to use correctly. Simply
remove it and replace its uses with dat_crstep_xchg_atomic().

This solves some actual races that lead to system hangs / crashes.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: 589071eaaa8f ("KVM: s390: KVM page table management functions: clear and replace")
Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")
---
 arch/s390/kvm/dat.c     | 53 ++++++++------------------
 arch/s390/kvm/dat.h     |  9 +++--
 arch/s390/kvm/gaccess.c | 26 +++++++------
 arch/s390/kvm/gmap.c    | 82 ++++++++++++++++++++++++-----------------
 arch/s390/kvm/gmap.h    | 24 ++++++------
 5 files changed, 97 insertions(+), 97 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 48b5f2bcf172..8ba80b0b4698 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -134,32 +134,6 @@ int dat_set_asce_limit(struct kvm_s390_mmu_cache *mc, union asce *asce, int newt
 	return 0;
 }
 
-/**
- * dat_crstep_xchg() - Exchange a gmap CRSTE with another.
- * @crstep: Pointer to the CRST entry
- * @new: Replacement entry.
- * @gfn: The affected guest address.
- * @asce: The ASCE of the address space.
- *
- * Context: This function is assumed to be called with kvm->mmu_lock held.
- */
-void dat_crstep_xchg(union crste *crstep, union crste new, gfn_t gfn, union asce asce)
-{
-	if (crstep->h.i) {
-		WRITE_ONCE(*crstep, new);
-		return;
-	} else if (cpu_has_edat2()) {
-		crdte_crste(crstep, *crstep, new, gfn, asce);
-		return;
-	}
-
-	if (machine_has_tlb_guest())
-		idte_crste(crstep, gfn, IDTE_GUEST_ASCE, asce, IDTE_GLOBAL);
-	else
-		idte_crste(crstep, gfn, 0, NULL_ASCE, IDTE_GLOBAL);
-	WRITE_ONCE(*crstep, new);
-}
-
 /**
  * dat_crstep_xchg_atomic() - Atomically exchange a gmap CRSTE with another.
  * @crstep: Pointer to the CRST entry.
@@ -175,8 +149,8 @@ void dat_crstep_xchg(union crste *crstep, union crste new, gfn_t gfn, union asce
  *
  * Return: %true if the exchange was successful.
  */
-bool dat_crstep_xchg_atomic(union crste *crstep, union crste old, union crste new, gfn_t gfn,
-			    union asce asce)
+bool __must_check dat_crstep_xchg_atomic(union crste *crstep, union crste old, union crste new,
+					 gfn_t gfn, union asce asce)
 {
 	if (old.h.i)
 		return arch_try_cmpxchg((long *)crstep, &old.val, new.val);
@@ -894,7 +868,8 @@ static long _dat_slot_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct d
 
 	/* This table entry needs to be updated. */
 	if (walk->start <= gfn && walk->end >= next) {
-		dat_crstep_xchg_atomic(crstep, crste, new_crste, gfn, walk->asce);
+		if (!dat_crstep_xchg_atomic(crstep, crste, new_crste, gfn, walk->asce))
+			return -EINVAL;
 		/* A lower level table was present, needs to be freed. */
 		if (!crste.h.fc && !crste.h.i) {
 			if (is_pmd(crste))
@@ -1072,17 +1047,19 @@ int dat_link(struct kvm_s390_mmu_cache *mc, union asce asce, int level,
 
 static long dat_set_pn_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
-	union crste crste = READ_ONCE(*crstep);
+	union crste newcrste, oldcrste;
 	int *n = walk->priv;
 
-	if (!crste.h.fc || crste.h.i || crste.h.p)
-		return 0;
-
-	*n = 2;
-	if (crste.s.fc1.prefix_notif)
-		return 0;
-	crste.s.fc1.prefix_notif = 1;
-	dat_crstep_xchg(crstep, crste, gfn, walk->asce);
+	do {
+		oldcrste = READ_ONCE(*crstep);
+		if (!oldcrste.h.fc || oldcrste.h.i || oldcrste.h.p)
+			return 0;
+		*n = 2;
+		if (oldcrste.s.fc1.prefix_notif)
+			return 0;
+		newcrste = oldcrste;
+		newcrste.s.fc1.prefix_notif = 1;
+	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, walk->asce));
 	return 0;
 }
 
diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index 123e11dcd70d..22dafc775335 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -938,11 +938,14 @@ static inline bool dat_pudp_xchg_atomic(union pud *pudp, union pud old, union pu
 	return dat_crstep_xchg_atomic(_CRSTEP(pudp), _CRSTE(old), _CRSTE(new), gfn, asce);
 }
 
-static inline void dat_crstep_clear(union crste *crstep, gfn_t gfn, union asce asce)
+static inline union crste dat_crstep_clear_atomic(union crste *crstep, gfn_t gfn, union asce asce)
 {
-	union crste newcrste = _CRSTE_EMPTY(crstep->h.tt);
+	union crste oldcrste, empty = _CRSTE_EMPTY(crstep->h.tt);
 
-	dat_crstep_xchg(crstep, newcrste, gfn, asce);
+	do {
+		oldcrste = READ_ONCE(*crstep);
+	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, empty, gfn, asce));
+	return oldcrste;
 }
 
 static inline int get_level(union crste *crstep, union pte *ptep)
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index a9da9390867d..4ee862424ca0 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1456,7 +1456,7 @@ static int _do_shadow_pte(struct gmap *sg, gpa_t raddr, union pte *ptep_h, union
 static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, union crste *table,
 			    struct guest_fault *f, bool p)
 {
-	union crste newcrste;
+	union crste newcrste, oldcrste;
 	gfn_t gfn;
 	int rc;
 
@@ -1469,16 +1469,20 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 	if (rc)
 		return rc;
 
-	newcrste = _crste_fc1(f->pfn, host->h.tt, f->writable, !p);
-	newcrste.s.fc1.d |= host->s.fc1.d;
-	newcrste.s.fc1.sd |= host->s.fc1.sd;
-	newcrste.h.p &= host->h.p;
-	newcrste.s.fc1.vsie_notif = 1;
-	newcrste.s.fc1.prefix_notif = host->s.fc1.prefix_notif;
-	_gmap_crstep_xchg(sg->parent, host, newcrste, f->gfn, false);
-
-	newcrste = _crste_fc1(f->pfn, host->h.tt, 0, !p);
-	dat_crstep_xchg(table, newcrste, gpa_to_gfn(raddr), sg->asce);
+	do {
+		oldcrste = READ_ONCE(*host);
+		newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, f->writable, !p);
+		newcrste.s.fc1.d |= oldcrste.s.fc1.d;
+		newcrste.s.fc1.sd |= oldcrste.s.fc1.sd;
+		newcrste.h.p &= oldcrste.h.p;
+		newcrste.s.fc1.vsie_notif = 1;
+		newcrste.s.fc1.prefix_notif = oldcrste.s.fc1.prefix_notif;
+	} while (!_gmap_crstep_xchg_atomic(sg->parent, host, oldcrste, newcrste, f->gfn, false));
+
+	newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, 0, !p);
+	gfn = gpa_to_gfn(raddr);
+	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, gfn, sg->asce))
+		;
 	return 0;
 }
 
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index ef0c6ebfdde2..d974cdac1cce 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -313,13 +313,16 @@ static long gmap_clear_young_crste(union crste *crstep, gfn_t gfn, gfn_t end, st
 	struct clear_young_pte_priv *priv = walk->priv;
 	union crste crste, new;
 
-	crste = READ_ONCE(*crstep);
+	do {
+		crste = READ_ONCE(*crstep);
+
+		if (!crste.h.fc)
+			return 0;
+		if (!crste.s.fc1.y && crste.h.i)
+			return 0;
+		if (crste_prefix(crste) && !gmap_mkold_prefix(priv->gmap, gfn, end))
+			break;
 
-	if (!crste.h.fc)
-		return 0;
-	if (!crste.s.fc1.y && crste.h.i)
-		return 0;
-	if (!crste_prefix(crste) || gmap_mkold_prefix(priv->gmap, gfn, end)) {
 		new = crste;
 		new.h.i = 1;
 		new.s.fc1.y = 0;
@@ -328,8 +331,8 @@ static long gmap_clear_young_crste(union crste *crstep, gfn_t gfn, gfn_t end, st
 			folio_set_dirty(phys_to_folio(crste_origin_large(crste)));
 		new.s.fc1.d = 0;
 		new.h.p = 1;
-		dat_crstep_xchg(crstep, new, gfn, walk->asce);
-	}
+	} while (!dat_crstep_xchg_atomic(crstep, crste, new, gfn, walk->asce));
+
 	priv->young = 1;
 	return 0;
 }
@@ -391,14 +394,18 @@ static long _gmap_unmap_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct
 {
 	struct gmap_unmap_priv *priv = walk->priv;
 	struct folio *folio = NULL;
+	union crste old = *crstep;
 
-	if (crstep->h.fc) {
-		if (crstep->s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags))
-			folio = phys_to_folio(crste_origin_large(*crstep));
-		gmap_crstep_xchg(priv->gmap, crstep, _CRSTE_EMPTY(crstep->h.tt), gfn);
-		if (folio)
-			uv_convert_from_secure_folio(folio);
-	}
+	if (!old.h.fc)
+		return 0;
+
+	if (old.s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags))
+		folio = phys_to_folio(crste_origin_large(old));
+	/* No races should happen because kvm->mmu_lock is held in write mode */
+	KVM_BUG_ON(!gmap_crstep_xchg_atomic(priv->gmap, crstep, old, _CRSTE_EMPTY(old.h.tt), gfn),
+		   priv->gmap->kvm);
+	if (folio)
+		uv_convert_from_secure_folio(folio);
 
 	return 0;
 }
@@ -474,23 +481,24 @@ static long _crste_test_and_clear_softdirty(union crste *table, gfn_t gfn, gfn_t
 
 	if (fatal_signal_pending(current))
 		return 1;
-	crste = READ_ONCE(*table);
-	if (!crste.h.fc)
-		return 0;
-	if (crste.h.p && !crste.s.fc1.sd)
-		return 0;
+	do {
+		crste = READ_ONCE(*table);
+		if (!crste.h.fc)
+			return 0;
+		if (crste.h.p && !crste.s.fc1.sd)
+			return 0;
 
-	/*
-	 * If this large page contains one or more prefixes of vCPUs that are
-	 * currently running, do not reset the protection, leave it marked as
-	 * dirty.
-	 */
-	if (!crste.s.fc1.prefix_notif || gmap_mkold_prefix(gmap, gfn, end)) {
+		/*
+		 * If this large page contains one or more prefixes of vCPUs that are
+		 * currently running, do not reset the protection, leave it marked as
+		 * dirty.
+		 */
+		if (crste.s.fc1.prefix_notif && !gmap_mkold_prefix(gmap, gfn, end))
+			break;
 		new = crste;
 		new.h.p = 1;
 		new.s.fc1.sd = 0;
-		gmap_crstep_xchg(gmap, table, new, gfn);
-	}
+	} while (gmap_crstep_xchg_atomic(gmap, table, crste, new, gfn));
 
 	for ( ; gfn < end; gfn++)
 		mark_page_dirty(gmap->kvm, gfn);
@@ -646,8 +654,8 @@ int gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, struct guest_fau
 static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 			     gfn_t p_gfn, gfn_t c_gfn, bool force_alloc)
 {
+	union crste newcrste, oldcrste;
 	struct page_table *pt;
-	union crste newcrste;
 	union crste *crstep;
 	union pte *ptep;
 	int rc;
@@ -673,7 +681,11 @@ static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 			    &crstep, &ptep);
 	if (rc)
 		return rc;
-	dat_crstep_xchg(crstep, newcrste, c_gfn, gmap->asce);
+	do {
+		oldcrste = READ_ONCE(*crstep);
+		if (oldcrste.val == newcrste.val)
+			break;
+	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, c_gfn, gmap->asce));
 	return 0;
 }
 
@@ -777,8 +789,10 @@ static void gmap_ucas_unmap_one(struct gmap *gmap, gfn_t c_gfn)
 	int rc;
 
 	rc = dat_entry_walk(NULL, c_gfn, gmap->asce, 0, TABLE_TYPE_SEGMENT, &crstep, &ptep);
-	if (!rc)
-		dat_crstep_xchg(crstep, _PMD_EMPTY, c_gfn, gmap->asce);
+	if (rc)
+		return;
+	while (!dat_crstep_xchg_atomic(crstep, READ_ONCE(*crstep), _PMD_EMPTY, c_gfn, gmap->asce))
+		;
 }
 
 void gmap_ucas_unmap(struct gmap *gmap, gfn_t c_gfn, unsigned long count)
@@ -1017,8 +1031,8 @@ static void gmap_unshadow_level(struct gmap *sg, gfn_t r_gfn, int level)
 			dat_ptep_xchg(ptep, _PTE_EMPTY, r_gfn, sg->asce, uses_skeys(sg));
 		return;
 	}
-	crste = READ_ONCE(*crstep);
-	dat_crstep_clear(crstep, r_gfn, sg->asce);
+
+	crste = dat_crstep_clear_atomic(crstep, r_gfn, sg->asce);
 	if (crste_leaf(crste) || crste.h.i)
 		return;
 	if (is_pmd(crste))
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index ccb5cd751e31..967a280b3235 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -194,8 +194,9 @@ static inline union pgste gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, uni
 	return _gmap_ptep_xchg(gmap, ptep, newpte, pgste, gfn, true);
 }
 
-static inline void _gmap_crstep_xchg(struct gmap *gmap, union crste *crstep, union crste ne,
-				     gfn_t gfn, bool needs_lock)
+static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, union crste *crstep,
+							 union crste oldcrste, union crste newcrste,
+							 gfn_t gfn, bool needs_lock)
 {
 	unsigned long align = 8 + (is_pmd(*crstep) ? 0 : 11);
 
@@ -204,25 +205,26 @@ static inline void _gmap_crstep_xchg(struct gmap *gmap, union crste *crstep, uni
 		lockdep_assert_held(&gmap->children_lock);
 
 	gfn = ALIGN_DOWN(gfn, align);
-	if (crste_prefix(*crstep) && (ne.h.p || ne.h.i || !crste_prefix(ne))) {
-		ne.s.fc1.prefix_notif = 0;
+	if (crste_prefix(oldcrste) && (newcrste.h.p || newcrste.h.i || !crste_prefix(newcrste))) {
+		newcrste.s.fc1.prefix_notif = 0;
 		gmap_unmap_prefix(gmap, gfn, gfn + align);
 	}
-	if (crste_leaf(*crstep) && crstep->s.fc1.vsie_notif &&
-	    (ne.h.p || ne.h.i || !ne.s.fc1.vsie_notif)) {
-		ne.s.fc1.vsie_notif = 0;
+	if (crste_leaf(oldcrste) && oldcrste.s.fc1.vsie_notif &&
+	    (newcrste.h.p || newcrste.h.i || !newcrste.s.fc1.vsie_notif)) {
+		newcrste.s.fc1.vsie_notif = 0;
 		if (needs_lock)
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
 	}
-	dat_crstep_xchg(crstep, ne, gfn, gmap->asce);
+	return dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);
 }
 
-static inline void gmap_crstep_xchg(struct gmap *gmap, union crste *crstep, union crste ne,
-				    gfn_t gfn)
+static inline bool __must_check gmap_crstep_xchg_atomic(struct gmap *gmap, union crste *crstep,
+							union crste oldcrste, union crste newcrste,
+							gfn_t gfn)
 {
-	return _gmap_crstep_xchg(gmap, crstep, ne, gfn, true);
+	return _gmap_crstep_xchg_atomic(gmap, crstep, oldcrste, newcrste, gfn, true);
 }
 
 /**
-- 
2.53.0

