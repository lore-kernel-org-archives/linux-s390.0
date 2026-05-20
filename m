Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD23F1AA4;
	Wed, 20 May 2026 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297086; cv=none; b=GUbDj60UkNPG/hUEBHjmFB/w57ftL/sPrnK3Rjs5RLZhw149CT4Zadeg/8Jy4nUDwmFI9Zh38EPm93rDyvLweOCWx+zva+ltZUlFgLSbzjknJYscsU4c8Vw0egzGxvXdBut9ClokWWmVCFr3wQwL0djMDy67xbvWPn8kfjTHgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297086; c=relaxed/simple;
	bh=RQ+lhbs/20dpjDWkfLkvzRoH5lgweVzoQtY2ETnzPfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B71gQIas+JRLfZMIEFUTezNRzlXlyiBh+ycK1cdM1zPMJEnE4vvDcWT46VpBCBU14WjD/h+Rw/UrtVuuaNXrA9o7UnWL29nkxG+N1HWU41UBmlHDefhZzMqpLmQlRYOv+aQXWw0L7HNkfvTfF94TpSBEOHAOc8iBk6QlEBe7eew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LRkX5AL/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LRkX5AL/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7e9iA883231;
	Wed, 20 May 2026 17:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cFYGaeCjhi1C6NNXk
	0q/9v/1B4HO6gGEzVR0sxD8XXU=; b=LRkX5AL/hiFT4fZLZH3z/CCvIbz52+67T
	iVAssRR0nAuwJLtsfi1c6qv3GGnc/TH4apfWjW25VaZFBi3/L6nY3Jjqrl8ISBY8
	79hQk0D9TZC/67uv8gtr6XpUaToGilbDds2ArcRjAxMO5o1RmsKrTDUlChRnbDBR
	YSIGXJBV1tveGnKO48V3ZtDsnKpLNRRsIMG9wLNiQiuhEJQMbOyQgdrODjYw470D
	KOalzQdvj2N4jzQ77846Dj31d3xOh7zGD4hhiFzJ1T3Wj7ZV3Mr/vOBG3ZmPwTcb
	cVWXibxX8UoOpWJuLTsSheWgcoeZhhJgl9CZqpih6GEJuD8MW9WvQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mu4f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 17:11:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KGsDqV013522;
	Wed, 20 May 2026 17:11:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk8ag3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 17:11:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KHBJBA23331360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 17:11:19 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA7C258059;
	Wed, 20 May 2026 17:11:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C22B85804B;
	Wed, 20 May 2026 17:11:17 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.46])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 17:11:17 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v17 3/7] PCI: Fail FLR when config space is inaccessible
Date: Wed, 20 May 2026 10:11:09 -0700
Message-ID: <20260520171113.1111-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171113.1111-1-alifm@linux.ibm.com>
References: <20260520171113.1111-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vg75slbuDjjo0r2g7M-lBTuet-cZeqIb
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0deb39 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1owyFLT6pZZ0tE0DW5YA:9
X-Proofpoint-ORIG-GUID: vg75slbuDjjo0r2g7M-lBTuet-cZeqIb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE2NiBTYWx0ZWRfX12pik4cOmkzb
 E9E3ExY4p1CxxJrVRGC+8YFIAJWSxvEy2uC17HOolz5EFRFnJD9T+GGwIFywwqpUBiVUWe6K0W4
 DlHp5ZlDyIg+xJ0OvMVjkJAYsRWFPbiHobW68EUYa3y086wiw/X04CjvFSExJH3HGLBSCPpoTiZ
 ELMh6Mj86AoRC5m2HeIygS8iOiALrbxlLHkwVPEReTFprN76eXYd1b2y+AJ3oZM8HzttE/xSGW0
 c8RRKVYmaQ6zrNF691heNC36vRYfHcitJWCFVxdwVeq+v4ejozBwKFOR4eEOa4smqqp+wzJUZIb
 vDa4kUj6CJwikpX5j6Lc/iUXBFe8QDkH3wGDDUr8Yb6311NaSTlsRqUq4nEaf/tk/rLPbpZXlCS
 wAZnhmt5MtKclQguXbmhFIh4p7Na3EQfiHLiXc29RVBFb8Uc+R5UJHdgBuQnUf30+mw2jLlQXpa
 Mx5C0xlyidRZsDj+6aQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200166

If a device is in an error state, then it's config space may not be
accssible. Add additional check to validate if a device's config space is
accessible before doing an FLR reset.

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 973d23e41c48..061dfcd1472e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
 	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
 		return -ENOTTY;
 
+	if (!pci_dev_config_accessible(dev, "FLR"))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
-- 
2.43.0

