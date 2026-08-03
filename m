Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1840963F;
	Mon,  3 Aug 2026 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760856; cv=none; b=uvrpwVFGVeLfARu2ZzVx9tDAp0ZZ6Job1p++YGj/asNBuuh8PHfcyM4PpjWmbVFjDwNvzvCo69gqCLCcHbg3A5BM+q6i2bB/xozFgTmNPkoa0Egn7RiSw9M+OJVuvzUYgZSnCDcMC1aYGzO+/KDVGGsZoRkOFmD3y9GrZ/8pWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760856; c=relaxed/simple;
	bh=tswRcvjV2UsGuXuFcHb6Xe6uRRImcfr585nXnRvh2Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPgwsG4ghRtPw8VLFDh/q9JKm+Ved5krUAPbnlFWjlxyTtSjjH3ppPG74azjPV9jDt2ob3chTr9iMBYuJDwDhFA+I9qT1pEQYKd2Z4MRKuHYynHeL1NgzZRj7H2zfm8399H5cTVJO7mw+lNqxOqmZGyx1Ki6D20P7/o4x583bbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XxIwD5fS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XxIwD5fS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHvNg1937897;
	Mon, 3 Aug 2026 12:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bPRjq6q44qll6i58L
	O/+Vola2iS5l5Z6UG1bVIPEDAA=; b=XxIwD5fSJE6XXcsYRomAvuN2rkuopwBXY
	eX9JF1XFptWpv1pCb4kZvmCT0yHzAMlbxWCWbKp3lWzAXLdQpYtJ5KkC9gWOnlF/
	8NbFNIEq1Ij+Uyl8Hcp3mco9UADBQTctOMBYpu26dOh4c7sAa8iMUO8I9CBbGF5n
	A2pajQfx5s//WCmIB2rSBdSnF1peuY/liALn7iKyqDv6ejVw1+GhhCyl7NWfkqrH
	cfFr2vfrOoTrVm7W2K0oDQd0cbSDejbFoc4DGG7e6m/mT5X0740gIfGqW+/S8xM3
	2hPoEJ9cUtMdBeUyCsokQC1H3cyqWJz3pQLM8Mv2qB4btz1/krNhQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hgqd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CQMl9027377;
	Mon, 3 Aug 2026 12:40:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jwbsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673CejbN30015834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A45520040;
	Mon,  3 Aug 2026 12:40:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B26D820043;
	Mon,  3 Aug 2026 12:40:44 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 08/13] KVM: s390: cmma: Fix dirty tracking when removing memslot
Date: Mon,  3 Aug 2026 14:40:35 +0200
Message-ID: <20260803124040.126471-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803124040.126471-1-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfXw7nuvcnhzlBT
 Ru7kvJys6Ppg+3m2tmFwkX0L4bws0cD8qiipPI5RoyYgptvXoyOrnHzio61gh4zOnkXBIr0+AOV
 VBFKbbzN81GNC8F5ZoUylymtS5mu8bw=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a708c54 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=xy2Bf3EjJieBI87QFfgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX4yxJWxwX/Fr8
 mF3aHlxXEy4M3vaOYhif0jv9gLCMnAZ4e/taRuEYh+DoDbvnzkG6N/YosJjup+w0diSgDOSlQFX
 W6HsK+CVFwZ8TvPWhNOw284RBiflDLCTJX4Jm0Q/6z3Wz96BlNPKMKNsV89jMG8Xn7uVe+KGlTB
 HVVMxt8aw5WfhuvovGxplv4WAQ5k7pcnb+2pKqArfNg1BfKFw78Gp2cZBVboxaaeNmuv5J6Wi76
 8Z5clP2e4SP/kdtD65chQSCCo7/ud1fvgYJi7AewHDuMKx+Hlv6NJEaaWKmrZfOcA7ao5jQJBhj
 be7x8K7GTMXcL+lMWF3gZL+ZRMUjC65idyFagEa/nQnQP8fC60avu+2DRTEZA5FjjitzozU4X/m
 Ix2pMOw4tjvNONRvvZRh7qNP3QGpM41Iu0iaIey8hSYyBcqaxm6wGdfSE3JU9KaIoQdbgvumlFv
 U99szTeF+PD1NSV9s6A==
X-Proofpoint-ORIG-GUID: SF5tn60_wXxhyXOY8usyIfi-1YxNw77t
X-Proofpoint-GUID: SF5tn60_wXxhyXOY8usyIfi-1YxNw77t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030110

When a memslot is removed, all ptes that mapped the slot are cleared or
even deallocated. If this happens while the system is in migration
mode, and if cmma-dirty pages are removed, the cmma-dirty counter will
not reflect reality.

Fix by appropriately decrementing the cmma-dirty counter when removing
a memslot.

Opportunistically improve kvm_arch_commit_memory_region() to use
__free() for the struct kvm_s390_mmu_cache.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c      |  7 ++++++-
 arch/s390/kvm/kvm-s390.c | 25 +++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 171b61959908..3f2d6e8902d7 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -850,6 +850,7 @@ static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wal
 	struct slot_priv *p = walk->priv;
 	union crste dummy = { .val = p->token };
 	union pte new_pte, pte = READ_ONCE(*ptep);
+	union pgste pgste;
 
 	new_pte = _PTE_TOK(dummy.tok.type, dummy.tok.par);
 
@@ -857,7 +858,11 @@ static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wal
 	if (pte.val == new_pte.val)
 		return 0;
 
-	dat_ptep_xchg(ptep, new_pte, gfn, walk->asce, false);
+	pgste = pgste_get_lock(ptep);
+	pgste = __dat_ptep_xchg(ptep, pgste, new_pte, gfn, walk->asce, false);
+	pgste.cmma_d = 0;
+	pgste_set_unlock(ptep, pgste);
+
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e5c5e9f61cb2..ba811f0673d1 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5812,14 +5812,30 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	return 0;
 }
 
+static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	union pgste pgste;
+
+	pgste = pgste_get_lock(ptep);
+	if (pgste.cmma_d) {
+		pgste.cmma_d = 0;
+		atomic64_dec(walk->priv);
+	}
+	pgste_set_unlock(ptep, pgste);
+	return 0;
+}
+
 void kvm_arch_commit_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *old,
 				const struct kvm_memory_slot *new,
 				enum kvm_mr_change change)
 {
-	struct kvm_s390_mmu_cache *mc = NULL;
+	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
 	int rc = 0;
 
+	guard(mutex)(&kvm->slots_arch_lock);
+
 	if (change == KVM_MR_FLAGS_ONLY)
 		return;
 
@@ -5830,6 +5846,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	}
 
 	scoped_guard(write_lock, &kvm->mmu_lock) {
+		if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
+			_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
+					    kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
+					    &kvm->arch.cmma_dirty_pages);
+		}
+
 		switch (change) {
 		case KVM_MR_DELETE:
 			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
@@ -5851,7 +5873,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 out:
 	if (rc)
 		pr_warn("failed to commit memory region\n");
-	kvm_s390_free_mmu_cache(mc);
 	return;
 }
 
-- 
2.55.0

