Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374751B4132;
	Fri,  7 Feb 2025 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961640; cv=none; b=O2+adRMgm4d1j4rXxKrltYOHnAIhQ08YoRWZG9btDvWIl6G/GnCN54RwdBCxbRXfBqhmxEHDHx6110YxekiEdquP1wBKw7d3sbI4O81DXVhd7kH1lOAAVYxcCvrZX4fR1uoMR+oG1nYCMOrxISsuW9LaGDKUnjudNlMB6V8JdSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961640; c=relaxed/simple;
	bh=wI1MHowA80iIxAECLLCmspP1IM6adPGDHCugie5UhD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHGifNHeiYrpmj/ovZfZbeSmS3qt0G+gGIYKF7Q0Er9x8WSLViBqzIz90GJrRHT30PhpoeOqfBwEzNRUm//qOAT0gw5eWnq7xXc6/CG4eGC8bbKF/7tw1ZKisX6h3pxmVQNAHKVckwCVO6MlVHRSDdQFhqNCvOwaHaEZJTl8Lz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LZKZFA6d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LZKZFA6d"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517IjtpT004288;
	Fri, 7 Feb 2025 20:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qQXDr9ee4DxcBjU9H
	P0m1OF3o9C1GlZT/POYV4GYW5w=; b=LZKZFA6d6zqteZOPM+Jh44THN4uKpC0AP
	eKz7DzpSHSES6aNCkD5KbFDgP+9w8JQ373L8IHapW7OJ5YbPxtdjvTgXf0QPWjHz
	nuQUL3vL/gr2VVLqB0TYx4DGViOkW2zMxzH7P5HCvXeFanpprHQmFuQyDDqh5kFI
	hBvQC8VnlT96x3A9Wl2t9m4RGmI839oPnJ8uHBmE6dexu1h7Bg0O8QXcARuoahTU
	boHdnJmp98ZhKSUiIvf2hEexPQQs8sB1KIx9o8jM3B8d7eaJTJ+X+vRdgZfHauuG
	9ut0GXAcf77bgWODUls3w3L2JjDbu9fo8smv6mqsaBw0JKjEND4Eg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44nfn5kcfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 20:53:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517KNoEk005254;
	Fri, 7 Feb 2025 20:53:40 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05kd60d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 20:53:40 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517Krdq524969686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 20:53:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 520EC58050;
	Fri,  7 Feb 2025 20:53:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3CF658045;
	Fri,  7 Feb 2025 20:53:37 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.30.101])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 20:53:37 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 1/4] s390/pci: check for relaxed translation capability
Date: Fri,  7 Feb 2025 15:53:32 -0500
Message-ID: <20250207205335.473946-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207205335.473946-1-mjrosato@linux.ibm.com>
References: <20250207205335.473946-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L8mjDPYG1u5LTTKCP4MkYN13fMiR-x9o
X-Proofpoint-GUID: L8mjDPYG1u5LTTKCP4MkYN13fMiR-x9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=782 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070153

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

