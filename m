Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13E42DA5B;
	Fri, 31 Jul 2026 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502917; cv=none; b=INgqLqgx/G9KFnAKk7iswh0ouPd2WJqUOtNnN14wQbp35r+T/uCkKqSgs0JafC5+9iVfkbrthNNWVLIndfQfHWz7K68WJL7+3qxsvCJJMJ638x4HwEojYvLW4AFBp32U8ewgk2yK6O1g6AUqnUz7bwVVRabzmjVHM4WovsIq1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502917; c=relaxed/simple;
	bh=6BvXJsYg00jRP6uWfhHCWlM8CF6XCRguWqBauy/PYB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obaiX6IL/8wL8fcFJ7urxEWc/HJlFpJaPRi8N5ZH8nuKBeChCXIBts6qiPT1c5vmgkcdnTzY/43f0CjnE3cDyenlbCoHObM3HHoZO24DtK36rdD5PLaZZi//hhpw3S7aVS8fbvscbfN1LZvmcHZwkbxWzsi+6oaquUNdcoHXbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bif0epfc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bif0epfc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmHbp1674791;
	Fri, 31 Jul 2026 13:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FffIEzQXrsNsbAmGp
	RELJwzpowdDByJB9nWkVuIUH5I=; b=bif0epfc9gI4Q1Yd4wPq+W+PdZOb/F0mW
	EH3MNMtoZmBYl5Yp89s/wWuBKe9rMIM1fl43+S4zGO9ECbJm58TqNeajRw6tfgKl
	5DZlhwCDL+jxsvT/FYHzC4/hIN8Tn7d8jMxmHUXQXpHoeMFGQuMNqHMvHfzau+Um
	7N/ADCkzM0tHi87/x2cEob6qt+0Ri/b56OXrVrbl9zKk6zXMZkKUYLw+HDuQF1WA
	+EzvoPIg8MLU4FQHev0TV4fwUY39SXcywnyyfylGvuYxtjyaGtc2pzDRAKvLET61
	PSGoSCfWirMJ4gCH6DFN6SQgumfwe5kB9AQofuZskixqojdntEsig==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p420h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuHFf023546;
	Fri, 31 Jul 2026 13:01:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yfp77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD1jMt43581900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:01:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B300A20040;
	Fri, 31 Jul 2026 13:01:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFD4920043;
	Fri, 31 Jul 2026 13:01:44 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:01:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v7 06/14] KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
Date: Fri, 31 Jul 2026 15:01:30 +0200
Message-ID: <20260731130138.173983-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731130138.173983-1-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXw92rNFEVCo1I
 oLBAJOYNX4QThlTGLux//6yoPsHnNloM3wBKl9/5YInVvRTT9P/wZUJAOugt1ZnJRbUN31Lz2mh
 6JYxQrOG/pjXIDUlWSdA/BVGKWBlU8w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX4FspcwP/7wC3
 rCFb0iMD5sc88ESUEZcv+8H5HMhzip7tC+25Ju4Fc2nIzqH9hCkm90h5AIKqeloDnUmyPzwlWQ6
 2v2785J3Y5Nzd2mNUODyGyzj+c0WTWj84HNlQBXMHFsCTdlCxKJcf2OAXmEAZnFqoD5hd+FosXs
 VOG7G6qWTsUFNx/zrRBo9EGvwltkjnUH7p8zoVRgh33cFErvcgvYtByK+YnN50dxg/eJ5epZyyz
 v1Nnp+UU4d2VaBNeWNnvIkG5ZPJ3ItuLxHZfKa/TC3ky+4oGrbxVPCl3yEKHnOUMzFBSkXWQhq9
 crTsudMMsXUBR6npGXt5W63For6ultDi/Zlek72Am+vvSn/ASvHjGNeMvNBG/mrPlZajlRu0g2L
 AEZtIndrvFeNmzH47cwnEtrs7XIUHz72fnYUTWOVclAwPAv6Sbb4yeyaauhqg6etSzOQNPH1WjX
 zraQZC4CfQRni2v+1mw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6c9cc0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=GvWetJuFWLgL5UM2GZoA:9
X-Proofpoint-GUID: oECl6dkHjoOLmJHDzojFGSJcdx1lXsg7
X-Proofpoint-ORIG-GUID: oECl6dkHjoOLmJHDzojFGSJcdx1lXsg7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

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
index 21574f57be72..e162efaa35b8 100644
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

