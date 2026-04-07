Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0E3C457A;
	Tue,  7 Apr 2026 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579258; cv=none; b=SJtp+w5lor4hvI8jWlOV7oMdECeHtnQM3Mzrbv2VsjOXza/E4EkSzks6zFoZ0vUfYNZ1yuCS/0bIUKfFAKBBPYtMrzXjjBGG0VLgHrwglFoq77VebfVYTfpOuyOuWEXKJ2Enwnb5kaaze0S1ooj8kkKycF7uvgeTe2fkNzS9L+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579258; c=relaxed/simple;
	bh=Bvl0Z0mJvZ/ZDGwEJTG07XT+RhEp+CTt+icr5RTAxO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAAmnfqZpibIvsx674xT/MVA4nJA6852CPSAA7OuavOan72q5d+o606Ws5ZFFgqrVelZ2iD+ZhU4hx7hoFb8mbD5tnGXg6mcZ6PnHzEgutTwG7GXMnBdgm/2WBumBHnJqySvIMaozl47S2VmNdhZk4YcWtq0XvOXTBz2lQGJwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lrF+LN1r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lrF+LN1r"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EEZbl2213123;
	Tue, 7 Apr 2026 16:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hqTLffEHUA/cHgOln
	ZDyaAx4UvpIycqi7E+CSnPZw5I=; b=lrF+LN1rVavZUf9cBUUitr/lkSZ7LF7mQ
	q17OsR2XpiE0Sq3H2PK9L4/+lQ3Od1xYkXgo0kjncS55B2N81nIK6RAilgFcYLSG
	K934QUJ125dwoMAnWwkPfy1F56vsHJEYAA1SUjC4tmuxFDoXJaPl+OE0RQMUCLGe
	NSIERewZwN4oKfH/Bsl/Fhp/R4fjMrgVc50A04vkA/TYgMUXklrjQibkAaIWEWJf
	AQV7ToCxCLhc1VA4UBY7RboPs2qPGUtOzfdNDuBS2wIgOCOINWn9UI78G1SiUWRh
	2dY9f20jBsoiAUioFzXgsCb6V4jQL5TtYpUH+T/OfeXVmgfrMt6Sw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hbpnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 16:27:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637Edrl7007881;
	Tue, 7 Apr 2026 16:27:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2bxyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 16:27:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637GRRQa28574252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 16:27:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADFD020043;
	Tue,  7 Apr 2026 16:27:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4941020040;
	Tue,  7 Apr 2026 16:27:27 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.78])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 16:27:27 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 1/1] KVM: s390: vsie: Fix races with partial gmap invalidations
Date: Tue,  7 Apr 2026 18:27:26 +0200
Message-ID: <20260407162726.252141-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407162726.252141-1-imbrenda@linux.ibm.com>
References: <20260407162726.252141-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0NiBTYWx0ZWRfX7vtFEjV9uhSn
 qXNNi1WFsFkh8eFZekWB18jYTBt4VQaoX4iyMCi9NiEPJZUIC0aFfJPpjSnarMZRzciLXr/BBTD
 5fD5SSV4pCqw7DQ+DUDVAe0ZrKN9Y1i1++XOoVi6TVnQt4sVfQLwHOlmUIBZr9nY9c44xSkGGED
 JuIE/9H1by6jel3aSsmOjvz0HDbfbyJH9zVbbg2C54QlkaS0r6ynKgd4N7gb0GBrXNy78RHfXd7
 KZXYDv1Xmm6CvJeZ5ENzN6EHm3PcCuYP3XFs+UyVP8qHP4ZD5q41QuFUFKtJgSyDYqKoWotgN+t
 MI38tSsDZht0KKA72+7CNUkVb6C8A1M3v8ZMAYEyWUY5ESLp0ODNLFRvxknd1NDcyN8+c7n+ixj
 nlcTm+WIRbNYqh+YmujdI7EjDNDJR2IeATOBKFtslohOhKtXymRwAXvuu/Ol3XFRIaauKHn16Dn
 2eAZFRFnihg+KG/+4/A==
X-Proofpoint-GUID: pLoEZrNw9JY6fwqWvvXp1Ybn4_9NnAWO
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d53076 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-C8uiT5To9FaDu-4sb4A:9
X-Proofpoint-ORIG-GUID: pLoEZrNw9JY6fwqWvvXp1Ybn4_9NnAWO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070146

Introduce a new boolean flag, used for shadow gmaps, to keep track of
whether the gmap has been invalidated, either partially or totally.

Use the new flag to check whether shadow gmap invalidations happened
during shadowing. In such cases, abort whatever was going on, return
-EAGAIN and let the caller try again.

Fixes: 19d6c5b80443 ("KVM: s390: vsie: Fix unshadowing while shadowing")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260407161721.247044-1-imbrenda@linux.ibm.com>
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

