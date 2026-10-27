Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122371;
	b=1fAq9zHjlc/2znZi9P3IiNltzaQZu275/70TzW6CGIqJSIkdvjYiWvj3UAvzCqSWCuwq
	 PuW4dEknIwKqQesI1mS4GhXGtn2tXPyHhpP5V/rgxuzH0dArbx+afAV1nOD0WJFSjdFR6
	 c/VDyUGvk0X7OSO1GO6rNtwd7hMAWILFkNbQVjcdgbga+iCXlYmjqSoiIYBUcxUiuiBLN
	 e/YBCQ03AL40JOVAnLanAjAE5Nqt92AzdHviftfmF4uHqw6ZEp0c84rVqcw+keyHihaoO
	 w58l6G2Xh0a7kev5msV5IJpzLqANTm5hJNdIyNXJ+Lw3BcwKVHREj3T8AKCTi6dMZUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122371;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nAoBGfeqG8r4nTkYv/SqS7sg30afeDFVpQSRm9B+mw0=;
	b=tPOKqypJbSSAgJe/C0eaX52KSgRc805mMjGvm3AKRE4ueVcHXJ7042Q7IkjZaw0BSJUz
	 SvPqJYdx8aR0zuH6bRM1kLLhVjt+GJuJX3Z0+vAS3/3GMm7jwWZXrRFAWxfzm9qHjbxcE
	 EBNykHPgMesMrg5+pBlszs4Sxj3TiC47/coCDCsujumZxZT8jZgWIElFbj2T0PI3+05Kc
	 1Th+rqQoHcoPV5qWJANtdJ+V9T9GKku+ZKcU38kOGcSslTuLrAyB329xrSAUgH3Jhy1pp
	 x51UK0fJQvBa+yX3ETBUWLD04PSZFt6qaKJl2ia4+Npgc2eVkKsyqUwTzKTe3V7rSyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bnsisbT7;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A94606A333;
	Tue, 27 Oct 2026 17:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A94606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bnsisbT7
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RHEdGw1952276;
	Tue, 27 Oct 2026 17:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nAoBGfeqG8r4nTkYv
	/SqS7sg30afeDFVpQSRm9B+mw0=; b=bnsisbT7XDa1kzNft75bdhCbv1V3jRVcW
	3hK8U7TUd1rhcaU0U9+3uha3MGwiAk0vDUyDmMgIzxE4MpcBVGQSJ+iDMlOHBpXB
	of1zc+lkN5kp7mf2qy88WNr3aHVvlt0OmsmarLPhh/XBgzofrVn5NlKY256zVc9/
	DZ4wl3iqr8QUTkM8ISRVBcRL+rPQR/j/eFzuqIm+UtZyOdfiLwzPpcyySH96z/S0
	nWNixIRwnQLJiy85XbYoS+xwxbKCs/xohN/3kCK8k5WN5K/RlRPj3J9O0IWFXsQ2
	rbNUeuC/qbEiY42UMB6S2LeBOvNYuP7K+Wu62GMZCtJquMfJ4ObZA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3g0qr9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 17:32:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RH52dk328597;
	Tue, 27 Oct 2026 17:32:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh1s78b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 17:32:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RHWehx38732276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 17:32:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 107B820043;
	Tue, 27 Oct 2026 17:32:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5C9D2004D;
	Tue, 27 Oct 2026 17:32:39 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 17:32:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v3 3/4] KVM: s390: Improve unmapping of large ranges
