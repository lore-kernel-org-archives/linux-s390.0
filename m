Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3902248B9;
	Fri, 24 Jan 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749856; cv=none; b=Po5CEDyDJtg3M2yRoYtDQaqAAAj/h9MMkPkyaKkbHH+1LucaKZaKE1DjhYExMGbQhgLXXrW8tSs21ix7xwoN4/CPoB5r3gZbc3XR8Py7QmlbjNTlrwjoMiU+zD7QHvNKpdyMGxoIkQE9nlRpsv6p9CQ8YP3Gn+rcvDKa5a6dHCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749856; c=relaxed/simple;
	bh=rx96MLupxdtfsp5U90jN/nJ6xXjApEx/CoX03yHiVi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvxxmlFw7QikoNPV50cPq+jRgqcjpPzs1IVVdHIAx7kSDK2QkUV8xdl8GAMxylbbLD+nTJowzJ4Qg8FwvMlXdoKywbT2zJaz0xUgw7oiy++aB5DPy/sTP38y5kTLuerkOzyDXxGkK5vclMVN8cV8s9u0xyy0JbZ3RMbFOvdrmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gKI51xef; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gKI51xef"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O9WnPo019254;
	Fri, 24 Jan 2025 20:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KtrhSVDk65hd4VTnF
	66WtulDKQkUwMxsDI3FLswq8QE=; b=gKI51xef74W3dvwquEf7egdje9iAoFTUW
	dhas2i8/vhuzOVBEfIEuijOrf8f97pAGjIhHvl/DwyrUCig1CXf7+qm0xJM9YG+8
	BzJXJY4WLLCw7QMI02b6eFlsD0TJUqZ8wsD+Un2fFCkktBbTnEE48YHCJkHt00CP
	y19z3nW3OGqBUxB2ldgUZUceudRWCiyA9w8vSPUtxEyir7aSwos0V0aFbizzZHXW
	GZwuoptkOV+c8wpRkx/PSDRLMr+42NtY41JkkzYq52xh0t0ml5IdU2OpzLRKRJU/
	e73Y4Kq40IzRgYPxgai08bHIpX90Nschss8yGXhYLkgcWH4NAdDzA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c0x95yqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:17:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OHVFJa032290;
	Fri, 24 Jan 2025 20:17:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448ruk4vyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:17:23 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OKHLq838601322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 20:17:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4F4458056;
	Fri, 24 Jan 2025 20:17:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 342D958050;
	Fri, 24 Jan 2025 20:17:20 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.77.196])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 20:17:20 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 1/3] s390/pci: check for relaxed translation capability
Date: Fri, 24 Jan 2025 15:17:15 -0500
Message-ID: <20250124201717.348736-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124201717.348736-1-mjrosato@linux.ibm.com>
References: <20250124201717.348736-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CRLRaY718Vt_w_MbWhil43XVt7KPIs5W
X-Proofpoint-ORIG-GUID: CRLRaY718Vt_w_MbWhil43XVt7KPIs5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=789 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240137

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
2.48.1

