Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD13D300F;
	Mon, 30 Mar 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892428; cv=none; b=iTj13RZtXPeAhTHKBZaqZQuDcVL6TuRRJsdsglDO73UvIkLU9DOVC74KVzWIWyDqYKy3R11wJGU1u7oX5hf6TW6HwUp5ghl/jNuTu/dOi4KbBtpkgEYOxX25R3wuLqoZsmCRaa3pfZy6B2MxXvfNwsTiCQHmgT4tidp+RZS/VpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892428; c=relaxed/simple;
	bh=xH0bpVU/cdHwEYkfWSLVW1e2R+QWBkI8b4LqDl7ItOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUZXpFSjHB9zrcb8aV5FR6QQ96VGTt7g8YmIGVmMGwFyivbjgOCqGGyg/IJXr0L9r7dV7voo9HeX/LTIq8AvIKN4M/ukmrs0TzhQeYDXesyy7dguu/EQDZf+hp0+m8Pf/dE+tAmxkMLu0X9AAo5tDCoS6SYcdWeGnNnYV6zW4xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s5uxcAEx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s5uxcAEx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UDKZvO016485;
	Mon, 30 Mar 2026 17:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o/odM+SF5JZQPmV2E
	CjE7SmOujlqi3O4p9BfbYhLHHA=; b=s5uxcAExyXPETjJ6dY9qa4+4jr224JqXs
	suuIxT0k6Cg23mfCk1uQvtPcVlmT+fO1rgWLJj8QQzBEYizfGaanSuurfo2Obcf+
	mAYAUtVF7thNf/8ZMkiNJupZxdW3C4wCSE05YnDKXenMLwfYvG/hWRbsBmExo+oN
	4RaZDkheaAZdV94h891Iw0IMmpg+9idM9R6aXoUaQaKc3dqY68mUgblXeMMs0epL
	U2iM9AiEaO1/QcQibtblEdQ7GBav9pHRWlnzhmzc/sBpsLZPQSIh6wh4YEgfxEGL
	jUJyeFkS9F6ONxmFDtf9pb/+qRM2uMgt/6StLLSxQln0q7KgdulbA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnfyau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:40:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UG6N9h008689;
	Mon, 30 Mar 2026 17:40:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11dmqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:40:18 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UHeHBV26346120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 17:40:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E88565805A;
	Mon, 30 Mar 2026 17:40:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0804A58052;
	Mon, 30 Mar 2026 17:40:16 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.214])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 17:40:15 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v12 3/7] PCI: Fail FLR when config space is inaccessible
Date: Mon, 30 Mar 2026 10:40:07 -0700
Message-ID: <20260330174011.1161-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330174011.1161-1-alifm@linux.ibm.com>
References: <20260330174011.1161-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pDbrwcAnQWLbFZ3ZYcSJ07JL8Mtksoe8
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cab583 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1owyFLT6pZZ0tE0DW5YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MSBTYWx0ZWRfX65DQaLP5nbiX
 okBxVYD5NbIGlnR//bOOuWFT8eqGhWG3htjtdCkaPAtXdKtnLZS211dZskT0d0lMxxvavG25LTC
 7MSxBvFWjAVOBdWi7Wl/M3jDhKN1NzvWZpWy1W3Qsm7Q7FXSBdBvtMqepEiva17VAE8L1amq+ZF
 E4IAkvXjPczjyPoZGhIexvicMkcW/OSLz1q+aI56wFb58Qj8p8068LbexhGxJhXzpcygGWrYUEZ
 SUn0U4C48yXQGDzveRvfkglfdvj/k9CskDeEs+oqORc5fZCEaguJnPUY/REnLWcQk4LxJI+fTTU
 AzA37GELd15G74MRIEuRLqQxhvk0ZmRppxliZpn2HppRA8xCZnMnpccvAQ3nee7ukCdgVlHDL1l
 e6ca8pQhk+G5hVjyT/eCfFaSk84RjGT6ArvH36Q+gIIRWMUtUf7Rnc8giQ6+tlCY+lj8lpomPF8
 2qCvjreRvJ3x8HPmBBg==
X-Proofpoint-ORIG-GUID: pDbrwcAnQWLbFZ3ZYcSJ07JL8Mtksoe8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300141

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
index b36263834289..4795736193fb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4398,6 +4398,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
 	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
 		return -ENOTTY;
 
+	if (!pci_dev_config_accessible(dev, "FLR"))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
-- 
2.43.0

