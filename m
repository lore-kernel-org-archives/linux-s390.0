Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487F4447806;
	Fri, 28 Aug 2026 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918099; cv=none; b=uFaLayMh/ZFPeQJyJ/jZgntzfXUuoH67k5I79XtANk4HxHEEj8ZhiuKZ1m7Rui6JGIlAzCJarSGYNEIcKeCHoZZTr2AFSif6qwZZ31Lc8l8OneHgS9Ub3u5S2j4V1QGJ/kj59MUnOyjcdJOy746KCfnilSX35/VLyXhqbNifKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918099; c=relaxed/simple;
	bh=UXzMxOA/F5Wpk/wIIrcQD1e3a0cCfMHiFaPCobTVW44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDiLyVRLhh17ArBrdPD2P77kklLC8sMoPRSEybTHOY6mPzqWQ3XOVrX/owheHeMhzo2m5b5AytVxp4lZsgnIsGrffRwFK5l9hZ37cXJq7JXMcHkwlE7gOY0FpbyQuW+297w6Hh+tS9q6flkpxuZnAY8WnDDooZTRn55FgQHc7W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n0w4qIWj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n0w4qIWj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SAVbjY1733548;
	Fri, 28 Aug 2026 11:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a35CCf2wzD5NLbaFo
	t0AtVwpPca5U4ydL+s555X/69U=; b=n0w4qIWjS4/bh0T28C3hlEeT3rCporMkC
	f2YBC/FUq6WCkgoVq0AITI1maux0P4Jsca3IDFhM9NVahqVcbFe2RQwCsgMldWsr
	ePs6g/Hi4mYdBPDdK92jj9j/UBENw9+fctEaADfynO5epMKQt5LfY/O93MCyskZH
	XxOsHkkksbkHGOO7Vfs1r2+QmDhWEEQw2It2IoFnDwx21mfOpuEeKBYaVsO9XfN+
	Ht9vcuo2yy6iJIjqc6leneQm7XhwK6wiX2IGjcfsBJA1oLTOKo9+/PWbKLWJGylL
	ka4jVXxcCb/4HVFzUdV1IQCqWv+F0dTeMffkj1j5FPkRAZk0cTBZA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g5c00a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SBfLuR009452;
	Fri, 28 Aug 2026 11:54:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhnva6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SBsemW7799068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 11:54:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54A5820043;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32C642004D;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 4/8] KVM: s390: Refactor dat_set_slot()
Date: Fri, 28 Aug 2026 13:54:35 +0200
Message-ID: <20260828115439.145885-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828115439.145885-1-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p4Ku6UgQkuhpyECh-k_UsVezohhphL01
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX8Alq+vo+fSOj
 jCtJDiZmsLoFzL90zc+m3xWLSF2KHcrqgKDoYolgKnWytV6KqhvAXiokBT/4v/7Twiv7FvSVfws
 ITdKDAUycj5d6zUq6kUccsOvyD0TNSg=
X-Proofpoint-GUID: p4Ku6UgQkuhpyECh-k_UsVezohhphL01
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a917708 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Dh8sLtxf0uV7TDLfvswA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfXyxWQaeAmn0Fl
 rFXG2gTT5NuuNB929pIilU/3es7UC5EwnyHmwEmFVMOtfkYnMmzce/I5qBLzccQT4Z7eSse8pah
 49gUxNsf0uTBbz75NRjBOGAH35Gu+Is6wu4x5khyOS37jpmY5mWubmg5Es2IbgpsoDEsx3fnyf1
 8g6KdyBJzSxPUY812/v5r+Ij2PAlbzza2EfR80II2SBHJhkJv0cRPW6AuPrLa2FeAjOefD3Vo1T
 9fJsEoMOCm2bxanD0Lqoc4GMYynaMG6qKBQO43FfAJVWkqzxwhWmqtRFYYfywo2c1VuT9CXkRKY
 aVkWizTTdQM0FisHOQ/lj5knfxAeorOHB5emgxLtww/qlJs2pObX4A2w7pUwKOU1lK4ajeXLMb9
 2QDwsuZoQu1rcdMKUFeF4qpQYR/c+cX7wmacyzM/Jv6hec2vOV7jbWxVOtYtXzDDFkzxDJ1FkWl
 GP1rmt06R5RPg2owfYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280099

Refactor dat_set_slot(), _dat_slot_pte(), _dat_slot_crste(). Now they
only take a struct kvm_s390_mmu_cache as priv. For dat_delete_slot(),
mc is NULL, as no allocations should take place.

This is needed as a prerequisite to move gmap DAT table setup from
kvm_arch_commit_memory_region() to kvm_arch_prepare_memory_region().

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c     | 29 +++++++++--------------------
 arch/s390/kvm/gmap/dat.h     | 10 ++++------
 arch/s390/kvm/gmap/kvm_mmu.c |  4 ++--
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index 24547e39fab2..dcedd5479d82 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -846,19 +846,12 @@ long dat_reset_skeys(union asce asce, gfn_t start)
 }
 #endif /* KVM_S390_MANAGES_S390_GUEST */
 
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
@@ -875,10 +868,9 @@ static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wal
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
@@ -902,7 +894,10 @@ static long _dat_slot_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct d
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
@@ -910,16 +905,10 @@ static const struct dat_walk_ops dat_slot_ops = {
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
diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index e452c141b841..90389d47ba4e 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -547,8 +547,7 @@ long dat_reset_skeys(union asce asce, gfn_t start);
 unsigned long dat_get_ptval(struct page_table *table, struct ptval_param param);
 void dat_set_ptval(struct page_table *table, struct ptval_param param, unsigned long val);
 
-int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end,
-		 u16 type, u16 param);
+int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end);
 
 #if KVM_S390_MANAGES_S390_GUEST
 int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn);
@@ -973,16 +972,15 @@ static inline int get_level(union crste *crstep, union pte *ptep)
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
diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
index b08b8229bb6f..4c8054e18490 100644
--- a/arch/s390/kvm/gmap/kvm_mmu.c
+++ b/arch/s390/kvm/gmap/kvm_mmu.c
@@ -111,10 +111,10 @@ void s390_kvm_mmu_commit_memory_region(struct kvm *kvm,
 		kvm_s390_update_cmma_dirty(kvm, old);
 		switch (change) {
 		case KVM_MR_DELETE:
-			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
+			rc = dat_delete_slot(kvm->arch.gmap->asce, old->base_gfn, old->npages);
 			break;
 		case KVM_MR_MOVE:
-			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
+			rc = dat_delete_slot(kvm->arch.gmap->asce, old->base_gfn, old->npages);
 			if (rc)
 				break;
 			fallthrough;
-- 
2.55.0