Date: Tue, 27 Oct 2026 18:32:38 +0100
Message-ID: <20261027173239.224849-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027173239.224849-1-imbrenda@linux.ibm.com>
References: <20261027173239.224849-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae0e03f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=a_yAbKu6etgibcV5VCMA:9
X-Proofpoint-ORIG-GUID: HzmeR__9M2j4RDG0YQj7fWo1uqoHf25c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2OCBTYWx0ZWRfX2zdwJZZjxY/J
 FjqXcB0SOytAFaKMGAIVbyVmaiiK1AUREY1XM+ubW4lcfksIYSaPYvjf1NioRNnRv4UN2SW+fwK
 GQ5cAfPIdPp7iSw01HNRLHreR2xn6UjKxDALLxA73OEBZXdj0uoDnl9D7p5sSYQJ2IuujCMBLMd
 3MHfW4HwJpoCUFV8PPu0PYIHq+GXwcnJ1OPISpn1wDIjgtgl514aKhsKaOkZSXnIfbwDMU+NKu7
 cyzAS5voLQsQeiSPLTWXjA1VB7M65tmBjfenpiQohN39ziN/dYL21gEtsUAsIUCPEcruIdhhq5a
 kimgJ8XVjs8TdQfkUFNi9DvIQgkn7Gji2/Hyn1OicNEw88uvqX5oDdcQU05lHp3xINLiRR4zg+w
 eZ5AGt7r2BfrUl9+lSQdZB0ZHPndQzcIOfg/hDwGqldSN3/AQixGmdplIeiiHwD0pqTlqbS98GP
 yrxN+7fe+Q9G7EaU43Q==
X-Proofpoint-GUID: HzmeR__9M2j4RDG0YQj7fWo1uqoHf25c
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2OCBTYWx0ZWRfX0+5bWi3bEvay
 RuhHhfN5wp/pksc9kPWMwgTdnw5fjquRfDRJYhFFcrWYfwnIARW6AK4YtAdHmKQCXrxv7NQOe+l
 gAorpUKR7Oy3I872lzMVDeQY1OHMM/M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270068

When unmapping guest ranges, each individual leaf DAT entry is
invalidated. When unmapping large ranges, this results in a very large
amount of invalidations, which is time consuming. Moreover, since the
unmap callback is called by KVM while holding a spinlock, this also
leads to stall warnings.

Improve the situation by invalidating DAT entries higher in the tree,
instead of each leaf individually.

For small invalidations (up to 1 segment = 1M of guest memory), and
special cases (like protected VMs) regardless of the size, the old and
slow invalidation is performed; all leaf entries are invalidated one by
one.

For large invalidations (larger than 1M of guest memory), the new
strategy is used:
 - Invalidate prefixes on the whole range, extending start and end to
   1M granularity
 - Iterate through the page table pointed to by each pmd and unshadow
   entries as needed
 - Detatch (invalidate) the pmd
 - Save storage keys as needed
 - Invalidate each (now detached) pte by simply overwriting it
 - Reattach the old pmd to point to the updated page table

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+
---
 arch/s390/kvm/gmap/gmap.c | 124 ++++++++++++++++++++++++++++++++++----
 1 file changed, 113 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 225fdae3d57c..7ae0b4a1a6ca 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -434,17 +434,8 @@ static long _gmap_unmap_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct
 	return 0;
 }
 
