Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18E4457A2;
	Thu, 30 Jul 2026 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428850; cv=none; b=Lo+7HQ3hIEbyWTrGPpWWYfIbOMMxqUALr7AiVYNS8Y6DtWdkJ7YePkAQbQgxtNU/dXVVxhkZUc0fQ+DFW9ST+bDi2rLHplwfQq4+N8EhVh81YL5SxMzbl/6r4kn0ExOtefIdeXFcA94muF3KWdReNuPnoUKiyUa0zeflgD5J9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428850; c=relaxed/simple;
	bh=0vlBxdGXbjJDWQrcBGcQhxdUMezkzkssaJm4HXFo40k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThIlSQqf8GfOQxReoqSSclNYPjHekErcR0BEhd9CiuM0KL+b8nUSZKAc/l0L1Smz/KKktqfeUMdz9CNpDZ2Rj+iFF6k58DpAGnqI6hDY30qyoXZhyLw7OZUe3BPAFRbZaYrXk0RRHcYhGbeM1cKv8dRJc5O8OO9vFmprfCpGpn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IG0e7UmB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IG0e7UmB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFmiIR3355578;
	Thu, 30 Jul 2026 16:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m0p5AuMnmCGfCWumf
	4rQpE8uBdEqMZZ3p0Uo7bxCp/I=; b=IG0e7UmBUawE4vgP5PN7oi+AjC2oEFQD7
	z0Q3gCQ/DITtBcfYErJRb0w9ASlsHKNywGI2fdSwmZu/aEE/f/jmSTFU5Lpxtg4g
	fLk1eF1jZZ9QgHvMkc1ETqRDZSArNKX2FdvPAVHoEnUFZFIBZnjNowhcQFi41kgs
	LEvevYVs+e1lnFPGhBzBdawTOTARiDkuyAtwMYX84R4Acha+juwXOsncfBbvOWZ/
	Kw4VedIkR2G1uH2yymo6fSHtug8W/VX2gglDBrEpnjrJhg4P/kKoLcrDupTr39Wa
	D9cqx7a+vUVGgVZHXdk5/JqJcHATXCPdp5ozA5xAYeVeXDm5wvNyg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjfvkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQSIU022229;
	Thu, 30 Jul 2026 16:27:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgky7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRHt043450752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 664C020040;
	Thu, 30 Jul 2026 16:27:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42C292004E;
	Thu, 30 Jul 2026 16:27:17 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:17 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 14/14] KVM: s390: Move DAT table updates to kvm_arch_prepare_memory_region()
Date: Thu, 30 Jul 2026 18:27:14 +0200
Message-ID: <20260730162714.133327-15-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730162714.133327-1-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfXzcAT5C3K1alM
 j9uWyX/Aho4gyXrP1eF5svKY6l9JPTY0WR1rEv7VgL6tHpN2Yp4s7lRvhvL4gahbZkfEx3RneJq
 VuJe0Q4pPMtKrmJKAYY0FwRRptZ42NU=
X-Proofpoint-GUID: DMVU7hwS49NWG7GSzFsv3aV6caDN6Tu4
X-Proofpoint-ORIG-GUID: DMVU7hwS49NWG7GSzFsv3aV6caDN6Tu4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfXzsu05pGlePH1
 yz43P6fPWG923gZc2qGyaRume8RZ3vM1rSSO0sdEV6jJFNbueo7rvIj5+G3NXND35L16omqmURq
 T0fHe+8ih1OtizCHehDLx96GNA5gu2XGKIzht2kAnB/eiAqVWAjb0ggkU3e+qx9DlcJZKy0Ddq5
 tD8W6tA/wLnQW4xguozggTj62dWQGxb8ZuWUD9BwBdRxiobzZuY0Q7LMMxE9bhWmfiQ/LqQIi6E
 TGgmfiMlhQJ4X8yimLknK1zHi19d3yc6CbQ1IlGUF14OiYG90232IOZpLKPrnswjh8QfeVBgH4J
 DTyVnP/sjXGddIg0IlExkqzou+7A4WZp4+LPYhaxVvAvrJWv3pYwMUkG1isuwYjqG05v/Sfd2/f
 b7ecsifYPW79llegRFSjNDYRpTfQJRriZ77QKoWvHj+iPJyIKvOvo5G1GarsRXI9Xdyc0G/gIS+
 OGwCRx8sX7D/Ppfpn1A==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b7b6c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Ik9v8dO2Bu5cKhyEOHoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300123

