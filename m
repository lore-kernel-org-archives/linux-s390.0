Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791897;
	b=agtu1C52d9Qoo+t5hp2kgLw2V2X3vhlk+tyt4hkzDUhSlIdhE01O2N5MZmHcTNVDIYjV
	 xrPBOcSDQJLwKOd6g6lS2jOzF6F6zHcE1vLsR999ZxAJiGGDz8vFFnzswk4z9FmWcKR5e
	 oJKrRKoJ/ffryqcYwcPAUiFGP+LqKZQoSmq+5qlKYcpqFaAYXi720EE1sTDTM0nNsjp9X
	 RR2DzOTc23tRUhnp9qA/BbdUSWVw0ye1RRhYmhvu4eXzPE26ph7gaarBI/SFINI1mA6kf
	 M2WPm3TpRYV0CD8Z6xB2Fd0nudF1p6/J71x+jnGdxlXRWLa0xmCPZhIgvLFw5Tydrdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791897;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8H0VaCkfbaxDai/lKnm6uJyfIJAJB+dPAiOkc0MVrlU=;
	b=EwxdDYQmFEVa5EExagriEM/nkm0w/cEkqN66MVcVLxZTu5zk+TWoV8bKCp2zTrrTn5Oy
	 kt79k03yiSrlmlb5VSFfDB8tJbTZ1kknii1++wJhxsCcXckeykwgHNnw/ReRO1+zeHsUo
	 XtDd3mQpIhUMR0/8xgiqUEwwOecZ+/MlXPD81OPPEFkaVDk7KuFuEmVJQdQuNAEa/nKsR
	 18lHbehOHj1het/OqhRibXIuofk7LtPb9bEXivtP8lj19Epwe7rTgolBzAoQopnK37bxG
	 ZPnCFhCAYeaau5HmufHWk7bj6YjG0qZAapeUtUy5gUZdzm1Ve60rUahDw+P45taup0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Pq4CSLtn;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82821606A31F;
	Fri, 27 Nov 2026 15:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82821606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Pq4CSLtn
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE53Qa2012392;
	Fri, 27 Nov 2026 15:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8H0VaCkfbaxDai/lK
	nm6uJyfIJAJB+dPAiOkc0MVrlU=; b=Pq4CSLtnhcJS2DJ54KPrqtjrgH6346d91
	TjfzHrO0NuxEHsWhDL8IAdofMNsDdSQZ1XVVR+JDj8I190bsbgHxlTL+ZcZcfmen
	gIsxry/4hYULrGsrW2HQ5TdOJJfJ7CmjMbr8FVBTpZj2eSjD5CiwVaT0WDwqbn6C
	Pj2i/fSRMRz3an0dZGMLC+pYkIOb9ZqGhvbO8BpSSoI0OPqC3ZxUPNv8gfiLCGjm
	wvywgnDwvxgYgIoM0JDRrXnuym+9Jjf0Xg9poKPp64mO6KepsnJTMQ2FCam33lIT
	BMIY2BwA+wnTAH92BYzTwoR/w84lPtLfyDfJa9Rr1ELyTWaMUS48A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4wctr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4MHt2819332;
	Fri, 27 Nov 2026 15:04:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfaann2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4RVi48235002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CCEC20040;
	Fri, 27 Nov 2026 15:04:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AEAF2004B;
	Fri, 27 Nov 2026 15:04:23 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:23 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 10/12] KVM: s390: Do not unnecessarily drop the soft-dirty bit
Date: Fri, 27 Nov 2026 16:04:09 +0100
Message-ID: <20261127150411.221072-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127150411.221072-1-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfX55s/6R+T5trG
 hmzI1T9TQ9aS1Rh8otoOgZcfPMRgqkaO4PbVytOFYJn/mctPaLb+QRb7kB57e3w2nrsIzh0bIuA
 ZMjfFY6/OTNhTjf9fWehIGwPpYWJ9YM=
