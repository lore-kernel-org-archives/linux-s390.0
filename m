Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD0318ED7;
	Fri, 27 Mar 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625054; cv=none; b=bhqtdNXrTT8Kmu5TQ2eTWNpPCNyeZWOZ6jkBeygOVaiFslo7puX/xae5NGCC+YGQuLv+d09OmrKBLTVXLbn/txCVe3erAnh0JE+EIp1wFnLabUdS8A31bFEaKhNgmpe9VFJkgxBWp8JDs/fo12v1IRw+4bHdHUmrQS7XSS9zy9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625054; c=relaxed/simple;
	bh=Vmhjqg6NRRMblIlJpX3RL7yRTGJ9/RRuTztl++q1VLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR0pfO0+cmpcbIDoyAotepbWVv5u44GHZxjsMD8i23e2KwDY8oNHCPaLRw3Xn0lZT3K8gc+fx0L/zw84l5io6QKOdABkfx2DL4CdPmTs6SIGGnZ0d/bVA2s0KDgGbGhCOHiY0cU6vmBTwh8KRh4chGyZaNjPk4gYcYX7Iu/aCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZFRM/wCs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZFRM/wCs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R44T413340564;
	Fri, 27 Mar 2026 15:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Mf6kQmeUP2mAHxhbc
	3L0X9L6/VdiOPzrR018plM0yAQ=; b=ZFRM/wCsWMW+OpQa9AUf4lhlslzSQS2Qb
	9a2qeNStksF8MvyM7zqS7u6gzEKz+w//u9PwKJH7V4FQrabOxXJb1nPSPIZT00rR
	PBiCrMqu+IRYCkLUC11cSIOctpjTgA+f5G61pACQCGgtYMxY+dGqj0r2J0Kep2iM
	Xc1iEipJVmFiXtlCEea7sfPUOm7Ly39uhxmvS7jZOuCnBKxsUC2yAxe1WelKcIcV
	S8nyrKGfmNrpr/hIquRgxOvr2sjHQ04nDd97lHNtiH0GHGqxJrwRtieb14LFbHFj
	vCwRzrt+c6xFm5cAfvbdgBoPKLfdTG3G/jwVr05p2QqLbNE6FDsCw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0hk28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RB8evC009115;
	Fri, 27 Mar 2026 15:24:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26np0195-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFO42L30933616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:24:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F86920043;
	Fri, 27 Mar 2026 15:24:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 871EA2004B;
	Fri, 27 Mar 2026 15:24:03 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.84.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:24:03 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 08/10] KVM: s390: vsie: Fix unshadowing while shadowing
Date: Fri, 27 Mar 2026 16:23:54 +0100
Message-ID: <20260327152356.250625-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327152356.250625-1-imbrenda@linux.ibm.com>
References: <20260327152356.250625-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX1zQnqSERTivB
 cqYwswUD1i0a/LKzsaMzq4kT2wFkPU3Ta8cbiIe3MZzSY6RrnPEmEcwqbAYTQD7LFuP46YaP2Nh
 u563ppml4NwFoDQXhqebBPUUSpuTAY/Ap6u47QEbc4KcFRWb51UR6s7LW712P2gvB7knzSd9tPw
 UgTo1vsUuxF1YZZvRqzSijZ1Ch0cr+0uEH7LnK8b4dydCmOVZpnK0GVKLIppsIIGph1VvKTS0DR
 9TSbzCyJxc/OhfuwG6kUINULeS/cd1EVU0SFbjPbhcnfie6vvaGWc6GQ6GSOgvqwqFySCOT3eHa
 WpyqjLODwDlVAsSLQujiNmgcCfStQqpPuuGVDSowcVvWXDVmkfIRcWVwsgycCLhWWub/PuDLeTX
 qSu26jVGhIqJEJpLD+FhMAmy7yr/iT/QuDLXi/yDIhI0je1G8exoXekaGo2iWTmSGv6WpYwnuHk
 Orno07IFjAiVaatW01Q==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c6a11a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=bRHUIx8OYqRU_FziVQ0A:9
X-Proofpoint-ORIG-GUID: Y08tFoNUaJbRxiqejaxsNreb3vUb531f
X-Proofpoint-GUID: Y08tFoNUaJbRxiqejaxsNreb3vUb531f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270105

If shadowing causes the shadow gmap to get unshadowed, exit early to
prevent an attempt to dereference the parent pointer, which at this
point is NULL.

Opportunistically add some more checks to prevent NULL parents.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Fixes: e5f98a6899bd ("KVM: s390: Add some helper functions needed for vSIE")
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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

