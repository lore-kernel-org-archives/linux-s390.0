Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F9401A25;
	Wed, 22 Jul 2026 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739991; cv=none; b=Jnr4xjyJsAX63zjbJnwa8vzGYCZpI+Yl+oYswWfBDf+hDaB1Fdxeb9W4iqZcIR8hRvk+bh2/vZIzZk5gGNOOhahZuqb4g0SLxQW9uyJmobtJSB7dQ8x5cJLhICfn6DFudXkS2B3TY6A7yRGq3aDvtakHQBwoOs+Uu8zlfCanGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739991; c=relaxed/simple;
	bh=/ACkjr1TvXEP84dGVA4YeXKP8Wo555KsO/P7YhohpFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEyBnVgrxaNyCtgnAXNno/W5P4WO8wV9Gw0qaSWw1ouG+De2FypxsA6s+5OJLo0NB9hcXhizsviT0u++4Y3S+tETyztrTgau63m21+KBNtjIl00EMhvOCot26Nmp6VnP7CNPLuB+xo4Sk/JDQxfa4T41QFTxPd8Ptfx0yLDxsBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ive2TK+l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ive2TK+l"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFgFvS2692215;
	Wed, 22 Jul 2026 17:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oNm5d3PId3WDFe1sN
	hEu2rh0fC2v7sHGl4qNpwMZirk=; b=ive2TK+lRsWIbc20eP2mjzqDq+UW4y6T1
	jRr+GUM7eBY9PRcLt6rPVQhbV1Dd/AmLyIwXYgbVjxdQdaEK3FplzicHYoL/K84n
	xlyQrl4ap2ggnXGiggmXTn2dk7dJU7+TdmMRIrms8x5D6Z4INUPjA+E2UfpO/tzD
	fnvTA/pr4n7IcewQ/azcX5Q7dhe9cSU0OGbsfAaPiUlbXzFz8NXOvsLB+3Vp1jem
	HWZAswvULJ88RMNhTeGb9dwShVGK7vdiLbsKNZnAIjEs0yIfoH1ukDE1OKyaXjl+
	7/3WjM8OKA2cYpvTI9dsrtFxRLWkHGQSZ9P/rHissbMHY7bAondLg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77akcd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MH4dqj012758;
	Wed, 22 Jul 2026 17:06:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gg3yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MH6QFI6488672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 17:06:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C23F95805D;
	Wed, 22 Jul 2026 17:06:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE57458043;
	Wed, 22 Jul 2026 17:06:25 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.249])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 17:06:25 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v4 3/6] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Wed, 22 Jul 2026 10:06:18 -0700
Message-ID: <20260722170621.1686-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722170621.1686-1-alifm@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SqwDvS5CwKMSrxhFaU539YlGGGJOlyMH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX9mF738Etj1wT
 WxXOAazy4bQ4JGHFNYRx7L70QZKq/5uSu/7JIpANn15n3wzYG+3QY9ZUKhcrLAhtduj0kHm3hvm
 BiBwIgMIQ9MXi3uynhi0nDfCixgqVQw=
X-Proofpoint-GUID: SqwDvS5CwKMSrxhFaU539YlGGGJOlyMH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX7DxK2bhAHYQG
 ahSDOl2Z/4a8zJZ6Y54VfGZ1STXu+QKja1wZfbUbiw5kkFfJjmoVhe3k/Oplp2RgaQnyYqQu8Yw
 V84yDSca/iiyX61hLkFY8EOgclWGaO/Uw33bEwx1jWbiQgd115yj6wpP9jTFtxstzdl0Sf0a5c5
 4B9L8aKZBa2+w5b2VDh8RBpKhkgARN/3Oowu5cSHcaDF1RwZ7QvnMMw3bahWQWSztPT7SZMRule
 S/ZOczH079nfBtB5/a3IwstqtuZyCgmBVrXmVLeU3QCM1DQRSKBTICxCY2iQ56pGh/tkqCI9Chn
 0lan8LlqaDkyTcQ+/H7AtczH+94j/+BkJhb4IKJVwzdCdPqwh2ZvNb/60XCPOzpkfbuf/qkY59e
 lm9PTzs1PFT0x/pP04tn5C88BLjEOzTyoyDs3g6ag0XtdDmTIp/FtUjO01kRhgI4q3CMzYsCV28
 8VOvHyZVB6Ic/FGZ2Vw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a60f894 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=g4erIPh_aaDScpLpsJUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220164

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
index 1b3114c7cfbb..33abc15aa685 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -297,14 +297,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(zdev->kzdev, pcount))
+	rc = account_mem(zdev->kzdev, pcount);
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
@@ -348,6 +351,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	return rc;
 
 unlock:
+	if (pcount > 0)
+		unaccount_mem(zdev->kzdev, pcount);
 	mutex_unlock(&aift->aift_lock);
 unpin2:
 	if (fib->fmt0.sum == 1)
-- 
2.43.0

