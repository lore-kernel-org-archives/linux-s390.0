Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084401;
	b=EhA3ioFnWaCFFtkqm+1tyuaVKRHTPVoEq2LvDmLuJwAII9jGZRbPKF3NvhlutVBQMPEE
	 urdQ34hCdX8R/XAw+OLMjah1Mq9C2SgzY5AF5MbuFZAxO0Ws5hvVj68zPKUUwpJIeePLO
	 x+IH07W46UHXg/SwPizlH4+rf6ZnaVAG2J0DOaapDEUk8Xdq0KXt/dyPIZ8mlOjgQsl/F
	 GRnGM5ChdmTCbjolP6Mx6aUHUvh3CR9glvoXYTtNcv7k3ELiqyS++d5ZP0a0mruwxyxCt
	 uYkiYJ0qJv9TMvvhRuDOuIDkjqK8mfaoxymKN/97qiEM3YWL7e1DUcBjqAzZW63nKXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084401;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xq0q1BIc25vkbrUf0DeYcA2LwqBhLqkO20/4QPFsfv0=;
	b=tkw+SkoER63S2szB0y1lgZOkOZDo1k1dEBT6d6SrzD/wl8VnXKDTYmLZHzwBx8hl5Hdo
	 ROdA1Yb75KhufDtvpHNm1p4jpxuPpcuUS0qubrTv8XSXKaoGkhj1KWgc+eOBMpcWoqpAz
	 GNrnx/3mnnTB6xtyJG6zhJ2tk1xO6gFo8Ufkm7R68VPWlPBEdvwpdc8dLPUj/WJDLUcWa
	 3U2fyheWNSZm75VgXJtKm93J5gVt0IdCggBwAW2LNbwPDcSW4pATCcTQuofypE3FUdeNJ
	 sUW3TKU2VJb0ByqASmwXLH5QGqfdlS3DTehTS3YwgRrUJQvTisViWgmRzZSC528E7Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YD0jLBh4;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ABF606A324;
	Thu, 19 Nov 2026 10:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80ABF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YD0jLBh4
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6v2ho2237182;
	Thu, 19 Nov 2026 10:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xq0q1BIc25vkbrUf0
	DeYcA2LwqBhLqkO20/4QPFsfv0=; b=YD0jLBh4NHtB8wJP789N8gVwd1Nj7GNAZ
	SMpgD2f0y8W0sPEfBMAT9cvEAuSlzZ23Of4vQLAiFSNj38WApVHrligVHM8Xe3ED
	0KZxbs/60BXeYKPFdA5odGYo7NWb4shZ0nZvmxbo5Zpo2yGHPB4ArlSuNGX2flgN
	IXD+jBVDuZN1Aaycx/4o+UoeHE1ZhbdZuFJlZVMUUTQlS2I3ykEFZCaEEMStiULO
	gHAJPV22iEmkRFUM/AlxsFY3fLpNdjV5/pgmjNbKB/EUIUgE/NBvBRqlTboI4lRm
	BQEHxN8voybIUKbxwtQJF+YYxSA6UXXWcxL/BHuB+iTx5bt4A5m5A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w01yu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 10:33:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJA8nE4179460;
	Thu, 19 Nov 2026 10:33:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3hu416-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 10:33:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJAXEkW2490906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 10:33:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B04558061;
	Thu, 19 Nov 2026 10:33:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54CE358062;
	Thu, 19 Nov 2026 10:33:12 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 10:33:12 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL 5/6] KVM: s390: Improve unmapping of large ranges
Date: Thu, 19 Nov 2026 11:32:58 +0100
Message-ID: <20261119103259.7523-6-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119103259.7523-1-borntraeger@linux.ibm.com>
References: <20261119103259.7523-1-borntraeger@linux.ibm.com>
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
X-Proofpoint-GUID: UmhLW-09QkSSao3dHRzwpQBBMPwTQK_v
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afed06c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=HzXv01lb-o0jQ-3OhD0A:9
X-Proofpoint-ORIG-GUID: UmhLW-09QkSSao3dHRzwpQBBMPwTQK_v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX36GiibHgZE+a
 l3IYKUIFyObhxlI3oDVob+UpHXN4Zmxb00ecBNxdCQi0vq9UZS/anyYTKR8Pdnk+0VPWEi6W5NC
 hc8VI5H04WV8WeJckeAn3N+YSa3m5LE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfXwHjW/ARR5sr2
 z7fIntkNrmwR5r//QBnPX2kUO0BkfufuGF7PNcaGf6C6ON+lgauNkZ3DPutJT3nmGnScZajHT7d
 Dm+nPoS0SB5o5Aaz8dXhCITWeMOaZyVkZ0FnF7ZbYPw77mymiz97Wo1Uhg5N2+6pxwZj/Al0jYe
 NXVYGlQJguLn8glYy/mh1xfo8fV2qZ7pxgWtkFkaL0/S3Bj9f5LI2gDWzmTowSGs8js4OiOLo8C
 3Ye2F7loH2rXX3cZu3msx1oG34yffaq7dcyrDcC0ZgHHh8zbxcVUv+SqMh8I5irYB2EIZ2YeyaV
 AWg8mE56268TQ7epK58qSMILkf+esh5fvj1QOoWeZC0t+04ZSW2SivhmZVEmEFdgSmwmK0egiTo
 OTSVe7jY0bskvVBkWTvXi7yFEy12+c09yJakbXNz7DsaGRPBABDoKm/dHa+F7wVZZZJiJPdZ6D5
 8k2IeFPCBczSE+quRFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190041

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

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
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap/gmap.c | 136 +++++++++++++++++++++++++++++++++++---
 1 file changed, 125 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 225fdae3d57ca..b9d92bef5459d 100644
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
2.53.0

