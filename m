Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213675;
	b=0Xgs7xO7gM2KyFHPdYb3c3fGjJmEGZ9KqaJMYY773KfFNtlLdmzKL0EM0Z0YvvDjbtXS
	 p23TxT9/mXFTqapJf/JSHmCTYOzhv5siReDPXFuHFgqkNC1rBQeRcHsLbAmoMXGD0a1mi
	 ZNv1dsM2YX5eL8epT1hv2/J1ZUBd5mmBeV7uRdpsSqQMYzSzJkjJn4xvvmPAcZXC+ajgK
	 6QL4vZ2WYanzlOWJR/vO+6MAOPzWppHbX28iSjWFFybVS0+45R8qWgadMXsZ+46KB7u76
	 lYTIPDcyJl3ceAM1jwwU+Ml8b7R8aEHJh13uMzNs7wWe8T2tGN6UjUpSGJq8t8D2S2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213675;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qopr7VGogBjVXhTHtjwk73u2jjEi6s/kJvkcgl/+Y80=;
	b=rID4gvKYB8+r5TQcerV0/AGtoPc+5Z0GfC6j0z7g+syjS50GS1lOlKr4AiijmQnPqLTl
	 629VJsXqVrYMt8YkFsYiQet1I7YpxIwM0P4gFeObV4rurHOZ76eRMV54TmSmumJQbJ9vB
	 1t85w11LJpJOHix5DvgZGLKA6ft4Yg2P11CrB1Hlt3WewT4RNFeTWfQh8LEiXGHgWn5FO
	 7ChDVKiSFIyghrob3jBwgYYJCzAxATNXL5z3f/nmB4Gg2EASCJTkVn2GuiaXbBr7rbmXK
	 GWlSOiZ5ckkeovQOCWcEV2MBbLOPrUOjUXBb0wEJQVRhNJUXDsjAkEjHY+zR4yfFuIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N+oHN4lg;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9245606A324;
	Wed, 28 Oct 2026 18:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9245606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N+oHN4lg
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIiDVY2044970;
	Wed, 28 Oct 2026 18:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qopr7VGogBjVXhTHt
	jwk73u2jjEi6s/kJvkcgl/+Y80=; b=N+oHN4lgjfbO8ceMMwaRgvAZPfqdcGiv+
	9dokiKWAQrwam5D1J0Pqhesi1m3pRAILZUL4LenIE0O2fWM8YpxhOYQdlEJJUEve
	2FPTuV+HSXDQwCgcym45uJmd6DPf1BQDnTZIvZINcie1Wugq3PReTqkiKHK4aWes
	ZuJcOyQCRmpWKiFQwXcxkJIwWUeZxit8gzW2f83dz7Y7A7XgUXCW4ruFUOvOp6Br
	O++DXaNoePVsC3jTnc2Fjg3YOZ4o6aEfqc/kGS/7yxil+UIG805DX7zXbTHMRyTo
	L1I3VNX0KJqEq1AeA2C73hbj3zCL2h/nCQVuCXCKA14YBQSzgRkXg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavp0t6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 18:54:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIYqvX1900449;
	Wed, 28 Oct 2026 18:54:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnnedyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 18:54:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SIsNXx52101434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 18:54:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13BA62004B;
	Wed, 28 Oct 2026 18:54:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E89C220043;
	Wed, 28 Oct 2026 18:54:22 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 18:54:22 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v4 4/7] KVM: s390: Improve unmapping of large ranges
Date: Wed, 28 Oct 2026 19:54:19 +0100
Message-ID: <20261028185422.272146-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028185422.272146-1-imbrenda@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae244e6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=HzXv01lb-o0jQ-3OhD0A:9
X-Proofpoint-GUID: MFSLvjJWUGAxiaVy_Omi_c4M-W1JUzn7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NCBTYWx0ZWRfX41DD95v6n/DP
 GAF4qjsYhbg4yfa28H+tXPzW+nQJm+KRHvbk6i5hmO/AnjxKkaPvB65WxeloGmBtk65XIkE1KzH
 eI0zw8YA3ArbY5XrGPsbg9O7WGqi7VI=
X-Proofpoint-ORIG-GUID: MFSLvjJWUGAxiaVy_Omi_c4M-W1JUzn7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NCBTYWx0ZWRfX58oXJ7uQbUet
 eP7aZMR2DMUYzLYD7IiCbbN/V1FL4ImrIDk8+eh04noWZOsw7DLEqPUDZbzse10Tgl1rkcYInlW
 tde1sLF9/ohMvN0Ypg5RdwTOicuFCdz+xB+pDusAiDtiX95/tNdNDg1t3EeGp6SfQLiOt11dprX
 fTn3HSRTz2SwhsbgmRxLLkbBxmHb4V/iOpzXUkqjcypJxACKnE2qS+05E4IkW3PqFJDzWRb9n7C
 HCmUWSqAkOUCw4xIBAZfTfAG6yf1rtLQUOwzVYxeMJN8Extkxfnd8MtGMRfF8OWWkrsg8T8AU/j
 Q9b9YagPC02p/kk+oq1KgC90gLelvdVxTmT93UdgzavisvGqu6k3FK12/KDSbqKqB51kK54/Q9w
 6XWveb2C5q9koAhLnikte/1TTCwib9dVta5O96Wb37jNpN4U8a+eAwoXpbo2bAidwHCfDcH/c0i
 j1ILd21ABbJLTicUPTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280074

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
---
 arch/s390/kvm/gmap/gmap.c | 136 +++++++++++++++++++++++++++++++++++---
 1 file changed, 125 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 225fdae3d57c..04f3ab03a041 100644
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
+	if (aligned_start < _REGION3_SIZE)
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

