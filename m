Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF63090C6;
	Mon, 13 Apr 2026 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077279; cv=none; b=rvjz9q1q/bmeShXJNOKQGb6MCk0pDsz70ESZbWbdKVVH55QWkgThAOx2z4YSdz9JOfjhb1yE0/OqappnmtzF17Ov7Op7YcqHPFGIQLiEcv9vp26Rt3ZY0QE0nKTNvfZSNVH5Q8P065p72OUEROISwTT1Zzz1rZKPJahNf6VIIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077279; c=relaxed/simple;
	bh=xtAors0XMBHptVkAvyc0shGzDwIQ+uy4xsFIcvjx4ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZLiGAtWLVToa9WDk5S3SaHWJ8FQTW8WN0bTYHKEXxDfHQ1Oy8bBdi1RGClv8ZaKufrxHoD3X1P5MfgdM+kKZhWokhzwCByho9XAK1fORCXSTc//Y/IextthX92zB7043iDlg2EOOvpVcAeZNu/suxAg+k4UrgAnr3EtzoRD1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iJByruu5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iJByruu5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D6IZ3Q1130290;
	Mon, 13 Apr 2026 10:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8ecKh6ErANXgerYc1
	5KtapXQbFeGX0+5NndsrRgf8PQ=; b=iJByruu53LsshtzuxzoyTH1EKA0lkrgsf
	R8vQ1k0pvqGkBtwBrZEH+wlS0eyrm4YxPh2Wjov8QA1OfU7D7UjI9u9rz8vHkaSN
	qNQtmEIp/5Suh20vOC+gHmX3RkLo3L32uqgbJzI1DWsBOX3dRgDZYEDLtqO8quh/
	04awABEhJ05wWQkBh94b+stymtvwxMpI7GuFqtYb14NCOpR4JVIvq93SDvtPh0Wm
	IN8eaXp4UkgsuyVzu2yRtW1sFqDhtiORGoTHlb67NZuiS3pZWdeTZ8gZQWexJeXV
	4pzluGz/Dd5UcPgWRMuTNsKx8u3qp4gDt5XKLYU/y8Ekk+xPa0laQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfe17q6tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D8u6ia003586;
	Mon, 13 Apr 2026 10:47:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn4se0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAlnlY38142224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 977DE2004B;
	Mon, 13 Apr 2026 10:47:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C2E120040;
	Mon, 13 Apr 2026 10:47:49 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:49 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        Steffen Eiden <seiden@linux.ibm.com>
Subject: [GIT PULL 08/12] KVM: s390: Add alignment checks for hugepages
Date: Mon, 13 Apr 2026 12:46:36 +0200
Message-ID: <20260413104721.203024-9-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104721.203024-1-frankja@linux.ibm.com>
References: <20260413104721.203024-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNiBTYWx0ZWRfX7BEa0eMxl+mC
 OHT98pgj0sy3690EpYKFqAggkZdK2+AW/NWgnD3C6VVvTUPr20zgRsAqqAN7Sa979k0ksfesHyJ
 wRLW3Ta2eDqwBDx4wdz7UETelqYSqAMNEoSUKl6lzP9jxpLO5rB8b8Rg6Qs6CaRLmttqTNhdsLo
 8y+fGZetELPTQ4pHN3NvQq80Z2YXO1QY+e0kp/iHwx3nrW64WvhVgCa1IPqZiWU5+o3jEezWSI5
 LGTFHroyMrm/g5BAfcHS4F1pMg2GH0oARslLa+ftWi96FJvmWLmcJMw7F9YqSd9ZbTD8PNoCN7u
 bMsC9SL+iFMpY6/aClxvCT2CWwGVzH52XHq6ic40FHezkntZzCLFSAMd08vEfTTWM3KnOQY6vPD
 nWlExvvlpm35mMJ34eRsd1bNNF3CVMNdZbIJN+uxQtmK3nUUaF3vtl+WoE7yyQrwqJkq7s2Kdpa
 OaVX6mWwMunzincfJGw==
X-Proofpoint-ORIG-GUID: jWlYTqPweaHoG3yjRPHbIGSJMzwujh1J
X-Proofpoint-GUID: jWlYTqPweaHoG3yjRPHbIGSJMzwujh1J
X-Authority-Analysis: v=2.4 cv=SrOgLvO0 c=1 sm=1 tr=0 ts=69dcc9da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=L0FeP2ZHASatk8IJKvEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130106

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

When backing a guest page with a large page, check that the alignment
of the guest page matches the alignment of the host physical page
backing it within the large page.

Also check that the memslot is large enough to fit the large page.

Those checks are currently not needed, because memslots are guaranteed
to be 1m-aligned, but this will change.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
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

