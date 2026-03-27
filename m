Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6B0331220;
	Fri, 27 Mar 2026 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625068; cv=none; b=hbDWXe20QyxNFqQmRPZFqNnVqQIP1DUbqORmUkE3fhQAA112KghE8KP+vCHi2ToAyP/caeqQ7uIeArbfKvkeLKgcc7YtKkqLpsiHa9y6MNWQ2s96Baqcg6sZvxRBbj7JKTa2OBWiRB4Lw89TPoRcb4fMHjqztthGXrrNVvXXuE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625068; c=relaxed/simple;
	bh=vmvLvE8bRBiPE3XS4XDI/xxgaZ9u3ILLAqcMD71QInU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTFJoJQn0uCJTA8QI3rB++JyBkhvwjC8cvMtis0uCrA6TtAIV/TRojN7iAjF/38CntGE1SaS7icvpTNtSDlnJm0BwZqcQQrWi3XViWdsv9rZleV32Q7PxJnaF5O11WHDcJA/oNRJHmQdd3EHUyTemiGiK7YdVCEjahp4niO7Zi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CuYhBdan; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CuYhBdan"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RF2hnp3430662;
	Fri, 27 Mar 2026 15:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KCK3cUUD6WxTIrlmh
	dZ5yqHIehePu4X5aPs/oUs25E8=; b=CuYhBdanFuGJKgTHS/TnF0apyzf86yqj4
	xcB3xLoKhvgMv2dKLMGrB6tiZZO8B2jz5gSqbgdp6BAwitI3YEJBQVP4FOcuvUsY
	bG4wNTvCxqHwpeiolNFlBDW/4GbYA/Ed6oheoB7RyO6vN73qUt00OyF16Qpr3XTh
	N7AlphtyQ8xmTL2KamF2/EdxPSbTvMejmMYn28i5S8jqD5Itu9srMONSJbPWCSGY
	v/gPBq/q4MXmTmQku6C2B6rSFM8/iCxlQO0q3I/DXs24tVqzbw5X0neaMqVaSVZ/
	iOh2c/14eUiICxzylbtHmqIBulFPrX/2hr+q8LJitDUTczc+ms3Qg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktyaswx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RF4pcl008749;
	Fri, 27 Mar 2026 15:24:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26np0190-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFO0QJ50201024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:24:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8D8A20040;
	Fri, 27 Mar 2026 15:24:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23BF22004B;
	Fri, 27 Mar 2026 15:24:00 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.84.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:24:00 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 04/10] KVM: s390: Fix gmap_link()
Date: Fri, 27 Mar 2026 16:23:50 +0100
Message-ID: <20260327152356.250625-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327152356.250625-1-imbrenda@linux.ibm.com>
References: <20260327152356.250625-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c6a118 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=jDauOpCy_z-6rDg_B6MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX2OgUksZInIzk
 Qsv7dxD9VMZkfGprzcbWE+U8d7TR1L8db1AObpdb+8zxdLNSc8oohhNDb648n9he+Is5qgpleY+
 G9RfrO8leQ1vuQ3urLbMlYn/jo+EsY151hJc7jp3xznDiu6/SBdaiV/VUBCxAPNTTJOG55EQUsP
 dzLKOWuc2Krq4sSUQhliLN5iZ2zmcqVw9A27iElujPQpxqB56bcGrZkauR2kctFNlZKYxESZgIo
 fkT4Qw+3xdHkcZuNBKoAm1eTarlR6VNCiZDqPrmQnazD6AuUhJyCxpecL1itUZxmCLgMTFJxAlr
 s4LqLamuwnhbEK/La+mMTsTPzQ3YmjYbWjy+/ZeEWSG/uaU4IPHEDePS2rhiV2WiYMg9ToRhjSA
 DuD52wx62k3dJc4ZgAxiXkwmFSRvGO75eI4ZOMJ1+heeCm1E9Dv77e9PxMWRwN+hbjggU6rMHw9
 FT1440OLSWmk9N0dhLw==
X-Proofpoint-GUID: UvkAp4KCuhPp09mw0Cs8Ly-Ix-QSPlpg
X-Proofpoint-ORIG-GUID: UvkAp4KCuhPp09mw0Cs8Ly-Ix-QSPlpg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270105

The slow path of the fault handler ultimately called gmap_link(), which
assumed the fault was a major fault, and blindly called dat_link().

In case of minor faults, things were not always handled properly; in
particular the prefix and vsie marker bits were ignored.

Move dat_link() into gmap.c, renaming it accordingly. Once moved, the
new _gmap_link() function will be able to correctly honour the prefix
and vsie markers.

This will cause spurious unshadows in some uncommon cases.

Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c  | 48 -------------------------------------
 arch/s390/kvm/dat.h  |  2 --
 arch/s390/kvm/gmap.c | 56 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 52 insertions(+), 54 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 4d44c0f9ad45..7b8d70fe406d 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -997,54 +997,6 @@ bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end)
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
index 956be4c01797..03e15b5e0b9a 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -631,10 +631,60 @@ static inline bool gmap_1m_allowed(struct gmap *gmap, gfn_t gfn)
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
+		do {
+			oldval = READ_ONCE(*f->crstep);
+			newval = _crste_fc1(f->pfn, oldval.h.tt, f->writable,
+					    f->write_attempt | oldval.s.fc1.d);
+			newval.s.fc1.sd = oldval.s.fc1.sd;
+			if (oldval.val != _CRSTE_EMPTY(oldval.h.tt).val &&
+			    crste_origin_large(oldval) != crste_origin_large(newval))
+				return -EAGAIN;
+		} while (!gmap_crstep_xchg_atomic(gmap, f->crstep, oldval, newval, f->gfn));
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
 
@@ -646,9 +696,7 @@ int gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, struct guest_fau
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

