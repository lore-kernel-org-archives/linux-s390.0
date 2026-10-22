Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684554;
	b=N8cN15xIj1abNBuAEPEMfaa6oml74nT4u8kDYYiNMdi//Ge89Iekq3hrZ+1B/UKePusO
	 8OSwFYU6rRUIu9+8hzSYNb79cmpF6TJxQRuQRDOrptzRxOzcLBCiMhrZ8IZhbduuZdj3Y
	 xDVITL0KJe9nLCRhLyuBkR3C1Bh4MP+2v8KKgxfvWyAPgYlIBRyfv9I8LUCh+k0lGBpY2
	 cIGTeAopPqObWMlE6u4Aw0Kt3nnUSvbhN8WDpsT2EdHe5c0r5X/f9oMq2jaJ5Jq5jD+gm
	 pWZwwKmmTxYck34N5tOAw0XhYxgVyjhYX4UrMty3DWuwfCOh81KgD3mflXdfYUI0QIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684554;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jcTVzBjWKROJ2CUvKR2E5sMyD2qIq67VoJZ5UDKhDhs=;
	b=jpCSZxfOVV3NwayBkxJXv+/l5kZME223+Wz1niWvjm6gJDraLwA/nTn1TgsApI4nsjyz
	 aETRoxQnsS3ZXSGAKNB4I2eYMYqQR3TdXPX+JRvSTiHXVAZZwfvxZZZ+99Y/292tn0t/H
	 53A+HtgghPD/CUgpSYSAJkSgJvdnK/ubEaSrPHRCyFkOG7n4VdM+tJkFTId1wPHA9V08u
	 J4rG8lEVTcSMStDNZvF2hi0gNNTKYES0e+yhwBfgNRpK2xMuNeNmw0OCfSIiEM4Od70zC
	 Z0/Bxvtf6hHJLOhPziqY75aD9tqVzQmZjOKyMPoNTTuS3OPoO82c/LON+aXLuhaiNTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aZ8YuZdr;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31705606A329;
	Thu, 22 Oct 2026 15:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31705606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aZ8YuZdr
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEEKs2241268;
	Thu, 22 Oct 2026 15:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jcTVzBjWKROJ2CUvK
	R2E5sMyD2qIq67VoJZ5UDKhDhs=; b=aZ8YuZdrwogM1vIvjJ4O19XzV00pq/DSv
	Nea1mPWvlXgLurCUDQpQdmdukHq28FNHCAqMsRrkMZPXKwIxMHDNsEjS9rQiXLES
	ttaG5I0tFcG+8PJ2VQNPKmpcaPcw6om/0cBsqDoQ6F+aYYjh42vZXd6vKIhgKYmR
	91dIwMPPOtFi4Y9jIfwe0nqUwtQp5vOJCYOebEc9m7GaDZbAPhy8MzHgfMMrv8fJ
	3NuzFeZyX8kkpZfTqfCpJz5i+NIYRQdhgYIBE5pYog8wJfos/VCHRYVI7ovBWDdz
	nYNHx9gMmt2i5UoA0pkT8Xay0ZuWrZZ5x51WfTbxhLZqMDVn0xNDQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5901kf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEJtmE3612475;
	Thu, 22 Oct 2026 15:55:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss8eru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFtV8X50921870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:55:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC26E20043;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCB152004F;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:55:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 03/10] KVM: s390: Move prefix marker from PGSTEs to PTEs
Date: Thu, 22 Oct 2026 17:55:24 +0200
Message-ID: <20261022155531.204593-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022155531.204593-1-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZGy43x3Vw1qoE1niXmTXfiMPN0PE8eUB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX2XEPat2NrImH
 d1m1cT0OkZPObOHmS9UJQQtQTLf69C+rg/t21tUNBoaVYVqx1t2wG+YMmFtMeQy8Va0VbQMXwJp
 q1YL+/3Bu5VgQOfs9SUdLC9GKst9md8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX+8ATG4QRE1OQ
 fvWRZ8HZzLUwS1tscQQqwW7CoeeIwVXTYxllkbNeeT0F5Wuv0+ILUVmd3e3OlRyo8ZZCJgwuKt1
 GnRUhTCbPE87oa5s2b76e3sTMLRYof5rNiLqHO8dj0YRKHgFEVGj8rRXeJuDJ2U+dd+l3Cud4hA
 ar32oosocFVUhSslI+qGjos8LpHeN7iFigP9rLe2mrYozi/MWqxEQyEbCERLAPhoB3UfJsmmEk4
 vrJZEuwunzlcsOP7AzBx5YUDgkX9pQEL6OzlnAIwFmizMKtTVJXm2Otv2O16sKLft071JjwUF3o
 pdIDRWd6OvNLTCnk3dWDp+M9Gs/slGQ8Ektu+ev3Rzbngh5mpKywPGlrpxuJrzq5t4AIx1u/YRL
 PS/l6hteBLUcL481vdAEs8CP/WOo6sk7XaKsnygEAeMvnmL3uP6rnBhRnRuo1a4plNQYr1Y/faa
 2hQIPf4mLJ2X9XHeUGg==
