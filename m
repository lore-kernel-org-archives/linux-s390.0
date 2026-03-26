Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62030CD82;
	Thu, 26 Mar 2026 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531060; cv=none; b=OPQltcuQ/SmwtGRiO4zyxMbrW+xpGIrwoVqzMOL0syMDXpRtWfhCKs0Hd2FC5wigT8kKCoH0GURCBNSaIMCVCZTqjj+BE+EHiARv1SnH9/RiXJrIGwpDQEMviB2pT9jOr9VERMr7oavwetJ0Vb6DmlaGdz3L38sf3GaaDfwPQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531060; c=relaxed/simple;
	bh=x9Dwo9eGIdpNtx9CuaUZoB/tREQkjX0cqrVUgV6nnlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQ65QXEWHFyXJV4Te2L/acAbfQeCl5BZ0+JpDR9J9u9hlsFSg7tKotx2Ls1yYycBWMKNyLkP3XxquzCfZrSi8MbqX9/qXhabkNQ5VXTY5CiRLJiNUHjSSELH63DPPbSHZ4vXhv+dpiYON6SNoa9ARAnsL1zfW2wBdntM0OIeFHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=He324dZe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="He324dZe"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q1kMme2074523;
	Thu, 26 Mar 2026 13:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BLMIvelPDKR0ELsTb
	xsfx05HMFwKnYIBqajoieQu2xI=; b=He324dZecG958ef61DMXKayGyjAmpc08f
	CTJ6kzpW1XEHMOsRC8Pe18VYCnzfzF9pZcCEqkQ2pDzipinE9xh/CuBuPX4bU2kq
	o+xBRHftXZJw/xz4qHSaVPnb1v1luv8/MgJ+e4aGimOci/s7IsTRjwwEJbHRakT1
	KTFl3LMCxRPcu7dYCPZnsrFPwA7NS2tEiQFJFUv8nXxhYN9kR8CV3scU8AMtNGtW
	kymo4idffPlF3wdtGir83rusWklSk4wehLDPvaeKe4ySadWpdfkATKedv/UgAsJ+
	s2X7gbP7H034Xt9Ix1eg/YXoHIlEUZ8NfzAtUqu5tvCr6JfHFa23w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqnd1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QBQndA008745;
	Thu, 26 Mar 2026 13:17:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnu3dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QDHOb545810100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 13:17:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 463032004B;
	Thu, 26 Mar 2026 13:17:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23AF920043;
	Thu, 26 Mar 2026 13:17:23 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.23.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 13:17:23 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v5 02/10] KVM: s390: Remove non-atomic dat_crstep_xchg()
Date: Thu, 26 Mar 2026 14:17:11 +0100
Message-ID: <20260326131719.98229-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326131719.98229-1-imbrenda@linux.ibm.com>
References: <20260326131719.98229-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1z9b8iY6aL7orzFgZ6txU69EU561Yflq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5MyBTYWx0ZWRfXxaJ3SQynLUDJ
 IVjtsAFGuYR3z53rzrpW2belMPMavpY4Zj8c+C9ylClRBV+xWSxfq9B3oKl7YjX4dqIA2I0PpcO
 9xSLi8a4MWlCPGXi6Az4cHJtTtFXPZYYLLFYlTVlUXzLhASNxGpDXXh2lJ1t89/7sr62HLHC5TN
 ga6XGSEiqB+YUFn/9t70tbPs9awJLuUUiVDwJZ1sPvSvZtsgAHtoczL5ylk8K/BKy5FIALgtkXJ
 NBYBUFqUc/QNieD4rLKh2waKDuBzPiS2w/xKQUv01PPnrGdCiSW6BYndV6IML/NU3yRQ7Yby8KK
 dJeMVO20TQr+dr1NfKw7sJ7qLM5S7QYly4YNlszkpgi8aZ3Cor68wEmrNT123F5MR3oOV1Cjnfe
 5qrdxCsOt+q/k9RsEp2DuX20fKSs48Zh7uYnhcAbWXG1g9Fj6TdCExEVEm5aoZOIhGR41DIYFKJ
 hwF9rroGTOJ3N+apnOA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c531e9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=UWa3PdyAdGT8wWmJkKEA:9
X-Proofpoint-GUID: 1z9b8iY6aL7orzFgZ6txU69EU561Yflq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260093

In practice dat_crstep_xchg() is racy and hard to use correctly. Simply
remove it and replace its uses with dat_crstep_xchg_atomic().

This solves some actual races that lead to system hangs / crashes.

Opportunistically fix an alignment issue in _gmap_crstep_xchg_atomic().

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: 589071eaaa8f ("KVM: s390: KVM page table management functions: clear and replace")
Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/dat.c     | 51 +++++++------------------
 arch/s390/kvm/dat.h     |  9 +++--
 arch/s390/kvm/gaccess.c | 26 +++++++------
 arch/s390/kvm/gmap.c    | 82 ++++++++++++++++++++++++-----------------
 arch/s390/kvm/gmap.h    | 29 +++++++++------
 5 files changed, 100 insertions(+), 97 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 48b5f2bcf172..4d44c0f9ad45 100644
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
+	do {
+		oldcrste = READ_ONCE(*crstep);
+		if (!oldcrste.h.fc || oldcrste.h.i || oldcrste.h.p)
+			return 0;
+		if (oldcrste.s.fc1.prefix_notif)
+			break;
+		newcrste = oldcrste;
+		newcrste.s.fc1.prefix_notif = 1;
+	} while (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, walk->asce));
 	*n = 2;
-	if (crste.s.fc1.prefix_notif)
-		return 0;
-	crste.s.fc1.prefix_notif = 1;
-	dat_crstep_xchg(crstep, crste, gfn, walk->asce);
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
index ef0c6ebfdde2..956be4c01797 100644
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
+	} while (!gmap_crstep_xchg_atomic(gmap, table, crste, new, gfn));
 
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
index ccb5cd751e31..150e91e15ee0 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -194,35 +194,40 @@ static inline union pgste gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, uni
 	return _gmap_ptep_xchg(gmap, ptep, newpte, pgste, gfn, true);
 }
 
-static inline void _gmap_crstep_xchg(struct gmap *gmap, union crste *crstep, union crste ne,
-				     gfn_t gfn, bool needs_lock)
+static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, union crste *crstep,
+							 union crste oldcrste, union crste newcrste,
+							 gfn_t gfn, bool needs_lock)
 {
-	unsigned long align = 8 + (is_pmd(*crstep) ? 0 : 11);
+	unsigned long align = is_pmd(newcrste) ? _PAGE_ENTRIES : _PAGE_ENTRIES * _CRST_ENTRIES;
+
+	if (KVM_BUG_ON(crstep->h.tt != oldcrste.h.tt || newcrste.h.tt != oldcrste.h.tt, gmap->kvm))
+		return true;
 
 	lockdep_assert_held(&gmap->kvm->mmu_lock);
 	if (!needs_lock)
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

