Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3FF424D6D;
	Wed, 19 Aug 2026 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129477; cv=none; b=a4n6SnvUlspG2RfMwTFGcE4PnvnHD7UrVjolQpC+Jd/EtxRM/Bi9mCmVb2Pg6n4NTJ89WivL6rgEC4YKjHXgwmCafYMh6FLZqHFIwE3wysNG4zFjZISXANMCyGiHPHTUQdL4IRaNNB6tAROyS61YqnfzMndgYUojm6ueys5Xf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129477; c=relaxed/simple;
	bh=n+zdyWWYmMNNFu8LL3tJxKU4bHapgAI4vHnbe7Vh4Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nLyDuW4UBGkuysVY+BTa5i1CMTXAo1JDat/DRjcysIAeUL3D0e1C1wIjtRAarpv6lfR+A6QmpehANr9p9Ril9R9E/Ek8kxSZtJBt4c5h0jorxsJf0+5nWIBAjQ7IFMAr6oQ6nHcIduiyTtuHWONX1w5PgZdkMbTUIkOJGVNQECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ixzMxj30; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ixzMxj30"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6WIvI2700051;
	Wed, 19 Aug 2026 08:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+c9hkR
	/UvnFv1X+twEJIzP9975oBrBOHa03KPUs8p4I=; b=ixzMxj30XKSfhc+b7DPckN
	Z7sz8tkB1OGUiBYYsO7p7sibCSQ9GhSALxeFqudWkwXasZU14TbptpanTtR6AMAY
	wDwLcSdAMRNC2jN+abVWbj6cYhisTjGyV4zJCYfSkLprHrW5BAuwF+EYpkvYDPQ6
	+37jP6u/xF7L/5II9AW8upTMtpUk4DqvmjBzdPKb9ct0XGP09R3QZyUf27S7OwPS
	i+5Oo1yQ8nyLRQkfhqreYgDDsz73jXPD3HqWMJEEZAJbv9lIlsvIXbdWuyEZLTzH
	SVIb+yh65RNLiHlUrpyoV/zwbCqnWzFtmzT/2n27wMtewVaEBI/BlXwAB3EB5EoQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu42jk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J8oZfj006773;
	Wed, 19 Aug 2026 08:51:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngftmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J8p9Hc43450742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 08:51:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CAF92004E;
	Wed, 19 Aug 2026 08:51:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F6382004B;
	Wed, 19 Aug 2026 08:51:09 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 08:51:09 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Wed, 19 Aug 2026 10:51:00 +0200
Subject: [PATCH 7/7] s390/pci: move MSI affinity flag initialization to
 boot time
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-s390_irq_domain_fixes-v1-7-826ff27b6e97@linux.ibm.com>
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
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a856e82 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ZS0GaVJMuydn_FCVLc4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UihizuyWQUkHQOyZ82EzVgei7QeALog4
X-Proofpoint-GUID: UihizuyWQUkHQOyZ82EzVgei7QeALog4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX1twRYAuB5CR3
 k3HzMpApIimOeUlQ3kCsrzFdNb5SbLMBzNmPqR8srUYfTLtkigKpVhGilSrVOi9e4muFRp8T74p
 /29cseWvKCB4HyZOatWNbhvRQo2jL9Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX1wi38Xdf9E7W
 cB9Tg+rwPyTpkmHj4+SnVdI+9ZJs5aRGo3k2JHKqp5BstEizszrJwWsEF7bgNfHYR6ccVTAvhiG
 YqNuz9pjcvrEEhBHhzGexnvdUNVxkeU8+kWkjnpmH+cKmiPsEF/z+Qv4cN8C7tTXAzaWWdwHxss
 //TiQsUJpHB+xZmfpFZlikTf/gZmaPbVEVhXMxKxWM/XDZH1qF/96fPRmkJD40YmVAEBN+rVLxo
 6GSs6y3Y3yydO9yIfj+qVXbrCG68xZTOHcaIdFdF5x02X/y/x4u6bB66PO5UYUYTT1TryKoDETj
 69D53LyP+bEqyeFt2Rv98jlsYZdfVLBT590ZTecQYWqKcgE/UQRcrWLXR5Yd8YjIFAIx4lwO/K2
 FtvMJFkT0ffVQw4dBDWZ2C74L+9IFozaLggdAnQdBartS4e1J3OedEckx4Uh7VqVdWryvs8NiVG
 vDW60tfBd5YJ8TXgFOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190063

The MSI_FLAG_NO_AFFINITY flag for FLOATING mode is currently set lazily
in zpci_create_parent_msi_domain(), which may be called multiple times
when discovering PCI buses. While setting the flag multiple times is a
no-op due to its idempotent nature, this is inefficient and unclear.

Since irq_delivery mode is determined once at boot time and never
changes, move the flag initialization to zpci_irq_init() where it
belongs. This clarifies intent and avoids redundant repeated operations
on the shared structure.

Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 1ddf6b3625a2..ed19f7cce9eb 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -533,9 +533,6 @@ int zpci_create_parent_msi_domain(struct zpci_bus *zbus)
 		return -ENOMEM;
 	}
 
-	if (irq_delivery == FLOATING)
-		zpci_msi_parent_ops.required_flags |= MSI_FLAG_NO_AFFINITY;
-
 	zbus->msi_parent_domain = msi_create_parent_irq_domain(&info, &zpci_msi_parent_ops);
 	if (!zbus->msi_parent_domain) {
 		irq_domain_free_fwnode(info.fwnode);
@@ -646,6 +643,9 @@ int __init zpci_irq_init(void)
 	if (s390_pci_force_floating)
 		irq_delivery = FLOATING;
 
+	if (irq_delivery == FLOATING)
+		zpci_msi_parent_ops.required_flags |= MSI_FLAG_NO_AFFINITY;
+
 	if (irq_delivery == DIRECTED)
 		zpci_airq.handler = zpci_directed_irq_handler;
 

-- 
2.53.0

