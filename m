Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A805382F2F;
	Wed, 18 Mar 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842943; cv=none; b=cI25XluhEmWN/MPgPhvSOQmPAjfwpEpjatqzcYqB1kP8z4ut6NZltKtz94tVXoOaI8tV+vQkYQIKwo51IwHp1TLTjauyQWZ63Tb7aIDWBbWsIlw8PMgEKDWO7Xu/p32jbwXBdoH6vdokBQTc0aQKgYLukLOvAzm8IefyMDoIIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842943; c=relaxed/simple;
	bh=ZKzoW4CqYUYXfg941YKlSMyeaKXqcPwfYFlm4TXgeZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1R4ep2TsK9EDbiIY4+814NRJUplitJQDxENpHpRi4kBarqEJa1+JCxKoMdIWe5LVtYIA+OUy6pxCeImUcOrxQRDIV85+UKaVKCRfcGawiz1FWO9zdOMxSexGbyHLcfhNmifgbe4s4iFrfEI73lyIUN0Aokj0eXpOKzngI3uolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eu3owpHy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eu3owpHy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IBB8oF475030;
	Wed, 18 Mar 2026 14:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9NWO1HKrlvylPa41s
	TlhZntynvWlg5m99P6B8m/oAuY=; b=eu3owpHyUC9zXlJQDbBNFQiuGBwxOIYcf
	eJ9CoCRaBo6D1F7ICrQeslVFAtWg7YVMycvkSVjnydieDK0ii904aR4S1SPec16B
	T7kwy1+LlO5NoFMgIOOeTRtlbi3U0DQA/KD+UGOauZJnGgNGrKqKNsoffv8itryw
	KU2QV093vrM6Yr+dzYHwnf/rDB0C8rIxHHZTviGcwIE0lZgqSc/ZL46t/Pu1TQng
	5IEvZVpDr5aSgefoiUTfPU8OpT10PDyfCXtogqmrH5nbgw27o0eb/Xtn4Tn7LcfM
	YSvOgrwaiD4pMDRtC8V3BzFp2L7exCkENvrb72peSxgW7UA3bjrHQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauhnd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:08:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IDtjtt015655;
	Wed, 18 Mar 2026 14:08:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0ne9ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:08:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IE8scu55771514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 14:08:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BB4D2004E;
	Wed, 18 Mar 2026 14:08:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E8252004D;
	Wed, 18 Mar 2026 14:08:54 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 14:08:54 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nsg@linux.ibm.com,
        nrb@linux.ibm.com, seiden@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v1 1/7] KVM: s390: Remove non-atomic dat_crstep_xchg()
Date: Wed, 18 Mar 2026 15:08:47 +0100
Message-ID: <20260318140853.119460-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140853.119460-1-imbrenda@linux.ibm.com>
References: <20260318140853.119460-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfX0e2vXoJ9Ac90
 laNnvUK5041XB5PQVWO515/wGls9vSdfw66NMVXwHff6CPsIRkL+29DBc1vrEgDLJlK0n6+Shkc
 u+yYJfbihXA2/i3H0JMM0TQYj2OMUpTUgTcrEMoEBWcbfpGBH7IQqJcRUIotkDQnTorvt88awTZ
 mycN3y2c6pZifnE+dY5XeC8Eu9BfpO7giBrJdOHC6BTrIDUQN/zGCAa1hC6AzdbJ9lkVNhed/Mr
 3A2EEGNWlVpcX545usR34yBCH20073fEZMmIpJYjImcJ8A3Or9vbfCrqGhAAVTEofo1cCfnlcGL
 TojQhZ8qOOlMn2n9JQvIpM7r7rmc+ZgFtahQ28aYPh08LJH2/ZPawspnLNW+wZ/oNjmARvzNuTE
 fB68KtaRwR8eBC61RV8oxMQjI146aiPxk0dddPlLzrfIgmleWe9RyVZKZU1lWCvATNOc0P7/j/S
 jv1UmeSYaNSdQH/WOzQ==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bab1fb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=EjwUsyl_T-KN8MHjdx0A:9
X-Proofpoint-ORIG-GUID: vs4FUo-cYqAEzDzgbzMWLSrQyg5l1aRu
X-Proofpoint-GUID: vs4FUo-cYqAEzDzgbzMWLSrQyg5l1aRu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180116

In practice dat_crstep_xchg() is racy and hard to use correctly. Simply
remove it and replace its uses with dat_crstep_xchg_atomic().

