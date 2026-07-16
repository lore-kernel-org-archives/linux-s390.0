Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD873A0E8A;
	Thu, 16 Jul 2026 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224371; cv=none; b=BYZ/jveZQ7TC7NrbfKfIrwVzIQHiHatcUpcBnFExutzS2Vtz3vQ2ZRcKccOitVHnZiOT25sxhRbTohqSag+uJ3Zlh0N4IJ8NnqMCjDxEh/0zWqyaeAahhHWxSn2cyLPsggBYca0nZwjj9TSKANrubYs8iNLRaNNEwbLmbfpOXAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224371; c=relaxed/simple;
	bh=CcqKWYY7ZsYS5qGMWh/UlpC4JOWFday01Sj2aFj3F7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFz9tl+gMYxhbFX4SIYZvyFHMpSoIrg4J8uT9EzDcHgmP+xC3NOw5Ft6kfUKHdcxoc1n2pW6PGrbLXOuMC4XMwWsix5l8DNCG0LuT1XLRb/7WXB91cvdEXoc318fPvkxPoyUFfa0Gkt4qlhPGKaZVp36hyP/4UqiG/Ib5xDKOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fv49gaB1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fv49gaB1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GGfggP1866349;
	Thu, 16 Jul 2026 17:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+h3hHDJBubYDrmeM2
	+O+lmqQ0VlmK2E3XRocYf/CfIg=; b=Fv49gaB1ATb+xi9U2Hcs58kNza+WGhbYG
	i3+9vg3opD+67peLWps6ySMTxar4lXOWeIvRMZEGoxUQRpMa8evXHGDAItetGRTn
	WXgdB3Io6NxkVBKkBdAKXihUClap5qz3BPOq2OtPUpJbJ4YCEJzE0GZ1kHbLSO3g
	0+JuwIR7cSJV69UFaC7iMVu5tg3gD5qpVuTLDabNjCrSJyLrlMsfGWpJ/yJAhreB
	mxxVhmQE9ttnkjTWUWwd5V9bNrudG8ZgRDrJbqHV7X94BmnMt8FmdjyfgQdx5r+r
	mE7duCcp9JJqsUfyONSzAzi5yQZkEYOTf+hQZ7ToR5DkmTGEHV/3w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33jtbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:52:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GHncA4005511;
	Thu, 16 Jul 2026 17:52:47 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyduvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:52:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GHqkZb22938290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 17:52:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8717A58059;
	Thu, 16 Jul 2026 17:52:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0E4C5805B;
	Thu, 16 Jul 2026 17:52:45 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.47])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 17:52:45 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v2 3/4] KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
Date: Thu, 16 Jul 2026 10:52:40 -0700
Message-ID: <20260716175241.1039-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716175241.1039-1-alifm@linux.ibm.com>
References: <20260716175241.1039-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4MSBTYWx0ZWRfX9CdIMR5tN62L
 3xSlwAVDjau5V4uvx2LVZ9lDWDGmVT3kdIcCrCZbAtbpnO8GO8rZUVNBIefO+ewgYybTZzTdq0W
 FldRTp9lQCiCnGqgB2OlQmRUUp3RNXQ=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a591a70 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VpFnpj6RERqEfYQjrFkA:9
X-Proofpoint-GUID: LCQbIG4row-tHaDhqCyhgYQuk2BGyqgd
X-Proofpoint-ORIG-GUID: LCQbIG4row-tHaDhqCyhgYQuk2BGyqgd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4MSBTYWx0ZWRfX904m1TKkYeUV
 91qTtz5zDZvbSa/r3ytxiF99aPVqyVDbvVRkr5GpYoS/BidJSoMhPOe5qMqdRlxGST6ulo2lZrk
 EwyGseJUK96wqR2ZGz6dqoqyI4BSmi+krgbfvzXp9dbrrx1UxwsnEBEp7kQO40Eap4OVSVmMqw7
 tSK1/3+DBwTo2YZhZxJmnjAZ6A37l4391T5GSpG3YGK8iAfPPLvOS/XyKLMVyp+B7v0xFoHLe1C
 C3H5Wher4cqebUj+UwspRA++Jx6dtKRkagSAvPk6mWB7QxpYYLQE6H1ipS4VJvVQQHkyMYkpRj9
 amnpMNJgPE+iZAYpIkqCB7YmZfaFus2Tucz+LNl/LBR9TgarG30B8aa1RvZu+2hDiCa91dSgHiq
 SDNlP4hOL3iNtzVnaiydpnygarZMifLQunX4hxck9EOvZSSbZsKHPw2DTiAqY8lsnwtN+ewkaaC
 YDYGvv93AarBU6gZr7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160181

The airq_iv_create() can return NULL on failure, but the return value was
never checked. If it fails, zdev->aibv will be NULL and fail when
derefenced in kvm_zpci_set_airq(). Add a NULL check and free the previously
allocated AISB bit and zdev->aisb on failure.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 9fdb6e383b18..85f4fb5d36b3 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -310,6 +310,11 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				    AIRQ_IV_GUESTVEC,
 				    phys_to_virt(fib->fmt0.aibv));
 
+	if (!zdev->aibv) {
+		rc = -ENOMEM;
+		goto free_aisb;
+	}
+
 	spin_lock_irq(&aift->gait_lock);
 	gaite = aift->gait + zdev->aisb;
 
@@ -346,6 +351,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	rc = kvm_zpci_set_airq(zdev);
 	return rc;
 
+free_aisb:
+	airq_iv_free_bit(aift->sbv, zdev->aisb);
+	zdev->aisb = 0;
 unlock:
 	if (pcount > 0)
 		unaccount_mem(zdev->kzdev, pcount);
-- 
2.43.0

