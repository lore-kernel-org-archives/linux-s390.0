Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2FA3AAF4A;
	Wed, 29 Jul 2026 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338991; cv=none; b=VXdau/GYSE700vGTsIF60/fWcU3QlbZymWNmmkUddoJxKN/q9/T54g7FtM3ns6WYB4xUj19prjpMwd63LdD5uKexDDZ0iUqWyzjtblTaZtstxH9bjSakTvmmcwucVlUUXicQAwKnJD/vSxvfseAOwzbQF3TyLyzDYgXIl1hHudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338991; c=relaxed/simple;
	bh=bsItN2eKH0NKmt4cwNr2G5pissNkYFs/R6ts0O4UZjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/TZIb4Yp8SHot1lLUfbKK+qzllT76FT2bU06X2xa950wXinw2s+YNdPEEJt77cvgCE9rQfm740n0G7CTjyFVeM25h+EFYijd/wQuRCUDonwWbWTStCLfgsNO0kPOq3f/KfkFoN5VWWDM4iC3nVQQKf6OMdf4OAcFhKOiKoUcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V8j97Brv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V8j97Brv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHbRb356133;
	Wed, 29 Jul 2026 15:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=40rpRBx5sQPyjxyPg
	DKV8PRN5T5cv44MWFPE8ddjkGk=; b=V8j97BrvJf7ZPPUjwIIAtoNDiyp31XVan
	rx9K32rh1eLAaIn0QC6PUWYDf3Py7dukNG87kwn2O7UGiQ4GPnN4ZV5b37TZit79
	JCO79iZZdwXskkyi3yXk8QTVwP71WkMvue3yRN2Fyn2u3jJMlOl2qfPkJB3TSpEH
	dEfIMjLn4VCGTlCxbZ5mq6ht5wL+GOmAhS71Fh9syRlGD5WnK8l+9GrkrWwrjOGs
	QVxVs0fbcUNNmd3Xk6X21FteM07BITgrMGtSj8kwpdGGgG92oiU61FCv4VJTRV8R
	7i28RZFHWJQziHh2qNArW/pUpqGKkT4AifB5/sAWykBV81kpfSIvQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7kdfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFQJ9n005662;
	Wed, 29 Jul 2026 15:29:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgf3hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:29:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFTdII26804582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:29:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C26DC20040;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CAE72004D;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:29:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v5 07/13] KVM: s390: cmma: Fix dirty tracking when removing memslot
Date: Wed, 29 Jul 2026 17:29:32 +0200
Message-ID: <20260729152938.782383-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729152938.782383-1-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: upuYaoxabMJCh7ovtPrn97VCsOUIL0Dn
X-Proofpoint-ORIG-GUID: upuYaoxabMJCh7ovtPrn97VCsOUIL0Dn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX5NL+0Q4QAxdU
 fku+WKhACMibvkgLTZb71PBGJZ4oOvtfTcQlgUlMcsipWm3WGmD/rIdNQYUZwiQ1C7LU0mCr1jh
 am7TfpXRh4In4rtotJlqRgaUSnaPf0nHOVhOz3G+2r2YcTsMWZ33OHZOIHi52XbBzH+XfTTMxAk
 KRn2c80dXx2nR6gQZ02KBq+A65o01pBGzVemIwVrNKvTptN+1cWh4PTGRe8Za2l9jEnQAhf9GpH
 3fN36bHZfcvlqa/XvVHjIjdk28nhwsau4LzUQQ6Rluabp4g2S/kCMYDAe/ewARQipjXKDDiPuW5
 peusO3IvQ4T1OyFY3uAzOwrM0H2sw/eoFPDuBvW8SgzNE+9Q0DKJmfweVFeUDuWexyV+MF3aZdi
 gAWhpVmHJ5NxISy3FWdxVXASPgCb8X+e08JYCE+LPSEJj28ShhhJ3GwmtUtE0JHpUMiyzUAXvrY
 jficuLvauVgGQOTe59g==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6a1c6a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=xy2Bf3EjJieBI87QFfgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXxD0iwNZvbKKI
 /sZHA0aJXJosFBPe4dGN3I5DPCETCdEnXFrKaLQiuLmsdsVnfPw/IPZr9/iAep2gkOo+txZEPOV
 wblgcYz7cFU5Qlp82eCtf+eRgb6foJ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290123

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
index 80036b8a1f31..3e7e5cfea181 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5806,14 +5806,30 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
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
 
@@ -5824,6 +5840,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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
@@ -5845,7 +5867,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 out:
 	if (rc)
 		pr_warn("failed to commit memory region\n");
-	kvm_s390_free_mmu_cache(mc);
 	return;
 }
 
-- 
2.55.0

