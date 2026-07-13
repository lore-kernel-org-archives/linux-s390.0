Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C65347535;
	Mon, 13 Jul 2026 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963568; cv=none; b=mcGo3Gr3MI7EqHTxppBft9SP+CkmHr7d8yrHPjKVyxYcFP04chYB0rB64vOzSNOw6jmf2I2uwPVPFieg+f7VJSNo7tL++7pCFVijElC694QoSJNs7kClU67H5eLd4ChMoo5Uc8tBsEhnzrtHbhnYQ2eOly5hSaZkkq3TkPtl/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963568; c=relaxed/simple;
	bh=m+pNB44JX5uhwRo/pxQ+khK95yb2+fKh3piZsFwkJlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooYX5guBinH+D0HuSx7m8rhoP3TqcqadMyqxebPKir1to1zcDIE1hJhcHc9Wjh7vl72mSrQ6Iq3x79U6YNQ+x5ZxVZjTWcOPdyB8+LluRJ+gOtTiOn/xa745Z+nbZpS3RwPoN9NzPUbk5wijaG9plRUyzYDGcRrxc6F3snAfZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HlXwSzhU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HlXwSzhU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFEUkD2833096;
	Mon, 13 Jul 2026 17:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AxSQixaZay1eU1Wkq
	BYr28d80HyLe420iYBSt75YpF0=; b=HlXwSzhULve9Df8lrwz+M3l4kfFoOj/ZZ
	e+8MgwXdgHbS7PVSH0khu+SpyGozRXG0HHYjicSDYF0wZxbRxQjGu4c0ZSroPzGw
	wb+i3sR8xofhsroXenjM0CMG8c8VcrMGbbqq445k0yNdd3kMrQ5JEzyxPZABNXtv
	MvIfNXxJ4n+tonK/WBXsxGT+6RYiObud8ecGv85gww6okPYnJqadOYbiom72ryfD
	HqPvP1I8+LqqaLxvVLabi5FmvP559T1stsRDu5QajkIyHO7q9Ff0le+K0g2CjgiE
	O+FPlDE4tojMr1rTrlnYFT+nF5aUqJL+a9RgF1sYuwdcGNVSx8rAw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbhmjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:26:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DHOeFP003385;
	Mon, 13 Jul 2026 17:26:05 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh6r8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:26:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DHQ45s23593634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 17:26:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3036858051;
	Mon, 13 Jul 2026 17:26:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A28A05805A;
	Mon, 13 Jul 2026 17:26:03 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.249.24])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 17:26:03 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com
Subject: [PATCH v1 3/5] KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
Date: Mon, 13 Jul 2026 10:25:58 -0700
Message-ID: <20260713172600.1284-4-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a551fae cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VpFnpj6RERqEfYQjrFkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfXwROeCSoit9oA
 9Riec5TR3LG5s1hlcr9hlsU6ot1A/asanIt6AlO6CU/wQunl3fNVGyDQskYc2yhGyEGB1CUORC0
 IGpLxBFsL61nlP0/JMvoWmNBT3AhI/fz+Ts90Nrx7r1Kzq6F0Wi69Ccffo1P/BQzxstNObRHbqF
 WSZZQIF8B5loUYpOIXKvu1DYUN8tE7BKBX0AeqtbgCn2VVADMip/jMruQWjlr1z6JF3gPJmQoBz
 PTamZn4iqJxyruuCFkygAEE4GvkHUsF43hi7PjcqThvyD12B/TnZhhb+/lmvV07UY6n5hb1tV8F
 a8L1avAJtMVgxMji0kasw8V++Au62yAgXnO4C+S+lEXxiSXHd4lh62AfvvYIIVlk9xSZDYrfXhz
 PR+gx/oyojVaRB/SZnOwFQ6yEGLM881qUa5ANHsmX23ZbiN+BFKKGspLys/j0r5vmbOoRMkKpkC
 /HArUKjEaGpBadzGEAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfX/wkvyiIJNpxg
 ST4GbP3HQEooBYWg3ZdWcGIKBKz7fMSX/Tavf93f11xM08PEsa7SHGXYFiSJwRKmgRSQrKDCb7w
 8PwZpdSzdeoaa2N0E06Ic4rvLl3bQdE=
X-Proofpoint-GUID: mFGIARYrnFLYu4fMj0LDVAsHPrp_kQHh
X-Proofpoint-ORIG-GUID: mFGIARYrnFLYu4fMj0LDVAsHPrp_kQHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130178

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
index 42db20c2afca..b3ffb8c25510 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -299,6 +299,11 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				    AIRQ_IV_GUESTVEC,
 				    phys_to_virt(fib->fmt0.aibv));
 
+	if (!zdev->aibv) {
+		rc = -ENOMEM;
+		goto free_aisb;
+	}
+
 	spin_lock_irq(&aift->gait_lock);
 	gaite = aift->gait + zdev->aisb;
 
@@ -335,6 +340,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	rc = kvm_zpci_set_airq(zdev);
 	return rc;
 
+free_aisb:
+	airq_iv_free_bit(aift->sbv, zdev->aisb);
+	zdev->aisb = 0;
 unlock:
 	if (pcount > 0)
 		unaccount_mem(pcount);
-- 
2.43.0

