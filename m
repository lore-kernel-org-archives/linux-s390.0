Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDF476699;
	Fri, 14 Aug 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718457; cv=none; b=pvNBp9AuBmuvUgr2b9f46I415CX1X1qkLO9EcI5cUIPNe7Gip7vrXSRHhKBHVafx0v0l9mimLbcjj9orMX6c79PDs6Tq1aXuIosxn6nkPpKq9Nn5Rf+uDZYCTlb185IRXp2/QW3u+aRsgcjNnyOaihq+FGU+ciOreS8akJuD6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718457; c=relaxed/simple;
	bh=99mCpKsKgMSMna3npHucj1EMAgFp+JjZUq4Ju6s9Q7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqxzF7Oa7OF0uJql+Xi/SebhQAbu4xGLsp9Ss5pZPOECNGYO/PzA5LRMqC6W+TKTHVKmJb9gDsuEFgNTdkgvNGEyvowRNwCjPEunwdJJ1ksRwB4MLhFbdxHsYOUrHt2EPQ8sf6XUFctTj8Ncq+bS0ozTWofVrYTpK13hW2qdhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kPoL3+oz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kPoL3+oz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5unR1343452;
	Fri, 14 Aug 2026 14:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=30RofdWLxvQ5WcM8V
	3wNiAmTmagK9/Yrlbk+TyjGDzc=; b=kPoL3+oz1Vhma5m1GxbF//6eW6lSiaqrC
	YjvcfItoJN/16+zIVHWewF8ZlwsMXPqEJBm2pvkS6BdzvS/q0RqhJLRVGg2fyU8X
	Nl/wB398K5ArY9ImOCSiK7BXxHVVDmo1szKGrdn+IveYVqrbEBxoPstJmN1glUun
	Aw1zcCb7C5Ax2Yyr7bdhd1AYsORHfOHy4TvQsFqp59KYbZjaSR875LrlIq1Dxl4k
	nZ4dI0J14tWOWto6d13f2jRgszGkbV0CMIeqEjJPKCRu7gS0CpwMQjBGDJKX4B2+
	bS067JCZMTQKV53c4SBU9ZNbJTiKS5bzBKTca+eWBQyeoofWsujPA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma5b56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EEQKkn016811;
	Fri, 14 Aug 2026 14:40:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wfrty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EEehrl21758606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 14:40:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4880A2004B;
	Fri, 14 Aug 2026 14:40:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24CD420043;
	Fri, 14 Aug 2026 14:40:43 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 14:40:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 6/6] KVM: s390: Fix potential race in dat_cond_set_storage_key()
Date: Fri, 14 Aug 2026 16:40:41 +0200
Message-ID: <20260814144041.169025-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814144041.169025-1-imbrenda@linux.ibm.com>
References: <20260814144041.169025-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX0dwewHVWXo6O
 mUnfrSzOOnUdt2Ho+x4EzcTN8w3ajKrDafrVT0NC3dRJZJgRizayhS9u4Fpf9FXt/8tFGeJxE41
 fDykx+Ec/wk11aRZ3ALR3GPHZSs7YkJNEmHpdC1C+zCor7qyI9ABwVVNxmZyREyHdvlwrF2LoP+
 tVAZ0dEqn7ETbLH+pEzlLsLPsy4vrhvdp4kBVJT7erbK+gH/Zs3AZ4EVMdGNMJWAGxm4/xbkOzZ
 mUxINNXFfzhXMR0V9DMBZI220L5dX1JyJlKYkWv+ge7EGWC1hc2y7IxZsgejzcPWxPjo7TN8fLE
 pWIArowIJgMo/ar/8e5/UTA8hfs4qn94jg92wXAsp+6p09BbMZ7WTg5AFici4mH+0Sy7/OG0ZFi
 tCf6xidPi5SpqcgS7u4LBYBakOdZsqG6r0/OLodMcy/VxFsnkc4aDYBbPAzrCoHT/Zh9l8lL/nn
 f4i0b5wMcN/jNyCBshQ==
X-Proofpoint-ORIG-GUID: j6L-Yk1GktosYrdKTAhUJ3dSxUZBwv2N
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX0h3KUbyeBdpO
 QeY5eT7SxYXpUHey9yEF1MooNyW0Sn8omkAfcmoKru2pobbGM8fr7DKhjCOCtBwQ8LI+oXZaGgA
 Z8X2CVzOQ6WiDGGesqsvpjkWUpVGbJ4=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7f28f2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=wsP9SkaD_1DqgBQrQ4IA:9
X-Proofpoint-GUID: j6L-Yk1GktosYrdKTAhUJ3dSxUZBwv2N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140111

When dat_cond_set_storage_key() finds a large page, it will
conditionally set the storage key in absolute memory using
large_crste_to_phys() to get the absolute address.

There is a race window between dat_entry_walk() and
large_crste_to_phys(): the large page could have been split
concurrently, and large_crste_to_phys() might be called with a crste
that does not designate a large page, leading to crashes.

Fix by performing a READ_ONCE on the crste pointer, checking and using
the result, instead of dereferencing the pointer again. In case a race
is detacted, try dat_entry_walk() again.

Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: storage keys")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 7e5dd5a1eb1e..b467b95689b2 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -713,10 +713,12 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
 {
 	union pgste pgste, old;
 	union crste *crstep;
+	union crste crste;
 	union skey prev;
 	union pte *ptep;
 	int rc;
 
+again:
 	rc = dat_entry_walk(mmc, gfn, asce, DAT_WALK_LEAF_ALLOC, TABLE_TYPE_PAGE_TABLE,
 			    &crstep, &ptep);
 	if (rc)
@@ -725,7 +727,11 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
 	if (!ptep) {
 		if (!oldkey)
 			oldkey = &prev;
-		return page_cond_set_storage_key(large_crste_to_phys(*crstep, gfn), skey, oldkey,
+		crste = READ_ONCE(*crstep);
+		/* A large page has been split concurrently, try again */
+		if (!crste_leaf(crste))
+			goto again;
+		return page_cond_set_storage_key(large_crste_to_phys(crste, gfn), skey, oldkey,
 						 nq, mr, mc);
 	}
 
-- 
2.55.0

