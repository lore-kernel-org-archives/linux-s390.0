Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95FE1993BD;
	Mon,  9 Dec 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772268; cv=none; b=H9g/vYoM/TZl5gfokrovxqB37ZQug5HrJhP+UiB2yTJ2TfMoVUx1t7GPWoXAy/WToRegB4pOJ4YbVAWAqzIdvXysVr7VvmYfuT16rhYMglSybUZjlNY8xuRBqBgnrFUQNuiMUJr+CUSniSWXkJ8ziytYPZ3ErUSlXcE1LK9VBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772268; c=relaxed/simple;
	bh=4t3M/LFI8xQI2dP8zyuDM11laDXF1cxWj0wZiCzvzGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbANvosR7qhXAlQ8HcrQ4MExCNUIR15yfPTStu9uDmz3hz7uUn3O1HS71F3xHsX3weJY7ZR8uRwAn5UxTQbtnKx7N+Z8HCgJKtOxvgCmKVfi5xvo+LYuoHP9dgFLdCCtjshBGx6+pABi0Jc4Ng/VcE+G8mEf3L1cg+6zGuEI8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aPy2CTKi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aPy2CTKi"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9BHnnf016108;
	Mon, 9 Dec 2024 19:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=T7jhz1GBlueszh6LA
	n0GVJ4QQO/fPk9U2VxnhKMtZQw=; b=aPy2CTKiKtiHSY4FD4yFGtsmVSD4+buwc
	JOpnQ93XbYTyCSiAaJwWAUJK42d2e3/sdQ7XmdKNwWyS9bRWqU+e9KbYxFK8YCYe
	VOPrSTkyO+U6bsKiSoqGuG1QKHuba+R40OPv3S7dkGaQgI0pGmA+iZm+gNAGaOKO
	VUvEFEAzoXWCCHFNc12RMG5a2R1XenY7gNmuRHCHxs87N8a0xdwBnwnQl2rOs8VZ
	SjRY3TOIy+yK2XT8YvuQanNZqp7oc+1baTzplVCnXVjKh6g6TPTRJoMknQwsnx+e
	WTDDAmExouhvrT7kh1BRVlMSfGyDM1z1OH+58TASgDOuLn8+iCyXA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq2hgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:24:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HvNI8016919;
	Mon, 9 Dec 2024 19:24:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12y086d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:24:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JOEor54264272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:24:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2704658068;
	Mon,  9 Dec 2024 19:24:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C7905805B;
	Mon,  9 Dec 2024 19:24:12 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:24:12 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 4/6] iommu: add routine to check strict setting
Date: Mon,  9 Dec 2024 14:24:01 -0500
Message-ID: <20241209192403.107090-5-mjrosato@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: qSPmcwGyrn5nKXB390gbqvLHelXddQ9R
X-Proofpoint-GUID: qSPmcwGyrn5nKXB390gbqvLHelXddQ9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=632 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090147

Add a simple routine to return whether or not strict TLB invalidation
is in effect for the iommu.  For drivers that implement the
def_domain_type op, this can be used to determine whether or not flush
queueing is allowed.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/iommu.c | 5 +++++
 include/linux/iommu.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 599030e1e890..6bdede4177ff 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -715,6 +715,11 @@ void iommu_set_dma_strict(void)
 		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 }
 
+bool iommu_dma_is_strict(void)
+{
+	return iommu_dma_strict;
+}
+
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 318d27841130..05279109c732 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -911,6 +911,7 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirks);
 
 void iommu_set_dma_strict(void);
+extern bool iommu_dma_is_strict(void);
 
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
-- 
2.47.0

