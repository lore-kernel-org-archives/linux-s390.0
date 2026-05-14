Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3D396D25;
	Thu, 14 May 2026 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781674; cv=none; b=PUpEKHW/sOCa2wYK2uq031C2dt2z2T2GJO5NtM/SVJTRzI+axLolxTxnIUZ7+ZOYXsoXzLv64D+E+f4uh6gghHQp+5NIhCxX5D6Xb8ec9pZC4gkMMBY6V+S0bEOt3WL843qaLOCbZKQDq4OUeIdsInBjiyB9fszoCnHcOU9WXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781674; c=relaxed/simple;
	bh=RQ+lhbs/20dpjDWkfLkvzRoH5lgweVzoQtY2ETnzPfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GG6UFQdS85VGRLnIu3llfm9k9ogy8tWoyYLw7UwyRseAsiJqRNIJDBkEif6zuN4ZmvDC8FmEfh0tJhev2xu1fbPZs5Sk5JM7rHFG92tQmIgmf1zUleD131PXn3O5R6lvMllciqC3NZNNOgq66xZRTnuNR9oJB6vw5TB2NI+/0tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XfwZf/se; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XfwZf/se"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E6hhH72611844;
	Thu, 14 May 2026 18:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cFYGaeCjhi1C6NNXk
	0q/9v/1B4HO6gGEzVR0sxD8XXU=; b=XfwZf/seM1Mf9ywuAHWum/PwWUurr0fuu
	4+hMnthGTsqftKhywLuIbFBBEDzQqUjn1n7cLyveQxU2eDdHQDi0xjRJJFZrxUw9
	nIHnPYAJjxy/xFCmYIjFPRFQwqP6IE+IcObsyJRcPm0Xz7LkUSQYngK4ZNS+k7fm
	VqeeEqaNUyrnEy9hpeLJ8LUbU2fLThf9JJigCQgc6bGZ0OYG00LySf4rq+nZJ3cy
	xmPkQjzLyV0TbbaWBHzTY2YdUJyorOEcq2UQknRviWsB+uIzpQoX+tBoP0AdYMOe
	9Oz+oZvMZAdF1QHujB01a/JnhAuEfvoNb3EXBEWyKY88o8LAOhg9A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nve5tkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:01:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64EHsTXa019443;
	Thu, 14 May 2026 18:01:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgwh1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:01:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64EI16Nu25297430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 18:01:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D325B58054;
	Thu, 14 May 2026 18:01:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC13058045;
	Thu, 14 May 2026 18:01:05 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.43])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 May 2026 18:01:05 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v16 3/7] PCI: Fail FLR when config space is inaccessible
Date: Thu, 14 May 2026 11:00:55 -0700
Message-ID: <20260514180059.1553-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514180059.1553-1-alifm@linux.ibm.com>
References: <20260514180059.1553-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a060de5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=1owyFLT6pZZ0tE0DW5YA:9
X-Proofpoint-GUID: 53k3f6ojS3dfNen6T93vXGAyZMpXPTaF
X-Proofpoint-ORIG-GUID: 53k3f6ojS3dfNen6T93vXGAyZMpXPTaF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NiBTYWx0ZWRfX/KQU0Kzx8+/V
 di65qktpnchYPU1TiKXpBJkIlp9KgDEDPMAsOXpPzUGXdMh257bHz9T/TvCRawdkaERFPTeTDbO
 3CTejT13Zg9v+hDUIycj+tnMDj0GDJ9tioIsVzxobOmZVDQjbY18Sj+2hGFisbhBjYLltInJETC
 cEv+emoExXbtsjAScl8fvAA3YTP0ooPq2IYuluXQE2+asxvQW43VPHN4UfaoGXeH0Rwvovk2e6G
 XJ0Ksfn5QwlOTnb5uhuDIAuLniVsUp7WDAJbJiJPbq9fyW5GyqxHru7mBsTsL3doUEUdyX+n9Rm
 HNXR3IEJHTl+upQyxUdQ+tjH035ZynkfykL9xVZMjj+XACyoa1ttKussG6y5s2xAe+FzfMsloUL
 854LP9q04m+4olosoxHkZoX0v8hH1TpZa7ZQjKLjOKYZLO3svYo+AazbofN/4Q9RMa92r8PjYar
 7HwkJOjya8I6YwhXwgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140176

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

