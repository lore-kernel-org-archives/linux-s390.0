Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30094409273;
	Mon,  3 Aug 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760856; cv=none; b=MDveJljNHaEnvjJ0isNvZoU4FCxzQH3q3CncIUZm0zgQN1BwXAJf8F716GLzZ48a6G/tguFCAfL+mRTAN5j3blPPjCu52GlwU67NPhLka0XfGb8JY6Gcih3p94v/V4DRhFbxzQaHX1yXXPOAL/R1LbPouxx4/r27SGsUDr8jmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760856; c=relaxed/simple;
	bh=6BvXJsYg00jRP6uWfhHCWlM8CF6XCRguWqBauy/PYB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXIChDEiC+a7prCJ9QYeMDXU8Ux8vJj7hEpltk8xO0yaueBULLU+Q7V3Ow37F11/dPuuDx4CFuTz1MG7fTis4TRuzuOPaQW+yGORlfj3HAH4XjhR7bCSd245qYdIWwv/SiD4X7IHLJfEiKc2kqMlNVV5i39jsfBg11z0iaN7Xyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XCeEcFv2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XCeEcFv2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673CHmdf2076350;
	Mon, 3 Aug 2026 12:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FffIEzQXrsNsbAmGp
	RELJwzpowdDByJB9nWkVuIUH5I=; b=XCeEcFv2F9b7E+EcrsL6SE4KLpCUyfm00
	PN9OeeFTmkTdL20okQlIHWhjrqkUEqrxGW28aLYdkGRt8bYFxe5JWD1dR9EGN1ae
	MUZb2/9YFiRVqRDdlrzh4YeGDpQSG3lUa4NSM2WeCHW4nCpyE5fSpCCXbDQEXQE0
	/RAF9Jo5by4BccISwevntUj1LITIBopUWbtpYKsxE4CUBnkQO4+EhFeLNELG2SfO
	XmJxByj7zWKYZTniUVz+2EK+gKSREVD9fMoFRqDh2jYJ42XWYpInh5u2FGkpaL0c
	+FiCQUS1z7jCEsG+qNFov657XVyx7/+Y7M4eDqxt1aCAz7gN/BLeA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eugda9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CBchh016819;
	Mon, 3 Aug 2026 12:40:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvwe5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 12:40:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673Ceich30146966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 12:40:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3049920040;
	Mon,  3 Aug 2026 12:40:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFAED20043;
	Mon,  3 Aug 2026 12:40:43 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 12:40:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v8 06/13] KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
Date: Mon,  3 Aug 2026 14:40:33 +0200
Message-ID: <20260803124040.126471-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803124040.126471-1-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lrQxx1x4x-U3f5iPFDXWFVmc03BlzvZB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX6kGDz4+/E9Vb
 iKDqkWSosFvi0SA2TR6ixMgYTjtuECVBJSl4BMkpSW3cPVlhZr4NToL6v4MpbLxFvmQuaE3LR90
 kk8cutl2PuKNv8RDsaTad7kmM61F/VI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDExMCBTYWx0ZWRfX5H9TajedQyLn
 QNTruPEjZe14J3m6JSw053kegbSfz/9uDCFf+3mG8irc5Y01LUiLcyeJNBTdZheL3MHDsNEF6lZ
 u9QamuaO87M69GsKS8MREx18629b2uP5G6EneeYTtaYukUxd+My7pqGU1M6mH4c2oB953OwIQJL
 +eStJhy3IN/+NOavygfzmM1nHDj25I/4nTs3+jXIoNUCmjwk3i8UnqG99IQV3LjhEGZwVFIhjQg
 3P8qxJdiB7CzjDchtES9bk+1vQkIxg7pfwcIPd71U3qP31hR7mXShsXAk1g9NAkD/KJJ6vTqqpO
 xJ6/pPqLgGEDjM5Or5SGsPlGp+BONNjHhA6YsJKY8vmDIUuKDrIwaBXN1rKf4kMoFspxPtvLK72
 B/XrEGDXmWordGVmj95ibl7cLoAHftnWoOajirZiKS1MQDzyXQTunP59c1Ih4xRDTde0EzbDXzc
 UjtToPz6Vxe46UJZSTQ==
X-Proofpoint-GUID: lrQxx1x4x-U3f5iPFDXWFVmc03BlzvZB
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a708c53 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=GvWetJuFWLgL5UM2GZoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030110

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

