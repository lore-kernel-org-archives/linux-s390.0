Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ABF443AB2;
	Thu, 16 Jul 2026 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224372; cv=none; b=im6FUc84Ag/cvODGRBV4JW9bGKMABqZKn8arDW5dJb56+TvmRLhrxe3Xmg/nfHAgSEnZIPixTL3PJmJGsl+LelTu+NGwtCv9XuYhxgDV0jBlFycJk8SosfzwNfVz7jPm5/qta8KtdKrrkakEASDxU936OvMfbeibnxLUFQEoHA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224372; c=relaxed/simple;
	bh=UWdOZNWZXME+2Yz7BGzABGZKWdPgE+RuBS0qOAwoptg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajgoxjoBRRkWr5Kw3vy4xjUGHBjYnGlbbqQRftJPmGeK67PLrAtbKvAsz5j0++6Ah4MJyeKPXYH/8ZUQdeQxGjlJ4lpvwpqB6MQRw66i/tr3EnCnpJYtlgZmbkaHP2DHrFf0ojFKvGAh98/rLHA4NCBwPiuoFWbbLxNwew7pT9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W3GF3puw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W3GF3puw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GGft4H3678372;
	Thu, 16 Jul 2026 17:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o/jy0bzMaQjq8R5k+
	AwwaVrD/J+EDOrQRIcnF5S22bw=; b=W3GF3puw1TzHr4dbJFWSsj/hZx6sab6B9
	lHSIi2GowcKon+mrdRZRBVHSIJZ6MzBVuZ/UqFnQG7PEFYf73/uOGU7kqUv2BLzM
	IOzvKPLFtcsgR9fqW+X01bDp76VN7eXXQduy9yr1ty7Scbue1guLktEpjTdCEoNK
	jZl/ov4xg1pjAinp+fhSsDGhY4KMnRkCSDyJ6d7peWGDrH1w7lHHTxxKLMhJGekS
	q3rlqu8TMaTP+BiR8K7CpX/CYCaOh4W67AwT7h8osBMNLkWoKciiSePLsbxirzri
	ddX9pZcp5YDZBIeI6eISQ0jjj8Fqu9tHYI2ZkcfnOJn0qjgYy8jNw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2ahgd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:52:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GHne1l020733;
	Thu, 16 Jul 2026 17:52:49 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhp2yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:52:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GHqlJW21496388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 17:52:47 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E3865805C;
	Thu, 16 Jul 2026 17:52:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0A095805D;
	Thu, 16 Jul 2026 17:52:46 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.47])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 17:52:46 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v2 4/4] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Thu, 16 Jul 2026 10:52:41 -0700
Message-ID: <20260716175241.1039-5-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4MSBTYWx0ZWRfX7/SJZYxEhnAz
 HD/70NcLYI+pArOI+X+v04CSjGhdypo6NxSZAMukbtzku3YUH4pvcdpcDkaW2gEvI/SqnlW4QKw
 HVwQsnWz8mjMz0F8A61X7C7f5pHgkgU=
X-Proofpoint-GUID: vK18012Y_ahZg_mt3T3mDGqsAsuckNBP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4MSBTYWx0ZWRfX+sZAXPTvvOIc
 chTwV0ATXrEPbmp4YRnaeYPdScGEZOpzkrYZDKACD5KmCqZ/NCASpVRLNi7Bz3ibVLgs6TqeTXm
 NkN+Ams8GHCsAo6sgeYnpvJesyJ9UeUq+xtx7jpxEb8I2gXoqh/JVkMLj35Heyj6luLqvAxhx29
 xz1GKXoxFqXU2LoL3cHipScwP24fMH2A8HG+PPxP3JVNPee616HxTazB5an/V914RFr0ugnk8JC
 pMpei8qIiM4RNBv/9ZojEgYi+7ypdDYJOc1u0hOFQzPgooeIRJ9eAu+lCy5wF5SQ9/MePMbMoLh
 UMzbydtyTvx+hKp6KKA2bhmT22hNc0CrnPDZOWFLjcX8Kv7zYiLSq5ax3qbsI03Jw0SpO9Wno/F
 T27GzamEHI0ulrfiGFx7Cg3zptorvq36OjIhF7NrFA5rrhJT9jrj3E3KO5+oyVgbG6+YGjZL6KA
 u4zoP9oVaAPusEMc8+g==
X-Proofpoint-ORIG-GUID: vK18012Y_ahZg_mt3T3mDGqsAsuckNBP
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a591a71 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=S3gQTLpqa8hfpVGigeQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160181

Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
the error code but doesn't do any resource cleanup thus leaking resources.
Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
unpinning any pinned pages.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 85f4fb5d36b3..f85d856b58c6 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -345,11 +345,29 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	/* Save some guest fib values in the host for later use */
 	zdev->kzdev->fib.fmt0.isc = fib->fmt0.isc;
 	zdev->kzdev->fib.fmt0.aibv = fib->fmt0.aibv;
-	mutex_unlock(&aift->aift_lock);
 
 	/* Issue the clp to setup the irq now */
 	rc = kvm_zpci_set_airq(zdev);
-	return rc;
+	if (!rc) {
+		mutex_unlock(&aift->aift_lock);
+		return rc;
+	}
+
+	/* Start cleanup */
+	zdev->kzdev->fib.fmt0.isc = 0;
+	zdev->kzdev->fib.fmt0.aibv = 0;
+
+	spin_lock_irq(&aift->gait_lock);
+	gaite->count--;
+	gaite->aisb = 0;
+	gaite->gisc = 0;
+	gaite->aisbo = 0;
+	gaite->gisa = 0;
+	aift->kzdev[zdev->aisb] = NULL;
+	spin_unlock_irq(&aift->gait_lock);
+
+	airq_iv_release(zdev->aibv);
+	zdev->aibv = NULL;
 
 free_aisb:
 	airq_iv_free_bit(aift->sbv, zdev->aisb);
-- 
2.43.0

