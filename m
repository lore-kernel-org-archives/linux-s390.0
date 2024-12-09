Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16151198A1A;
	Mon,  9 Dec 2024 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772270; cv=none; b=L/SoQt1vn0HfZzxVK/BXnD1J3vUl69eYoOatxH2Rn2HREM9rUQy/Aw8C2t6Jsq1yCO0ps6RtgWG9tX71As5LwQDkFIp/bOYACHULVj8Pioln0B7i4Q9mtBGAGM0qH3B02L9h7BHhi2emTHwnK3VYueibZ5dVbVqXmTkeTG7SYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772270; c=relaxed/simple;
	bh=2H3v0Kp6QuT9dBBdMh1p8eIlnPIw5OTegPTKTEO7qxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qh3ptyXVKfnpW0zAm2Z9bD4rbUkDDhA1SYb+ivXUeMalhhNAaB+sQWFF3GpyX6FAIFox5IF2AMNiObXT724DpiRhkfDkSoDdNpr4rrF1MbcIEX14MqPo70M1u4ftX70GKQeh3LNXZNzd+xa7raXlcHK+CQi9ctsNAb/9c+OUjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SW6ZFWaW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SW6ZFWaW"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9CblDB020924;
	Mon, 9 Dec 2024 19:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1PzxnFKgbpd0suK57
	mb6gHLfcFYBJuxvqlMUjse2nn8=; b=SW6ZFWaWBv2UvhmuCWhr5DYRRMuvrN2zV
	UUmQ0GIGeWPqWsX8l0imWDSx9/cr44xWU96ry5ALnt2YcoDdz1VHFg2eVm7Wxs1U
	8XulaYijE9Voh8rjlapHm3RQJnpoS6Pq4+EpHWWC1EF4fpGVcVtk3hM7/y6g0N3T
	ArEk/a5gQXUiZAtgXlzj0Cnn+VJq1SY9ntUnHSCM+sybhFUMbroBHrCJcco1pMza
	2Qeffxmgf67HgrbAP+CwHtehbqOkJfq3i2Uqb7HKf31JkZyysvTMaaaPDx+NW8rq
	q4BnCmYXmwKABGyGjtjounGKCZs2XjzGOPvcAlQJZPuyj6mM+RvgA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq2hgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:24:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FILRL023023;
	Mon, 9 Dec 2024 19:24:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjqt1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:24:19 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JOIgO18285112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:24:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D0FB5804B;
	Mon,  9 Dec 2024 19:24:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CF0C58065;
	Mon,  9 Dec 2024 19:24:16 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:24:16 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 6/6] iommu/s390: implement def_domain_type
Date: Mon,  9 Dec 2024 14:24:03 -0500
Message-ID: <20241209192403.107090-7-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209192403.107090-1-mjrosato@linux.ibm.com>
References: <20241209192403.107090-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Pq_rI4anfqEDA3VrbremRz1I_1tf1mpV
X-Proofpoint-GUID: Pq_rI4anfqEDA3VrbremRz1I_1tf1mpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090147

On s390, identity domains are only supported under certain virtualization
scenarios.  If iommu passthrough is requested but unavailable for a
device, ignore the request and instead fall back to dma-iommu with a
message.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 18979d8109b2..6906e1b5b1b0 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -462,6 +462,28 @@ static void s390_iommu_get_resv_regions(struct device *dev,
 	}
 }
 
+static int s390_iommu_def_domain_type(struct device *dev)
+{
+	struct zpci_dev *zdev = to_zpci_dev(dev);
+
+	/* If strict DMA is requested this takes priority */
+	if (iommu_dma_is_strict())
+		return IOMMU_DOMAIN_DMA;
+
+	/* DMA_FQ is the default unless passthrough is specified */
+	if (!iommu_default_passthrough())
+		return IOMMU_DOMAIN_DMA_FQ;
+
+	/* If passthrough specified, CLP must indicate it is allowed. */
+	if (zdev->rtr_avail)
+		return IOMMU_DOMAIN_IDENTITY;
+
+	/* If not allowed, fall back to using translation via DMA_FQ */
+	pr_info("Passthrough ignored, translation required for %s.\n",
+		pci_name(to_pci_dev(dev)));
+	return IOMMU_DOMAIN_DMA_FQ;
+}
+
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 {
 	struct zpci_dev *zdev;
@@ -839,6 +861,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.device_group = generic_device_group,
 	.pgsize_bitmap = SZ_4K,
 	.get_resv_regions = s390_iommu_get_resv_regions,
+	.def_domain_type = s390_iommu_def_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= s390_iommu_attach_device,
 		.map_pages	= s390_iommu_map_pages,
-- 
2.47.0

