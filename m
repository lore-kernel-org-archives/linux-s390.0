Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731701946AA;
	Fri, 13 Dec 2024 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734130200; cv=none; b=K0mBj95UBIos+GnMaggjfOmksxWJX2TQyDynFQsvvrAm0ivw7LEROc1SCCTGMei9uq1Dz/hcPBz39Z1Kd4vFoLBvgidMx3CjJT4K0rYQlLxJscTP0Ujf063yIXJtNZ9Z54f6EZiJPyoYMDzVgDBOClLOPENElEUr4zAQaWHue9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734130200; c=relaxed/simple;
	bh=ZbKiRTrrdkm1V2O7xQ8FaIJbHWH0EDzhFY+/0iLsyTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVrFV4J0xF//yfr5Xey6PwJzihQX6QL/3CmUmgtr6NaebxfuCztHZQCExlX00PWcRIP+rg0Xn3DUhvnBe3zB0Ot8hN/XXZn6JdAPS17tTP+kuN3LNzGSxG3F4UmwI+e4dXv/b3/RJGS+Fwa1XsOSUvW1pEprnaVS2A7oCJ9cwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KAjpf6mV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KAjpf6mV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGfW9i026836;
	Fri, 13 Dec 2024 22:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AZ72KimlqaUWy6p7F
	bz2xaxxOBZNuveFrquwyCc7Cxk=; b=KAjpf6mV+Uj2EY3SlCqNem6Wel7wPTk26
	/iPSzbhrY50rFS0Ijhmicq67d/eEYasNQiKKSxzlz5IdUes7KP0FNE0uOyfdnw5/
	DD/U1XR4os957B015PnWn5tBh1+K8MVKnliCzx1xugjq62REfkhOIPC/aujZxQQx
	F3ocovaVGKxs1UcZ2MIUE3dpDJCb6/YaXF/2+xEmtiH3cpI18cXbi1feZzZU/ksn
	/ycedq7GOQQd1Z2Piwj+4n48+NFfode3baEb41WPAxNpn7aLEo3fqb+N0pppSFW7
	xu806qfqqXfL3PWcM7IezKOXCt+mxMdDvOWBflu+wITDcsHAXqsCw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9yhnqwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 22:49:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDIrw4S007796;
	Fri, 13 Dec 2024 22:49:47 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft121hs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 22:49:47 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDMnktc35455716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 22:49:46 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D3F15805A;
	Fri, 13 Dec 2024 22:49:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6573958054;
	Fri, 13 Dec 2024 22:49:44 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 22:49:44 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 1/3] s390/pci: check for relaxed translation capability
Date: Fri, 13 Dec 2024 17:49:39 -0500
Message-ID: <20241213224941.571060-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213224941.571060-1-mjrosato@linux.ibm.com>
References: <20241213224941.571060-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bXuQhXRvw4sO4i9r7kOaMO24ZkeZr5hs
X-Proofpoint-ORIG-GUID: bXuQhXRvw4sO4i9r7kOaMO24ZkeZr5hs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=811
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130159

For each zdev, record whether or not CLP indicates relaxed translation
capability for the associated device group.

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
2.47.1

