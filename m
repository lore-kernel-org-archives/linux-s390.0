Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEA447D451;
	Thu, 23 Jul 2026 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831694; cv=none; b=ABb+vZM/I+62FZoScd9m+L1ntl5ThTqE6BcYyHqlHTKi81zKS1sKSvzrDrbUkjTDhhE3QjDTpsRopK0FWTDsD7DsOye593f4SGIFcqhjrjEFKibmmyKf8GPKL5KtEYIjSGiLLbGeJQ+MXE9UhLYW+rVQ3pLPSUcWGtNtzai6a7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831694; c=relaxed/simple;
	bh=thA7gX6G54GuWpd3lC/bjXhJ5WYPxJjBSUfbZ+4GtDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VczXRJPLIUdb+M9mazIh71KtZ6w8HWFZ/YcvHYN4VOALLj007QOK4LWCh6cm3xh8u4rhchbUyXzTiEFtBjqItjRcRs6pTRFV4l5ShOtK6rkBAzZIq2fAiHnl2ZAKvr7ymKYqr2ahJIcitUdvWAC3CDqhZDbJS1jfTLnv9NeV+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A6KGDZrc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A6KGDZrc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHg5AI1805143;
	Thu, 23 Jul 2026 18:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Je/LVVXLIsLg5NQyV
	sdx9SPo3hpI5m+RasXNPrFWqus=; b=A6KGDZrcDK0gVKcvW7H6aiYAis8mzSdbL
	FOQ7ORVWbO9OGDnHAF27z8PAbGoEHt8XtLqzKRF6QkNOE9HEfAHsSH6WvXr3vZRj
	aBrGB1LKfRN59t866SE6Y8XwFXVPTC0OLzuZZBwmCKlL0MydTuNwbVpc/WdQc9QZ
	E2XNFFPp9aMe8rR6g8o1WI6iRWALfwHt8KSmqbea8gmwXZiV56FjzVN8SDMmqZTw
	bbwYrtlFns1y+JFCKCimCiXXoTIAkDJb9Vrc6sPGdVrkBUcoGcdDuttALEatexAe
	6gyWoI2m1pocmtZduubv4BhhZFqQ+9FBA4uwEMvOh3zX+AOm4nwKA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77as2tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:34:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NIYcPL019024;
	Thu, 23 Jul 2026 18:34:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gnb4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:34:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NIYkZD59834662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 18:34:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6913F58052;
	Thu, 23 Jul 2026 18:34:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95CAE58050;
	Thu, 23 Jul 2026 18:34:45 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.118])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 18:34:45 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v5 5/6] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Thu, 23 Jul 2026 11:34:39 -0700
Message-ID: <20260723183440.3271-6-alifm@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: _orBgy3qahhQAKwrfse-OLlXozT97iSp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfXz7UmwMStJiYb
 jDLhHRjC0zPfJFd6hWBJ8tASIyVQGEUG30/fWh/DFQ6F7IKmF8ErCaozswIfuJG3XsepYQj6PBE
 uxnK5yA1lgkGhh5eV1QhmYnyrGYfBiI=
X-Proofpoint-GUID: _orBgy3qahhQAKwrfse-OLlXozT97iSp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfX8z6nJz6YHAWv
 46PQptL6otKlK3o7NGvisJjY4jAdpo3LTL3DbLbtPj6oW0W81OxuoFJuDbn7TOjqNHitkQa3cnV
 HNFm+heloMAc3PHAYmGJEcz5aNmqIcKydyFu5At5fAIQ5DDI3TC9WLlEQgJ7OjlFT+rLUI0WqZ/
 HrADA7csEwUaTX3CInCdn8bySFV+V+5ilGZ0I+GW+d3jyyrNsnZ1zuPUkmWeMVp3N7RFmBU/Zbm
 n7SNummLeh+Nydn+Js0ZWmIk7jR1vbzLo5qIQFgN/jCTtvDanWuIcALjTMtpc8YLFNnFvYfJVf5
 b5oRdkLogVHELasCvIDdFc2jSJkCccxl8RdGAcaVC4cMZWT8jqC1VfaByOH96Eve7fkSB93PcS9
 fdnGK97d1CoY/nwup+ZTykOipmfFPXoUnP3JHLFn7UzhueaWzupve9f0wq9tB1jM0R4MK2Wex2h
 SU1zpya3uGaMyJA6qXA==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a625ec8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=oLYdd9eN5-LzSxCheKcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230178

Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
an error code but doesn't do any resource cleanup, thus leaking resources.
Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
unpinning any pinned pages. While at it, remove dead code that stored FIB
values that were never referenced.

As part of the cleanup, we are also holding the aift_lock while executing 
the MPCIFC instruction. Though this is not strictly necessary, it means 
we don't have to drop and re-acquire in the error case.

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

