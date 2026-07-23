Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700714071D9;
	Thu, 23 Jul 2026 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844859; cv=none; b=KVcdOqVHaJItFIica+zEY5RFOfQCYyZHgnlhj2C1ziuBYAuQD7lLDsDJ5He/eztiYt6iRoNpn4eGEXWLW35Ba/pFAptT77hvcZ2SeVY3EHSWav1d8X/sE/nHgv93ijlUUxN60a/dLAdv0UWoDwtB7PWVFstQc9S4dNkisJ7O7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844859; c=relaxed/simple;
	bh=eTUhxLhdcL3m5nLDSBqMtukI3bolpOlUGy7PrCpLP9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRj71CNATd+TFzeiuLNVYUNDvoX32//nYEL9jGAYRADFxw05IYTxEIbD/B1NkVMCzc7+TBNre1dt/grmtHNUEi18q3gOukScJ+NDCgED+AC9HCDI7NeW/g+ydeJSIZn4pC6Qmis80BTvhhkBYdK5i5y94qZQAh4aBogNaQKe1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DSK839Gm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DSK839Gm"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLfr3o4190840;
	Thu, 23 Jul 2026 22:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0ditP3I48O0xc3JbV
	5y4O1MbTHUZnFmkecjfup2QoGc=; b=DSK839GmKcuXJgoXg3YLuaiCdXrXqsZaM
	T7zMMY+t7WVEfAWx7gCZSUKK8QBOv1bXhzKqERcOzmmbDiRcaxNKv0mkkjNqQKkb
	aOTmoM7XgXYMaESvWc1JK0BNGGgMMLrjWgL4NxAzCwLTTJ8tKwrtH/HmoRpNi6Dz
	1Eys7t8HSsfEQvNXherSyw+kEXAPwJmOJxQ4xXtxVSPdq1qF9E5JsH0tOBkWfEw5
	1LYx7c+XNq8+qElsBj2sKSl7QhVmba5bPCPjrKs3jZhu2/iN5uOQCOtc5AIBYTT0
	Eq5OmNitfy3twHZKGAn9KRyb2elAdEBqqdzSW8o24q/H22P81Q+5A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahh8f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NM4dVt027215;
	Thu, 23 Jul 2026 22:14:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk69rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NMEDbB28639894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 22:14:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B86E65805A;
	Thu, 23 Jul 2026 22:14:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F9EC58056;
	Thu, 23 Jul 2026 22:14:13 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.245])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 22:14:13 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v6 5/6] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Thu, 23 Jul 2026 15:14:08 -0700
Message-ID: <20260723221409.5874-6-alifm@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 5ICDvvMv6NZToYVo987AmCR4xxlKUphG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfX306TGzgr+g3D
 GDAxD4TR7gtM06JNEiGG/7neFH08LHni68kvC9iEH5zmp7329I3cZ9S/SYKblgNczDGJqfbJCC+
 AG88XOB0k2M/Gh3H1gQo0NauTcP2ybgnqGfmi7hIV2j3UxYizZ8W0jWsoBXmXCfNYNnNrX/Ml7j
 xqZTN3OyRp7tWsjY+gAEMR5Io/bIwLdGahoSBGPxxxw9t0WW+XLmCGT4S5u7KHWlok3BR06GF7V
 AZ5EDKKGkbQchsFHIiuZ/gtcijHGEcM9jto6SZKNjcpuZudnwocZiY1tvkAaO8qyVUoLLmdFxAN
 ABEKoKIpKjM4PJ5WdDhTwxWCFSaU8RSUe4mJmTABchFu2BMOsokf1mcS0Ql4cCwHClnptIxZDc5
 TwO7/vOrwcuQ79+HIr0EoiKDoreHdysj7kvD3UAnGGo6vWOnG8w9aKOdCQd/K1CSAhj+m3KVlnB
 uApP8xfMPhygA9FOEPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfX/KFIsQ9fEFOe
 j72cV6SpjK5kPDcDARt7nMXIwoO/vq+8NUYpcatrO38rw0JyLc9g0+SOKlHs6KVzkBUse/Zidw4
 RPHv54F93wiUi39X/Xk3ziRI+6IX/to=
X-Proofpoint-GUID: 5ICDvvMv6NZToYVo987AmCR4xxlKUphG
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a629237 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=oLYdd9eN5-LzSxCheKcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230215

Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
the error code but doesn't do any resource cleanup thus leaking resources.
Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
unpinning any pinned pages. While at it, remove dead code that stored FIB
values that were never referenced.

As part of the cleanup, we are also holding the aift_lock a bit longer, as
we hold the lock while executing the MPCIFC instruction. Though this is not
strictly necessary, it means we don't have to drop and re-acquire in the
error case.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 602534e3cc10..ca8ef76bcf6b 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -344,19 +344,32 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
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

