Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D047DFB2;
	Wed,  1 Apr 2026 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065212; cv=none; b=Q1nXlxdZnTFpn1wJGcLzJo1xA8GonjBV1McEFGbqd3nDAdIwHtlTAW7WFlOAD24ZC0YY6foo7FH1m6xQ9j9v6eSh6/tYv7ix8X6mPQCF/dXrK9oNCBn4W8bAIu2bgv7V4zIzjyNIG9y2iJ8x5twJKZzP+ZsbImwFbFB9JogsMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065212; c=relaxed/simple;
	bh=EmPirQcevw+Nf/B/EQlvIHWhaoy0kaAz1B5Nyns08co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlMWtPeqX/A4tTGIST+uwmI0bslM8tkVpXFm7yzBFN21OLi3nhlWWNAZFkNJlkmslEsFssehX1QDu8ddIod4psy7nziFqfnPk9JZgKydFTshGlanUmayF5gbcRFS1f5/KcgbMU84Ty+mdwEhW81Uw3zPIyqlnAvZYu83dxAOC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZFRChnVO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZFRChnVO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319dfLJ3948870;
	Wed, 1 Apr 2026 17:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FS44tKqpgrPrSqxT4
	3CY6F5uHOjzNASQqSW9bEv+ZF4=; b=ZFRChnVOaHV95usT83JYsCdBQ0EMFt7tb
	hv2bF9MrClzBWg7CeIwlhDJxJtKyXWbAtb/Opo7LWHYqfY3+bKf8+c6I65jeTo76
	n/4oFHepH5IoKQIrNWIPsXGwid9uIVSmW+HfdWZCGGBfT6BQDHCGdBZBVF1ZjUWJ
	Gry0SuQvNooNA+GMHJ3glbY7cCLX6SBQXHcQbtk0IapjT8KdulhzzErllMp5VVgG
	LYFgd2WPS+QqzrtTEhdiHor8dD4HsiINoeBuu9ntOtzWRNwnWxfQg5riVul0t3a/
	WXmbpajgsycdcVYumRqDaijMj7FlKTzciLFl8Wz/ZGiMSsHi+RvMw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcgqmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:40:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631EhCBp021722;
	Wed, 1 Apr 2026 17:40:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6saspwgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:40:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631HdwoA59703702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 17:39:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EE9120040;
	Wed,  1 Apr 2026 17:39:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D274220043;
	Wed,  1 Apr 2026 17:39:57 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.24.224])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 17:39:57 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 2/5] KVM: s390: Add alignment checks for hugepages
Date: Wed,  1 Apr 2026 19:39:52 +0200
Message-ID: <20260401173955.314821-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401173955.314821-1-imbrenda@linux.ibm.com>
References: <20260401173955.314821-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cd5875 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=L0FeP2ZHASatk8IJKvEA:9
X-Proofpoint-GUID: 5myQG2D0trALsb34NemH2n8F1vVtAcVI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE2MiBTYWx0ZWRfX8wE3EKcTLszq
 rbaHH9BRBKNF++RAm9sZBnrJJdbvUW7ClZTfpoXLE2m45ZoKtNAs79aQI6cjqC/AQgcFlxXFGmV
 ZwzOAzvAKouXOdyECiXD/mCtRlVmfmFmdIWr2N1I4Pa/LDMKN/N4kqmnYUAozNyg1m0CD90oMSG
 xv21JAW70Hs3rKfJuMq+OgciIEeDTTDM4b97zUyazzgrrvTe7Wq59EpfT20YC8CSkelBq2DqkqK
 /amtXUhw793Y0BwGawdm9qFevckU+VTvIlaV+3zX/7NF4fi3B6QK+VeGztpupKm5iBhOxY9s32+
 jxviwNBCmaAPGzV3TpBDWnqrawnsOMSMExFqcnZMcrifOrPdi6yTuRKtZ2uCnKjBqv2+O09n1aU
 xeQA01ebksmZi1SJz+IIaSnWI28X3lWURSsgLSTqHlLVHXfbJ1UgwRYmobxw7pDkFoql9fCnPa9
 R/qNEeVRQjwTyTbNIrg==
X-Proofpoint-ORIG-GUID: 5myQG2D0trALsb34NemH2n8F1vVtAcVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010162

When backing a guest page with a large page, check that the alignment
of the guest page matches the alignment of the host physical page
backing it within the large page.

Also check that the memslot is large enough to fit the large page.

