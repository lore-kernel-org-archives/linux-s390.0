Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117DD39CD19;
	Tue, 28 Jul 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258443; cv=none; b=Nyw6O/dhbOfWLxYvyZd44P6HPmCcxS6FWkSaWpEB9fpsHNt1qO48eET3vB8tvlAB92b6voePTGZrMGLpLh1UE///hHVAlXRDqxCaoCfZa7Tg7DuWNTANChOzRE1sIM/4EoMst9cu8xrFUgKgwjbFoHofZQUTczMeQEy31k04zyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258443; c=relaxed/simple;
	bh=XmKGA/l1qre/tlP2yKW/mCZrS/pitpnh2bcvyU3hpW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZsQACuywz6AO2VcfYc+MxYC/fZhgzRtrgHEqo9v9Hts2rZn5zXm3sKc50kHUvcdvXNVgPimGC259xYM7cKpY4Y86QuEpMNfC7J8wTqzItvv0//xjbtbYsfdQz2z1AJbZhHbmn8TvAOTiuxovOrFrAUyzb3qirWVHbSomIAzhrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kKiO9wzU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kKiO9wzU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SEleQY1380124;
	Tue, 28 Jul 2026 17:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+d2ObGnbjsa/SUMxv
	Dz/6dSYz8KEbRCOPdp89lyL3e4=; b=kKiO9wzUQylxsvjsHiLpyp8cqpGFD9+TN
	o1clYa4cLa0p8x3xmVGaOX9m1TWgj/mPNeWtQeWcu/imAmyv6laP8oCSzZOsL6VQ
	Bo7WKPFVOVWQTEEF452Tm+WJJVy/15brVYFMwLAGvLpkkWPDSBoOqRPQ7AIFPsQV
	Qb8QgV9Ddbkg1M8G/XVvBxYkWzE5qf0GALOmTtTjNUYZW5SHrw9ulOPauDLWXOi1
	vC1tKQwslUlSRzGn3azFH9La63MjtcxHIupo1goxZI9HIbQ4CN5TNKh1+JAKa8Nb
	Wzp4jBzAoOoq8O9JO3gtGQ2Ir3A54dcX8wgeJ9kUsQ/jig64vJ4dA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj5wat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuFJG029483;
	Tue, 28 Jul 2026 17:07:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhav8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7BHY15335780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4025E20049;
	Tue, 28 Jul 2026 17:07:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9004E20040;
	Tue, 28 Jul 2026 17:07:10 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:10 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 02/13] KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
Date: Tue, 28 Jul 2026 19:06:57 +0200
Message-ID: <20260728170708.294400-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170708.294400-1-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX+oMXnJobuM8c
 aO+9hGLyBnUw1WD3P35UQ1sZ3WnMXntVVnMJTExgQ1H6e61rh3TYP/e4RkdMhx1NGQeDXolSNWP
 I6chTDA4ZW0y+SziFMUjSj54aMUCu2E=
X-Proofpoint-GUID: WfO3JV4AXx3f9Z8xYodUCvoO1JVoBG9C
X-Proofpoint-ORIG-GUID: WfO3JV4AXx3f9Z8xYodUCvoO1JVoBG9C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfXx40ifT3GOWJG
 EHuVZ9whuYatZdYunMWOaqxVhd2k9AMSuQSxyXaqzMkvgWmBLAiLuAy8TP9ym/EdrM2BOcQxkIT
 RreVKAHamUpBpoeN2Zf0PV4XkMsAfBfu9iaQEkTOYZr2+xdoITf1AoiJ2xD68ijbVpT2dY/q+ID
 hDVdthct5Pdb7/cYuaAsM8x+A87qm3x6qYOyoLF7+C0294ARDegAj7sAOlgtUSo78l3rj2053db
 N2Tmoea8lD1LaoXc6+HxSifR915ZsBWVyhgZtHLZPShwLWrKNEO8Boarug4gj6IYnRNRJjFKU2a
 ERC2lPZJsqms3HSSTQnWVUDIfPt8D8+/cPQbSlPRc3Y3PBXP6wQy402WqWvOlMc8Na4uJWjnlVI
 3L3dAkwDRE+cAg7fjAtX8Y5qZaAPHQ0icVNv96SkOhHb9sRM/bvdyiZGjJvZeat/cJiQhc1Q2OO
 9hng/vsrMeWb8iI+LPg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a68e1c6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=GvWetJuFWLgL5UM2GZoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280149

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
index f86b4b0b356f..7bc6426f5f4d 100644
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

