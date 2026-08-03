Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21136BCD7;
	Mon,  3 Aug 2026 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773383; cv=none; b=hMw6/802BHepVcfa+bOg9XZ5flp4pZznzlQ33irJU04m/2vr/thxIvXS5sGPOnGoWwyoJLuC0ry9L6dgkJ6SW8Eyqirk/+XLCvGwpZmfzu3QbpEZtp2zGp5138sJeIXmlGImWjt7I26zuoQfQedoy1UzR8g2AGh7PbFXlLDpCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773383; c=relaxed/simple;
	bh=XDAYZpNt6ec/dbsLMD+1qKSJ6kmgwyOi5XvmD5lKyjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjkAwWN25p4yLl+sggWZa7qzsobq///KPA0llQJNNaygD6NsR9RzoVzTssOMXBk2wUyAApv2NLfSlF1oynH2ZlGnH5j7m2m6gtBZCZhzdySWqs8+Tn46ulJ21bOVMW0tXQpTQhWEGptoO5Jr8tAthswr1moUUaX7MMSLm9T+cPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d1AByLs3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d1AByLs3"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHpuG2202033;
	Mon, 3 Aug 2026 16:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UyFnvXsSCerK9Ytmp
	up4yCkAzF5OmB+xu+4QThaosXU=; b=d1AByLs3WS/2h4HAKqKoVMwTi1DZDbQkM
	ygkgQg9SzdD8GGpDgphwabbSX0U+US06k2V+yuSBc+mT3ewCz70Jgdkqc6Pkzza3
	DHRvjNQ5afOSJ1s2TTjUB4uaRjCWJOe6hv0NS+4r5677mTHbCWbVGCX2+z4UBRRx
	RGCevaijoZ8ZYD7k9WclMD3Nx8Jak43+eCmSSOe+/GHCZclKi5Q5hIGlTNKN5rNp
	ZqIKHksB1O7eZ+G0sItdyfjAXCp+8kPVCm4LKm56Q7ZDOj6TOabLUq/yGvvU9A6L
	g+ravfBTgybopbzZfOgh8wzhCIk4LAmK3lUtUVI+bMK8zWYigRE1w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hhnq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuG0O022258;
	Mon, 3 Aug 2026 16:09:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5xyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9Rhq50004258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05FF22004F;
	Mon,  3 Aug 2026 16:09:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E11812004E;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 16/23] KVM: s390: Fix leaking of PGM_ADDRESSING to userspace
Date: Mon,  3 Aug 2026 18:09:17 +0200
Message-ID: <20260803160924.236807-17-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX62IHlcXpcEYZ
 Da1kOI9UKYd/uK441rY0l5o22YL4hljSQZMlQHsANIkLCPFjzAWtMVf2stJ5bx4qTGv5eAzA1M4
 ieIPAm6n1ruct5HkzdgoqcMG26eMQrM=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70bd3d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=GvWetJuFWLgL5UM2GZoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX0LT/B4qM8MSn
 kxpDOD8fpD/1xn8+YYeJvBSkcnA4pqRTxqBu8Qd/Db5dDAhaFNYgIFe9vTgGN+pmxBR+PwncUOW
 9eqSMZigEMqzYlaoccSvMT3kEdBE1WhAoo+sfIzRgGHPMEtFTTEQ7V8EviZZC/AtmO+dS/COaLT
 3sGhQSEZgDyGuocE8yH8VfD14lMmmaW1iCRYQxfCK6gHGWIAq5YbbEIDaq//k0c+HQhvmQoJ7LE
 OMGbLR47/Jz6nLXSO3WmSQZ20AYms1mtD0yK3AHKpK70WtlSLZYahgXsTKMYxIGYYTWKAJMiSHk
 mgJCCWK7QFZ74qEd5fYn79DcioizLoVuWcnrRMEjuBUZB1Z8LuMupW85Pqsy/A/OqMoUohC81Se
 q0Q8HwZ1P6gpG0OLLs0w+7PNfQGZuoXpXydIKOlfM61B/ttCb4QZa4oOk/sr+d/tQLPhn+bqlFs
 A0YeGLJsiyrgWuxv9dQ==
X-Proofpoint-ORIG-GUID: x5WO3Ct6BdhpW4Y20-cXPGNZaHdYRKQq
X-Proofpoint-GUID: x5WO3Ct6BdhpW4Y20-cXPGNZaHdYRKQq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

If kvm_s390_set_cmma_bits() is asked to set CMMA values outside of a
memslot, PGM_ADDRESSING (5) is returned, instead of a negative error
value.

Same issue with kvm_s390_{g,s}et_skeys(), kvm_s390_keyop(), and
dat_reset_reference_bit().

Fix by returning -EFAULT whenever the return value would be > 0, which
is consistent with the behaviour before the gmap rewrite.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260803124040.126471-7-imbrenda@linux.ibm.com>
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

