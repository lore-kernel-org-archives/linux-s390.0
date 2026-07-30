Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823E446C19;
	Thu, 30 Jul 2026 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428847; cv=none; b=mYevObvx/SLKCyVO+nSRPEKpAOs2Ir4t7+MrS1G5BD3mewxxhrO+Cgkc26vh87Mb9H+HJLhYJ4OE0D7/vAZQqrkQS+uN2vi0pb80uol6WLf5qBkW3mkZ+C00y172jN63sKmnvwWKInBeWd/uU0h7+BNg0f+OULkb5AcYkfIiDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428847; c=relaxed/simple;
	bh=3FuKg1oXpih1Mf3L7WgcFzjM3MwrrUlyhNpe8uIM+60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBT5fMJb3zoNSODqJJABvBXIApwn7YUHtrakGXUPXtMB7JBFonOfSPSomCxt+kuUMiPLm0n8hCP4TMpjsUq7RMXFO+uOo9Q+fedLtuU6WQjVCCKVEc99j2vJ5ZXZvoU1Wl7Zq5Tc5Uc7KTkhKW3n2rQsZWi1yDaZzRxUwJGXOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sVjksZm2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sVjksZm2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFmCUc3425760;
	Thu, 30 Jul 2026 16:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Aa0SE1vv5WvDBFY3B
	gkKUeswHJ0BCNcuNfpbLpErh6w=; b=sVjksZm2C2YFaQI8T1laD/j19fIV5svrM
	R/wyw4+0VYPIstn73tWPIGob8wnruydTXtjIrWgBhQQOfl9w2qltoni9gwYFsAUU
	w/zLFaEbDXjw5tsBSatfC9MX3CBCD747/YC8+yFpLOZXf+Xn72p3bskIETDywu3O
	DDOz0xus91ZyNZRkjFnzD5QHKuDIBY9LmMTZZja23HiW/E1Xt08Pwut3x7RE9jAk
	LxXIGk/kU7uo0HA+Es/fq6oV+TyQs70ObwmPVJ3JJjbYqX+Ro2i5g+V68GZKyRmw
	IpCRDFPqojmUh9Li1Fy5ooVl0GaKnHZg3HC9hQIdC6rQXp9sL+fqw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7rs5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQUDT011327;
	Thu, 30 Jul 2026 16:27:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhm1vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRFqe31130056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C57262004E;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0EBB2004B;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 05/14] KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
Date: Thu, 30 Jul 2026 18:27:05 +0200
Message-ID: <20260730162714.133327-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730162714.133327-1-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0B-X1pZpPq8_M6SfU8mX_ftiY3N44oa3
X-Proofpoint-ORIG-GUID: 0B-X1pZpPq8_M6SfU8mX_ftiY3N44oa3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX6AMZe0U8188u
 +oheCe1KhL6syJ0KEYS+0HEzO32h3VGWCqCpAxpLdn1ndBjkz7Xu1hIjaVbUremENX+RKLZygdM
 01a0+g+QMq2jfRDg83tGhxusMLdOZnXkmTdqJDb/O37QZ6m/4BjvfBNqsrHBhf9bEOX5FZ4Tpox
 j61sIH1IxaVOqtjKArNIj3bb18G+la1KgXkVef4Kk3K4frFvy1qOQqJ8eWem0p5fZJ5nJ1nd9/v
 7rufu4C5XHaclNCgJm4ts6WCA+HzbAqq0EtY281q1Ac6V5KRRzOPmORea/af5lCeHwjKnVyTHMb
 Lmb88bP2Nb6ZAu+d2wQ7TUNPrru6gOlXlJiZ5JT2VBB7VBFzxI8UkuKTEKmrvAk2Tms84a8ZOUw
 PLMNTRYHm6qKumQ8YTBESFC62iNWmzqudbRwMBytmBnyecLqhzw90chvsqu/gSo6LsPsWN0zQB1
 1SAwNomo7xf0E9JMBLw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6b7b6b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=GvWetJuFWLgL5UM2GZoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfXy4cylahqaCGc
 RqNLyyEUN9l9AtZuluelpCHdanEX/O7cdYkZ/KS0mPUHt8XMlHgiV1/oodgFQdB1nTx3VMEeOOS
 HKFnzGTduBNbaCDKLbAT3Ts7y11NE8o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300123

If kvm_s390_set_cmma_bits() is asked to set CMMA values outside of a
memslot, PGM_ADDRESSING (5) is returned, instead of a negative error
value.

Same issue with kvm_s390_{g,s}et_skeys(), kvm_s390_keyop(), and
dat_reset_reference_bit().

Fix by returning -EFAULT whenever the return value would be > 0, which
is consistent with the behaviour before the gmap rewrite.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c      | 16 ++++++++++------
 arch/s390/kvm/dat.h      |  2 +-
 arch/s390/kvm/kvm-s390.c | 16 ++++++++--------
 arch/s390/kvm/priv.c     |  5 +++--
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index ed4259d17629..171b61959908 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -755,13 +755,15 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
 	return rc;
 }
 
