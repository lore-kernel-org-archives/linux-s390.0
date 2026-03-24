Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE940823F;
	Tue, 24 Mar 2026 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374207; cv=none; b=XhHoA0m/+YZWaun4+gGbKDsfTwZ5FJSZlG6geX5lEFsd6WFFd/YGlX07wX3yFqI7soFTmFN63GJoud5z0PPprfGxU6Zz7va8AgYbw7McQOBvWHD0maE4DAqgWPhA4SbgeTc7I3VO4QwOnM3uwlcR3fQjhMnoEkYfVSAn8eLZS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374207; c=relaxed/simple;
	bh=geOCRXU7oMQ99+G7u/sKGQlk8E00TUceeYK8OL2A2Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5uOXL49OyoDXBns31nNbzffK/3Ff11ClOpjDObJWFbrmLKVnQKRsS9QyyrO9/0loiogsPF1apoXlVatUm0TgXoh4Cq3TVqIaXaw9sqjc/1kN85Stc6n/OchfvEDJJ1R3clxV8JaqcF0dCWpGjsDT3F9Fodls6wSrYn8QLmVL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bbGJGQrT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bbGJGQrT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OFSKXu3792418;
	Tue, 24 Mar 2026 17:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8dfSGCnyP4m1Lop63
	yHDyFZ741TrisGV/vG6J+hB02c=; b=bbGJGQrTHECqUtHENP+qUvGH03dCKzMXe
	Zw880VdHQ5WIitLyiq+kGWrTWZ/Nb3ABeuiLSjpABJaANttKlwkBhIhMBKEfz0CG
	KqKRJx8sS+56h5K1rpMTsr06Kz//HPzjSpn7X5qWd/DWt1k5o+bLsE5vxNnThn4h
	MtJL9EKNrcWTfPzKKlH3gAuI6k8CMfx6HwGBGHTdBEaRaSFwqntZpsHEjGj7+In9
	YkkQCBL0Qc/XgZQ66taOWs7bVXRo3uDWEclegGx7vGRbLSrA94qgYTtUci/n2SrG
	mV8QCCVF11ubQJ9tQyoXMCQLfo9JWOZe8yLCTQSjq17ZeAU3SUPJg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqcxdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OG6SuP026681;
	Tue, 24 Mar 2026 17:43:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275ku11k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OHhAQK15860044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:43:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AB2120043;
	Tue, 24 Mar 2026 17:43:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23DCD20040;
	Tue, 24 Mar 2026 17:43:09 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.26.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 17:43:09 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 5/9] KVM: s390: Fix gmap_link()
Date: Tue, 24 Mar 2026 18:42:57 +0100
Message-ID: <20260324174301.232921-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324174301.232921-1-imbrenda@linux.ibm.com>
References: <20260324174301.232921-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b1R8KCOTqTnwaCekzKAtGC1wR5YfgHGH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzNCBTYWx0ZWRfXwICDE4YlJp5d
 zSGFw9dRmDzzXfH0aDwgwbSwaM+WA/KBhKVce4hbLWGkxnSHpsu0n8ix20k0v8XY1XLnXN8kNGz
 m3z3V3D4ZK/hyWBn1qAoX4Hrh294Kj4Vv5OoBxHUllnP0IG3Op8YPbAY8GmGa96Mezpjw+0Do0I
 uD/2Ujo6OlJhLr05GM+LfnO6g4UezUROcj/Y71bbYEB5XOStgYye4AICarxC1YsZm29Y/CKifZ3
 +XLXTml2VFoAhm8U2AMt6PrlxrYR1f9ktxbpmJRVoQF7MB2nmlFmYv9GcHprnhYNbRAC4vh+msC
 TAyDimSTg/RICm/rxSb1DvVWVhbMm4guMRlKCGhf6Fmxljt6Jbd7hkhAxeLoZOicSVlK4EZ52C3
 5iucBtYgjx83Q7JrVoAH7/Rv3xQLUYfr/gjLpLT/qp2AmXuy8KhTFxsRdNALgmO8Ln1rjdqARgg
 Uev8Rl/0nbaNYY2Iegw==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c2cd33 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=jDauOpCy_z-6rDg_B6MA:9
X-Proofpoint-GUID: b1R8KCOTqTnwaCekzKAtGC1wR5YfgHGH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240134

The slow path of the fault handler ultimately called gmap_link(), which
assumed the fault was a major fault, and blindly called dat_link().

In case of minor faults, things were not always handled properly; in
particular the prefix and vsie marker bits were ignored.

Move dat_link() into gmap.c, renaming it accordingly. Once moved, the
new _gmap_link() function will be able to correctly honour the prefix
and vsie markers.

This will cause spurious unshadows in some uncommon cases.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/dat.c  | 48 -------------------------------------
 arch/s390/kvm/dat.h  |  2 --
 arch/s390/kvm/gmap.c | 56 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 52 insertions(+), 54 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 8ba80b0b4698..a4f482bd3077 100644
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

