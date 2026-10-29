Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278856;
	b=aq/R6NY6RNrlrQRteWrIdT22n3Dz8CgxXo+u43ZKzcsqwSOEypt3YO6Orj0FO2p9y8pu
	 iJFH3pcZ4MthAeRxtX59D3KpC0PR0VZ3zOvkWWa0U11Iry2YsnGmiTD12zQm0sbRQkdTP
	 ZCAyeKu9UiCTB5ceUa310ENB8LDv5f2uhAoeHo84djOsE94kH2aPmpM5rcpMSyRl0HKuY
	 3KAdZoWVtipcaFag/5aDVaPSD2ZgUssTciwkDC+FJX+b8sLC4Diry3fhn2YfFhUIWwfNr
	 dHS+JNUvefUCrD7e6/8VDHZ1HhmbkhB5Oq8CgH56wGb3ikngpbeOPIE3ZO93kKcMDag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278856;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KXgDIZxEirsc6Cj5CahPcCL9RChvo7USBBIXwsK4K4U=;
	b=VTrLRWzbGas+F3EZmLyWExRvNolrvqmMDEa7rr3IA3DIVCYiR88Pmk3wM2qNhgXE0qp7
	 UAmi/LryKgPGq+Aspcn+oBjBN9hzzamjEpm5RiF13pO+BYEVVmtECsnqyXCPlev5wt9UZ
	 JKGuejiAUrDRQ6b3mgtGTj/PKHSHcWKm2m7FAan7LV/ek+gDGw5gwKXcLkaVDINeQv/h3
	 b4yQMAsyZogSt7ykYw/ZNR8xF/mihljcocmmQ3tLo2x/1qixsFlhqX0GZWqHZNVl5f7Gf
	 Bbl1JyhOJWBPGLCZYGBg+OS5dIZCzmQ7RXN+1WyZUy6zRNYyQnNLu7WQH9TXQ6Wt1ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WiDik1GY;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC7606A321;
	Thu, 29 Oct 2026 13:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8DC7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WiDik1GY
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCiIJQ3046040;
	Thu, 29 Oct 2026 13:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KXgDIZxEirsc6Cj5C
	ahPcCL9RChvo7USBBIXwsK4K4U=; b=WiDik1GYWIY16hKQdFWfryel/BXKIgnu1
	EVrsHwDrO5Acu1PgwssUR/GQuBW7w/Gpb4pxh8xDf2oMMlLKrctA7BJ0i0PYAHhY
	jBp42Nq3qdIdeckEFN2mDkVX9LuIsz8yV0aKedEhhic72GZGPA0x7Ei6CCzenkvv
	G/77fQa0ThLv6Z54vR9A78wCKNKUF4mZvXcefiNnzid0RD2PZgN6Lk5qzd4TtC2u
	eVwGyH6ekkWxLq7EUHM0ZA5SjshDfe+CEKUAjmK3lHR0BsEgxMOsYVzKepwORD1y
	GygiGfFCzjKrkGiostS+wGSit0/EHZyrqJbMLc+8Oo7cucKKSuBVA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3ga19k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCnt8a3196218;
	Thu, 29 Oct 2026 13:00:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh218w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TD0jXj44106088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 13:00:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 738FD20043;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5439E20063;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v5 4/7] KVM: s390: Improve unmapping of large ranges
Date: Thu, 29 Oct 2026 14:00:41 +0100
Message-ID: <20261029130044.125032-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029130044.125032-1-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae34384 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=HzXv01lb-o0jQ-3OhD0A:9
X-Proofpoint-ORIG-GUID: GmmvaqUiCwARHKXttwyrzFWyVGCqdmLN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX5hAFAxH99Ny0
 5KvclzdKgILoYkQNomzxQ7NqBNiTqqEYF6SSk0C/PGStSj+kprRrlK/QwKDv82Z/aHG9Egc/6QM
 bMydnNVOzeXiLN3EF7REfg7Z1nUGcooQctRdCSgWpreJ+68jpkwWsBdAU81gU5XzHLocCMR9Tfd
 y2WlCwcHUAd0O5BNWgbQbOCAbwahMneGmGmGm1dQueZdThksbVzzxzTREHq10qCbbVH18/0pZWc
 8QdluH4mVwT72phVyD7OuytMzYQq8fwyMWUUAr1PlyhmS68T0i7mhmsbNtAGUiHkbVPkmz4OKsZ
 dvqtK/JWLbMpevxxfM7gN7X7jQjTda8wxd63IgI891vBtB8f2kWWE+EUs7MKNkWCiE1q8VL8l+8
 Z69dLTwzqilpCVZRcVDNWphfNsdVVzNseEMsk/089hZuSr9N6yyOu6cOGK9Hruu9X7VDEqJoPdg
 3P9mRx7jAoNAX5gK+Ng==
X-Proofpoint-GUID: GmmvaqUiCwARHKXttwyrzFWyVGCqdmLN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX7gKdufgF5QTj
 iRu9UdczMiIq+b6T69R9SeWps4uoSfeGypo/RW9XKB5w8CPGKqE0W2wx0gzsOabebS/IAtLMbhg
 B7kCbMAYaXUWwI4BViTgUQdGghgpJ2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290049

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

