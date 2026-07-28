Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153B39D3D3;
	Tue, 28 Jul 2026 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258444; cv=none; b=H4sq8CcKjLrEqVdGIyVyUWEffvFHcVRIvxSle6luUcaPGqMoUigfsyM3IpPGZ63OaKwPBp/C5GcYrCCvejMoV72nThKDUY8ypYbqkxA7COeeog8384sXiYVrHQwAB0yZgnUAtKB3cfuO1tlO8hS4QmOYAJV2BEBVtKpwCfZb3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258444; c=relaxed/simple;
	bh=GOCN2KpJf7Sg7tRxWf8KQjlfUHD4Hyx/PRUHH/TuY4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeCpQQas175a5865zdwGhf2azNUYlshKI1f53YyBhK6PpKUSGbt0RR+NkF0RPnBLyV/k/oPh8eCe6EE9XzGUAEDVljD+g3+tVhbt/bPhRRgqbwO2BQwiYXKSBoKSlATT3de31K49Oulx8vV8QwEaheyZGBMCSmAD5ASMlYmK1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QODGztn3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QODGztn3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SEmELr1492028;
	Tue, 28 Jul 2026 17:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eowEMq43YsmMZfpbd
	eIadMOMc1umF8AjgILbHA7Ki4M=; b=QODGztn3jY0qydDh1bDJTrbacu/0MZoBd
	uR8HyBH/+23AqbWjBg2y4ZGK1vlQ95CeL9YAAVBN7VxUaB5Fux10iiWwRpea/K/i
	AVxWvhqAH+QTofhczvtL6lQ9BFhJdarkOSd4E0zgcm040S3d8b2wbQATHBy2n3xI
	krifpnsioTgcmG/GZ7yiXadnj3fRkF73RBieRCPAOOFJs7ftQImwVk+Qyc1t1VJe
	wm58PUvvIZYHW/If6vESETN7Df58A2BJA/ITJqZ/16/2Qpdjoy77oaCTlDp/wmEn
	LXoKHazegMuXq/YbOY/PHZ9R0ME/nuEkGF2cVqPmukffWLJmbgreA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xphra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuJkc030229;
	Tue, 28 Jul 2026 17:07:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw33af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7DIR38928786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18CD92004B;
	Tue, 28 Jul 2026 17:07:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B76B20040;
	Tue, 28 Jul 2026 17:07:12 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:12 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 04/13] KVM: s390: cmma: Fix dirty tracking when removing memslot
Date: Tue, 28 Jul 2026 19:06:59 +0200
Message-ID: <20260728170708.294400-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170708.294400-1-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e7_ddpPCtvcT6AHNhY_LHPcehwivwHwE
X-Proofpoint-ORIG-GUID: e7_ddpPCtvcT6AHNhY_LHPcehwivwHwE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX1v3FW+pbMDqp
 hT3xaF9euja/p9b/7doSJRiSRS3XRXwjgB5Uev92RGSCoi+F+A4QS1Y42YADroGvz28PTl2DsJt
 VUQhYaE6v6K26c17h9kmnHdjSjbqKrg=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a68e1c8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=pfyf7wEKKELI5JYCgUMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX6XHPCU2eHMM0
 +kvbC9e0x/LlqXontQd/1CPWTe4DtjgILcuJqFwopEV/n5RlMkXmXiAiuBczzRPuCsJ0zUJumXM
 0HxMhQl1TXoAt5JcpDdHT5I6Ehy6t9ZnBFyqvdxZ7H9JfVk4R8MGJAopyLdH/BboRLktMF1k/mQ
 gAQDC3O5Cb8JnA2sbQplsZrcxcqdrt5JsQbVe0SQRq2ji2r8QRAn7m4xYIpjwBhI/gcvrLnVh0b
 YiHTBL4w0KeMRD68qoXK0/4FwyiNmPORwKbM9tWU1PxKkkYKenpk5nc8wxR0CeZloOb8c6OjpqV
 CbSxTLkbvuX0gI1JThSTDMJQ/MD2qyWbtm/IpnmsHjTXQo4giTcLnALRU/L/teWZdKPeHuSQpU/
 q9IbYyvoz4H8uHgeRRnwz/eszQRNcNh+NRo7bA52zzECLY9TQA0Wg+ZrHR2n6LDiKem0xXOIeHJ
 /jLR+CXU1MqS6/B9DcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280149

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
 arch/s390/kvm/kvm-s390.c | 19 +++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

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
index 100911ee793a..7b37e410d416 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5805,14 +5805,24 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	return 0;
 }
 
+static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	if (pgste_of(ptep)->cmma_d)
+		atomic64_dec(walk->priv);
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
 
@@ -5823,6 +5833,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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
@@ -5844,7 +5860,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 out:
 	if (rc)
 		pr_warn("failed to commit memory region\n");
-	kvm_s390_free_mmu_cache(mc);
 	return;
 }
 
-- 
2.55.0

