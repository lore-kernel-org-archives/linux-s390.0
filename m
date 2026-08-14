Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CBC4756D4;
	Fri, 14 Aug 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718458; cv=none; b=FbpCkTle0nMIe7XU2GFps1plYgRbJhXAjkMS029r6wgtlTm7he1zPXaxuBH4vW4OmmQbSxF3ipK8eecHTQu0WS+6aQ5Av+CyDLD8ZI+c9N/X8NpSaJcIK4C+ZeWGYXXz3kvYWUNAMmTKoxAUMmFIhalcU37iIkFzQ3W6bzR5hA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718458; c=relaxed/simple;
	bh=4bvuluFbTdEh4Hx56NI4fikneWt6dgvAi1KIwoQK2I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umBD8u8GYfspoxPgzc7epFDTOpMcCtw/rz9+DaZIE5DeiWXCXyoXWSsWjqOjUUIKWXHTw6YZEhroSCHTYtxy3zyQMWrWiS+4estsl0nilGmssVx1p3CFdSSc0hgf/nqUGsWkCb9H4AoMH3rJXpWC1zb1d22jD2Z9UCDVCSW4SVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O1IhZ4/X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O1IhZ4/X"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5XF31289657;
	Fri, 14 Aug 2026 14:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WkBOYSIYxpAraxZmP
	ap/T8CHdIrws8UERe+w9ssbQkA=; b=O1IhZ4/XfIqObf4IYBa+EpsNjLCYhNcXb
	GyGUx8F7xTkCwSAFDCQ6zdIOU5UqcWO/iMKgT4/KH1Z8RDS5pXY/qStTiQt1jCTy
	7ve9DqQ7yznmmes/tDVdJFbsQpamK2/4Cd6gBlhjKlzQid1XJNjBZuySPPtD6lon
	UybDAN7F99mDGVygIVfEIvpsYv7JEQb20AO58BVnhkNi94O/EzqLMCKHj9Hp4H5Y
	3isfLm6lCNzeRmOPZxqPXhMHrok+PouHfPPO3qcrjTgJbo8gOfKAibZSnEZl2ICx
	dK+S68kc9NGqkd5ncQ5d4jmTbA5sPgSowpK2hcipbtVRFTwPnTiJQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9w7k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EEQLOF004030;
	Fri, 14 Aug 2026 14:40:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk7n6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EEegJT37880210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 14:40:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B755620040;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 924422004E;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 3/6] KVM: s390: Refactor dat_set_slot()
Date: Fri, 14 Aug 2026 16:40:38 +0200
Message-ID: <20260814144041.169025-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814144041.169025-1-imbrenda@linux.ibm.com>
References: <20260814144041.169025-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FCYvkbfOLydm8vNSz_c45iMW9-EL0cWp
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7f28f2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Dh8sLtxf0uV7TDLfvswA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX6FtstgJzCAox
 nV5pFC7p8HGKCZW0NZ6sg/xJp7raytpgk/fxxbep932fT/kJDatE+wMAusX+NXhsYDGhA1Vmli/
 NO1bTk1ofUg/p7KIPc9z0WI/tYeNunG3g0hjxjeSF9pJKBuK4Pwjz75f2ks+NbngihXrHU9WlRM
 sT5VsTpdy5Avbxp54wjL14dLbZ4p1vvI055EcoTua6WB1oSLEJDDpMiOwjWpLaw0kQQ0oW+Z47y
 HP0oWBS+wrEIv6IRJ3pkgKFxNowiofCuvy7eOSw+U30D8xV7Nm01MIUieUCOZL70JQsiyPrYSOA
 ObxZEdXbw0NgwMnPfVurFjhxA/QRaT/vbYCNbJ+Xx0w6AD+kNO/muDXpjf9Lt0Pt7dY34ltj7/W
 2ki/SCyDMhjyWIHPjYlTfsQZqYvYsxl94iNTCnjMR0uQKllO6aLrBPKq1ZCH06ov9pqXhAxK4x9
 zFzfzn6mDfWghLHHjyg==
X-Proofpoint-ORIG-GUID: FCYvkbfOLydm8vNSz_c45iMW9-EL0cWp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX/+5GZj81oJJy
 VbhN/UxJ00amTVmh5pX8NhkSbOrwUYqKN2x6DrVwwfV+1iN8IOq0TKjbz7qgdZx4rnthkOqeJzv
 ldpXD8v9Ls6Hx4XHzYjWKRENZJHFXAA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140111

Refactor dat_set_slot(), _dat_slot_pte(), _dat_slot_crste(). Now they
only take a struct kvm_s390_mmu_cache as priv. For dat_delete_slot(),
mc is NULL, as no allocations should take place.

