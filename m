Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE3403E97;
	Thu, 23 Jul 2026 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844857; cv=none; b=EyQz1JqE1qzCRCS1qxTL+hbRelMEEcVrnce2phBPGal9zdUJfdDjhkMcvkkIDeU9QCLrtguqP4mJBM1ZPaHRsQ2xCtmv/TqXV5Yy7L0BMSARmTEXFinc9/ZnDZaEdogs0/TFyoFHTMlDQqOD+o9/n/H/luQZfo85OGTNyphnAgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844857; c=relaxed/simple;
	bh=SbKNcsHNuuvpmBhdUM5aPMA2TeC7kEeDkvO2AnWU1DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsN1w/c5DSxNEFuTFXXFifMLWziFL/VNKZU1Ce0Pc/PnmokMwWnLzJ62qeVG/55E1/n7u4srIC/IbGeo6PiPA4rC5bX3Ff+PT881cP6N7MCHOaD8Fxho5PAIRzOKxzOWmpytn9XtlRPmqjH0xY9Y7A8LWUjuPPzDyUF5NjMEjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KujGQoka; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KujGQoka"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLfn7F4185875;
	Thu, 23 Jul 2026 22:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9BSAswjPgsFB3mwS+
	9M8RqhlvouBeOd1JU81W/D8CTc=; b=KujGQoka4k8Lw+gAKyU0QLP9wVmYxT8qG
	iGkr8ZUFle1oC7v0d3myzSnI4k7z8ufsU5az5dzSLSKZehuX9QWduQTypZx8pshg
	eMMJCtU/6MrDCvxHzcf/nmrKSZXb7UWxzeuNnUQGjAWIyG4dBXv6LfFj39PNV+/X
	OZ8TnsWKAqjJjFcjotN7QU1Rasmp6MdREFTkfsHGOKbjU/0lMBm2tqPzlvuStDYJ
	jMTK+YGB7cy97fDpHyHkYrNkCRIuMMqkQTsAhRmBqbKdVhhy8AeGh8DdPJg2WWOk
	zNW1Ost0dRCJzZ7AhaDCHnNm1404X1vk7vSekiGtKAdlHrl+I5UYw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abswx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NM4aIj024339;
	Thu, 23 Jul 2026 22:14:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahe89q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NMEDU130605900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 22:14:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10CAE5805A;
	Thu, 23 Jul 2026 22:14:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 712DD58056;
	Thu, 23 Jul 2026 22:14:12 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.245])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 22:14:12 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v6 4/6] KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
Date: Thu, 23 Jul 2026 15:14:07 -0700
Message-ID: <20260723221409.5874-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723221409.5874-1-alifm@linux.ibm.com>
References: <20260723221409.5874-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfXwWzHi2a9ZnIC
 wCjZpvEUquNpcG9gTmzglLbUvpEIjxR//3uvt0gtPTdDFr9A5PEDEXSQgrs4ufok8Mt/q6wQnYY
 dEsZhxZo7oUTPQ79Yr3U/Wym1TKWCdeJEnm304G22DRCiEr7b1dzH4UCRg8JnmHRnpVBP5iT45c
 /BMvPpRC/7pnxxr4kAFAqipQR4CCG3gkILUXq4zQYaEZ7bqY7h5ePW1VDceqNTTySAV3NQM9euL
 bk+VpD7Ck1/FwRVXCZcbI+5MOgIYeW/bqOPD+ywC/94KxuC6FJxUVBITSWpd0+iW99tY+87cHvn
 ru4xe2t2xkjKwh8jNopXEDd1ma0vozS55O1Z9T+JCtVRsJSI4LFqtcaDmz5qjX4/eyeE207ICPz
 jVW5nrpr8cl9p8KzEbTDyHN1WZKN2So4il2FJVHLXvcI04BZjyZRoc8YADSSkuq2c7PTyQBzrQZ
 Sf1XoWK4RAGidNNjpvQ==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a629237 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=VpFnpj6RERqEfYQjrFkA:9
X-Proofpoint-ORIG-GUID: CCfJCW68kNntKFx7dJgXYuhH50PBBiLC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfX3CsV3tAiwR3q
 OZjGfuOzaP9CpIn0I3nO1M3GntVtMburQuhzqnciwKZzgKVOjMqH0m5old19pwD97juHkWZRSPT
 SO4IRNexHgxyKRAhKpDamI373+9Xk6I=
X-Proofpoint-GUID: CCfJCW68kNntKFx7dJgXYuhH50PBBiLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230215

The airq_iv_create() can return NULL on failure, but the return value was
never checked. If it fails, zdev->aibv will be NULL and fail when
dereferenced in kvm_zpci_set_airq(). Add a NULL check and free the
previously allocated AISB bit and zdev->aisb on failure.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index f58d7ec0bc7e..602534e3cc10 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -317,6 +317,11 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				    AIRQ_IV_GUESTVEC,
 				    phys_to_virt(fib->fmt0.aibv));
 
+	if (!zdev->aibv) {
+		rc = -ENOMEM;
+		goto free_aisb;
+	}
+
 	spin_lock_irq(&aift->gait_lock);
 	gaite = aift->gait + zdev->aisb;
 
@@ -353,6 +358,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
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

