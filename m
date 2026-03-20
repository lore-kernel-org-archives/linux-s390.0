Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F383D0914;
	Fri, 20 Mar 2026 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023360; cv=none; b=BbaV3CCsm6fzPnI9pe3chFgKrhckHd0izJEgyZ83a5qfj8/AjRZVvJpE/pdZUi2XAzUkUax1RHm8mNOPx+3OIGXd2n5lcMZ1sFdEXlsHifHH4UhCxPfkwumFbd8FsTQOxZcdEiF4H6aidTbWZi1RlBsXLwYa6jb9+H3aYl/2Xng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023360; c=relaxed/simple;
	bh=EVWmb6LiCuPUDzG+eTM8dHj0mZFDO0wnLSwBoZHuklA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M60Zi7OPPEfoXiNaYumo/Sg17eK8vcHg8C3xNirQwa4iXDpdn6rqw/13cxBHBOKrU3uPx8EHno8cO9CA07CtDTYE58owi40uiHsrVRW78aDHNCVGng3u7S/9b0/4zhpdiUs5ZFhFBHbKci2Lqh2VtS8ro0xnPYNNmqnXrngyFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qhgax1yU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qhgax1yU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K6kCC8753346;
	Fri, 20 Mar 2026 16:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Q2GIe7nMtFanca65T
	PShGNCRdcguyfXxTm2P4Eabwx0=; b=qhgax1yUmrGdfyjS/tlh2LOoMPkU/rfmt
	hX8RX0YeUmGCLDEbCnRYRUx0NnWsqgaTNk2gE2X8HWVza/ws67nd/1seItybhNZz
	xF+nLVQqm4qQmWjS8u3wdHtLRVu07OBlL0wmkovQMrhu6FTzG33mU3xg4r6sBCdN
	Fa4GS5gToD657Wj30udeo/hZZB99X9TgykwFy7D208p5x+Z9sw6b096OXKQErU0D
	0CNjzo0ZPWlO19oFGKqHFSqjDPtcmF7P3NQyFzWY1mWjIpRJNHoH+R1SXIjfe2j5
	+RcIv8gBFBISLNhunYFcjf9lE+PHk/zVoaAxhk7Hz0Peohncy9hWw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3jbk8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KBdVgV015648;
	Fri, 20 Mar 2026 16:15:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nqupr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KGFhcg25821638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:15:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C26020040;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06E6320043;
	Fri, 20 Mar 2026 16:15:43 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 16:15:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 4/8] KVM: s390: Fix gmap_link()
Date: Fri, 20 Mar 2026 17:15:38 +0100
Message-ID: <20260320161542.202913-5-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: q1H_sMzNhSLNU2TvGVfzsIHOXE0OeguQ
X-Proofpoint-ORIG-GUID: q1H_sMzNhSLNU2TvGVfzsIHOXE0OeguQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEzMCBTYWx0ZWRfX5UE45gNIIdvb
 O504H0OM3tSuGnDWGtdz4PugsGtXPSc/oShE8fjThB8BHHAsiNe9sJfVjE1vE6etSOXmlRlTL+M
 cSazoQAzMvPgASOB8FAZGWjPQOk3wV0eFGRjv6y0x/nJykz01mHfXvV1a6mGdGkx8i4n5h33/t+
 tQ3N4CE0Li0nP9JRQrSaY3mQWBp4g9b8oJ40WLNousexbYxWcHjNmOiN9NWKdUCMeo5I1ivkuF2
 SLz2FTAmTqO52Ryw4+F2iTIrW0zK5I7hdeLO5URi287EUbtDPUcrwozR3UJfap4jmfJ5M25dmLI
 rKE1DqEhyKaMAqY4e6G6y8j6RAEnMML/Oyzl6Qfv3adNB74FzhRBLrH2dho4SVLjaz2ioi3jUUQ
 LMI+bu3mJaV2Cmt3DwLpINH9D6HeMv62a+9mIRboJ/7JL3dzsaRzJZ+krwTqP3TShjHHifS+5Jz
 jlDoPgG9wkBy4lC+uPg==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69bd72b3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=jDauOpCy_z-6rDg_B6MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200130

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
index d974cdac1cce..e9cac6dce48b 100644
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

