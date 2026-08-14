Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599B484228;
	Fri, 14 Aug 2026 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725247; cv=none; b=P3/KEiofU2sLQFqJmqToor/e4gueeKIaD/OcvSeYJBVOZwtt7FP1Fw4ac8Vd6h8tcJ5PhykveNGIV3r9VfBUzaZFEy5+aNmIJRTg28bz1G4WEMR6pkl7/If2vuCDWCLdFLMZX1VTgZJ6BFeDC8cjixGF217hxVP2C/CuGwuLYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725247; c=relaxed/simple;
	bh=rjnRnqoVdjqF4JjoCvUaU7aiy/7n+xW04Er34YCbioo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lH+Tfetk+RR/bXLEUcaXLD6+lK+fp9/uBDUp8IFHGj7qaV/ian/iI18DhfuMxF75sURQ3mbDqIzxD05PbryxKnSPukdAC98zXsVmkRLUbjml16JBRWqs3lagULy+dvkkiWSoAVbr0+WBTxKIdr4MJfFPicGUkcNpJ/GTXIZqDEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mBqAlmGZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mBqAlmGZ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5mei1343022;
	Fri, 14 Aug 2026 16:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uJ6V15LHEbNe5+Ebz
	gUP1pHpHpvtkaSOKvq+eoKtIb4=; b=mBqAlmGZYGzu9G6xXDs6Eu9jTyf+PWe6S
	vmZ5l6/8jaBuh15xpDvByK1PoHUN8kdL9a19o6wcVmP2flyV59AdZ2t0/M3vEWHi
	hBDbU4H8dv1OyGoNoLvmHjovMQ70+GP/XroxXpWspcHT6NCxHOQ7anY+yZ6XFHwG
	4X3rMMneoJZOoKc8Zq+q5ZxzamN+5P/bNg/QBd45VUfX3hEAxvvDynvcoigh7TQp
	vgB7H7y+CCBDpLBF889wF4kY7UNlYBge74Y1nGaJGR53xpBsHlgEsvbNvF6vRVvI
	YCzgag1N/MVVQygLtSOOL5XznY+FNdiYz6o9iVK76SsjH3OBCL3gQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma5tb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:34:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EGQSlh016756;
	Fri, 14 Aug 2026 16:34:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqg71u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:34:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EGXvMw23200366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 16:33:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BF9420040;
	Fri, 14 Aug 2026 16:33:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB5342004B;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 6/6] KVM: s390: Fix potential races in dat skey functions
Date: Fri, 14 Aug 2026 18:33:55 +0200
Message-ID: <20260814163355.227191-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814163355.227191-1-imbrenda@linux.ibm.com>
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfXxL92De1rqMGZ
 7sdGALrJNKETCECN5G5OWwJAygdcdzyIHGUwkgclti7KKkxEoJOgUEuKRXYT486/c+DpjK0mZqw
 uzUuLToPWITXGn3403MoPac7bc58+PrSPbxL4N5iP85U3bO90uzJO297kEbP8MNHbK/lJVxJ8U3
 roeBWmcrtv3KxyJ65ItsAp13R/OJFYEAkCgFgbp3ZsZOg7rZ1MaVBnrM822g1wGphIgHsxsNdN1
 jCJSgPZrYd8LJeeDX7NVr/vchy+CHsuNSqNTDeGlPj7g5yzwDwqqKdr59VBMrXy8KmV3KsPmtWW
 ck+MPYJu4G7vodeq+mGHVN1fQicHBMYSEV3rYBDmbPCU9OfamWXWH+ZXWznNRtHmQ1X7whlGkqB
 2Q3j2wGIwRSlAPIRte1ThwNhkVoFkd+M8CrgRf5xKL9cxE9D1TU/7k+0Xfjbe1frR+xin62MW+P
 22qyZeRPvfq51UpWUbA==
X-Proofpoint-ORIG-GUID: bTuf-HnmT8aM9nkiVVl4MnnuQHSfopEc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfX8HlPFrKz3HhC
 u9vh8EEQb88bBGO+vQC0yi2dA93RDPYUkemrJP/F41BS5aldgY7qt716R/AbhIrd3cxAX/w4FIv
 zBz8VIDB/jEz/dKJuHHPrP1gBYyDhUA=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7f437b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=wCyL4Wiu_ChfG3is39wA:9
X-Proofpoint-GUID: bTuf-HnmT8aM9nkiVVl4MnnuQHSfopEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140126

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
 arch/s390/kvm/dat.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 7e5dd5a1eb1e..b4c318ebd91e 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -620,17 +620,20 @@ int dat_get_storage_key(union asce asce, gfn_t gfn, union skey *skey)
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
+		if (!crste_leaf(crste))
+			goto again;
+		if (!crste.s.fc1.pr)
 			return 0;
+
 		skey->skey = page_get_storage_key(large_crste_to_phys(crste, gfn));
 		return 0;
 	}
@@ -661,13 +664,20 @@ int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gf
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
 
@@ -717,15 +727,22 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
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
 
@@ -767,7 +784,7 @@ int dat_reset_reference_bit(union asce asce, gfn_t gfn, union skey *skey)
 	int rc;
 
 	skey->skey = 0;
-
+again:
 	rc = dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
 	if (rc)
 		return rc;
@@ -775,9 +792,12 @@ int dat_reset_reference_bit(union asce asce, gfn_t gfn, union skey *skey)
 	if (!ptep) {
 		union crste crste = READ_ONCE(*crstep);
 
-		if (!crste.h.fc || !crste.s.fc1.pr)
+		/* A large page has been split concurrently, try again */
+		if (!crste_leaf(crste))
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