X-Proofpoint-ORIG-GUID: ZGy43x3Vw1qoE1niXmTXfiMPN0PE8eUB
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ada31fa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=lhHyj95B5iAaskYyJO0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220062

Move the prefix marker from PGSTEs to PTEs; this is a preparation for
PGSTE-less guests.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c     | 11 ++++++-----
 arch/s390/kvm/gmap/dat.h     | 10 +++++-----
 arch/s390/kvm/gmap/gmap.c    |  7 ++++---
 arch/s390/kvm/gmap/gmap.h    |  4 ++--
 arch/s390/kvm/s390/gaccess.c |  1 +
 5 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index b9507daaf327..48bb97ae4dd1 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -234,12 +234,12 @@ static int dat_split_ste(struct kvm_s390_mmu_cache *mc, union pmd *pmdp, gfn_t g
 		init.s.y = old.s.fc1.y;
 		init.s.sd = old.s.fc1.sd;
 		init.s.pr = old.s.fc1.pr;
+		init.s.prefix_notif = old.s.fc1.prefix_notif;
 		pgste_init.val = 0;
 		if (old.h.fc) {
 			for (i = 0; i < _PAGE_ENTRIES; i++)
 				pt->ptes[i].val = init.val | i * PAGE_SIZE;
 			/* No need to take locks as the page table is not installed yet. */
-			pgste_init.prefix_notif = old.s.fc1.prefix_notif;
 			pgste_init.vsie_notif = old.s.fc1.vsie_notif;
 			pgste_init.vsie_gmem = old.s.fc1.vsie_notif;
 			pgste_init.pcl = uses_skeys && init.h.i;
@@ -1017,14 +1017,15 @@ static long dat_set_pn_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct
 static long dat_set_pn_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
 	int *n = walk->priv;
-	union pgste pgste;
 
-	pgste = pgste_get_lock(ptep);
+	/*
+	 * Updating a softbit while holding kvm->mmu_lock in write mode, no
+	 * need to take the PCL lock.
+	 */
 	if (!ptep->h.i && !ptep->h.p) {
-		pgste.prefix_notif = 1;
+		__atomic64_or(_PAGE_PREFIX_NOTIF, &ptep->val);
 		*n += 1;
 	}
-	pgste_set_unlock(ptep, pgste);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index bf01af50e192..27cc5abe6eaf 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -77,7 +77,7 @@ union pte {
 		unsigned long u : 1; /* Page unused */
 		unsigned long s : 1; /* Special */
 		unsigned long w : 1; /* Writable */
-		unsigned long r : 1; /* Readable */
+		unsigned long prefix_notif:1; /* Guest prefix invalidation notification */
 		unsigned long d : 1; /* Dirty */
 		unsigned long y : 1; /* Young */
 		unsigned long sd: 1; /* Soft dirty */
@@ -113,8 +113,9 @@ union pte {
 #define CRDTE_NODAT		IPTE_NODAT
 #define CRDTE_GUEST_ASCE	IPTE_GUEST_ASCE
 
-/* Soft dirty, needed as macro for atomic operations on ptes */
-#define _PAGE_SD 0x002
+/* Needed as macro for atomic operations on ptes */
+#define _PAGE_PREFIX_NOTIF	0x010	/* Guest prefix invalidation notification */
+#define _PAGE_SD		0x002	/* Soft dirty */
 
 /* Needed as macro to perform atomic operations */
 #define PGSTE_PCL_BIT		0x0080000000000000UL	/* PCL lock, HW bit */
@@ -147,10 +148,9 @@ union pgste {
 		unsigned long usage        : 2;
 		unsigned long              : 8;
 		unsigned long cmma_d       : 1; /* Dirty flag for CMMA bits */
-		unsigned long prefix_notif : 1; /* Guest prefix invalidation notification */
 		unsigned long vsie_notif   : 1; /* Referenced in a shadow table */
 		unsigned long vsie_gmem    : 1; /* Contains nested guest memory */
-		unsigned long              : 4;
+		unsigned long              : 5;
 		unsigned long              : 8;
 	};
 	struct {
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 3f3fa864cc36..bf7f27d6be96 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -298,7 +298,7 @@ static long gmap_clear_young_pte(union pte *ptep, gfn_t gfn, gfn_t end, struct d
 		return 0;
 
 	pgste = pgste_get_lock(ptep);
-	if (!pgste.prefix_notif || gmap_mkold_prefix(p->gmap, gfn, end)) {
+	if (!pte.s.prefix_notif || gmap_mkold_prefix(p->gmap, gfn, end)) {
 		new = pte;
 		new.h.i = 1;
 		new.s.y = 0;
@@ -307,7 +307,7 @@ static long gmap_clear_young_pte(union pte *ptep, gfn_t gfn, gfn_t end, struct d
 		new.s.d = 0;
 		new.h.p = 1;
 
-		pgste.prefix_notif = 0;
+		new.s.prefix_notif = 0;
 		pgste = __dat_ptep_xchg(ptep, pgste, new, gfn, walk->asce, uses_skeys(p->gmap));
 	}
 	p->young = 1;
@@ -470,7 +470,7 @@ static union pgste __pte_test_and_clear_softdirty(union pte *ptep, union pgste p
 	 * If this page contains one or more prefixes of vCPUS that are currently
 	 * running, do not reset the protection, leave it marked as dirty.
 	 */
-	if (!pgste.prefix_notif || gmap_mkold_prefix(gmap, gfn, gfn + 1)) {
+	if (!pte.s.prefix_notif || gmap_mkold_prefix(gmap, gfn, gfn + 1)) {
 		pte.h.p = 1;
 		pte.s.sd = 0;
 		pgste = gmap_ptep_xchg(gmap, ptep, pte, pgste, gfn);
@@ -707,6 +707,7 @@ static int _gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, int leve
 		pgste = pgste_get_lock(f->ptep);
 		oldpte = *f->ptep;
 		newpte = _pte(f->pfn, f->writable, f->write_attempt | oldpte.s.d, !f->page);
+		newpte.s.prefix_notif = oldpte.s.prefix_notif;
 		newpte.s.sd = oldpte.s.sd;
 		oldpte.s.sd = 0;
 		if (oldpte.val == _PTE_EMPTY.val || oldpte.h.pfra == f->pfn) {
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index 8f47f29c89fd..4042e1d4e77c 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -232,8 +232,8 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
 	else
 		lockdep_assert_not_held(&gmap->children_lock);
 
-	if (pgste.prefix_notif && (newpte.h.p || newpte.h.i)) {
-		pgste.prefix_notif = 0;
+	if (ptep->s.prefix_notif && (newpte.h.p || newpte.h.i)) {
+		newpte.s.prefix_notif = 0;
 		gmap_unmap_prefix(gmap, gfn, gfn + 1);
 	}
 	if (pte_needs_unshadow(*ptep, newpte, pgste)) {
diff --git a/arch/s390/kvm/s390/gaccess.c b/arch/s390/kvm/s390/gaccess.c
index 2d27dcb68002..8dc5b93ef01c 100644
--- a/arch/s390/kvm/s390/gaccess.c
+++ b/arch/s390/kvm/s390/gaccess.c
@@ -1435,6 +1435,7 @@ static int _do_shadow_pte(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gpa_t
 	newpte.s.d |= ptep_h->s.d;
 	newpte.s.sd |= ptep_h->s.sd;
 	newpte.h.p &= ptep_h->h.p;
+	newpte.s.prefix_notif = ptep_h->s.prefix_notif;
 	if (!newpte.h.p && !f->writable) {
 		rc = -EOPNOTSUPP;
 	} else {
-- 
2.56.0

