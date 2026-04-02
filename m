Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5E3EF67D;
	Thu,  2 Apr 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142110; cv=none; b=iuLGMAhLEdb+2Cg6ivHhy+aLqJbOQ5uJoGsxl5fzmvAIgqx0MVsgjaPpae2z91VODN3E561fwjQkQ4dhr7x5Nt6bzFYixVUWO7hr10ACijAq5fhRqUZ3hGcAm9j/7LeX+xHht+ejnocKQmcwpW10ljOP8tFTZOdK9ZofqEoMzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142110; c=relaxed/simple;
	bh=EmPirQcevw+Nf/B/EQlvIHWhaoy0kaAz1B5Nyns08co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmJuGbGL03oVxoMykZ9VoKRK/nDBEJplM3cE1gAJ/S6DS1qWEXaixBQI7OhK6UxENONY1+MuPI+QKQDtUeEfOdqVZk0n8AFd9DtKh6dpRZam1auJuI0gVIeQyyOqe+YtYy/J9aO/ghcSDnJhoXouQB4WQx62E2YzVoqm08UH3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TdQT6wK3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TdQT6wK3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631MVUYo4036177;
	Thu, 2 Apr 2026 15:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FS44tKqpgrPrSqxT4
	3CY6F5uHOjzNASQqSW9bEv+ZF4=; b=TdQT6wK3OAubywbBd22vsoCYc4CKTZQ5e
	YNp/E9w9u9JabUrBLl2l212JadcImXFYMV6tFuPgIQI2wt5YRFAM8pm4n86B01Jz
	mH73bUb+V1hztLPwxLD35HQftyqbrQvY2k14F45YbeeUFi61oVFT28YbnJ8Q+hIJ
	4Dy6k7ZlwEvPjbYFEgF8oZaeM6hSQnzKW5cgHb9dNo9PCGlo8Hk4JU6dxpep35E7
	j800zDeZQqtLN/uWobDo/0tkAnLq/Se430stuniV/q2uN6GXev0Mz1/mlSaa5TCa
	Kgx8rgfEQERgXC7LV2ZMU4fIZq/O1oq0+gsQtgeobM1WFjXjdC2XQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66mscbhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632BMugV022165;
	Thu, 2 Apr 2026 15:01:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tanaec5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632F1cN628377586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 15:01:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A9F520040;
	Thu,  2 Apr 2026 15:01:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8477920043;
	Thu,  2 Apr 2026 15:01:37 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.129.177])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 15:01:37 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 2/6] KVM: s390: Add alignment checks for hugepages
Date: Thu,  2 Apr 2026 17:01:31 +0200
Message-ID: <20260402150135.196943-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402150135.196943-1-imbrenda@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ce84d8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=L0FeP2ZHASatk8IJKvEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzMyBTYWx0ZWRfX8KM4s4FTMTxh
 bLh4XGC2pMCcxZtH4kxd+5EaEP3ZP6Syo5BLJAb2DB0NdT7BiTmTDJFKEzx8shvzlRrvhOvt8kH
 CeiDnIfWTTouzz5IUpy4aatYxC/DB45y3gWjoYC3rOmqhPhjRi6lrOP06JE6gyUS33k7GfKcheQ
 8ehu+gYtjISfH1pSDRzEjhouYa4UoNiGT29Ml9XbJ5EfMqbrlzq+G9GWPeAmHVrRfkjofbEeR1S
 PEih8RofFvrl5TvfDlVlzh5RFUD8g6SwLQdWK4wHsW+IFF8svq2XXQUaTZaSztBexxv+pzllg+/
 P7zS09L63iPWoMyg4MxRn7UZOBKvls6QYW4Xh8u49R17k99SNMVnbOHu9owC490b5VGq0EuLAHU
 EYR65otBOHYZ1e6psjKM2mog+E+Zww==
X-Proofpoint-GUID: 9DyDnfyf5weZViLQOUsuOjxeuqyvZ0FI
X-Proofpoint-ORIG-GUID: 9DyDnfyf5weZViLQOUsuOjxeuqyvZ0FI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2603050001 definitions=main-2604020133

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

