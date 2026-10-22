Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684542;
	b=koZL3CquTtpokcWXbkNIh0dXXLA7IlykhNe+9nSVUaKcnoC8SFY7TgmJ5jcqS6jvKIZc
	 cPgP0kHPFbExSKxmFrcVFBeaLmEe3CoE0MRAuEWW1LM+s5xlUNLa7N8UI1VXJGJ+08ETD
	 ryc0NfXH319kXsaXfK6qYFf41DUaIyqsubLKo6lZ4Slid+8f3qU45HGasiU5dxQrpYqjL
	 vDq5CSFyyruMOl4iy1IhYA88BeRIsM0UhYsmaow2bn9EnVwcFoFYr/AXXRhjPGLUW/vPd
	 jL4ZSZRe/ww+wkQIT1Qvv9u7BEqV7m5I1bHz9cA4ABQdvZ/ZgyVIEKBwF1GB82grD9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684542;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nFxi4pZ4ETwsTVgTeoIBGzHtilp85cagN17NWONk5yA=;
	b=PbI3BZZ1ri5a2T6jtC/LRS4xeUmGmKBA+dZi5oPA7+aHrwijcsBAYGznz2cHcgIHv1/T
	 Cws1rBs7X+zO0wYkMe1bAR0i3lACh3YVuylml/jFCii2BvUWznVKRGYzbyLNB6ebMlLcZ
	 +j6PUCotjKn7uWtcZ+Y/FX4AfpEp4wycsWwmgZemZDh7U8x8TeJi/WewhCz/DbDCFvlIh
	 h0IrCrGv/cjjW95FZxkIVVabPvHduOswWp8xbD5Sr81fdG9LpUd7lj3lqagigVegoXBsw
	 RqwLoyM66aDjY0FV2DcFVOfqKjSEFMwTaLTFmKsQOY+xtjkKqcKygmIf6LGdSpjcSwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OBudV0vO;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3957606A320;
	Thu, 22 Oct 2026 15:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3957606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OBudV0vO
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEEGPS132754;
	Thu, 22 Oct 2026 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nFxi4pZ4ETwsTVgTe
	oIBGzHtilp85cagN17NWONk5yA=; b=OBudV0vOituJITpLkU9fxW0eqDshEqTgN
	a5BB20LnJhluCYfzYx83RbhuCv/3p80pz+1RnH6ImPupXCtg2IzWE5T54I4fs5qZ
	6iwtEsiLRur1YoL0br9FsioTu9Se8kQdo/2GQgXp2cBip3Nu25jgoQYMLemOax51
	sLbOQ7XwdXs+xodv7bmLuqjR9/L4VF/gjn3c9uxfIg8dQqarjr2nSYTbObmudCXm
	m9JqIgMbVHnBqF1USXXRLOS2ZnzMSoVVL9TDi5NnwyYn/IaAO8Kjd1s1tB75pnuY
	iraNzcOYp/WxCSxc6swIFiALrtzi80R3tEf/zE8J2bBBnucabdKWw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5ag0ru-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEJtmG3612475;
	Thu, 22 Oct 2026 15:55:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss8erx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFtWm043385246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:55:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6D932004B;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95A0E20043;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 08/10] KVM: s390: Improve unmapping of large ranges
Date: Thu, 22 Oct 2026 17:55:29 +0200
Message-ID: <20261022155531.204593-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022155531.204593-1-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX9U5HOqYTaHiU
 CcS6rKqrHqoIwBsKLaTcBqs7YX2suP2rkD6HEptbXItIkSkNmVSBTTQI7+Q4+NXiBp72PBBpzGj
 Xd+BfU2jiiWxZPZcDpl4MU4QnhFwyYs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX6oDZ65GQfbRn
 pv3n5z3wnyfLbf9VuTZ/CATEOaxouIkydhKGM3VS38XrqO+48hew29DVxElfcW0HiP3IDIl5S9P
 /BIwZoTSEPXewXmVLZzxi6pI8pRv6WlI4YKDYkF/xZIQPlkfpAUaXuW06jq8oOY8WPt7Q6rbZpD
 cYmh2ereGazSnd2nzl3m9yZAkiMoVAJYd3WSFlzDrz+pDOrlF9VrVjAPLLc+KzYDRlRlBZfaO7+
 tXqFGykyr+7Yu6sYa2e/hL7oGf6Nlr3e4j5JYaRTzLs3WPt3Yad4p4JoVCNk5gyzaTwsX46VxqV
 MnJO6lvQrKvi72duYdzCGvAaz8Du1LGUVMoRD+JzVgoxenplIX7zox4HryanoDzgr/MufUuSYke
 39BSaLJN8OpNynvcNQUXhjHxejcOI8LdrzvXecg1CcOld9ccOG+V6KssBD5QDKbap1DKgrG66y/
 F4D6ib4L9IY6bsnyVgA==
X-Proofpoint-GUID: 6N9mcQ0pSbuYOxATEuHdCrLIg72dxu5T
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6ada31fb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=a_yAbKu6etgibcV5VCMA:9
X-Proofpoint-ORIG-GUID: 6N9mcQ0pSbuYOxATEuHdCrLIg72dxu5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220062

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
---
 arch/s390/kvm/gmap/gmap.c | 110 ++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index c10681f882c2..6700a87a420a 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -437,17 +437,8 @@ static long _gmap_unmap_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct
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
@@ -465,6 +456,103 @@ bool gmap_unmap_gfn_range(struct gmap *gmap, struct kvm_memory_slot *slot, gfn_t
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
+	idte_crste(crstep, gfn, w->datt.asce);
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
+		idte_crste(crstep, gfn, w->datt.asce);
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
+	idte_crste(crstep, gfn, w->datt.asce);
+
+	for (i = first; i <= last; i++) {
+		if (!pt->ptes[i].h.i && w->datt.uses_skeys)
+			pt->pgstes[i] = dat_save_storage_key_into_pgste(pt->ptes[i], pt->pgstes[i]);
+		pt->ptes[i] = _PTE_EMPTY;
+		pt->pgstes[i].vsie_notif = 0;
+		pt->pgstes[i].vsie_gmem = 0;
+	}
+
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
+	failed = _dat_walk_gfn_range(start, end, gmap->datt, &ops, DAT_WALK_IGN_HOLES, gmap);
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
+	if ((end - start <= _PAGES_PER_SEGMENT) || export_on_unmap(gmap) || is_ucontrol(gmap))
+		return gmap_unmap_gfn_range_slow(gmap, slot, start, end);
+	return gmap_unmap_gfn_range_fast(gmap, start, end);
+}
+
 static union pgste __pte_test_and_clear_softdirty(union pte *ptep, union pgste pgste, gfn_t gfn,
 						  struct gmap *gmap)
 {
-- 
2.56.0

