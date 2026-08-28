Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8444685D;
	Fri, 28 Aug 2026 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918105; cv=none; b=kck44cUURFnzn9rr7rEr2yEs745EUvXMjwpYf7a6lG8/SqvInP/Z3JliZc0KTIyjMFxU18TRkeGscYqqFE48cAY3quARIM1v5O1gmqVAwAe+nEUE6Mksm4oYyqZg5JjG4b4R6/iSRrEU4Ta3NRGXqOsAgn6D3kLRas7XdF/e900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918105; c=relaxed/simple;
	bh=CIdmYXkP+AhLkgjkPc45Wi+4Cof/SA8aCBscCAyLlj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frX8xKXoOP+LDGHH4i9zk01nHLo45pkoysSlPZrwfjoL9/mDdLYUyzK9zy8TZJKyieBdLlJrTDuOT62gq7Ou/AHwzoFldAyBGIAB83DZbhRnIEMttViQxSDJYAO7HO0VglWqkUK1IMFTNgGTi18wA7uqqGLIFJdAJg3duhCEOGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nN/zVzGq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nN/zVzGq"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SAVjwF1623150;
	Fri, 28 Aug 2026 11:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XbyQZJrE9LFi0NS9S
	3sqo8CHsRHL8LgaOBYGliHk8XY=; b=nN/zVzGqNap0d/02Gf39o1rh9VybbU3za
	9/P7pbIrAPW94OHRkfZ5eCUBEFnEO8/0b8YwHQ1FnvOHDpKv+chaYYOECHh6Xl72
	2Sim/d0cB1yM6I4JUGEDP5lIr52FU9oKOCSVFnymN0Paky26CFkH8n7uxc+eoGfQ
	tJyzRX/5wXQ9zoz6FI9TET8E30nj6Fg3UcnC7aVK1LbCMHXEUYLzok2csAeoiiIh
	VlbEWzkEhqs8F+qP3mGxuU2OKBvwvc8xDi3gVj4lo9Q8Q8Y1cqO2uMimmMuZrzMb
	TdAyhoYx0Fi+9BwJHztkdTdJ23daWZJIR3RcV3qDXRZjs1qE3aT2g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jbx0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SBfODD019841;
	Fri, 28 Aug 2026 11:54:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsynnbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SBsenH9109996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 11:54:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D68442004B;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B37C320043;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 7/8] KVM: s390: Fix potential races in dat skey functions
Date: Fri, 28 Aug 2026 13:54:38 +0200
Message-ID: <20260828115439.145885-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828115439.145885-1-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX2aOGXbhV5k+o
 Kvhpee3eJt7QtFD2SxYyFGccjFMSnAU4+oGmTCjQgoBO4ziHBEm1GvaSj9nLrC15tkxldJj8JXV
 bvQTTk+YRIN/7JrsDEBSI8cidpE2r84=
X-Proofpoint-GUID: eNBEnjkVqaizNNB-qD9Fa3BydUnugTHr
X-Proofpoint-ORIG-GUID: eNBEnjkVqaizNNB-qD9Fa3BydUnugTHr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX3khf4/Mu8O5N
 yY2vhZs/uYToxYAOzVcdasb/4S/LJMiwn9RD5FyQQilkc3Ez9dbXGxhSK0+zxwg8xpbj6xaVpSL
 wwEqHVp/FwlrkGD1Cry6E4L52G++u1JnmbZjEm+IMPQ0VjK2IfRz0xK9qgAT5e7yZ7pgUqBIVQ+
 hShQskbS/iRgtWRclHlulGV/vOuYWLW85qFwl4yl7YlXBHmIR4c7mYwQCUpnuqHf9Raj/uJhoIr
 Os8rF9Lq6YPGVYbwtBT9COhL/KotNGs4O993N8ngJkH1U4lXVsUzMtZRy4XGHrciB/JEsXEMq3t
 din6k+Z+C18lYcNpPi8HkTygEJZEsfY4lvDefVkhLLLwdULZX/j5dFoxq5TnM2stPL4ONDKrXDm
 Zf6uq0UQBqXSknUnNwiUrih9X10kMGx/6d+hbixzFpd1K6KaeBz6a1SA8IPeAHymP6vVECr5jrG
 skyTtD2UIRA230j33OQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a917707 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=wCyL4Wiu_ChfG3is39wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280099

