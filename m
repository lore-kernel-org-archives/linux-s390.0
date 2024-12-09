Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5509A198851;
	Mon,  9 Dec 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772262; cv=none; b=AbSekurv1hblQESuLPoBlNc7C9y1J+prSnTtXrgg0CymRRxPaAbb/+H4WNh640ujJoUCeoWl6sLavzTJbxm9yVA+3pNd+t6N+a3F1XiBxsBbl3b/Q5BRyvau3c3jDgtg+2BHfWc/WCeg0qLH+Hi7DiUF0B3xRKrlA6p0IZeQr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772262; c=relaxed/simple;
	bh=ivzM0Fn+SYmmRrt31w8ZZD2rWtkfeOYME2IS420Zv28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goL4IBTPK94QIDCVP6BAmk5uZ8kHcYOMa470dcDArGJ83YxVlUF1zlZ3XbJJqZcGt/OYsb9+3MNY6rgzPyLkCYDCsiMcHvAg0W4O987ja6xIXo+EOJO/CyeXqCXp6cFDJPp9fv3hJJkfyzUzlpo0tWUH3qaaQhe9RwG/5D6Dxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KHgcLg2S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KHgcLg2S"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Crbk5018529;
	Mon, 9 Dec 2024 19:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=y2cCHdWh3L5oPNUkh
	XBi+lBVCm0QqWlTx3Vs/0PeLPo=; b=KHgcLg2Svg6YKNBgrOhzsguu9ZNluZ3bH
	9HRZBQkHqAHW/5NpJI6blQhmk+CxRfjCL0GARd43QkQaS/lH7SFJfVjF3C8TZ+gf
	SqJPiFn7f4Ovjx7hflPoyqEBbDMerfOSrmMz1XgLMsL5dTy3M/NYVqKMBhxYUOu3
	XNGSoSfHP+4FS2K2JNUgTboGaYBlLAQPcSa9psEt31z6WDPy/+bGj5fIQvXKXO3j
	YSKZ8oIo+tbVJdN91c0nkxec6xRXOWRlHLR2kN21dEGyBE/O+xCRCGEpOWYGD234
	W8NUeyO0AUx8FNA+qlgHZ1PsCzjdoWRjq4N2gp3syg0GHwe23+EFg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38k5g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:24:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FILRI023023;
	Mon, 9 Dec 2024 19:24:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjqt1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:24:09 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JO8TC18285154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:24:08 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F52F58063;
	Mon,  9 Dec 2024 19:24:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A4665804B;
	Mon,  9 Dec 2024 19:24:06 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:24:06 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/6] s390/pci: check for relaxed translation capability
Date: Mon,  9 Dec 2024 14:23:58 -0500
Message-ID: <20241209192403.107090-2-mjrosato@linux.ibm.com>
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
X-Proofpoint-GUID: rT4Ll5fkLXqtZ0D5Qv0a8oI27eEA8j06
X-Proofpoint-ORIG-GUID: rT4Ll5fkLXqtZ0D5Qv0a8oI27eEA8j06
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=796
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090147

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
2.47.0

