Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5CD396B7F;
	Fri, 12 Jun 2026 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287861; cv=none; b=ni1HR3883gZEmed4hRfEp7gA14ynZjdepO21Nv8wdHRwICb2JjiOqascZXQkFMxT0Q5WwwjQeyqYUVxaK1yX1OOl1hxdmEMsUz0BR9tEbZI/eAtnK3WBdBGK+6Xk1OXRwbxo+37ekMPtV2uXfjoY0bQw3bqswBbjJj+j8aVfdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287861; c=relaxed/simple;
	bh=MNFffotkc3sbM9n5Wo6cfZhCXqNaLzI/23NNBH/KLM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odOPAVbt1gy1ocvgpbYO7FNZT04IShBoYLAIRmIAJwzeGZbhLd8/9YFf8ZsxnbN0cWV73aMfmRQQBHpg5PUUqQ88qZclDvIk0JlX+HTPmsp+a5U/Bmc5xvkduFY0aczgNpyC8PpxPl5wfRnNnQ+D4YO688wvJwGlax5V13XXNuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CcrTQRhy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CcrTQRhy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CFKW0u3872896;
	Fri, 12 Jun 2026 18:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cGWDYzD7sk2qYfWo8
	Y1/9AftxDK7t1eHT6ZHFONArtw=; b=CcrTQRhy6shGCaKPvXGA/ptRddTtHo95Z
	F+Kycak/8H18KUiMBv9YZ9GfKXnS+VbiORE6yz02UrP4dpuHtsaeybbo67FF3MAo
	AXsyIOeKJJMYKBoLDcIwYAoL/S2IDeDQeNACqJrXZpEvuu3bwjU6OFbF8SOZx4QO
	I6p2upewWhVR0rp13qG/GLxAgqQBug8v+HMEHskVFS6SHQghatdXl2UGHi16qzQ7
	PAWZnEdjSRATsAwbD2OL5Sc55/zq4s3/4+Y2BFbnq3dFOsmzJ8jQDO8CCPOMeZcZ
	eLzEnzvfQtkAz2dXmlW3it8DUjaGWId1ys6RxyP+5qFiI1Aa1MWUg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8f2cpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 18:10:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CI4Y5X016363;
	Fri, 12 Jun 2026 18:10:55 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09s2hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 18:10:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CIAqGC25952936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 18:10:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE40F58052;
	Fri, 12 Jun 2026 18:10:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD8805805A;
	Fri, 12 Jun 2026 18:10:50 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.255.20])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 18:10:50 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org,
        stable@vger.kernel.org
Subject: [PATCH v4 1/4] s390/pci: Hold fmb_lock when enabling or disabling PCI devices
Date: Fri, 12 Jun 2026 14:10:45 -0400
Message-ID: <20260612181048.91548-2-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612181048.91548-1-oelghoul@linux.ibm.com>
References: <20260612181048.91548-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE2OSBTYWx0ZWRfX1Nw0ETzbzYWi
 1rNHTweYvLcVOqCW1mmmtSaOenUUoBc6ybv8GAnFyXHaswiw/n1s6x8b9hnUOG/51Z2Ld+UN3mp
 5OJl3XM5Ae77KP8sW9Snx04zXXxWTfiWK5zpBgJytVKOdsMuK2ojTQsdBb086jStVTcSoc3V7xF
 XAioE8AgapJ5aBMX+ZFppdLC16XX8jYgARuR+zProjNAhfQaVvGwFJfPMPAu/qTKQ73UyGzz/y+
 ooHlpcAa45FueIpkFsnWuuSQra8xDdo1zBjezQe0vbF1Wo2LZ2MPSmVBtmfFRXbSqVGs3boprS1
 PYiSUzdyRHQ2RLHRXNwTVvZT/OO0uoumL9TGAtjVpaLamGNE1670yIBRU2z1bO4BAUn1dIhG/lO
 bp3JGofgkDZFbag9KntPMvvKIdO8CMtD2u3zlZOfFR4tj8bsa45JoKoHFNW3pKfi7vDrmBBLLl6
 93Wk5osjGbcIqfL5PAQ==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2c4bb0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5NbLduwtq9nBFWGw9KEA:9
X-Proofpoint-ORIG-GUID: 3uppq2iq8Ear7LSsHeAe1AfEfmO7DKoK
X-Proofpoint-GUID: 3uppq2iq8Ear7LSsHeAe1AfEfmO7DKoK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE2OSBTYWx0ZWRfX7ZP/MnTOB8HX
 1ERIt6CMLpyGuja0wiEjjTLU3z5uDsvLpOyVhvPRLri0msepn38r4LXwYtfothJpldRMJRI0EDT
 mBTLV3rYe0mqjbUJXvRnYVmo+y72Xas=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120169

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
---
 arch/s390/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 39bd2adfc240..2910d4038d39 100644
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
2.54.0