X-Proofpoint-GUID: XIpi2I7cfUGLHvbqXnHD_RG7gcqijJdt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2MCBTYWx0ZWRfXyWDvsTwvAz1U
 1oMx6idIhKNxcwbzjljKjdtG48Q7B30AB8al2n6HmYTM14sirggCnI87auSGnCZ/Gm82oYH1MqY
 lN75AIJxnj+pn+8nOlnxUlPK3aO5X9Svs53t5ypKsdMAkK3ge59Ry82bbOWWgjOKRls7KF4eWwV
 IV6maJN0q9t2TT3mgoyO2o0I5aMBsrjoNgDU978YVetW+gOekQwDvJikL9zX0urtkZG5IUgdvpr
 KlGb8+8N0ciujIKByMSngjfMFkA1TqhYG+ebNxJDI2rExrQPnuZ24ReBE28D39AhwW2ZmbKBQvn
 f7U95UhikXLRmefA53Prbo7JmYLZZuY64C2RDRkkl8txNXzPPmy8zsYcf39Hvuc49Eq7voqDuT3
 sD6LATYXwz1nxgCxjTh+tXNd8Sis2eo0KKZAaTji/heJTgeU+BD8L3a5gpZECS+koTC4LYj5+pK
 f1vrY6wRp0RTU+KyKYg==
X-Proofpoint-ORIG-GUID: XIpi2I7cfUGLHvbqXnHD_RG7gcqijJdt
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b099c00 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NVkTMfBdrx6uU7DzjqMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270060

Properly preserve the soft-dirty bit when performing unmaps or other
similar operations.

The soft-dirty bit is only cleared by gmap_sync_dirty_log(), which also
properly marks the dirty pages as such in the dirty bitmap.

The previous behaviour could lose the soft-dirty bit in some
circumstances.

Fixes: d56cd0c0d4df ("KVM: s390: Improve unmapping of large ranges")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/gmap.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index ad2d815cf9c4..410226cf4dd0 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -389,6 +389,7 @@ static long _gmap_unmap_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_w
 	struct folio *folio = NULL;
 	unsigned long vmaddr;
 	union pgste pgste;
+	union pte newpte;
 
 	pgste = pgste_get_lock(ptep);
 	if (ptep->s.pr && pgste.usage == PGSTE_GPS_USAGE_UNUSED) {
@@ -397,7 +398,9 @@ static long _gmap_unmap_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_w
 	}
 	if (ptep->s.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags))
 		folio = pfn_folio(ptep->h.pfra);
-	pgste = gmap_ptep_xchg(priv->gmap, ptep, _PTE_EMPTY, pgste, gfn);
+	newpte = _PTE_EMPTY;
+	newpte.s.sd = ptep->s.sd;
+	pgste = gmap_ptep_xchg(priv->gmap, ptep, newpte, pgste, gfn);
 	pgste_set_unlock(ptep, pgste);
 	if (folio)
 		uv_convert_from_secure_folio(folio);
@@ -408,8 +411,8 @@ static long _gmap_unmap_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_w
 static long _gmap_unmap_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
 	struct gmap_unmap_priv *priv = walk->priv;
+	union crste newcrste, old = *crstep;
 	struct folio *folio = NULL;
-	union crste old = *crstep;
 	bool ok;
 
 	if (!old.h.fc)
@@ -417,6 +420,9 @@ static long _gmap_unmap_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct
 
 	if (old.s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags))
 		folio = phys_to_folio(crste_origin_large(old));
+
+	newcrste = _CRSTE_EMPTY(old.h.tt);
+	newcrste.s.fc1.sd = old.s.fc1.sd;
 	/*
 	 * No races should happen because kvm->mmu_lock is held in write mode,
 	 * but the unmap operation could have triggered an unshadow, which
@@ -425,11 +431,11 @@ static long _gmap_unmap_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct
 	 * had the vsie_notif bit set. A second failure is not allowed, for
 	 * the reasons above.
 	 */
