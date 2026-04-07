Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61235F8D1;
	Tue,  7 Apr 2026 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578660; cv=none; b=piuqRY2HFchci09IxkOH/VmOYTHuMjRVSgfoCPilZRLD01l4xhh4f0MtkD4Ie27YcmFaJaj5mPx3bp32juLItRcKad9COoDGTB9HwSVgG1Hg7E/QY+XiCBUy0jh0JGeZhgN4ju3XqmRP3dSnKLnAUcMI588lQq+p7MOPAg6RVEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578660; c=relaxed/simple;
	bh=5k/h7oW7UpWno9nkbdE8z7QzFwr54wYIqPgdqnvqr5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hrPD4swC5XHGgORuYEjrNp4izh3r5AIs1+BwiWur/Lqepf8EB7W85F4cEbICU4MjiESs0wW6033zsnnAYHju6nW6d2mW9f4EMFngAas/lYInwe0pBsiA5ALpq7hSjMN3uvjxSINyHVriGjrhHBThrKfCpxESpcwzV1AZVPjvjyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZoekPp59; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZoekPp59"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637E9hVr2210127;
	Tue, 7 Apr 2026 16:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VLx6P9EZiJAILV7jTLobvDdD30pFMbIvOCiwaZFPD
	To=; b=ZoekPp599EHWXAicGW3yl+9y/f2Mvt4+lDh8irMvpI+4x9zFIwe59C4kQ
	IHtgdjrZE406Ktv0MZbR39r70OgxAF2pJttOcPnfE0Vc6vIuwc5tuPE4CauNuqXb
	PU1VFGJYYMb1ihRfxbVg1416r23wkRkPUi3ViUumlXXJbcYnU1qX/h47qxJP+YOv
	J2o5w7i+jdL6qBURz1nkbCiOYme8hhlBn2ViPGNgap75lIyETvEBm30tNCgRgPj3
	VlgDQSrw2DmdW7EzQv/qH6Dvfhy+/d73YqKqur2Zv1q+hP5PTnrTRjw5+QeTys+f
	+0kRzeQDfkD9EviDGo4CjR2Qwx0Nw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hbnft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 16:17:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637EWETU030062;
	Tue, 7 Apr 2026 16:17:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7bx83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 16:17:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637GHMVh19202442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 16:17:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98CC82004B;
	Tue,  7 Apr 2026 16:17:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC1D220043;
	Tue,  7 Apr 2026 16:17:21 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.78])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 16:17:21 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 1/1] KVM: s390: vsie: Fix races with partial gmap invalidations
Date: Tue,  7 Apr 2026 18:17:21 +0200
Message-ID: <20260407161721.247044-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MyBTYWx0ZWRfX1GPv+0uqSmvK
 ctMg8HT2elJHyedl1ffdxjp6axGDn5dtvSaVlPfgC4c07tK7egewJ1qTCRSNBuvNxQ0xZi4Ij5U
 IFt5P24ksBFLJf33lL1rbbS+sj6wtlbGSH+RY0jcWb3VKn53gObRS/z9RSiMUnEX2wDanrSr9fj
 HCD6SM09PhK0Z2sLXqVOKcUQZZu46tZ9jKXOq5oArO8RjI5rFIBX8Nm/jvkYADct3ifRrEPVAmp
 qb3HIPQqPIMdKhD41I9FMY2EOgyhIS3O6NRiVTp7KGEIQKlfECJi1ykJ+hEJjg8hZqiI0msu7pY
 aL+1PBPuLWAm5IKkW8CWeXQE+4BUvw3eYEysM17JcQirL7qAYUkx5UO5WjELwIQMkQUiAVoLd+K
 wmP7WN58g7U6asxUlFmTbqvrweaDZiwmedf/aKvRQesbZMSZjrSXnA2mx7hhEE55GtrFmoPYLwk
 dr4lfgR42jXHcqyCc2Q==
X-Proofpoint-GUID: m0KE56X3TkRM_SKN-W6kMOed18U8rHyv
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d52e19 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-C8uiT5To9FaDu-4sb4A:9
X-Proofpoint-ORIG-GUID: m0KE56X3TkRM_SKN-W6kMOed18U8rHyv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070143

