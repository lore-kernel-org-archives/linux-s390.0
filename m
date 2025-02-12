Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A97202C5B;
	Wed, 12 Feb 2025 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396077; cv=none; b=pRvamaVO5Q5MIGIMDiXoSZ0usy5lmbxkWAMzSiWA8iCk8xTgAzV2Gb9iwsOFHHRO6Kem0p/KAz4gsWyuVP5GP6xgkUwcIypxAaSJDwI5RcJ7tAX0Ylxbfe6vTgGrJTRf8tO4qgU7QU7c2ErqRFrMSlkX81XQmEa890mxhr3OfXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396077; c=relaxed/simple;
	bh=wI1MHowA80iIxAECLLCmspP1IM6adPGDHCugie5UhD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjRMT8jtirC4Pc4DBHSUIQAoeThXLzjqUWwd0Y9oAIzErdjI0l8BdhPg7cqJlsFwg+qvIBXE5iLg/H9Y+hheUUrIUV5ddLRA3rmMg3/SUWCAnu8q4kqoH2YqpPxJax7nJACKnsnr5g9Kqpawqmk7WJrMFByuvt5DMm+xjV/1hZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IbrvaJQy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IbrvaJQy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CKG9ei015177;
	Wed, 12 Feb 2025 21:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qQXDr9ee4DxcBjU9H
	P0m1OF3o9C1GlZT/POYV4GYW5w=; b=IbrvaJQyTBkRf4U3zkA212wtjuEsFXXvh
	fYjlHltvF/jt23bXbFZBwN3QGyenkFb+VgKANMyjE2WxELtzr9jHYe687euED7fP
	NI6TGw3FH4yOuzgtm1HMVGhW6uUzWi2fvbk2Btee7PpdnUmVCvUYeU26+YmqhnZf
	1pl1qdXyaqQROHaERHA6NUje5moahIWJ1mJeNZle/DjuKOL/zfFxAr81vpVDUMlf
	9lT43MDKWcfRO2woOz+65F6s7u6DHl9NZgBPQn7sIURZ7VM+hnnrrTF/nT0tAAzL
	E9zA9JBIK/lJX+MPWcYhbOPpdJk3zIRHKo+zK8BjS10JR9VQ62I7A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rxfu1qfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:34:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CJFBXI016679;
	Wed, 12 Feb 2025 21:34:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pk3kay23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:34:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51CLYLfZ32178730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 21:34:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A07FE5805A;
	Wed, 12 Feb 2025 21:34:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8895A58056;
	Wed, 12 Feb 2025 21:34:20 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.186.234])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Feb 2025 21:34:20 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v5 1/4] s390/pci: check for relaxed translation capability
Date: Wed, 12 Feb 2025 16:34:15 -0500
Message-ID: <20250212213418.182902-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212213418.182902-1-mjrosato@linux.ibm.com>
References: <20250212213418.182902-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -HN6U-kw9B1jPD0k7y_YccgCHhHmiLJG
X-Proofpoint-GUID: -HN6U-kw9B1jPD0k7y_YccgCHhHmiLJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 adultscore=0 mlxlogscore=785 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120152

For each zdev, record whether or not CLP indicates relaxed translation
capability for the associated device group.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci.h     | 2 +-
 arch/s390/include/asm/pci_clp.h | 4 +++-
 arch/s390/pci/pci_clp.c         | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 474e1f8d1d3c..8fe4c7a72c0b 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -144,7 +144,7 @@ struct zpci_dev {
 	u8		util_str_avail	: 1;
 	u8		irqs_registered	: 1;
 	u8		tid_avail	: 1;
-	u8		reserved	: 1;
+	u8		rtr_avail	: 1; /* Relaxed translation allowed */
 	unsigned int	devfn;		/* DEVFN part of the RID*/
 
 	u8 pfip[CLP_PFIP_NR_SEGMENTS];	/* pci function internal path */
diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
index 3fff2f7095c8..7ebff39c84b3 100644
--- a/arch/s390/include/asm/pci_clp.h
+++ b/arch/s390/include/asm/pci_clp.h
@@ -156,7 +156,9 @@ struct clp_rsp_query_pci_grp {
 	u16			:  4;
 	u16 noi			: 12;	/* number of interrupts */
 	u8 version;
-	u8			:  6;
+	u8			:  2;
+	u8 rtr			:  1;	/* Relaxed translation requirement */
+	u8			:  3;
 	u8 frame		:  1;
 	u8 refresh		:  1;	/* TLB refresh mode */
 	u16			:  3;
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 14bf7e8d06b7..27248686e588 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -112,6 +112,7 @@ static void clp_store_query_pci_fngrp(struct zpci_dev *zdev,
 	zdev->version = response->version;
 	zdev->maxstbl = response->maxstbl;
 	zdev->dtsm = response->dtsm;
+	zdev->rtr_avail = response->rtr;
 
 	switch (response->version) {
 	case 1:
-- 
2.48.1

