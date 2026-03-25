Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172283FBEBF;
	Wed, 25 Mar 2026 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458803; cv=none; b=rRU3k7+qny7t366W9wDLvcOFaIGJ3yFiiwcVf+HUGBPfGDr09gl8iJQK4jnbY6GTKcaiCtEX6AhRxe3W2oOqvyoW7zcbSLRrDO62IqsuqO9MgqHa9vr6RsEpDQm2ynrglNL6UxtWskcsn/IjX0FFc3twMpPi28zaDtVRuti4lvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458803; c=relaxed/simple;
	bh=fT8kuQUNTcFvgYxXyH7xCJKkML3OI/fwUx81PVutaXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHzKkc0b3oKjgnwerxmXQwb1VDHOmDSUKVyDdAF3h32XCicsu1iuzr2KxzLW8rPQaYSlAboqo09Jlxh8k+Cjwr/9MQBmGpHRujH8QcFF4iTVNh8Ya8KIbEKgRIp1MYx+J7C2Hv1Oskk9DxRGcH5F3y7zvBk1vwK2tsK5xK/DMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G8yWlfNu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G8yWlfNu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PCNxEZ657656;
	Wed, 25 Mar 2026 17:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uTY4JC4uePjsunCjP
	OFbLJv6BlIVgSM4Oskc+97kd7o=; b=G8yWlfNuaqwRdK7RmJ52p9prxdfkZnW8g
	DtuRtMA3e0ow4+askGQ/geitnil6SikkTGD6/vB3hDMoztl7ONCvh+RVKNLwIkjz
	ZZ50/RBUjIb8aWkB3FJmJuMSDIu4YKoRXdAw/ewvz+8RGk50E8VelIabdxmyKbIR
	e6vmWwRsWlyi4/zkcDgfHm7TGNm2J5a2Q44sivbMTE4lfr9t01JI8ysFhaJZlOgE
	cdAveSz1At0P5milx2yYjQYHbQBt4USsbvYfDfmaiqAl6WRMz7hH1Lf43EkIic02
	u48uJZm5WczMEzt/Hf2qxAfl+k4Uqs8GTvpeRWWegxVgmSMdpuHCw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumrs7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PF1ltj005964;
	Wed, 25 Mar 2026 17:13:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yqjwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHDEvA51839414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:13:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D6ED2004E;
	Wed, 25 Mar 2026 17:13:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D63EC20043;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v4 08/10] KVM: s390: vsie: Fix unshadowing while shadowing
Date: Wed, 25 Mar 2026 18:13:09 +0100
Message-ID: <20260325171311.182210-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325171311.182210-1-imbrenda@linux.ibm.com>
References: <20260325171311.182210-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Esu-TKNJiZE070vHugBytZPEi62e_Q0R
X-Proofpoint-ORIG-GUID: Esu-TKNJiZE070vHugBytZPEi62e_Q0R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyMSBTYWx0ZWRfX411TuMWCRB3M
 GJgYKpempwFhCjXAwv5UwQde75lQJBK0loOKgKQjQzHCp7xneaaY4FcY2w+pIJdA5KR5g5Nqu/8
 xngHvrjYBKerpZgccGvcfB4T3yHvxI7v+TxyFPkJT1FexalGkUX8x+VgkL1pIeKZCV5aSJU4gyE
 ME0soYKr0VR005wo4zTWN+Pam0Y4WThsY6fzRVQVOZaY1UFad3Ihyv/mgYNzeDY6rNxY7ErFg2b
 2tW7Vj61ECCs3BpBJ979XhfNCqYfSDqvJrc92oj+YChnTxVvycnCBSFUsSQd6Rx4PAOosFZjLIv
 X6Clp33GmOZhJiRqMZuKMyfvwBKHkIGKIjUtPByQSvxMA2r8DEXv+0oQkIeqs3IQWtj/o3wM/+L
 cI8gncaZNHwRqfDwSdjLdV8EW0dFYGekS0QiYB3xOE/FL4yQvfz588OfrJInp5PgMR9juw3kZS8
 vJrmyP+3EvmdcG+VJUA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c417ae cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=rP4LS0jab8kgWfQMVEcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250121

If shadowing causes the shadow gmap to get unshadowed, exit early to
prevent an attempt to dereference the parent pointer, which at this
point is NULL.

Opportunistically add some more checks to prevent NULL parents.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Fixes: e5f98a6899bd ("KVM: s390: Add some helper functions needed for vSIE")
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/gaccess.c |  5 +++++
 arch/s390/kvm/gmap.c    | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 6655c214f2d7..d14c2b40a5f6 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1472,6 +1472,9 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 		return rc;
 
 	do {
+		/* _gmap_crstep_xchg_atomic() could have unshadowed this shadow gmap */
+		if (!sg->parent)
+			return -EAGAIN;
 		oldcrste = READ_ONCE(*host);
 		newcrste = _crste_fc1(f->pfn, oldcrste.h.tt, f->writable, !p);
 		newcrste.s.fc1.d |= oldcrste.s.fc1.d;
@@ -1527,6 +1530,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 				       entries[i - 1].pfn, i, entries[i - 1].writable);
 		if (rc)
 			return rc;
+		if (!sg->parent)
+			return -EAGAIN;
 	}
 
 	rc = dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->asce, DAT_WALK_LEAF,
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index e9fc471a5141..b19020470b13 100644
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