-int dat_reset_reference_bit(union asce asce, gfn_t gfn)
+int dat_reset_reference_bit(union asce asce, gfn_t gfn, union skey *skey)
 {
 	union pgste pgste, old;
 	union crste *crstep;
 	union pte *ptep;
 	int rc;
 
+	skey->skey = 0;
+
 	rc = dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
 	if (rc)
 		return rc;
@@ -771,21 +773,23 @@ int dat_reset_reference_bit(union asce asce, gfn_t gfn)
 
 		if (!crste.h.fc || !crste.s.fc1.pr)
 			return 0;
-		return page_reset_referenced(large_crste_to_phys(*crstep, gfn));
+		skey->skey = page_reset_referenced(large_crste_to_phys(*crstep, gfn)) << 1;
+		return 0;
 	}
 	old = pgste_get_lock(ptep);
 	pgste = old;
 
 	if (!ptep->h.i) {
-		rc = page_reset_referenced(pte_origin(*ptep));
-		pgste.hr = rc >> 1;
+		skey->skey = page_reset_referenced(pte_origin(*ptep)) << 1;
+		pgste.hr = skey->r;
 	}
-	rc |= (pgste.gr << 1) | pgste.gc;
+	skey->r |= pgste.gr;
+	skey->c |= pgste.gc;
 	pgste.gr = 0;
 
 	dat_update_ptep_sd(old, pgste, ptep);
 	pgste_set_unlock(ptep, pgste);
-	return rc;
+	return 0;
 }
 
 static long dat_reset_skeys_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index fad605305e05..141ee7b9f019 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -537,7 +537,7 @@ int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gf
 			union skey skey, bool nq);
 int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gfn_t gfn,
 			     union skey skey, union skey *oldkey, bool nq, bool mr, bool mc);
-int dat_reset_reference_bit(union asce asce, gfn_t gfn);
+int dat_reset_reference_bit(union asce asce, gfn_t gfn, union skey *skey);
 long dat_reset_skeys(union asce asce, gfn_t start);
 
 unsigned long dat_get_ptval(struct page_table *table, struct ptval_param param);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 19ce7ebb83c5..de3cb6111bd4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -571,7 +571,7 @@ static int kvm_s390_keyop(struct kvm_s390_mmu_cache *mc, struct kvm *kvm, int op
 	switch (op) {
 	case KVM_S390_KEYOP_SSKE:
 		r = dat_cond_set_storage_key(mc, asce, gfn, skey, &skey, 0, 0, 0);
-		if (r >= 0)
+		if (r == 0 || r == 1)
 			return skey.skey;
 		break;
 	case KVM_S390_KEYOP_ISKE:
@@ -580,14 +580,14 @@ static int kvm_s390_keyop(struct kvm_s390_mmu_cache *mc, struct kvm *kvm, int op
 			return skey.skey;
 		break;
 	case KVM_S390_KEYOP_RRBE:
-		r = dat_reset_reference_bit(asce, gfn);
-		if (r > 0)
-			return r << 1;
+		r = dat_reset_reference_bit(asce, gfn, &skey);
+		if (!r)
+			return skey.skey;
 		break;
 	default:
 		return -EINVAL;
 	}
-	return r;
+	return r > 0 ? -EFAULT : r;
 }
 
 /* Section: device related */
@@ -2214,7 +2214,7 @@ static int kvm_s390_get_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 	}
 
 	kvfree(keys);
-	return r;
+	return r <= 0 ? r : -EFAULT;
 }
 
 static int kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
@@ -2276,7 +2276,7 @@ static int kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 	kvm_s390_free_mmu_cache(mc);
 out:
 	kvfree(keys);
-	return r;
+	return r <= 0 ? r : -EFAULT;
 }
 
 /*
@@ -2386,7 +2386,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 
 	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
 
-	return r;
+	return r <= 0 ? r : -EFAULT;
 }
 
 /**
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ad0ddc433a73..ea5a99537346 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -289,6 +289,7 @@ static int handle_iske(struct kvm_vcpu *vcpu)
 static int handle_rrbe(struct kvm_vcpu *vcpu)
 {
 	unsigned long gaddr;
+	union skey skey;
 	int reg1, reg2;
 	int rc;
 
@@ -307,12 +308,12 @@ static int handle_rrbe(struct kvm_vcpu *vcpu)
 	gaddr = kvm_s390_logical_to_effective(vcpu, gaddr);
 	gaddr = kvm_s390_real_to_abs(vcpu, gaddr);
 	scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
-		rc = dat_reset_reference_bit(vcpu->arch.gmap->asce, gpa_to_gfn(gaddr));
+		rc = dat_reset_reference_bit(vcpu->arch.gmap->asce, gpa_to_gfn(gaddr), &skey);
 	if (rc > 0)
 		return kvm_s390_inject_program_int(vcpu, rc);
 	if (rc < 0)
 		return rc;
-	kvm_s390_set_psw_cc(vcpu, rc);
+	kvm_s390_set_psw_cc(vcpu, (skey.skey >> 1) & 3);
 	return 0;
 }
 
-- 
2.55.0

