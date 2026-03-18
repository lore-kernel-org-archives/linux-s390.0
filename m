Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA93DAC13;
	Wed, 18 Mar 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842953; cv=none; b=qDkGRiBTl2xEfpGAdgNmXbzp6SNZjYfWUSMBtsI2jeba1hb/m+DrLOFn7v2puxVRHuIGClpUvFmEkWcPngpsWnRF05L+zblH9tcZgSPwQ4RAcNtrjKDXlp/Vav7wc1YvLbwlYXtWN0tg6zUdWLKprkvFij3uYA2mLl0QU/t2EOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842953; c=relaxed/simple;
	bh=XMutswqmex1/YtzaFxJuzs7afWGIspewhwKVKp2YUFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMgiMDFrXgX+Bifzhprnz7S203nEvv7K50GQmNMHfMnSGXAntbNreoPwTfGRVXGcRenpYg6t6Llag/d9QPtg/687FbUz4UHHzL+Q2tJfLeNyDMvU+he5JxL6kJ75ZVjwtJ1oHeDqNM+X7C9Fji63EdrlwN4W+OMB24JMj4XeYKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pHqGpOwR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pHqGpOwR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I9jcjp382519;
	Wed, 18 Mar 2026 14:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=G3GEBDkXBHa17qdP7
	GesGDNd09p/ivwMNWV3TQGN9Xk=; b=pHqGpOwRQntEmAKLdTRC7TMXY4+TKPHkb
	6lT2UphMuw9SFekYhX35dUtrw40nf1Ey+JX9xBHYTpIibtKCqZupjSaqPDRwCiHc
	z9kmcERNu32xTPuX2ADRpQ1YerufZLCPDHTQ8jnFHQMvPXSOhMzC76LTB58FHemK
	/R0s+y9Gr7E6FHF/1qaVKY3VKB+sn5U34ty+3wfOZ2ctz4o4YznX2RBuJhzIiCHf
	LnwkUadvrJDSX14NCn92RmvBWuc836ANGxdIxWvf3c4iq5aQ1ZO6Vd50I0gqPWhF
	48xBj6n/3+0NXmFj0wwNHdXf4I7TpJDNJIBpo/XjgG1KLlPe0lu+g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauhnd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:08:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IA9QZk032404;
	Wed, 18 Mar 2026 14:08:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jx4e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:08:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IE8tbk30867834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 14:08:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CA4C20040;
	Wed, 18 Mar 2026 14:08:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA63C2004B;
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
Subject: [PATCH v1 3/7] KVM: s390: Fix gmap_link()
Date: Wed, 18 Mar 2026 15:08:49 +0100
Message-ID: <20260318140853.119460-4-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfX/qkpWxrIIrYg
 2CuvbX9iz++nrOOIkFb94/p7F17uYBAuJx9vCcXATXN6f/cPvMQOIM1Uu1Phc+D04q4ebWxC5vO
 yWAi8+7ICWevEi447SgXTemyBtlrtMX0+BytNckPUrIHGIq+kGcbUx/WPjFA6RlfYyvRAJgL423
 sqIW2pPQ2Ebc6RUvTjImfD4bMQm06YJiYXNGDnZNUVDaqgo+KC1IhRUuKo80BePATSNAd0F2Hx4
 d6FxyVIFUHgfDVcWUd6yXgmCwbx3HxKcQJLxPmBl0lPeXSG4tM2BUqpi7kcEOAn4cKxBBE0GgD1
 /6mFO63439W5TpZgvivX+1vuKUglhV5TC3hOrszVBGxOfktc9nfGgIMOOuyfvhK5eu+owznq9Zm
 lFCsWcgJW6aKJzEJsIGZEmf/Pb951NfXJBo2hBiEKWhtGjjtHSkpxRq6fGDXmbMzyYXFvqrHPUa
 WYnfVlfRLIo1ZC6n9Jg==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bab1fb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=jDauOpCy_z-6rDg_B6MA:9
X-Proofpoint-ORIG-GUID: 4jN5lRdVLzPXSuJFMMRN9WDxS5chqkkc
X-Proofpoint-GUID: 4jN5lRdVLzPXSuJFMMRN9WDxS5chqkkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180116

The slow path of the fault handler ultimately called gmap_link(), which
assumed the fault was a major fault, and blindly called dat_link().

In case of minor faults, things were not always handled properly; in
particular the prefix and vsie marker bits were ignored.

Move dat_link() into gmap.c, renaming it accordingly. Once moved, the
new _gmap_link() function will be able to correctly honour the prefix
and vsie markers.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
---
 arch/s390/kvm/dat.c  | 48 --------------------------------------
 arch/s390/kvm/dat.h  |  2 --
 arch/s390/kvm/gmap.c | 55 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 51 insertions(+), 54 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index b673e86c8ae5..bfa84074f433 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -996,54 +996,6 @@ bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end)
 	return _dat_walk_gfn_range(start, end, asce, &test_age_ops, 0, NULL) > 0;
 }
 