-/**
- * gmap_unmap_gfn_range() - Unmap a range of guest addresses.
- * @gmap: The gmap to act on.
- * @slot: The memslot in which the range is located.
- * @start: The first gfn to unmap.
- * @end: The gfn after the last one to unmap.
- *
- * Context: Called with the kvm mmu write lock held.
- * Return: false
- */
-bool gmap_unmap_gfn_range(struct gmap *gmap, struct kvm_memory_slot *slot, gfn_t start, gfn_t end)
+static bool gmap_unmap_gfn_range_slow(struct gmap *gmap, struct kvm_memory_slot *slot,
+				      gfn_t start, gfn_t end)
 {
 	const struct dat_walk_ops ops = {
 		.pte_entry = _gmap_unmap_pte,
@@ -462,6 +453,117 @@ bool gmap_unmap_gfn_range(struct gmap *gmap, struct kvm_memory_slot *slot, gfn_t
 	return false;
 }
 
+static long _gmap_unmap_pud_fast(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *w)
+{
+	union crste old = *crstep;
+
+	/* We only care about large puds */
+	if (!old.h.fc)
+		return 0;
+	if (!gfn)
+		gmap_unmap_prefix(w->priv, 0, next);
+	if (old.s.fc1.vsie_notif)
+		gmap_handle_vsie_unshadow_event(w->priv, gfn);
+
+	if (machine_has_tlb_guest())
+		idte_crste(crstep, gfn, IPTE_GUEST_ASCE, w->asce, 0);
+	else
+		idte_crste(crstep, gfn, 0, w->asce, 0);
+	*crstep = _CRSTE_EMPTY(old.h.tt);
+
+	return 0;
+}
+
+static long _gmap_unmap_pmd_fast(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *w)
+{
+	union crste old = *crstep;
+	struct page_table *pt;
+	gfn_t first, last;
+	unsigned int i;
+
+	if (old.h.fc) {
+		if (old.s.fc1.vsie_notif)
+			gmap_handle_vsie_unshadow_event(w->priv, gfn);
+
+		if (machine_has_tlb_guest())
+			idte_crste(crstep, gfn, IPTE_GUEST_ASCE, w->asce, 0);
+		else
+			idte_crste(crstep, gfn, 0, w->asce, 0);
+		WRITE_ONCE(*crstep, _CRSTE_EMPTY(old.h.tt));
+
+		return 0;
+	}
+
+	if (old.h.i)
+		return 0;
+
+	pt = dereference_pmd(old.pmd);
+	first = max(gfn, w->start) & (PTRS_PER_PTE - 1);
+	last = (min(next, w->end) - 1) & (PTRS_PER_PTE - 1);
+
+	for (i = first; i <= last; i++)
+		if (pte_needs_unshadow(pt->ptes[i], _PTE_EMPTY, pt->pgstes[i]))
+			gmap_handle_vsie_unshadow_event(w->priv, gfn + i);
+
+	/* Detach the page table */
+	if (machine_has_tlb_guest())
+		idte_crste(crstep, gfn, IPTE_GUEST_ASCE, w->asce, 0);
+	else
+		idte_crste(crstep, gfn, 0, w->asce, 0);
+
+	for (i = first; i <= last; i++) {
+		if (pte_hole(pt->ptes[i]))
+			continue;
+		if (!pt->ptes[i].h.i && uses_skeys(w->priv))
+			pt->pgstes[i] = dat_save_storage_key_into_pgste(pt->ptes[i], pt->pgstes[i]);
+		pt->ptes[i] = _PTE_EMPTY;
+		pt->pgstes[i].vsie_notif = 0;
+		pt->pgstes[i].vsie_gmem = 0;
+		pt->pgstes[i].zero = 0;
+	}
+
+	barrier();
+	/* Reattach the modified page table */
+	WRITE_ONCE(*crstep, old);
+
+	return 0;
+}
+
+static bool gmap_unmap_gfn_range_fast(struct gmap *gmap, gfn_t start, gfn_t end)
+{
+	const struct dat_walk_ops ops = {
+		.pud_entry = _gmap_unmap_pud_fast,
+		.pmd_entry = _gmap_unmap_pmd_fast,
+	};
+	bool failed;
+
+	lockdep_assert_held_write(&gmap->kvm->mmu_lock);
+
+	gmap_unmap_prefix(gmap, ALIGN_DOWN(start, _PAGE_ENTRIES), ALIGN(end, _PAGE_ENTRIES));
+
+	failed = _dat_walk_gfn_range(start, end, gmap->asce, &ops, DAT_WALK_IGN_HOLES, gmap);
+	KVM_BUG_ON(failed, gmap->kvm);
+	return false;
+}
+
+/**
+ * gmap_unmap_gfn_range() - Unmap a range of guest addresses.
+ * @gmap: The gmap to act on.
+ * @slot: The memslot in which the range is located.
+ * @start: The first gfn to unmap.
+ * @end: The gfn after the last one to unmap.
+ *
+ * Context: Called with the kvm mmu write lock held.
+ * Return: false
+ */
+bool gmap_unmap_gfn_range(struct gmap *gmap, struct kvm_memory_slot *slot, gfn_t start, gfn_t end)
+{
+	if ((end - start <= _PAGES_PER_SEGMENT) ||
+	    test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &gmap->flags) || is_ucontrol(gmap))
+		return gmap_unmap_gfn_range_slow(gmap, slot, start, end);
+	return gmap_unmap_gfn_range_fast(gmap, start, end);
+}
+
 static union pgste __pte_test_and_clear_softdirty(union pte *ptep, union pgste pgste, gfn_t gfn,
 						  struct gmap *gmap)
 {
-- 
2.56.0