This is needed as a prerequisite to move gmap DAT table setup from
kvm_arch_commit_memory_region() to kvm_arch_prepare_memory_region().

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c      | 29 +++++++++--------------------
 arch/s390/kvm/dat.h      | 10 ++++------
 arch/s390/kvm/kvm-s390.c |  2 +-
 3 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index f2ea013cb33e..7e5dd5a1eb1e 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -844,19 +844,12 @@ long dat_reset_skeys(union asce asce, gfn_t start)
 	return _dat_walk_gfn_range(start, asce_end(asce), asce, &ops, DAT_WALK_IGN_HOLES, NULL);
 }
 
-struct slot_priv {
-	unsigned long token;
-	struct kvm_s390_mmu_cache *mc;
-};
-
 static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
-	struct slot_priv *p = walk->priv;
-	union crste dummy = { .val = p->token };
 	union pte new_pte, pte = READ_ONCE(*ptep);
 	union pgste pgste;
 
-	new_pte = _PTE_TOK(dummy.tok.type, dummy.tok.par);
+	new_pte = walk->priv ? _PTE_EMPTY : _PTE_TOK(_DAT_TOKEN_PIC, PGM_ADDRESSING);
 
 	/* Table entry already in the desired state. */
 	if (pte.val == new_pte.val)
@@ -873,10 +866,9 @@ static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wal
 static long _dat_slot_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
 	union crste new_crste, crste = READ_ONCE(*crstep);
-	struct slot_priv *p = walk->priv;
+	struct kvm_s390_mmu_cache *mc = walk->priv;
 
-	new_crste.val = p->token;
-	new_crste.h.tt = crste.h.tt;
+	new_crste = mc ? _CRSTE_EMPTY(crste.h.tt) : _CRSTE_HOLE(crste.h.tt);
 
 	/* Table entry already in the desired state. */
 	if (crste.val == new_crste.val)
@@ -900,7 +892,10 @@ static long _dat_slot_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct d
 	if (!crste.h.fc && !crste.h.i)
 		return 0;
 	/* Split (install a lower level table), and handle things there. */
-	return dat_split_crste(p->mc, crstep, gfn, walk->asce, false);
+	if (mc)
+		return dat_split_crste(mc, crstep, gfn, walk->asce, false);
+	/* A large page should never cross memslots boundaries */
+	return -EINVAL;
 }
 
 static const struct dat_walk_ops dat_slot_ops = {
@@ -908,16 +903,10 @@ static const struct dat_walk_ops dat_slot_ops = {
 	.crste_ops = { _dat_slot_crste, _dat_slot_crste, _dat_slot_crste, _dat_slot_crste, },
 };
 
-int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end,
-		 u16 type, u16 param)
+int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end)
 {
-	struct slot_priv priv = {
-		.token = _CRSTE_TOK(0, type, param).val,
-		.mc = mc,
-	};
-
 	return _dat_walk_gfn_range(start, end, asce, &dat_slot_ops,
-				   DAT_WALK_IGN_HOLES | DAT_WALK_ANY, &priv);
+				   DAT_WALK_IGN_HOLES | DAT_WALK_ANY, mc);
 }
 
 static void pgste_set_unlock_multiple(union pte *first, int n, union pgste *pgstes)
diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index 141ee7b9f019..57f32ac9ffed 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -543,8 +543,7 @@ long dat_reset_skeys(union asce asce, gfn_t start);
 unsigned long dat_get_ptval(struct page_table *table, struct ptval_param param);
 void dat_set_ptval(struct page_table *table, struct ptval_param param, unsigned long val);
 
-int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end,
-		 u16 type, u16 param);
+int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end);
 int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn);
 bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end);
 
@@ -958,16 +957,15 @@ static inline int get_level(union crste *crstep, union pte *ptep)
 	return ptep ? TABLE_TYPE_PAGE_TABLE : crstep->h.tt;
 }
 
-static inline int dat_delete_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start,
-				  unsigned long npages)
+static inline int dat_delete_slot(union asce asce, gfn_t start, unsigned long npages)
 {
-	return dat_set_slot(mc, asce, start, start + npages, _DAT_TOKEN_PIC, PGM_ADDRESSING);
+	return dat_set_slot(NULL, asce, start, start + npages);
 }
 
 static inline int dat_create_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start,
 				  unsigned long npages)
 {
-	return dat_set_slot(mc, asce, start, start + npages, _DAT_TOKEN_NONE, 0);
+	return dat_set_slot(mc, asce, start, start + npages);
 }
 
 static inline bool crste_is_ucas(union crste crste)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 91b975835457..0a08a3c7b023 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5860,7 +5860,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 
 		switch (change) {
 		case KVM_MR_DELETE:
-			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
+			rc = dat_delete_slot(kvm->arch.gmap->asce, old->base_gfn, old->npages);
 			break;
 		case KVM_MR_MOVE:
 			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
-- 
2.55.0