-int dat_link(struct kvm_s390_mmu_cache *mc, union asce asce, int level,
-	     bool uses_skeys, struct guest_fault *f)
-{
-	union crste oldval, newval;
-	union pte newpte, oldpte;
-	union pgste pgste;
-	int rc = 0;
-
-	rc = dat_entry_walk(mc, f->gfn, asce, DAT_WALK_ALLOC_CONTINUE, level, &f->crstep, &f->ptep);
-	if (rc == -EINVAL || rc == -ENOMEM)
-		return rc;
-	if (rc)
-		return -EAGAIN;
-
-	if (WARN_ON_ONCE(unlikely(get_level(f->crstep, f->ptep) > level)))
-		return -EINVAL;
-
-	if (f->ptep) {
-		pgste = pgste_get_lock(f->ptep);
-		oldpte = *f->ptep;
-		newpte = _pte(f->pfn, f->writable, f->write_attempt | oldpte.s.d, !f->page);
-		newpte.s.sd = oldpte.s.sd;
-		oldpte.s.sd = 0;
-		if (oldpte.val == _PTE_EMPTY.val || oldpte.h.pfra == f->pfn) {
-			pgste = __dat_ptep_xchg(f->ptep, pgste, newpte, f->gfn, asce, uses_skeys);
-			if (f->callback)
-				f->callback(f);
-		} else {
-			rc = -EAGAIN;
-		}
-		pgste_set_unlock(f->ptep, pgste);
-	} else {
-		oldval = READ_ONCE(*f->crstep);
-		newval = _crste_fc1(f->pfn, oldval.h.tt, f->writable,
-				    f->write_attempt | oldval.s.fc1.d);
-		newval.s.fc1.sd = oldval.s.fc1.sd;
-		if (oldval.val != _CRSTE_EMPTY(oldval.h.tt).val &&
-		    crste_origin_large(oldval) != crste_origin_large(newval))
-			return -EAGAIN;
-		if (!dat_crstep_xchg_atomic(f->crstep, oldval, newval, f->gfn, asce))
-			return -EAGAIN;
-		if (f->callback)
-			f->callback(f);
-	}
-
-	return rc;
-}
-
 static long dat_set_pn_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
 	union crste newcrste, oldcrste;
diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index 22dafc775335..efedcf96110c 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -540,8 +540,6 @@ int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gf
 		 u16 type, u16 param);
 int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn);
 bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end);
-int dat_link(struct kvm_s390_mmu_cache *mc, union asce asce, int level,
-	     bool uses_skeys, struct guest_fault *f);
 
 int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *state, bool *dirty);
 long dat_reset_cmma(union asce asce, gfn_t start_gfn);
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 3ae746fada36..759a2ed17038 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -626,10 +626,59 @@ static inline bool gmap_1m_allowed(struct gmap *gmap, gfn_t gfn)
 	return test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &gmap->flags);
 }
 
+static int _gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, int level,
+		      struct guest_fault *f)
+{
+	union crste oldval, newval;
+	union pte newpte, oldpte;
+	union pgste pgste;
+	int rc = 0;
+
+	rc = dat_entry_walk(mc, f->gfn, gmap->asce, DAT_WALK_ALLOC_CONTINUE, level,
+			    &f->crstep, &f->ptep);
+	if (rc == -ENOMEM)
+		return rc;
+	if (KVM_BUG_ON(rc == -EINVAL, gmap->kvm))
+		return rc;
+	if (rc)
+		return -EAGAIN;
+	if (KVM_BUG_ON(get_level(f->crstep, f->ptep) > level, gmap->kvm))
+		return -EINVAL;
+
+	if (f->ptep) {
+		pgste = pgste_get_lock(f->ptep);
+		oldpte = *f->ptep;
+		newpte = _pte(f->pfn, f->writable, f->write_attempt | oldpte.s.d, !f->page);
+		newpte.s.sd = oldpte.s.sd;
+		oldpte.s.sd = 0;
+		if (oldpte.val == _PTE_EMPTY.val || oldpte.h.pfra == f->pfn) {
+			pgste = gmap_ptep_xchg(gmap, f->ptep, newpte, pgste, f->gfn);
+			if (f->callback)
+				f->callback(f);
+		} else {
+			rc = -EAGAIN;
+		}
+		pgste_set_unlock(f->ptep, pgste);
+	} else {
+		oldval = READ_ONCE(*f->crstep);
+		newval = _crste_fc1(f->pfn, oldval.h.tt, f->writable,
+				    f->write_attempt | oldval.s.fc1.d);
+		newval.s.fc1.sd = oldval.s.fc1.sd;
+		if (oldval.val != _CRSTE_EMPTY(oldval.h.tt).val &&
+		    crste_origin_large(oldval) != crste_origin_large(newval))
+			return -EAGAIN;
+		gmap_crstep_xchg(gmap, f->crstep, newval, f->gfn);
+		if (f->callback)
+			f->callback(f);
+	}
+
+	return rc;
+}
+
 int gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, struct guest_fault *f)
 {
 	unsigned int order;
-	int rc, level;
+	int level;
 
 	lockdep_assert_held(&gmap->kvm->mmu_lock);
 
@@ -641,9 +690,7 @@ int gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, struct guest_fau
 		else if (order >= get_order(_SEGMENT_SIZE) && gmap_1m_allowed(gmap, f->gfn))
 			level = TABLE_TYPE_SEGMENT;
 	}
-	rc = dat_link(mc, gmap->asce, level, uses_skeys(gmap), f);
-	KVM_BUG_ON(rc == -EINVAL, gmap->kvm);
-	return rc;
+	return _gmap_link(mc, gmap, level, f);
 }
 
 static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
-- 
2.53.0