Introduce a new boolean flag, used for shadow gmaps, to keep track of
whether the gmap has been invalidated, either partially or totally.

Use the new flag to check whether shadow gmap invalidations happened
during shadowing. In such cases, abort whatever was going on, return
-EAGAIN and let the caller try again.

Fixes: 19d6c5b80443 ("KVM: s390: vsie: Fix unshadowing while shadowing")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 9 +++++----
 arch/s390/kvm/gmap.c    | 3 +++
 arch/s390/kvm/gmap.h    | 1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 53a8550e7102..290e03a13a95 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1449,7 +1449,7 @@ static int _do_shadow_pte(struct gmap *sg, gpa_t raddr, union pte *ptep_h, union
 	pgste_set_unlock(ptep_h, pgste);
 	if (rc)
 		return rc;
-	if (!sg->parent)
+	if (sg->invalidated)
 		return -EAGAIN;
 
 	newpte = _pte(f->pfn, 0, !p, 0);
@@ -1479,7 +1479,7 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 
 	do {
 		/* _gmap_crstep_xchg_atomic() could have unshadowed this shadow gmap */
-		if (!sg->parent)
+		if (sg->invalidated)
 			return -EAGAIN;
 		oldcrste = READ_ONCE(*host);
 		newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, f->writable, !p);
@@ -1492,7 +1492,7 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 		if (!newcrste.h.p && !f->writable)
 			return -EOPNOTSUPP;
 	} while (!_gmap_crstep_xchg_atomic(sg->parent, host, oldcrste, newcrste, f->gfn, false));
-	if (!sg->parent)
+	if (sg->invalidated)
 		return -EAGAIN;
 
 	newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, 0, !p);
@@ -1545,7 +1545,7 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 				       entries[i].pfn, i + 1, entries[i].writable);
 		if (rc)
 			return rc;
-		if (!sg->parent)
+		if (sg->invalidated)
 			return -EAGAIN;
 	}
 
@@ -1601,6 +1601,7 @@ static inline int _gaccess_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 		scoped_guard(spinlock, &parent->children_lock) {
 			if (READ_ONCE(sg->parent) != parent)
 				return -EAGAIN;
+			sg->invalidated = false;
 			rc = _gaccess_do_shadow(vcpu->arch.mc, sg, saddr, walk);
 		}
 		if (rc == -ENOMEM)
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 645c32c767d2..0111d31e0386 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -181,6 +181,7 @@ void gmap_remove_child(struct gmap *child)
 
 	list_del(&child->list);
 	child->parent = NULL;
+	child->invalidated = true;
 }
 
 /**
@@ -1069,6 +1070,7 @@ static void gmap_unshadow_level(struct gmap *sg, gfn_t r_gfn, int level)
 	if (level > TABLE_TYPE_PAGE_TABLE)
 		align = 1UL << (11 * level + _SEGMENT_SHIFT);
 	kvm_s390_vsie_gmap_notifier(sg, ALIGN_DOWN(gaddr, align), ALIGN(gaddr + 1, align));
+	sg->invalidated = true;
 	if (dat_entry_walk(NULL, r_gfn, sg->asce, 0, level, &crstep, &ptep))
 		return;
 	if (ptep) {
@@ -1174,6 +1176,7 @@ static inline int __gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, s
 	scoped_guard(spinlock, &parent->children_lock) {
 		if (READ_ONCE(sg->parent) != parent)
 			return -EAGAIN;
+		sg->invalidated = false;
 		for (i = 0; i < CRST_TABLE_PAGES; i++) {
 			if (!context->f[i].valid)
 				continue;
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 579399ef5480..31ea13fda142 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -60,6 +60,7 @@ enum gmap_flags {
 struct gmap {
 	unsigned long flags;
 	unsigned char edat_level;
+	bool invalidated;
 	struct kvm *kvm;
 	union asce asce;
 	struct list_head list;
-- 
2.53.0

