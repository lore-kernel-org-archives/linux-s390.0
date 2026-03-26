Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523BE3932E9;
	Thu, 26 Mar 2026 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531061; cv=none; b=jwxyu8tmLkZSrlWfYNS0rt+ffO3KzaWqPe6IjZ3xM8Mx1Xif+InEYP3nTTEXK4QKMsLl0B7T2MDCFgRA/Q19SeQB3B1pYhPTJPrXmqfSeRLzVYvjTguSqTqB53pxLJZeSP0+tzQISMezgpLYtNOjlNDsoYoaHoJdHuCfP6UQbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531061; c=relaxed/simple;
	bh=yLf16VTY8zHgbGWZObmkGq70ZNsvIQhI7H5el5ez5XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMtdz5KxNskmNvdNzTweZ4bsN0YShEabzh9Z+Cm1enWmc7CUC1IEijK/FshZAsRsrMOFGmAR+z1OmdB16/49snOMwnfW3Df8LkTVk2ztMZINT3l7Wej7emkKbibKPceEuUtJexz5g5AN8CEIkAiDl3X1aVqliYE9DbWBfapRSgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aQCreOS1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aQCreOS1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PMb9A7415280;
	Thu, 26 Mar 2026 13:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9YFviP9GfL+MtQpHB
	a/uSunbeI+6rJAMULnml9gWGfo=; b=aQCreOS1LsQHSLrPm36zSpqHknyEkejp5
	4xur7iLLelKdeT00oXwnDcXo0JyijPyw8H283zHpTsnhbDNCdeOrphpR2FGR6CQ5
	2FaRfHTlnLzwUtlnRJkDyn7aDPI6Okh2wmM38ZWz+akNLjGXOlNcYR/D/7yWRXpV
	mfYUTjXyBUOvL/ILKPciCB/ZGU+yFYfE4NDtAsNpUtUsYL6fOcW26KkXOg0dWwK0
	g8qlzVwxqEcJoHwtDshkL/r3jAm+KtfCmQUHEfpPomW4KLBL9LQaEN2cUwLUWBPP
	uLgCxFXygmD1ji8/C3B2fqevf6/gpLYWFE7lYjpNBHiPJqmyRcxag==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumvd74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QBhw1G012213;
	Thu, 26 Mar 2026 13:17:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vkavk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QDHWRs37224950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 13:17:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4C422004B;
	Thu, 26 Mar 2026 13:17:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6097C20043;
	Thu, 26 Mar 2026 13:17:31 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.23.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 13:17:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v5 08/10] KVM: s390: vsie: Fix unshadowing while shadowing
Date: Thu, 26 Mar 2026 14:17:17 +0100
Message-ID: <20260326131719.98229-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326131719.98229-1-imbrenda@linux.ibm.com>
References: <20260326131719.98229-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xm_dTDM1PNbEEUDndCoIkMOkFgEFE3l8
X-Proofpoint-ORIG-GUID: Xm_dTDM1PNbEEUDndCoIkMOkFgEFE3l8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5MyBTYWx0ZWRfX7uE7yiMfPL4t
 RIUQdU0BXLW0CHFej5D5AbdBkN+ggCIfQuA0ST8Ttg3XZYH3C1nQ4yzvJP/a21RBPfAefOv0kko
 sGsApmavVpyvWs2qpysd5V3S4qoa1awgn6+ud8P9X1oGrnkZCic7cZzB1mha/aj1tSTfrwRk2Jh
 6224Sqh4hfuKt16kg7kut3XocXxW3yMqZQalhdWqeHB67KhthtF1XXePIJ/KVCODhuDU9rYXoYW
 DmrZYaB2sif2xyjlVmn+y2Umzyoy5/+Ap4ueTr0JJGD3e7s4YTwMvHGwWFTj1PlsM/Gffaa3erx
 G9BaJnsT31L3DR3zOAHWKQN9m5AIaOsYWt5SMBcIjsU2u+K4Xw5Q1QCxok1A0npdaYR6lkE9fFr
 j2Mv1iCriH32UwNz6hauZy8LZdebpeHl+u0xBsM4Pimv7cAplsED/qyDDosjTbZF95LI3/YEf2a
 A+97E1zJzgGXnmVi0FA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c531f1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=bRHUIx8OYqRU_FziVQ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260093

If shadowing causes the shadow gmap to get unshadowed, exit early to
prevent an attempt to dereference the parent pointer, which at this
point is NULL.

Opportunistically add some more checks to prevent NULL parents.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Fixes: e5f98a6899bd ("KVM: s390: Add some helper functions needed for vSIE")
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c |  9 +++++++++
 arch/s390/kvm/gmap.c    | 11 ++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 6bc30f678921..8d99667e7d34 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1449,6 +1449,8 @@ static int _do_shadow_pte(struct gmap *sg, gpa_t raddr, union pte *ptep_h, union
 	pgste_set_unlock(ptep_h, pgste);
 	if (rc)
 		return rc;
+	if (!sg->parent)
+		return -EAGAIN;
 
 	newpte = _pte(f->pfn, 0, !p, 0);
 	if (!pgste_get_trylock(ptep, &pgste))
@@ -1476,6 +1478,9 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 		return rc;
 
 	do {
+		/* _gmap_crstep_xchg_atomic() could have unshadowed this shadow gmap */
+		if (!sg->parent)
+			return -EAGAIN;
 		oldcrste = READ_ONCE(*host);
 		newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, f->writable, !p);
 		newcrste.s.fc1.d |= oldcrste.s.fc1.d;
@@ -1487,6 +1492,8 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 		if (!newcrste.h.p && !f->writable)
 			return -EOPNOTSUPP;
 	} while (!_gmap_crstep_xchg_atomic(sg->parent, host, oldcrste, newcrste, f->gfn, false));
+	if (!sg->parent)
+		return -EAGAIN;
 
 	newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, 0, !p);
 	gfn = gpa_to_gfn(raddr);
@@ -1531,6 +1538,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 				       entries[i - 1].pfn, i, entries[i - 1].writable);
 		if (rc)
 			return rc;
+		if (!sg->parent)
+			return -EAGAIN;
 	}
 
 	rc = dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->asce, DAT_WALK_LEAF,
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index c8b79ad04ac9..645c32c767d2 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1160,6 +1160,7 @@ struct gmap_protect_asce_top_level {
 static inline int __gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 						struct gmap_protect_asce_top_level *context)
 {
+	struct gmap *parent;
 	int rc, i;
 
 	guard(write_lock)(&sg->kvm->mmu_lock);
@@ -1167,7 +1168,12 @@ static inline int __gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, s
 	if (kvm_s390_array_needs_retry_safe(sg->kvm, context->seq, context->f))
 		return -EAGAIN;
 
-	scoped_guard(spinlock, &sg->parent->children_lock) {
+	parent = READ_ONCE(sg->parent);
+	if (!parent)
+		return -EAGAIN;
+	scoped_guard(spinlock, &parent->children_lock) {
+		if (READ_ONCE(sg->parent) != parent)
+			return -EAGAIN;
 		for (i = 0; i < CRST_TABLE_PAGES; i++) {
 			if (!context->f[i].valid)
 				continue;
@@ -1250,6 +1256,9 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *pare
 	struct gmap *sg, *new;
 	int rc;
 
+	if (WARN_ON(!parent))
+		return ERR_PTR(-EINVAL);
+
 	scoped_guard(spinlock, &parent->children_lock) {
 		sg = gmap_find_shadow(parent, asce, edat_level);
 		if (sg) {
-- 
2.53.0