Currently, when a memslot is changed, the changes in the page tables
are performed in kvm_arch_commit_memory_region(), which is assumed to
never fail, as it cannot return an error code.

If memory is tight, the allocation of page tables can fail, a warning
is printed, and the system is left in an inconsistent state.

Move the whole page table update into kvm_arch_prepare_memory_region()
instead. This function can fail and return an appropriate error code,
thus not leaving the system in an inconsistent state.

Fixes: 598841ca9919 ("[S390] use gmap address spaces for kvm guest images")
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 87 ++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 47 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 035476ec7fbc..668272dffa18 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5761,11 +5761,30 @@ bool kvm_arch_irqchip_in_kernel(struct kvm *kvm)
 }
 
 /* Section: memory related */
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
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   const struct kvm_memory_slot *old,
 				   struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
+	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	int rc = -ENOMEM;
+
+	lockdep_assert_held(&kvm->slots_arch_lock);
+
 	if (kvm_is_ucontrol(kvm) && new && new->id < KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
@@ -5788,55 +5807,27 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 			return -EINVAL;
 	}
 
-	if (!kvm->arch.migration_mode)
-		return 0;
-
-	/*
-	 * Turn off migration mode when:
-	 * - userspace creates a new memslot with dirty logging off,
-	 * - userspace modifies an existing memslot (MOVE or FLAGS_ONLY) and
-	 *   dirty logging is turned off.
-	 * Migration mode expects dirty page logging being enabled to store
-	 * its dirty bitmap.
-	 */
-	if (change != KVM_MR_DELETE &&
-	    !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
-		WARN(kvm_s390_vm_stop_migration(kvm),
-		     "Failed to stop migration mode");
-
-	return 0;
-}
-
-static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	union pgste pgste;
-
-	pgste = pgste_get_lock(ptep);
-	if (pgste.cmma_d) {
-		pgste.cmma_d = 0;
-		atomic64_dec(walk->priv);
+	if (kvm->arch.migration_mode) {
+		/*
+		 * Turn off migration mode when:
+		 * - userspace creates a new memslot with dirty logging off,
+		 * - userspace modifies an existing memslot (MOVE or FLAGS_ONLY)
+		 *   and dirty logging is turned off.
+		 * Migration mode expects dirty page logging being enabled to
+		 * store its dirty bitmap.
+		 */
+		if (change != KVM_MR_DELETE &&
+		    !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
+			WARN(kvm_s390_vm_stop_migration(kvm),
+			     "Failed to stop migration mode");
 	}
-	pgste_set_unlock(ptep, pgste);
-	return 0;
-}
-
-void kvm_arch_commit_memory_region(struct kvm *kvm,
-				struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new,
-				enum kvm_mr_change change)
-{
-	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
-	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
-	int rc = -ENOMEM;
-
-	guard(mutex)(&kvm->slots_arch_lock);
 
 	if (change == KVM_MR_FLAGS_ONLY)
-		return;
+		return 0;
 
 	mc = kvm_s390_new_mmu_cache();
 	if (!mc)
-		goto out;
+		return -ENOMEM;
 retry:
 	scoped_guard(write_lock, &kvm->mmu_lock) {
 		if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
@@ -5869,10 +5860,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		if (!rc)
 			goto retry;
 	}
-out:
-	if (KVM_BUG_ON(rc, kvm))
-		pr_warn("failed to commit memory region\n");
-	return;
+	return rc;
+}
+
+void kvm_arch_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *old,
+				   const struct kvm_memory_slot *new, enum kvm_mr_change change)
+{
 }
 
 /**
-- 
2.55.0

