Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308BA41A547;
	Fri,  4 Sep 2026 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502025; cv=none; b=YepFTas/+o3GFddYmip6aHnhP68tH3LwrJwbHlAB7oV/F7SURcxmh1v/sAW4vaciKjpbpWBJWHhnZlB2icaN0FtMch3uNbmlOAfiGpisXNxNt7fKOY8A82sEmC5Dx3Ej2EpgGFottWr50Yf3fcL1enKvlxDFpZ9c6zQAzqIlpjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502025; c=relaxed/simple;
	bh=nk/WbTc65x0MQTRrpgH6F0KE0VlfkVLgs4Zmlhu5Ltg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lm7gMnenvsB4bMLmENW6bm7nBUesZX1JO9z7xPAurigfd/+22Mb9YRWIOg2crLoAJcQbnaLvlsqvXZEYaKpTfF7wk3EFhKzss5EjrVkBVF7/7kiJ+siuNVebfyEq8hU8X782BcqRBl1OWq/ro6Ekpkqz5fqOzlbZsyNAUMclCm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HLXv/98v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HLXv/98v"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464YoK940714;
	Fri, 4 Sep 2026 06:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2m73t+p3cf7YFlyod
	aF9Sl18fncFvXor64rKV4J4zgY=; b=HLXv/98vQ6nB2t8Uz7O0q5KII5XgfQkqt
	JZ0zSHXJkZazu74KKQ2r0e2wWZ3Cj0cSMC05cowvwWjitCFKVm3WlLQ6TcAeBjhR
	21OWEPPRvS6qoExEbKEd+1SYCNNDXe29Q4i5/cGxpjeJHByzkhqtkEv5MTCMu5B0
	BNPvO1mteKdTMI8OXcR9oCeTLA7TOLnZhuGHJQupzTjGx9ymUo/EWLv3xGnbeXPS
	W1sTRbM312VfQEKZ9LUN95AvzAmGYIIGcsG80kx8dSigHkGBVmuQb3pLJJeoNJVY
	Gq9cNhkXqGq2j7YniIbKSDOv/hExDrXTE/6sfvTdsYgN+7kDo6eOA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq559392-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uNjK002210;
	Fri, 4 Sep 2026 06:06:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqun2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68466q6N37880110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:06:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A28A2004B;
	Fri,  4 Sep 2026 06:06:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC93C20049;
	Fri,  4 Sep 2026 06:06:51 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.53.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 06:06:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 07/11] KVM: s390: Fix potential races in dat skey functions
Date: Fri,  4 Sep 2026 08:06:43 +0200
Message-ID: <20260904060647.562443-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904060647.562443-1-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX0J9/cJciA70s
 KTR8K1/MPn1hCenW1cXhrU6L0kDfsTldOfGPILztl1DI9UXRLAUQXRx34SpDtyTajKgGbiaFiri
 l5w9K+aDmMjScGX9pzXY4YLxiHpOFy6FMAHhubDm4GA1Y23Zg3gWtdCRxntVg3Y0n8G1oWjrup1
 ZytryGwW34EEF1KfEuBv/wxbZ0gVUdN35VNctIwvrQVi0sO0sD4C+p2THwYNs1a+qzUqZamPySW
 6+PAQrajoZE84WSgSLqwNBtUC3siesq0EO15mc+Zdv/ZyaH5w16uQedXmFmON1bx9rUvZ1bmZ5y
 YKlydoBOeMYN4hai1McXhGxOfh0kdQkg3CQtiM7XB0A6cy8eijibvpz+c3hiRIrJVq4JfKHGjsJ
 DGyKBqEVsFpJmtnpsd377LGTk+cgUrC9nYbzFvv8YITG2lyX9UcpIjzODxUOTrimEbbuSU7niwY
 Xra/AuddKAmWcXNUSvw==
X-Proofpoint-ORIG-GUID: k3t8WoGbKsBxj8gRUyecV5iP4cgZUMQm
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9a6002 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=T2_W0lP0jn_hVg4osoQA:9
X-Proofpoint-GUID: k3t8WoGbKsBxj8gRUyecV5iP4cgZUMQm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX59DcfT9mAiH7
 tWox8DHYxE0Spw2QODQhXzx0ub2RYBFSdUWvMb+f27sVzyX9vjPz++SazO8KX+eyzU0coqlcN6h
 GwRi/A70wVPcjqWJWSpt089tlMj1Qwo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040054

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
Message-ID: <20260828115439.145885-8-imbrenda@linux.ibm.com>
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

