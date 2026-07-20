Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B4446838;
	Mon, 20 Jul 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570315; cv=none; b=tsRst/8W45o9UDrALOwkiAYP/jyDOqosJOvG3KLXDm9ikmBCJkzJriXP+DwyAs3Dzxk/b1xdMsAX0vkbkY1B4lk9zECFRQc9FgHQD0PCpPjViZyRkLS5Yj3DYKjvkpUZj5AkVUCCNrvb1UFeGXi4dfZewzXZj/YtPrqoi6dSM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570315; c=relaxed/simple;
	bh=PCH+qvGdDSv67AzlxVv2kdTSWEsSuRaxvtPqygKjd88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHgEFry3raJLghSm2uup8dOw1OfEdS9gs5XNqhuezLjq09zF2Wsqar2r5zUvEqhAS6iLjOrPApEHQ8nPqTKs1ixvYDwFs8xKiYKLMh5i+eIL0/4N/DGVzTjp6yTgB/lmACFfqwsuB17esU0vhWV3iQw0Udg87pWqwE3u4Wjlwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XFTxx/u7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XFTxx/u7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBqFJ2731093;
	Mon, 20 Jul 2026 17:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JB94kMHHnT3malLj/
	EEXGKbkovRbQVu6ecUf0B1iHY4=; b=XFTxx/u7q2hUfsjaoa6qU4YCOC1GnABqr
	DKIsxSt3qkTrnxa0puMQ5uP3umXrqNCI/aXRarr61jkgX/rteNFqgq2ajOWDwYGI
	1y8jSceiC8qDyuWRmT5KPNl6JzUMR9weibE77RJs9QyxHrNmgfui1Z2jkD+lgp04
	BwRRyr8Y19fFE9uif3RhGJpr5byUAk0CqrrcR7Kxn/ylWaQz32hBp6jzaCsh/pPS
	7eqaKeqmqncs1cVeZsRlyOwYgSVCE5aumVXi/B0Vo3TFj5SBHCkmM1xdIX3IWCj3
	+TaLDzp4jwSOI4gZ9F7+A8qznXA175clnvM8N6YzPsFGEtaloVSqQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k0jeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:58:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KHnenJ004376;
	Mon, 20 Jul 2026 17:58:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy6fag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:58:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHwPOS31130254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:58:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93CBA5805F;
	Mon, 20 Jul 2026 17:58:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8BEC5805C;
	Mon, 20 Jul 2026 17:58:24 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.89])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:58:24 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v3 4/4] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Mon, 20 Jul 2026 10:58:19 -0700
Message-ID: <20260720175819.1723-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720175819.1723-1-alifm@linux.ibm.com>
References: <20260720175819.1723-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5e61c4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=bWxaYIw3U7VPAN5xrwwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5NCBTYWx0ZWRfX96JQHRPQiTrb
 bBEQPdzudV3T+NwV/tWJ8s9QZo1M/PtjxVzwG3/X5wGlIy7ORaBvo6dyPnEdhHFY3YBrp0jmVGT
 UtMyA5OXNP6v9HCf4g+gmZgmNsIfSsbnK5RMbLC0bjMGiO5TtpTyCZ1j6QqZk8iwImec6PVOIER
 iDuw0wj8C951R8h4vAqFl72O45QiPAhbBSS6jRDeUga5h2QliZkfzF+fPbl40uk7jLxiyX4hUKC
 FdnVNLKnP91Wr4pFnQ2T02NSHflLr00lv/yz5uPn0e6lRBZBW1jGKfKaGHze0IXHTtL/haTI60p
 /YxXtOh7DCo8JWHGHD8DskS2dtXE4VKc/px+RNc5OGWxij57q/NTsqOHYrD2sTbUAFrH0CJz3YC
 Eu5Fsi50HhGl3zRG2NCtzQgkfOnz5F18odvujOwnLjLPeQB9dmLPFrLcqn0U9sD1uynT7PiAKGF
 N1z/zfNRQBV7o2Up/tQ==
X-Proofpoint-ORIG-GUID: Yx4calUQDy67hWPRLqB9TOqrVmQyFjVk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5NCBTYWx0ZWRfX6RsIrN0t66h8
 O32gHaiBPZ1YkzSk78PlGNxG/ZgRHjz0diRSmwJMzfxBKK+sXS4LeTgj+ByVxz75KfuBzDV9Qfr
 O+/GdVAwSSP5V+I3kvlx10qo7VzjF6c=
X-Proofpoint-GUID: Yx4calUQDy67hWPRLqB9TOqrVmQyFjVk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200194

Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
the error code but doesn't do any resource cleanup thus leaking resources.
Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
unpinning any pinned pages.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 85f4fb5d36b3..d328bbd0dd99 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -337,19 +337,32 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	aift->kzdev[zdev->aisb] = zdev->kzdev;
 	spin_unlock_irq(&aift->gait_lock);
 
-	/* Update guest FIB for re-issue */
-	fib->fmt0.aisbo = zdev->aisb & 63;
-	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
-	fib->fmt0.isc = gisc;
-
 	/* Save some guest fib values in the host for later use */
-	zdev->kzdev->fib.fmt0.isc = fib->fmt0.isc;
+	zdev->kzdev->fib.fmt0.isc = gisc;
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

