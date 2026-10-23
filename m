Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770956;
	b=QuIi1sijwVHYIbpyAH+nhYlv8O9dLfSThxo7FGtuUX9DJ66tc2YxrKVntIlBIAS13ExE
	 rRz7xOa7W+ofCQPiwzDaitgj4r5aKTRpFAmUy4UnYI8x9N2C0LSpG2srQruMJOVUOPuRj
	 p0tjvxLfp80n+F0DWGSLeke4ZfA42jEdQIcBMGTFomN9d2DX0qL/KujjU+Uzjmb48Qn1f
	 HVB20QPkM8O7VDxPUNE/Akk+tiajzh8WjIJwRKOImcD7cqErP1k1JUShL+ej6Ay8Jzt4F
	 BsPrNordWyNTo+uL4aVdU9I5STFQtSxTkG+cZgTxD1gj65Qytl2eF5qLoCOodzQ639A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770956;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OHUlae2ZI4CgnN4n3fZjfZF18iJiCB2mLIXTEYlbN8U=;
	b=NSZyUR32PQHHr+pkY2uwLhqJMLPko36w1benqrQLEPpcGdQ+GgKDtahEeO3k5MJstzMl
	 JWzZBkt9+w2NRqS+mnw3rl9WjSA2tZhygCT4+Qvk1Jep8SKZlHjQaf+wTv7D1vYXa7csI
	 kXGp5Jq9/1ycZYT/gDec9f9yR3XoD/uATwNLJkwkpUJDOvKL/e8PvhNZ1u2Ri3gjo4dke
	 IhBp2KCuhvsa9A+iHGhvMz+gqPttFg4fYbdCqapRkdSZHkuEIMJai3aOTdg+3V6LLqfhY
	 eWPICdqiMJD9MRitWzH3YngQGIwLSKlaONGQIg0yTTQzHmuClgr0fi3AoiEshrJJx6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ma3bro7k;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C0606A339;
	Fri, 23 Oct 2026 15:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E68C0606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ma3bro7k
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEEPps1517751;
	Fri, 23 Oct 2026 15:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OHUlae2ZI4CgnN4n3
	fZjfZF18iJiCB2mLIXTEYlbN8U=; b=ma3bro7keCGEh9ldV/up+8OXkPHtLJDKH
	2OvfRfaNdQuCHvPmoC7szEIkgQLT8aS0MPO0pudSkYCd0bWct5J6G4fLOk8jR6lI
	jNWCjCb9edjtocTEheWu/QR1eCYL8a2EySfwZUrHeVbm8A2Avfoo99vkhsR5Nw5C
	wVVi5woF2fUL7mmm44ORqos85CjdjPBXdBXV5lPzhDjghBJjxbESomhnF2TYf+6T
	BWTE/sBBoEvcD27WeG1W0MvYFCb6ysNuKTKj60aX+AfjiqOWsMzNWb+YDo3WdQEI
	V6Zt4es/st2tmqb4iezVoZxcXJk6Sjc9KPFFINIh+Og8wdhNR/sBg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bx8ev-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NELEeq2203435;
	Fri, 23 Oct 2026 15:55:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hekdgms3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NFtWBX17826186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 15:55:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66DDC20040;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 465BA2004B;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 03/10] KVM: s390: Move prefix marker from PGSTEs to PTEs
Date: Fri, 23 Oct 2026 17:55:24 +0200
Message-ID: <20261023155531.206113-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023155531.206113-1-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: M4Do52C2nhKulear_x2LDyeOBTQAu7-H
X-Proofpoint-ORIG-GUID: M4Do52C2nhKulear_x2LDyeOBTQAu7-H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX/JX1f5ycHK7W
 XM3QB8LHki0T6FrIGFC4lgh4oIO6DLRHBYkHFTEjWbX2N+RlokTzKi9n1NLOyQ15vyTJtyZ1iS2
 lpKifOw2itwdUmtXyx6LF8qCbdU/kPc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX5mubNfSlzC6u
 49NDUsIyV5kXT1b9la1U20qeq1QES+Q8P0ounntdDTXkhgwD3XDhcJtVb6q94Li/TOqJ3ZN6AFb
 pS4o9/97gPgsiEroueRP4WWuItMLogKz8BHSDSydSv8ediwMyp3EVNFLWHDzU8J+VGohBiXYNS1
 GB5JojS+RZ6zgxnWoSt7wl+s9vgH2COqLoehP8UubWnIZeGesE2oN4dKki5g7HK/0L4HJM/LnOR
 rxPDxDmwlgPwoqRCA6/haTwY9OYn+DJ8IPPNhmAtQCQEqWxi2+EoeAShNg06tY52T2/i9DBCzDx
 BHumEddINTUor9+0uaebdkdOBgR8RIW2B3Go1JF8pEke0ATpyiodA8ycGbogKRnk81bmkg0mwGB
 zDv3aNn/gAEmnW0vLYGIjEgm17E4Xz1Ee/KdLjAZYzx3JxEQyOfQph3cCkIA+Tn/FQideWrCeV1
 LfrChePED3VGH1JyBDw==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6adb837b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=lhHyj95B5iAaskYyJO0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230061

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
index 0832a070f6f7..8af4409332e4 100644
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

