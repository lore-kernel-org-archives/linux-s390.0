Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4D40F8F4;
	Wed, 27 May 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893053; cv=none; b=ZwNImy0ixooIYyy7M2v3pooTRGNylbC1cJMvwYLKKOQlu6dIAzAysipnW2v2QgRfqLq5z7syy5wZlIcBflBDJNsW/PNWWJAcQ459S1unGXAG2sdkhWYSySJZMeaG3RbHevf5QNahRQxPQu9grbDJU942uTvK7Ys9XqSp9VyI19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893053; c=relaxed/simple;
	bh=TmRlg5ggWNGM9hQSdzZR4wEFox2Ebrdl5upRcPic/+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atJHC/qdXafFJycjm0ftw3RknCyeSRUKAjviCuK87nUY8nbhARy+dDm8iVDLbZO0DhZbR0QlOvw++3hujqRErT3nO1nNfLkdfA8KMFWQBCTyVd9Bpe8hCATCs11C2bEAod69+wa3OhG6nj1jcuqVZgvX+rRfqw5P71xKcUBszD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D/p8t9VF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D/p8t9VF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCLwsE272378;
	Wed, 27 May 2026 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RTvo4RELu7tBJZ6LF
	s9zQkxawwrOJGUz+MPYavYWaXs=; b=D/p8t9VFPminFN3a76JBjBq0EPnFg9S6h
	kyca1x0+S2YmM6BQFXYZCC6WYU5xRnLvxolO4/D4HxFlXGksm4HVFfulsHdS512d
	BYtUef9iYGcIIGuu7eolh7XeXWLMOmXjS6Oe51wkNR3pcic1ddI3nkWExqjQi5Iu
	TajqoVr2QmwMyb5s32ZRKKAEANW1po9DvaqUylXTXoJYyy74EPXsNT6hkEDimR93
	0Om/vOIqr54NAEeD5X0qo0SfgVyNS8fg2TXnfkl9arTHpQbeNEcVzfn3XGadyHYR
	0O9qvkvfn1AOfPFWnlhpdf+iuqERfxljNfJ4SVGy/Du5kmxHoF3cQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nq8mk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:44:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64REd5P8003170;
	Wed, 27 May 2026 14:44:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrb3fu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:44:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64REhxjN30998874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 14:43:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECC9520040;
	Wed, 27 May 2026 14:43:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B79C12004B;
	Wed, 27 May 2026 14:43:58 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 14:43:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v3 1/5] KVM: s390: Track page size in struct guest_fault
Date: Wed, 27 May 2026 16:43:54 +0200
Message-ID: <20260527144358.186359-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527144358.186359-1-imbrenda@linux.ibm.com>
References: <20260527144358.186359-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 4DD418tJ7BX5LFOfMFXuWrPMinh9m5F6
X-Proofpoint-ORIG-GUID: BuquLLJG9s1Csld4C0BOQE_ropDUDSCC
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a170336 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=HydwJh4hHmF5zmZ3e14A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE0NCBTYWx0ZWRfXyevpikL+FthY
 IpnqVyPtNqFPzo/VyXhni1womwVPFD5zaOCbu/uHlfj23dqI7SJLlMQKuaxwMyLfthLiMJ7NIRC
 FVYrvHPm9r/TDahGjUEkeP2vdXeVobHUnesDURvcFYK370lb8uIQ744oT60F8isTnRxOU1hfX23
 g1UhaJLr98h1jFU3ywznINkT9loGv+HfiRzdt4jr5cpdyVknf4ptvrIP1IRi5PDQvMKwiQgZLfD
 Z0jFHtQg1qaxgDSJViLRpxZdLIAt4I3nTcee/CaLbELZJ/2ZPfNBqbxskOWhTPRRpp8u7TrLnvQ
 uCA6eIM93IbbqrKmdOqCoV82T4EsJ5Uc872WpgZN5TC4pGDmYixFtAErVf/GdFgEh8y5Cden5Fq
 ssBLNXlvoP/EBecDDh5PAwHWBhDdKmtajOfYWx3XRKYamLtXJoiIoXZ955Q1QufxONenUcAUyel
 /TokZzFjNyTQGOZ/UZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270144

Until now, the members of struct guest_fault are always accessed while
holding the required locks, and thus the ptep and crstep pointers can
be dereferenced safely.

There will be some new cases where callers of kvm_s390_faultin_gfn()
need to know the size of the page used to solve the fault, at which
point no locks are held anymore, and dereferencing the crstep field
is not possible.

Introduce a new crste_region3 flag for struct guest_fault to indicate
whether the crstep used to solve the fault was a region 3 entry with FC=1
(large pud).

This allows to disambiguate all three possible scenarios:
* If ptep is not NULL, the fault was solved with a pte.
* If ptep is NULL and crste_region3 is 0, a segment entry with FC=1
  (large pmd) was used.
* If ptep is NULL and crste_region3 is 1, a region 3 entry with FC=1
  (large pud) was used.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.h  | 1 +
 arch/s390/kvm/gmap.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index 8f8278c44879..5d848e74e382 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -500,6 +500,7 @@ struct guest_fault {
 	bool write_attempt;	/* Write access attempted */
 	bool attempt_pfault;	/* Attempt a pfault first */
 	bool valid;		/* This entry contains valid data */
+	bool crste_region3;     /* Whether crstep refers to a region3 entry */
 	void (*callback)(struct guest_fault *f);
 	void *priv;
 };
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 3c26e35af0ef..fe138d17caaf 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -531,6 +531,7 @@ static int gmap_handle_minor_crste_fault(struct gmap *gmap, struct guest_fault *
 	f->pfn = PHYS_PFN(large_crste_to_phys(oldcrste, f->gfn));
 	f->writable = oldcrste.s.fc1.w;
 
+	f->crste_region3 = is_pud(oldcrste);
 	/* Appropriate permissions already (race with another handler), nothing to do. */
 	if (!oldcrste.h.i && !(f->write_attempt && oldcrste.h.p))
 		return 0;
@@ -690,6 +691,7 @@ static int _gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, int leve
 			if (oldval.val != _CRSTE_EMPTY(oldval.h.tt).val &&
 			    crste_origin_large(oldval) != crste_origin_large(newval))
 				return -EAGAIN;
+			f->crste_region3 = is_pud(newval);
 		} while (!gmap_crstep_xchg_atomic(gmap, f->crstep, oldval, newval, f->gfn));
 		if (f->callback)
 			f->callback(f);
-- 
2.54.0

