Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B023ECBE5;
	Fri, 24 Apr 2026 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059550; cv=none; b=ZkrwCH0bYR8RS5HWXHHDA4s/Yxom+d6L/8Lcg9zs4eHziBCY58fL6jRiYnxHvTU/F1V0NZjyY9bwnUvjIszqNOUWGT4+eNxLUsZRhBbaySPvj9ESej9t5vhUF6hN319jE4wzmppPhAWm6nVRaT39VPsgQ6BCGHsX9bPNdZCmJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059550; c=relaxed/simple;
	bh=RASnbwqalpFGwkiDz20lzK83CJ6MAa1aWCQBiOAXD78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tyMDN999EMnw2v8Bhwdt5wh+fXKy48ZKwBFemBDhr604xI12ec/+Hs3ZVe79Y86cdX1nHr7pifrnVGXloMAm1sxynDx7C/aZFCqnEg7YVOU22ick7gw1iqrR0Yp4PPpVp5w5XkPCQxZOUc4lqTL6Z9zWsmXk5p+AuPjhCr6tDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pwka+Q+b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pwka+Q+b"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OBF0WE3108720;
	Fri, 24 Apr 2026 19:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1g3hIKe5SzgfRdx89bKW0skWGPafTPKM/83AXfZl7
	iI=; b=pwka+Q+bTNWQChkbX6KDELcdDhK503nyL52vI3esveMNhaVN+DM/Gm0+m
	EJ0UJTwmiDR6a8zLCKTd4h0/FvizCxSERmaMImPGP/KF5agG8uV6dAuJdl8F9JL2
	1R6AijvyIh6OtNG36AXjjLq10ktQ3XPCBhorPyloFgvrWc6m8skQsh9drdnTwBO8
	g+28HtZLUc9AgdEFQK+sl20UA7QxirGKnsO7Re6KuF4M6ndhQxXuwtsaAqcK7ssy
	SU1Jp6jz7dn1gtLhbk1cf7eaXvQbGCAhAlV4f7JWG6c43L92yed4qmQgCLws+nBs
	g71S94bvs1f/Bp87NTi75AmfHze7Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6pp2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 19:39:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OJZJvr019920;
	Fri, 24 Apr 2026 19:39:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyc8f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 19:39:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OJd29t12059184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 19:39:02 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76E0C58056;
	Fri, 24 Apr 2026 19:39:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8452B58052;
	Fri, 24 Apr 2026 19:39:01 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.79.186])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 19:39:01 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, schnelle@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: s390: pci: Fix aisb calculation
Date: Fri, 24 Apr 2026 15:39:00 -0400
Message-ID: <20260424193900.940816-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE4OCBTYWx0ZWRfX8r0bpvQtUi7L
 QhhTLIEMfBPJrHdv6Wv9RZPl9qlc9mBNGtHYX3sy4td4fsgSRyOfd3Lpw1wpWACbLXAGxRCk510
 ZYz9IZ1syTxoQlNN5C/XCR9CMgtRAzkhqT0l0yI/SikyHai30Rpnz2ZBlN+HUP1muX94YbK7Xgl
 NAfyuxX78pO9oHXF9dlqoQyMSQife2fAjj6wZm37rbFNdq1tsIV9IW9uJufGXTp0ADjOI6dS0ln
 cLJ0jda+JKnXxCMWKFhKTD7J9BXoVKZOo3GvywFGWubnvKaQrCQIAZoKgPKw5bSozMWRVAxsunO
 b1hzZU9VIaWtCW4lgfN4bBJDV9B/qQfsqhMiHkraUPnfk5oic2yfjIpL9mw5YN4taavDUyBfO3k
 51/+BJR2J1ajE0J8U9fGM2tVU/rS3d/o5m2c+c+AWrScw53XENV+eLeZ+Qz5uWWND+532G6kYpW
 f3qU2pWBiEprTsRj26g==
X-Proofpoint-ORIG-GUID: OTAwnfp6YaxnXtp8iwEHoJAWxX94JbF_
X-Proofpoint-GUID: OTAwnfp6YaxnXtp8iwEHoJAWxX94JbF_
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69ebc6d8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=D0XiIlwIJVH3yKn5C8sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240188

The current implementation of aisb calculation will erroneously index
via an unsigned long * as well as multiply by 8B for every 64-bits in
the offset; only one or the other is required.  This throws off aisb
calculations once the number of devices exceeds 64, and can result
in out-of-bounds access as well as failure to indicate summary bits
associated with those devices in guests.

Fix this by converting to a physical address before applying the
offset, as is already done in arch/s390/pci/pci_irq.c.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 86d93e8dddae..338171f9371b 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -166,7 +166,7 @@ static int kvm_zpci_set_airq(struct zpci_dev *zdev)
 	fib.fmt0.noi = airq_iv_end(zdev->aibv);
 	fib.fmt0.aibv = virt_to_phys(zdev->aibv->vector);
 	fib.fmt0.aibvo = 0;
-	fib.fmt0.aisb = virt_to_phys(aift->sbv->vector + (zdev->aisb / 64) * 8);
+	fib.fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
 	fib.fmt0.aisbo = zdev->aisb & 63;
 	fib.gd = zdev->gisa;
 
@@ -309,7 +309,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 
 	/* Update guest FIB for re-issue */
 	fib->fmt0.aisbo = zdev->aisb & 63;
-	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector + (zdev->aisb / 64) * 8);
+	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
 	fib->fmt0.isc = gisc;
 
 	/* Save some guest fib values in the host for later use */
-- 
2.53.0

