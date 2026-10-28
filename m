Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202246;
	b=RCN7E9JG95dLlFt2rR/S1gNMv+7oVvCewaBDs+nbDr4xmSeK71tvcEr+ijlOfhqWfLqP
	 9o4rbfsMMWRqmM8K1KKzfHEO3jrkeT6EFk7hEbsdVcwEsGIE4zb/R0Kd5YjBTy+bfY5ot
	 6ru9Xp09E+0Grp3mSJIuK281ooAL0xD7rZjoxQwrUSBvUqgbO9h1p2cOs89LfGlNGdYab
	 jArQVhWLoYfwa916FmFT5d1S1lZXsbXkjZfI0cFeWkPBdSmY+fOjggw6qkn6ZTKIFoyuM
	 KgcW8FEL4Tk6SrEF2nNYx0M32r/pWjvqkq10Qf7NcjZR/EtSCjAwGy1Yg++rGVBwVPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202246;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ugy1MPPX4rX1hKJ3Iu+kcccg2ZINH127EjdwX5suMt0=;
	b=D4fQvPqJxsuIFT9YxPH59NiaOqYfFJvUogIfYQXNzz08zWWmfRGc1txL+8HbT5TpmyTC
	 D+GLjLWwvH3DqeqDC1rxizEbWkihgDe8V2iO9vFgWWay+pybz4dWF0FPM3OvJTilFl5NE
	 L1zE3uRyFCqEnZlmEDUW/mmoYLdB9/rC+nc6suKY+468JUZ5JVdE3xtcWqebCXYBzOQ1k
	 mb/Yw9O0vC2vRn8m6vYQ17ywp7cGb9Ng5U7+LIA4culWGHCF2p21GXtaxp0BrzAKM0r+j
	 nnvYHpLub0zySh9JH4V0dyMeeuLBBrr9a6IzTKNsXNMlACwhh6W5XhudgSsKq/GtUHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XCxbKWJH;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3660A2602;
	Wed, 28 Oct 2026 15:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65D3660A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XCxbKWJH
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFEsrC425223;
	Wed, 28 Oct 2026 15:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ugy1MPPX4rX1hKJ3I
	u+kcccg2ZINH127EjdwX5suMt0=; b=XCxbKWJHDaCCIqgeeRdAboIUEhOVPQdkL
	87TaSfmCozZCp/bIrG7yiKHBeLJe2CH0zY2N11E1idKjRBaMZ78CrZgHPGR5D0uw
	FUWxtX3KVr9WTRYsfxogWgdgE0Fh1xfqIIOZLAlJOhhOjoaN4rx4frpDo2aK8hdn
	f2dzV+6VKE/YKxDh59WkTKancOimjwMUYnY20dMQLugJyk8zjuUi0yp3rmB7+x0d
	jlN8FwhfMaRDZqQSpK0SGs6GJCBhA1Z1m1aQR6xQVloCJRZziOMorVHWxZ8xCNkA
	niVmw+F+3dIaJ9zUtf5MoJMZo0feyyOn3/LAXoPJsffCnBlyKlTbw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3g5c7g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:44:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFK9LR1784823;
	Wed, 28 Oct 2026 15:44:03 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh7xnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:44:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SFi01L28181002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 15:44:00 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 452395805E;
	Wed, 28 Oct 2026 15:44:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1898458050;
	Wed, 28 Oct 2026 15:43:58 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.240.205])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 15:43:57 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v11 1/5] s390/pci: Hold fmb_lock when enabling or disabling PCI devices
Date: Wed, 28 Oct 2026 11:43:48 -0400
Message-ID: <20261028154352.15108-2-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028154352.15108-1-oelghoul@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae21843 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5NbLduwtq9nBFWGw9KEA:9
X-Proofpoint-ORIG-GUID: 9oxKnwSWUzLArmNrO_QO0DPj7wZVDS7K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX4oufj4Ei8NiT
 U1RFkbeS5gYaPOtjZv+1vViDK3yQbKTSrz8Lw+FELSNGLmSqGNDzssIoMQ2I4LjFd2hNOZ3iEpZ
 UEe/vSCjOTq0bgdmEf7QFNcY7CdllzXgROAohhQhbzOAH0O7hBxVCXgdJdkG8+GhSmlCH2gUxz3
 rokAd0ZNgq1N37eINOvZ4KmYMpLZtqbRnD4GhoWWexyNqIOVXfz6kl87clAJYn+h2+ewosObvGZ
 fK8u8+wiojSCW4e2lC3a+HrGDlrpsuUCH8FQRIGLu3TRY80y7jsNrpWlkX3GRVXBaNW6+k6lIeT
 G/g0x7sf0kNn/Mxv/KWZp+/xi5rnOZh1chtAqvdCRl98nWyGgijPLNzPFKZZMkM+CWQxcOlCcG9
 lasLDlELH/psJnpsyoXwj5WbihYkXigvVFuKAE1Mx+snCyZynjsYqC5VLTZ/xptAATyOU+ZJ8Ay
 y9NOSRkhwO+UOgc4kQg==
X-Proofpoint-GUID: 9oxKnwSWUzLArmNrO_QO0DPj7wZVDS7K
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX48Yrauan3JUU
 sWKttM8B/e9CJ2rVFqs2hzDmQDzYbYS6Kc/1LL/LLvYDzScEeqqdfayWl+aXrFNPWhHvpMkBeuW
 ikjuXazx/ioQ7nf2zlmY8kTMvtfdBSs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280062

Ensure that fmb_lock is held by pcibios_enable_device() and
pcibios_disable_device() when calling zpci_fmb_enable_device() or
zpci_fmb_disable_device(), respectively. Additionally, assert that the
fmb_lock is held within the latter two functions to prevent future race
conditions regarding new callers.

Fixes: af0a8a8453f7 ("s390/pci: implement pcibios_add_device")
Fixes: 944239c59e93 ("s390/pci: implement pcibios_release_device")
Cc: stable@vger.kernel.org
Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index d64c544b32b0..c055a9ad0972 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -173,6 +173,8 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	unsigned long flags;
 	u8 cc, status;
 
+	lockdep_assert_held(&zdev->fmb_lock);
+
 	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
 		return -EINVAL;
 
@@ -211,6 +213,8 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 	struct zpci_fib fib = {0};
 	u8 cc, status;
 
+	lockdep_assert_held(&zdev->fmb_lock);
+
 	if (!zdev->fmb)
 		return -EINVAL;
 
@@ -639,7 +643,9 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
 	struct zpci_dev *zdev = to_zpci(pdev);
 
 	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
+	mutex_lock(&zdev->fmb_lock);
 	zpci_fmb_enable_device(zdev);
+	mutex_unlock(&zdev->fmb_lock);
 
 	return pci_enable_resources(pdev, mask);
 }
@@ -648,7 +654,9 @@ void pcibios_disable_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
+	mutex_lock(&zdev->fmb_lock);
 	zpci_fmb_disable_device(zdev);
+	mutex_unlock(&zdev->fmb_lock);
 	zpci_debug_exit_device(zdev);
 }
 
-- 
2.56.0