Those checks are currently not needed, because memslots are guaranteed
to be 1m-aligned, but this will change.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/faultin.c |  2 +-
 arch/s390/kvm/gmap.c    | 32 ++++++++++++++++++++++++++------
 arch/s390/kvm/gmap.h    |  3 ++-
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index e37cd18200f5..ddf0ca71f374 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -109,7 +109,7 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 		scoped_guard(read_lock, &kvm->mmu_lock) {
 			if (!mmu_invalidate_retry_gfn(kvm, inv_seq, f->gfn)) {
 				f->valid = true;
-				rc = gmap_link(mc, kvm->arch.gmap, f);
+				rc = gmap_link(mc, kvm->arch.gmap, f, slot);
 				kvm_release_faultin_page(kvm, f->page, !!rc, f->write_attempt);
 				f->page = NULL;
 			}
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index ef0c6ebfdde2..e3c1b070a11d 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -613,17 +613,37 @@ int gmap_try_fixup_minor(struct gmap *gmap, struct guest_fault *fault)
 	return rc;
 }
 
-static inline bool gmap_2g_allowed(struct gmap *gmap, gfn_t gfn)
+static inline bool gmap_2g_allowed(struct gmap *gmap, struct guest_fault *f,
+				   struct kvm_memory_slot *slot)
 {
 	return false;
 }
 
-static inline bool gmap_1m_allowed(struct gmap *gmap, gfn_t gfn)
+/**
+ * gmap_1m_allowed() - Check whether a 1M hugepage is allowed.
+ * @gmap: The gmap of the guest.
+ * @f: Describes the fault that is being resolved.
+ * @slot: The memslot the faulting address belongs to.
+ *
+ * The function checks whether the GMAP_FLAG_ALLOW_HPAGE_1M flag is set for
+ * @gmap, whether the offset of the address in the 1M virtual frame is the
+ * same as the offset in the physical 1M frame, and finally whether the whole
+ * 1M page would fit in the given memslot.
+ *
+ * Return: true if a 1M hugepage is allowed to back the faulting address, false
+ *         otherwise.
+ */
+static inline bool gmap_1m_allowed(struct gmap *gmap, struct guest_fault *f,
+				   struct kvm_memory_slot *slot)
 {
-	return test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &gmap->flags);
+	return test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &gmap->flags) &&
+	       !((f->gfn ^ f->pfn) & ~_SEGMENT_FR_MASK) &&
+	       slot->base_gfn <= ALIGN_DOWN(f->gfn, _PAGES_PER_SEGMENT) &&
+	       slot->base_gfn + slot->npages >= ALIGN(f->gfn + 1, _PAGES_PER_SEGMENT);
 }
 
-int gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, struct guest_fault *f)
+int gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, struct guest_fault *f,
+	      struct kvm_memory_slot *slot)
 {
 	unsigned int order;
 	int rc, level;
@@ -633,9 +653,9 @@ int gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, struct guest_fau
 	level = TABLE_TYPE_PAGE_TABLE;
 	if (f->page) {
 		order = folio_order(page_folio(f->page));
-		if (order >= get_order(_REGION3_SIZE) && gmap_2g_allowed(gmap, f->gfn))
+		if (order >= get_order(_REGION3_SIZE) && gmap_2g_allowed(gmap, f, slot))
 			level = TABLE_TYPE_REGION3;
-		else if (order >= get_order(_SEGMENT_SIZE) && gmap_1m_allowed(gmap, f->gfn))
+		else if (order >= get_order(_SEGMENT_SIZE) && gmap_1m_allowed(gmap, f, slot))
 			level = TABLE_TYPE_SEGMENT;
 	}
 	rc = dat_link(mc, gmap->asce, level, uses_skeys(gmap), f);
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index ccb5cd751e31..a2f74587ddbf 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -90,7 +90,8 @@ struct gmap *gmap_new(struct kvm *kvm, gfn_t limit);
 struct gmap *gmap_new_child(struct gmap *parent, gfn_t limit);
 void gmap_remove_child(struct gmap *child);
 void gmap_dispose(struct gmap *gmap);
-int gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, struct guest_fault *fault);
+int gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, struct guest_fault *fault,
+	      struct kvm_memory_slot *slot);
 void gmap_sync_dirty_log(struct gmap *gmap, gfn_t start, gfn_t end);
 int gmap_set_limit(struct gmap *gmap, gfn_t limit);
 int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t *gaddr);
-- 
2.53.0