When dat_cond_set_storage_key() finds a large page, it will
conditionally set the storage key in absolute memory using
large_crste_to_phys() to get the absolute address.

There is a race window between dat_entry_walk() and
large_crste_to_phys(): the large page could have been split
concurrently, and large_crste_to_phys() might be called with a crste
that does not designate a large page, leading to crashes.

Similar issues were also present in dat_set_storage_key().

dat_get_storage_key() and dat_reset_reference_bit() did instead check
for a potential concurrent splitting of the large page, but then
handled it incorrectly.

Fix by performing a READ_ONCE on the crste pointer, checking and using
the result, instead of dereferencing the pointer again. In case a race
is detacted, try dat_entry_walk() again.

Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: storage keys")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index dcedd5479d82..ff80d02c9f56 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -621,17 +621,20 @@ int dat_get_storage_key(union asce asce, gfn_t gfn, union skey *skey)
 	union pte *ptep;
 	int rc;
 
+again:
 	skey->skey = 0;
 	rc = dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
 	if (rc)
 		return rc;
 
 	if (!ptep) {
-		union crste crste;
+		union crste crste = READ_ONCE(*crstep);
 
-		crste = READ_ONCE(*crstep);
-		if (!crste.h.fc || !crste.s.fc1.pr)
+		if (!crste_leaf(crste) && !crste.h.i)
+			goto again;
+		if (!crste.s.fc1.pr)
 			return 0;
+
 		skey->skey = page_get_storage_key(large_crste_to_phys(crste, gfn));
 		return 0;
 	}
@@ -662,13 +665,20 @@ int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gf
 	union pte *ptep;
 	int rc;
 
+again:
 	rc = dat_entry_walk(mc, gfn, asce, DAT_WALK_LEAF_ALLOC, TABLE_TYPE_PAGE_TABLE,
 			    &crstep, &ptep);
 	if (rc)
 		return rc;
 
 	if (!ptep) {
-		page_set_storage_key(large_crste_to_phys(*crstep, gfn), skey.skey, !nq);
+		union crste crste = READ_ONCE(*crstep);
+
+		/* A large page has been split concurrently, try again */
+		if (!crste_leaf(crste))
+			goto again;
+
+		page_set_storage_key(large_crste_to_phys(crste, gfn), skey.skey, !nq);
 		return 0;
 	}
 
@@ -718,15 +728,22 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
 	union pte *ptep;
 	int rc;
 
+again:
 	rc = dat_entry_walk(mmc, gfn, asce, DAT_WALK_LEAF_ALLOC, TABLE_TYPE_PAGE_TABLE,
 			    &crstep, &ptep);
 	if (rc)
 		return rc;
 
 	if (!ptep) {
+		union crste crste = READ_ONCE(*crstep);
+
+		/* A large page has been split concurrently, try again */
+		if (!crste_leaf(crste))
+			goto again;
 		if (!oldkey)
 			oldkey = &prev;
-		return page_cond_set_storage_key(large_crste_to_phys(*crstep, gfn), skey, oldkey,
+
+		return page_cond_set_storage_key(large_crste_to_phys(crste, gfn), skey, oldkey,
 						 nq, mr, mc);
 	}
 
@@ -768,7 +785,7 @@ int dat_reset_reference_bit(union asce asce, gfn_t gfn, union skey *skey)
 	int rc;
 
 	skey->skey = 0;
-
+again:
 	rc = dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
 	if (rc)
 		return rc;
@@ -776,9 +793,12 @@ int dat_reset_reference_bit(union asce asce, gfn_t gfn, union skey *skey)
 	if (!ptep) {
 		union crste crste = READ_ONCE(*crstep);
 
-		if (!crste.h.fc || !crste.s.fc1.pr)
+		/* A large page has been split concurrently, try again */
+		if (!crste_leaf(crste) && !crste.h.i)
+			goto again;
+		if (!crste.s.fc1.pr)
 			return 0;
-		skey->skey = page_reset_referenced(large_crste_to_phys(*crstep, gfn)) << 1;
+		skey->skey = page_reset_referenced(large_crste_to_phys(crste, gfn)) << 1;
 		return 0;
 	}
 	old = pgste_get_lock(ptep);
-- 
2.55.0