-	ok = gmap_crstep_xchg_atomic(priv->gmap, crstep, old, _CRSTE_EMPTY(old.h.tt), gfn);
+	ok = gmap_crstep_xchg_atomic(priv->gmap, crstep, old, newcrste, gfn);
 	if (!ok) {
 		KVM_BUG_ON(!old.s.fc1.vsie_notif, priv->gmap->kvm);
 		old.s.fc1.vsie_notif = 0;
-		ok = gmap_crstep_xchg_atomic(priv->gmap, crstep, old, _CRSTE_EMPTY(old.h.tt), gfn);
+		ok = gmap_crstep_xchg_atomic(priv->gmap, crstep, old, newcrste, gfn);
 		KVM_BUG_ON(!ok, priv->gmap->kvm);
 	}
 	if (folio)
@@ -459,7 +465,7 @@ static bool gmap_unmap_gfn_range_slow(struct gmap *gmap, struct kvm_memory_slot
 
 static long _gmap_unmap_pud_fast(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *w)
 {
-	union crste old = *crstep;
+	union crste newcrste, old = *crstep;
 
 	/* We only care about large puds */
 	if (!old.h.fc)
@@ -480,14 +486,17 @@ static long _gmap_unmap_pud_fast(union crste *crstep, gfn_t gfn, gfn_t next, str
 		idte_crste(crstep, gfn, IDTE_GUEST_ASCE, w->asce, 0);
 	else
 		idte_crste(crstep, gfn, 0, w->asce, 0);
-	*crstep = _CRSTE_EMPTY(old.h.tt);
+
+	newcrste = _CRSTE_EMPTY(old.h.tt);
+	newcrste.s.fc1.sd = old.s.fc1.sd;
+	*crstep = newcrste;
 
 	return 0;
 }
 
 static long _gmap_unmap_pmd_fast(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *w)
 {
-	union crste old = *crstep;
+	union crste newcrste, old = *crstep;
 	struct page_table *pt;
 	gfn_t first, last;
 	unsigned int i;
@@ -500,7 +509,10 @@ static long _gmap_unmap_pmd_fast(union crste *crstep, gfn_t gfn, gfn_t next, str
 			idte_crste(crstep, gfn, IDTE_GUEST_ASCE, w->asce, 0);
 		else
 			idte_crste(crstep, gfn, 0, w->asce, 0);
-		WRITE_ONCE(*crstep, _CRSTE_EMPTY(old.h.tt));
+
+		newcrste = _CRSTE_EMPTY(old.h.tt);
+		newcrste.s.fc1.sd = old.s.fc1.sd;
+		*crstep = newcrste;
 
 		return 0;
 	}
@@ -523,11 +535,15 @@ static long _gmap_unmap_pmd_fast(union crste *crstep, gfn_t gfn, gfn_t next, str
 		idte_crste(crstep, gfn, 0, w->asce, 0);
 
 	for (i = first; i <= last; i++) {
+		union pte newpte;
+
 		if (pte_hole(pt->ptes[i]))
 			continue;
 		if (!pt->ptes[i].h.i && uses_skeys(w->priv))
 			pt->pgstes[i] = dat_save_storage_key_into_pgste(pt->ptes[i], pt->pgstes[i]);
-		pt->ptes[i] = _PTE_EMPTY;
+		newpte = _PTE_EMPTY;
+		newpte.s.sd = pt->ptes[i].s.sd;
+		pt->ptes[i] = newpte;
 		pt->pgstes[i].vsie_notif = 0;
 		pt->pgstes[i].vsie_gmem = 0;
 		pt->pgstes[i].zero = 0;
@@ -1115,6 +1131,7 @@ static long _gmap_split_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct
 			gmap_unmap_prefix(gmap, gfn, next);
 		if (crste.s.fc1.vsie_notif)
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
+		newcrste.s.fc1.sd = crste.s.fc1.sd;
 		if (dat_crstep_xchg_atomic(crstep, crste, newcrste, gfn, walk->asce))
 			break;
 		crste = READ_ONCE(*crstep);
@@ -1290,6 +1307,7 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 		return -EAGAIN;
 	pte = ptep->s.pr ? *ptep : _pte(pfn, wr, false, false);
 	pte.h.p = 1;
+	pte.s.sd |= ptep->s.sd;
 	pgste = _gmap_ptep_xchg(sg->parent, ptep, pte, pgste, p_gfn, false);
 	pgste.vsie_notif = 1;
 	pgste_set_unlock(ptep, pgste);
-- 
2.56.1

