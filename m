Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893037;
	b=Z35cMz92Z1Lq83Jyx2sEpwQ7JqTv0+9xrKQs39guYBAXsOd7KSXspChxCIoSlTgiM+93
	 DZUuJD5OpmvM/7Bras8MDkjLne+VQ69l6waEW2u1OOa/Bs601ZX8VAlIHouJO0VDD84X2
	 mgDENGbCDUocvxHRbYtYof6w7cW1meJsKycGn9GtfO3buXZIq/bo/GUdVj41CKaHGKoq/
	 kZMql0httr34S1IZkewA3TEEAi/hzDz7WDQJYaFHUzgIE94F3058/pHr04nzYZ7MdVzpD
	 x8KynuB2cr7MsarW5zwFGcvnIpWFUIwWGwMOo4eacOiyqPThp4Xji2Fj9fevMmRFePA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893037;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/EWXU/hTYceNfI5JVXxgUnfaX/Va5utnPc+dCOrE978=;
	b=h+hAPqVgQVhAtQifvA14voOszelLibQHh8YhPILo90wXGp5jbLt9Lhq+iLRQLrzeztOR
	 XNVW01JLKi6FFc5NmgCScbHTjES+ookoanD0MBHZQf5JiO/YyPFct8WjF+Y7UcgxwCnLb
	 7eaF5169WDpZNb2+SUEuA/9I4EfZxppnCNyXTO9Vu1UAG0olol3jggcGqweEgNv8Wl1bU
	 YH7HsMrA5Fm6lZlGUaaUMg+MzFAaNHe9XC7BR7Fzqi2GgRqKqPFIKe9vz+xbAOx75zoBn
	 Aku3NeGAlU6f3+RmIKql7wYRtCHlHsvtt1s+v7uyfn2rJxW16haOLJU0PGhw120S7mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H9h0FKfM;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B5606A33B;
	Thu,  5 Nov 2026 15:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 858B5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H9h0FKfM
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EiAEp3787424;
	Thu, 5 Nov 2026 15:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/EWXU/hTYceNfI5JV
	XxgUnfaX/Va5utnPc+dCOrE978=; b=H9h0FKfMe3pOD9tmNWGFCq7wzaCCC6yr0
	Htfm4KZwNfD8WPrtmsbsDuPrk4lYg/6HC79iVFgc0KHVP05Xzb5ob1uvAdk3fsri
	w/drVNCcLb0DgrcIWrY1QwpdvhLTgBrGHMTsX2+zndh1EJ+ePla9xQI4048tf9xi
	JmsM5xRytVm67nqXheIf+fNDaWpqe5e0YbvZb0at25ZZfUW75Oco56otUXhMfgnn
	uPRbsb1aHY0fzeLX3XEK/sdo6H3GSI+Szid1NZz2NdvOVZIhMI1fZVMbdwodTT59
	ImS5Ml9E3cW9qXtfN4j3HRZuWLqWhmixNq+rhlzuq+yFf2JDxajUg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn82736uq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 15:37:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EYxxo1829834;
	Thu, 5 Nov 2026 15:37:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7m82a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 15:37:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5Fb6Dg30999204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 15:37:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A57C32004B;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 872A020043;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v6 4/5] KVM: s390: Improve unmapping of large ranges
Date: Thu,  5 Nov 2026 16:37:04 +0100
Message-ID: <20261105153705.208516-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105153705.208516-1-imbrenda@linux.ibm.com>
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 1CV_dOk7yWaWZ2XqMRmjxElUDSeQj5i3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfX+XrGXde77tqm
 GM2mpRqSL6Ok1JN9l0C6On5HOUFiBt15rkbkz1icriHm/4da/S2ZkLTFj17EntBQcgxwQ87uG58
 y+hki7VHJ/oidKluw2zL2saO08QrRcs8fusKbJHdA8dD3GwDTTdO0AIEWkga8Qbk27IekWCYae9
 sNWyhYTclKkGVsVTLK2dpbZxUwM+Z8mtvoHeYH5vGhYEPhYr2mPGYF/hMdxe5BQapYCCuGI0sZR
 ZogaIJ+Eu4hmCLaxpe4lj9bMxPMmt25SJv7vcfcBDE3JE7UcGAAm/M/Iune1/Tgk3bs9dShiN4N
 /OKzKSiGsZiJgdna0C5TotneiUo3tmaQNwoaTz9dknPfgG44nAwO5Mrd1o/W7MA1Siiub3F8WET
 AIR7bviL5WkjBEcdt7o0aBpKGOgkTcX6u8SWYzXVh4j+OPQlJsK4Vc7HWVg5eC9aiIrVTTTfet0
 tJqQVhYNrUav3K4fUgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfXxuQIGodqgi+T
 YDOq2U9x1s6SzqfpZ/dA3rsFQf4rqhbUMq6DeLcZH7qIOMoHge1dhbwj9bV0gBRIH6k6YkRpJ3G
 MtX+tBUeDLFBaM5TBP82ei80axPPnaQ=
X-Proofpoint-GUID: 1CV_dOk7yWaWZ2XqMRmjxElUDSeQj5i3
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aeca2a9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=HzXv01lb-o0jQ-3OhD0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050060

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
 - Detach (invalidate) the pmd
 - Save storage keys as needed
 - Invalidate each (now detached) pte by simply overwriting it
 - Reattach the old pmd to point to the updated page table

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+
Acked-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/gmap/gmap.c | 136 +++++++++++++++++++++++++++++++++++---
 1 file changed, 125 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 225fdae3d57c..b9d92bef5459 100644
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
@@ -462,6 +453,129 @@ bool gmap_unmap_gfn_range(struct gmap *gmap, struct kvm_memory_slot *slot, gfn_t
 	return false;
 }
 
+static long _gmap_unmap_pud_fast(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *w)
+{
+	union crste old = *crstep;
+
+	/* We only care about large puds */
+	if (!old.h.fc)
+		return 0;
+	/*
+	 * The caller did not unmap prefixes outside the original range, which
+	 * does not necessarily cover the whole pud.
+	 * Since all prefixes are below 2G, the first pud covers them all;
+	 * make sure all prefixes are unmapped whenever the first pud is being
+	 * unmapped.
+	 */
+	if (!gfn)
+		gmap_unmap_prefix(w->priv, 0, next);
+	if (old.s.fc1.vsie_notif)
+		gmap_handle_vsie_unshadow_event(w->priv, gfn);
+
+	if (machine_has_tlb_guest())
+		idte_crste(crstep, gfn, IDTE_GUEST_ASCE, w->asce, 0);
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
+			idte_crste(crstep, gfn, IDTE_GUEST_ASCE, w->asce, 0);
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
+		idte_crste(crstep, gfn, IDTE_GUEST_ASCE, w->asce, 0);
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
+		pt->pgstes[i].prefix_notif = 0;
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
+	gfn_t aligned_start = ALIGN_DOWN(start, _PAGE_ENTRIES);
+	gfn_t aligned_end = ALIGN(end, _PAGE_ENTRIES);
+	bool failed;
+
+	lockdep_assert_held_write(&gmap->kvm->mmu_lock);
+
+	/* Prefixes are below 2G; if the start is above 2G, nothing to do */
+	if (aligned_start < _PAGES_PER_REGION3)
+		gmap_unmap_prefix(gmap, aligned_start, aligned_end);
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

