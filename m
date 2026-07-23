Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615EC3B71C6;
	Thu, 23 Jul 2026 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831695; cv=none; b=CO2JkyJo0OoqYd/o/mfIclsyJY2FRgRxlmlzFpT26ipZbSyigknYlbnVjvb31zIQfKlIdR40VVzgL92wBI5v3X90g2ZmuURe8FBuLwYGWd8zG7lCdpAksIRpqq04bfYYeKabwwrBETh1cF5sPYk0Xphob2klx0cJNkK6BjUeuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831695; c=relaxed/simple;
	bh=cACEiM6Nq+6I4fyIVQbBsqHVLzW5fcBPUsr1jB3xDMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0RoLJGUrjSv7cVz5TeJwGG0p+q4UDYORwtkBg6ceYSB6RwDTGhfbPynRLgv5lAmnIvuWJEWo+t11CyU/qZzK9QpamLHA5qmy3j96exjRP5X8qecyYAAsjserwoUE5nBwGV/eh91OBL/uLJdtLEczt/eenmONFAEgrQhLPfjegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QP7dXznj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QP7dXznj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHgb331806161;
	Thu, 23 Jul 2026 18:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UHxpgyzoTI4Km5fw2
	6DQzeQjQssmfWgLtDByRdwuZu8=; b=QP7dXznj8AYz5Pejb44RSFSrX9QhHJ0xI
	aEZBqXhc5jlrZr/epZ7vFvLz664Qv00yJY1Owq+Ng/KIdjVPOU9D2pUYIHw0MT4U
	2TGVo0VlDgWPj7lccZvbMDjY/Dvs9yghf7lsw5qG3TJ3BdpeUTuKI2Woz+tTNDM1
	o8Mxg16NRmY4OsWlG1iW8n4aGIGgsodna9fgXVjNAHBwnEzFiPg+b/RsLjS0izYi
	7KeMFtASHBPFMYwUDnyzAhr41y7rJL1T4hy/2NaqEnYRKt+PrG0RKJNZugaQ4RP4
	+DmQMAU6tNK6lmH/slm8M70G7Ld2nsjHWL+BgxNEY0KJNvIF3nqCg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77as2tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:34:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NIYdlc005311;
	Thu, 23 Jul 2026 18:34:46 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wdmg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:34:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NIYipq29426182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 18:34:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6952758056;
	Thu, 23 Jul 2026 18:34:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 985E158050;
	Thu, 23 Jul 2026 18:34:43 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.118])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 18:34:43 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v5 3/6] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Thu, 23 Jul 2026 11:34:37 -0700
Message-ID: <20260723183440.3271-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723183440.3271-1-alifm@linux.ibm.com>
References: <20260723183440.3271-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UJfjIU_HsYcgzBkwyyip0T1dd9qNtUWn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfX1+0MWlQHCCdL
 zVeJEpYU1nfLVVFyC87829PCN+S3QUZH3ZcFkkXygEVH6zSiUZ3KUBPFGzrVyTecZ7GC3KTtQq8
 kIJtlZu81opWrjOaYdfxU6DuIISZbFE=
X-Proofpoint-GUID: UJfjIU_HsYcgzBkwyyip0T1dd9qNtUWn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfX03Z2LTkuYjm7
 nup1BF+1aeCx6wKB7pac4ZDdvM9Btbhh8sE5sa82IgapjSgjGRyCIf+9UfXoZ7mtCxJSOtxk7Cl
 TxkRSc11OAmWgg/gov7+HbCaXGp5fnny/+x9w6I4g9s/f2aXvIdoaw2/4t8wzUELo5AuwgF2Jnn
 KtknCZRqpCLsTeaB+JcI19qHvyNeaoZqB3mUnhEhGsSe3NgRLxFWOoiMSeBkpioheNtwLTdqxs4
 sIQZcxRxMiNjjrBpLg8Mmi8T7T3ADvBERNsHr4f4B/sXkoBBCSjDqtbp3/1chgz+xgvtbaL6dvR
 NQ7g3t0AdBhM8EWBoqahdDoJXwSznO+dcc5hzy8FMPNfqaQ/GL8jol6O4Dqwa5lWYvP5AEVYPzu
 930FkpUQRMJltvRWSnck3jGaf44nz6OwBLLzI1y+5JgB2oNfRHjBdGvZPiy+YSC0fFkm25uZqBI
 Y36NhPBXBJS2USktEJQ==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a625ec7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=g4erIPh_aaDScpLpsJUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230178

In kvm_s390_pci_aif_enable() two error paths failed to set an error code,
causing the function to return 0 on failure. It also failed to rollback
memory accounting on failure. Fix both by propagating an error code on
failure and calling unaccount_mem() in the cleanup path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 44c00e5e32c5..f58d7ec0bc7e 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -300,14 +300,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
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
@@ -351,6 +354,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	return rc;
 
 unlock:
+	if (pcount > 0)
+		unaccount_mem(zdev->kzdev, pcount);
 	mutex_unlock(&aift->aift_lock);
 unpin2:
 	if (fib->fmt0.sum == 1)
-- 
2.43.0

