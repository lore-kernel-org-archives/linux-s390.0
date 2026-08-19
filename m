Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5197244692;
	Wed, 19 Aug 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129475; cv=none; b=rYYfuiRILXAOgQgZmRCqRmXv8a1p98ddchAwFovbKpbPWJWhD9lhhdcWW52AExf6nLu3/4ptV4R/xSuxMbZwPucmO4qDuqjGbgjDg8fLP5hZojdysEynzafqa63n3QZcSvvaEpM1SOMXNagElfaMOhVsECs2lqSDQaVwRH0lniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129475; c=relaxed/simple;
	bh=WctqrLEAZWzKfYg+EOvKS8CdQ0/iuFD9GoYTN73wdhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lU57Vjt+SN6IvjnTEg/VHjZbPZfic9WYSHLlmwYMD+qK5GK/qm/7/DwQFlrubGJT0xT8dUVi1itmn4JSYwtmhNyKPb3/1nLNKK5RE9W7ye8O+c15+0t7zis8ImQ0vO5eHu1v9pgVRjepOgviPFGSmR5CTcpFy/lwJLXd6IEOk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=irGyLVmK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="irGyLVmK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6VlEn2666835;
	Wed, 19 Aug 2026 08:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IGeXpM
	2K+U9rHRxIh7xZlp7tfxxYPblF6nobaKUiKfY=; b=irGyLVmKNIgGsGg1wvI9X9
	NTplPLw9ZCliMZvGi1C32qNy8IeegIgQcu2Ps6QHE3mA/CejoBYY+pM8HBXEkSie
	27u4AqHVh0cfxHq+9v1ZJBkqIL691Swej24HReEMWoztdryk6EUr8RJSuaET7JJz
	oDcZcMvH+cxTcO+DFq6joWsglweYwify8f5ovbgOgLsD7+h9yDNwxG8yIpjLMDjd
	KJM+Z0YLKOyqhXFDqWRCw4nWCqzBl4nnD/HEcHeIFlv8DLsFqhsOda9cr37ehMf1
	MtVTFAjePhtUoSaNTtB0ETsW0rrmVFN0n0C2J9B6EubOYprV6JeoONcuXScnhhBg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0amgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J8fHVb028355;
	Wed, 19 Aug 2026 08:51:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yfruc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J8p8rl46006574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 08:51:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 564B220043;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2095D2004D;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 08:51:08 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Wed, 19 Aug 2026 10:50:54 +0200
Subject: [PATCH 1/7] s390/pci: fix double-free in zpci MSI cleanup
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-s390_irq_domain_fixes-v1-1-826ff27b6e97@linux.ibm.com>
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
In-Reply-To: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a856e81 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=n6EUqp7IjLKcVj1b1CMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Cr771B-kUzzUDyObvkj0LSHAeylhJgtP
X-Proofpoint-GUID: Cr771B-kUzzUDyObvkj0LSHAeylhJgtP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX3Cs2rIBtsCLS
 lIk5VqFhVqdoZ/BVzz3ioVEC/pGRZuH6pAx73f60WIt8arOQAOE5iJCENh35sBd+/fbPO6Zns+e
 pAiE/SR7DrurLAU3cDomAS8ZTY8Q0Z4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX1oLkeaDZvPlv
 2uTy634QSQ0xIkps5jeu2ut4q3NkGZ9kSeq+wcWVmTtN7SHMY1XfyagoAuI+h03EF+iimrhs1k6
 O4JUsd6/PkxhspRMlyvUL5XEupcrUheXquGSUuNTl47t/Kosp3rHJyNO7kQ3DmAFhqYpXBRFCqH
 33JMogn7n94F4pr2Z3Vm1q1JxHHWVbH//dLVo3Gu5Lw1FVOz/Evuy6ktXWkevRdlm/VGUFJYit6
 QBLHSodhG6tEjR3QAJG7H5KwQG39U5w0ft+guFj/kxZC+vjZM5WwuscWhC7DtQBH4JRwiCIKNSD
 XtmNX4zHWKqp1TrzBStQC7re/P5r7475jYiPa2uMwcB03TqE9J50jF22p8GDktlvCufQkz8WGR4
 xjDR0ROoduNDE1QGvDQYbHybLt3NQyFYnwQf4HYobBrIVm5OP/D2jt1qOBHbfOoz3WdBsSSmBdG
 a26pLfYrr9h5h7jg4XQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190063

zpci_remove_parent_msi_domain() can be called multiple times on the
same zbus, causing a double-free. This occurs when pci_create_root_bus()
fails after successful MSI domain creation in zpci_bus_create_pci_bus():
the error path calls zpci_remove_parent_msi_domain() to clean up, but
doesn't NULL the pointer. Later, when zpci_bus_release() is called via
kref_put(), it calls zpci_remove_parent_msi_domain() again, attempting
to free the already-freed domain and fwnode.

Add NULL check at function entry and NULL the pointer after cleanup to
make the function idempotent and safe for multiple calls.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 9c9ed3d8d959..c9520a16ca75 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -533,9 +533,13 @@ void zpci_remove_parent_msi_domain(struct zpci_bus *zbus)
 {
 	struct fwnode_handle *fn;
 
+	if (!zbus->msi_parent_domain)
+		return;
+
 	fn = zbus->msi_parent_domain->fwnode;
 	irq_domain_remove(zbus->msi_parent_domain);
 	irq_domain_free_fwnode(fn);
+	zbus->msi_parent_domain = NULL;
 }
 
 static void __init cpu_enable_directed_irq(void *unused)

-- 
2.53.0

