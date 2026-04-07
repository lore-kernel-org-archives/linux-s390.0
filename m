Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF421018A;
	Tue,  7 Apr 2026 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570878; cv=none; b=Kw3tdExgYA5BC9C9KjOHdlZpdcOh4uAaXC5rbtp0tYGqsO1W4ihUk8R9DHGNRnhxuk1LmuHnCC51PYaxIuIaAfhXKd0UGVNSUbh5bLlkvSJcuZb8nOg87SsQAVjztO5avF9uJe+Cb51Z/Efw/AOyQfWrT/C++9GjUAo60ovd66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570878; c=relaxed/simple;
	bh=le1F3GHBd1Mu4JQihhFSiGna7F/6ravaqOBRfUwZAs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iqs0xEphXdyV+pAxd9Tu1ZdSsFe9VLjAg98LtqH4DG3qdxqG84PajJlfGb+72m3CdMy+Qfp6xFh4xxkDh5uzATBqyXdrkPQgW3S1lXzcDst/ypMroVuGjWlG1OwzNxvVxKGnFQAr7R4K4hjGY+OWuLnR1pfaYZhzGXqJhN1ZCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=skYnglZr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="skYnglZr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LlmLp2297424;
	Tue, 7 Apr 2026 14:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vWxgndwgJ5UFn1NT1GVnPigpuSWFlaAGaBA1mtvRi
	YI=; b=skYnglZrZ3AxYgpf9oUliIr4M2396FcVh6Pbkrdu+RDCppouIjv5bzjbD
	jpI8ek3Ht+C6nCEUO483hIZpiDO4PUEwXNS8QxbQ5f1s65vXKxizqQWBYLcZ5Cdp
	HlFhgjPW1CHafv5H1Q/jto3E6wMgswHMTQ0Qz2Caji5BgY9DSBvvNctdH+nZXS4e
	uLtlGkqHlqhN+9yuX10rm5Ot9T8lO1yQhOCqY7JBPS0vC/rRf0ma9H20nAAoRZDL
	F3FEYeVQ8oNSRhRXV3uKjv6ygpBwm0ggn9sWWDQ2jYJFRjyXd+/QpwK2JhTq0cBb
	ZcAH8G08AMIB1T6LMFkL3akj2crsA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fu2vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 14:07:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BJMQ6013821;
	Tue, 7 Apr 2026 14:07:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf43fav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 14:07:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637E7jX731064632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 14:07:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AA412004B;
	Tue,  7 Apr 2026 14:07:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CDBC20040;
	Tue,  7 Apr 2026 14:07:44 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.78])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 14:07:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 1/1] KVM: s390: vsie: Fix races with partial gmap invalidations
Date: Tue,  7 Apr 2026 16:07:44 +0200
Message-ID: <20260407140744.186879-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d50fb8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=awAvmdA0sdgCcS50IaAA:9
X-Proofpoint-ORIG-GUID: CxnK2dsxs8LzhmivOPJ3WEvCkP7f4Jmi
X-Proofpoint-GUID: CxnK2dsxs8LzhmivOPJ3WEvCkP7f4Jmi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyOCBTYWx0ZWRfX5ZtBDdsqYU5C
 ztjgoZoVs3Bxn4A4WPtqbZc6Tg3c8Kuc5gtPlA4ZnectSwDgbjzEFIbXZojj/jXTgsHH6yaWtl1
 ANgpPyR1Kjd3R9H9PAmc6lepNkeb1HEN2ZIjvCe763U/zQRRFSWeYIenQu4DDF7IAcpyKov2lHs
 dno1r9suqSa/1lFXV5B3sk8efNooLIdOpvIoboLacwK1BIYZ/Txmrh4aUbN5ckYdqpVKwaT2c0b
 RpJC0/UIpWuBrnvBNSNwQSl/SKB3EjQj5BUeBxkNCHtOXD8xh8iDjsh4VFZbEYkAoBm+f8ICXE5
 zcsMzsUO2xStbqVm4VSbIFn+UCPFLL5Y8ObtNI8p+/NJmBPZ9g+vKPrbctQMLNMCzLZc30ONojo
 CjW/OHhZSIDRMIawu6tpK9KyuNsFqoPDj0NvGf1GTl8P0imu9VsxetKziAd4mmGmGUTGskZsAuv
 cQxwcNbL0cRrHK8qI9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070128

Introduce a new boolean flag, used for shadow gmaps, to keep track of
whether the gmap has been invalidated, either partially or totally.

Use the new flag to check whether shadow gmap invalidations happened
during shadowing. In such cases, abort whatever was going on, return
-EAGAIN and let the caller try again.

Fixes: 19d6c5b80443 ("KVM: s390: vsie: Fix unshadowing while shadowing")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 9 +++++----
 arch/s390/kvm/gmap.c    | 4 ++++
 arch/s390/kvm/gmap.h    | 1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

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
index 645c32c767d2..57802cb8af8e 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -181,6 +181,7 @@ void gmap_remove_child(struct gmap *child)
 
 	list_del(&child->list);
 	child->parent = NULL;
+	child->invalidated = true;
 }
 
 /**
@@ -1074,10 +1075,12 @@ static void gmap_unshadow_level(struct gmap *sg, gfn_t r_gfn, int level)
 	if (ptep) {
 		if (READ_ONCE(*ptep).val != _PTE_EMPTY.val)
 			dat_ptep_xchg(ptep, _PTE_EMPTY, r_gfn, sg->asce, uses_skeys(sg));
+		sg->invalidated = true;
 		return;
 	}
 
 	crste = dat_crstep_clear_atomic(crstep, r_gfn, sg->asce);
+	sg->invalidated = true;
 	if (crste_leaf(crste) || crste.h.i)
 		return;
 	if (is_pmd(crste))
@@ -1174,6 +1177,7 @@ static inline int __gmap_protect_asce_top_level(struct kvm_s390_mmu_cache *mc, s
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

