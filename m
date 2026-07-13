Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2681346E60;
	Mon, 13 Jul 2026 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963568; cv=none; b=F/UYrfDedzSNdnBQ+wJs0Pu+XlyRQo8It3PXfYNCxhk9KzeG5dXC9HzeuX/9q4OT4NXEJV/vVr2D73L4ZyRjjxWtKKWqZVO3GBf7lQx0aoZbdmPvBnS95GtLN9fq12BEG6ziKJaWQJe4yKKOrd3hhj9lyrny2GMxzvjKsVIDvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963568; c=relaxed/simple;
	bh=kRib6+pCFP2nyfSJA5RosilzPMFkv6sx+/aIXrBvA7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeZ20F3e2SlG0IWKoS0F1qt6CMtRqi8cLmrNdv57qxgdKX32Oo5xb/9zCbXIHIzYd0aKZZKmXFmpGsWc8qXBgTqCr5kIVsgeFwVVAJCNo+dmOiMv/m+aDAgFWabEWFYiodSmv23Vw+dI48xbwJM0l8gab13N3BLufPDrV7iANZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lAGoANNK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lAGoANNK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFEP5r2770694;
	Mon, 13 Jul 2026 17:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=D1hBcD+/Ho6KnPOs5
	M5nq6yjhtFvFa0TV0vp/WMqsnw=; b=lAGoANNK5u2nTwGVGxBukAy/f8nGmadPy
	e/yOGlaEjG+ZczccMLqWZWOMFzL10vK632A1tob3RvhzuuyK9qGm+UuG6KBXqxBS
	u84usFRJSKICO3BQxXkVzo2MUdE2aR8Bpv7ZJ99tMh73Mr6y0ixFQCsv1D2Q0eh6
	FZIB7gP0DYaRZsfiBWynAaXFwZLVPF6NU6EfhYwx8T6b0BsbQoAx3vurf7KGQjt3
	hdJ+hNRagOADtuL81m+QqSSiRXn7u4JjRTzveuIeeOUSfqEXuoFI6b1a1A+anz2B
	0LLa63Ikg62uW3CfeFKg+utU8VhKMt2JwqyPxQyC86vQx+IrDWOoA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwhjge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:26:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DHJbFE002526;
	Mon, 13 Jul 2026 17:26:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jpu7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:26:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DHQ3Px32965238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 17:26:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85FB558060;
	Mon, 13 Jul 2026 17:26:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F6A258051;
	Mon, 13 Jul 2026 17:26:03 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.249.24])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 17:26:02 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com
Subject: [PATCH v1 2/5] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Mon, 13 Jul 2026 10:25:57 -0700
Message-ID: <20260713172600.1284-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713172600.1284-1-alifm@linux.ibm.com>
References: <20260713172600.1284-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tUeDD-S2RDqJKDzyC7UbJDY6WQwdjNx0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfX4F7l7OSxllW5
 njJ7jYNUMIrdktm07jRcsfkCgawaTaTjhsHd1Ndj06kBlz0G1vfDoLcoFGISvrhGCm+QbZ+wOV+
 QLpbogzA66VEcj35NI3oxg13MMfeuR6qgya99ktHO2zz+FIwrB84cH+g/ej66lndB4A/fH+kkWi
 QWBvhgFRvKxMXefCoRLHTaxEOY0nTf27GaqNt82r4v9bmv37CmVZIkEVHCpf6Cz+yHbRdgMzbxi
 1uHHnzCXACto3e1G3O8SGRhKWHuMIkw009axHQ/9LxXDFP7eqWty1arT1XU6RzmcG3akIbsL/um
 Ge4m6LzYDZPiPahjnAJKnZXgdASgRhlwrqL9Z9WOAOY7x8NLYJuvLYxsUYqkJlGoqlDSHGwR4p6
 fSuHXB8RBHo8yO4jYbb2ZSvCqZM1lYOHwaHUzKq09HqB986P+rr4YmNheXF/8ApWF7uNzphG6mP
 oRG+X2pqS8/OON62rSg==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a551fad cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=g4erIPh_aaDScpLpsJUA:9
X-Proofpoint-ORIG-GUID: tUeDD-S2RDqJKDzyC7UbJDY6WQwdjNx0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfXxLCj65X3m2uh
 RFvKYoHNQGZ0rO/UKhSv1Lg3+tgIh8q8cWcga3c5t80lHO36Q2JKj+8HVC+3jLsuc5+vtzkHD+k
 qvh/m78aUZn2Jn9+Nzzk6XRqHxYDPJQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130178

In kvm_s390_pci_aif_enable() two error paths failed to set error code,
causing the function to return 0 on failure. It also failed to rollback
memory accounting on failure. Fix both by propagating error code on
failure and calling unaccount_mem() in the cleanup path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 5bbbb1de4b5a..42db20c2afca 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -282,14 +282,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(pcount))
+	rc = account_mem(pcount);
+	if (rc)
 		goto unpin2;
 
 	/* AISB must be allocated before we can fill in GAITE */
 	mutex_lock(&aift->aift_lock);
 	bit = airq_iv_alloc_bit(aift->sbv);
-	if (bit == -1UL)
+	if (bit == -1UL) {
+		rc = -ENOMEM;
 		goto unlock;
+	}
 	zdev->aisb = bit; /* store the summary bit number */
 	zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA |
 				    AIRQ_IV_BITLOCK |
@@ -333,6 +336,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	return rc;
 
 unlock:
+	if (pcount > 0)
+		unaccount_mem(pcount);
 	mutex_unlock(&aift->aift_lock);
 unpin2:
 	if (fib->fmt0.sum == 1)
-- 
2.43.0