This solves some actual races that lead to system hangs / crashes.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: 589071eaaa8f ("KVM: s390: KVM page table management functions: clear and replace")
Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")
---
 arch/s390/kvm/dat.c     | 53 ++++++++++++-----------------------------
 arch/s390/kvm/dat.h     |  9 ++++---
 arch/s390/kvm/gaccess.c |  4 +++-
 arch/s390/kvm/gmap.c    | 32 +++++++++++++++----------
 arch/s390/kvm/gmap.h    | 32 ++++++++++++++-----------
 5 files changed, 61 insertions(+), 69 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 670404d4fa44..b673e86c8ae5 100644
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
@@ -893,7 +867,8 @@ static long _dat_slot_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct d
 
 	/* This table entry needs to be updated. */
 	if (walk->start <= gfn && walk->end >= next) {
-		dat_crstep_xchg_atomic(crstep, crste, new_crste, gfn, walk->asce);
+		if (!dat_crstep_xchg_atomic(crstep, crste, new_crste, gfn, walk->asce))
+			return -EINVAL;
 		/* A lower level table was present, needs to be freed. */
 		if (!crste.h.fc && !crste.h.i) {
 			if (is_pmd(crste))
@@ -1071,17 +1046,19 @@ int dat_link(struct kvm_s390_mmu_cache *mc, union asce asce, int level,
 
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
index a9da9390867d..e490ae87db44 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1478,7 +1478,9 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 	_gmap_crstep_xchg(sg->parent, host, newcrste, f->gfn, false);
 
 	newcrste = _crste_fc1(f->pfn, host->h.tt, 0, !p);
-	dat_crstep_xchg(table, newcrste, gpa_to_gfn(raddr), sg->asce);
+	gfn = gpa_to_gfn(raddr);
+	while (!dat_crstep_xchg_atomic(table, READ_ONCE(*table), newcrste, gfn, sg->asce))
+		;
 	return 0;
 }
 
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index ef0c6ebfdde2..3ae746fada36 100644
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
@@ -673,7 +676,8 @@ static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 			    &crstep, &ptep);
 	if (rc)
 		return rc;
-	dat_crstep_xchg(crstep, newcrste, c_gfn, gmap->asce);
+	while (!dat_crstep_xchg_atomic(crstep, READ_ONCE(*crstep), newcrste, c_gfn, gmap->asce))
+		;
 	return 0;
 }
 
@@ -777,8 +781,10 @@ static void gmap_ucas_unmap_one(struct gmap *gmap, gfn_t c_gfn)
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
@@ -1017,8 +1023,8 @@ static void gmap_unshadow_level(struct gmap *sg, gfn_t r_gfn, int level)
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
index ccb5cd751e31..3ef426abdc65 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -198,25 +198,29 @@ static inline void _gmap_crstep_xchg(struct gmap *gmap, union crste *crstep, uni
 				     gfn_t gfn, bool needs_lock)
 {
 	unsigned long align = 8 + (is_pmd(*crstep) ? 0 : 11);
+	union crste oldcrste;
 
 	lockdep_assert_held(&gmap->kvm->mmu_lock);
 	if (!needs_lock)
 		lockdep_assert_held(&gmap->children_lock);
 
-	gfn = ALIGN_DOWN(gfn, align);
-	if (crste_prefix(*crstep) && (ne.h.p || ne.h.i || !crste_prefix(ne))) {
-		ne.s.fc1.prefix_notif = 0;
-		gmap_unmap_prefix(gmap, gfn, gfn + align);
-	}
-	if (crste_leaf(*crstep) && crstep->s.fc1.vsie_notif &&
-	    (ne.h.p || ne.h.i || !ne.s.fc1.vsie_notif)) {
-		ne.s.fc1.vsie_notif = 0;
-		if (needs_lock)
-			gmap_handle_vsie_unshadow_event(gmap, gfn);
-		else
-			_gmap_handle_vsie_unshadow_event(gmap, gfn);
-	}
-	dat_crstep_xchg(crstep, ne, gfn, gmap->asce);
+	do {
+		oldcrste = READ_ONCE(*crstep);
+
+		gfn = ALIGN_DOWN(gfn, align);
+		if (crste_prefix(oldcrste) && (ne.h.p || ne.h.i || !crste_prefix(ne))) {
+			ne.s.fc1.prefix_notif = 0;
+			gmap_unmap_prefix(gmap, gfn, gfn + align);
+		}
+		if (crste_leaf(oldcrste) && oldcrste.s.fc1.vsie_notif &&
+		    (ne.h.p || ne.h.i || !ne.s.fc1.vsie_notif)) {
+			ne.s.fc1.vsie_notif = 0;
+			if (needs_lock)
+				gmap_handle_vsie_unshadow_event(gmap, gfn);
+			else
+				_gmap_handle_vsie_unshadow_event(gmap, gfn);
+		}
+	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, ne, gfn, gmap->asce));
 }
 
 static inline void gmap_crstep_xchg(struct gmap *gmap, union crste *crstep, union crste ne,
-- 
2.53.0

