Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C807947ECEE;
	Mon,  5 Oct 2026 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201812; cv=none; b=JQnPmHrINFx9w/8aItCaD37v+A44pjv0GE5mdkyEIlS7Cyp3y5cZFmFNcRoMgrlfhllwUI1EeJmFc8HJu1vNO1eDcoLR2fqzXClk4tMuR7ouiI3x9zSZvaYtyC3oZJcol4S8TgqonLCR69KXRFC3TXS4SwFfpGXQqg1VvAZ/zV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201812; c=relaxed/simple;
	bh=+z68eEBWRU3/NTrNfR88Exghdp8xeVPhNaHUBFgSGFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EUM8Ziiy3rMbB5hFck/xPdPZvw1ssDI6QEDc3ySQNYoDl/r8OL1VcseFX2sOb68EXYiPmux0Ddp36mWG+YejjHMx6iWDPf/bjI2VGdlgy6iLHTu7avZN+h1xHCxsew4+TT3lO8tb2F92q0P2CU8Qvj2lKFM3pQBYSDB4xH/T5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W4BYK/z1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W4BYK/z1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695Ba2ea527279;
	Mon, 5 Oct 2026 12:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c2YHpK
	p+8vdnIcKrbHfV34zRwDceo1uq96jBKijqWg8=; b=W4BYK/z1C6nnmxiNEXf+ae
	i/KUyVv/omsRc47/8SZlhUNT6EE7FrJfzX6u2MbvBPxHIHgSPf5XANZxGwWd7ndx
	xYEYn9IWYeybGn/fAT4/8nd12MlR0kUqGI+XrfWZim/F+ebY8lysljEMNLj5oJi6
	UZNgdh9yZGCpY0wocDMYGw2MKTdYSg33W2cFSHUSV6lF6faEf67IB3sF+LtjOEXg
	M/stOTdM4l+Ewh99bKGrKPVCrtKY2+6TNeAf9g88MyGP+tyegG5yTens/wlDuJ9v
	94vBIyjLXFRs3CRJDYQwlmcIptpo6tj5EXgItg9XXbkSA/YM8QATPn92JtnRrNwA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv196e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695BWbQk2862890;
	Mon, 5 Oct 2026 12:03:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy53fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695C3PI831064628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 12:03:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 009BF2004B;
	Mon,  5 Oct 2026 12:03:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C52B720067;
	Mon,  5 Oct 2026 12:03:24 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 12:03:24 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Mon, 05 Oct 2026 14:03:17 +0200
Subject: [PATCH v2 2/7] s390/pci: Fix resource leak in zpci MSI setup
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-s390_irq_domain_fixes-v2-2-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pCa-zGH0mqPnptTgKoNbXANXKS4uaVYu
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac39211 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=fzb7yXF3lHBN6XHo5OoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pCa-zGH0mqPnptTgKoNbXANXKS4uaVYu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfXwKqp5T1v5uv3
 kHRkBVptaT3l0XvYoIAikYdS58vEeNehwhSnZ2kBgQG8YRQzCU1ZWl/S38w+ah0Yxx+qtgbrVy4
 Ep1GkFry1tQ7ec8km0RfQrLmachXkWx5Lf2+jS8ytuuXQ6rIDkXyQ1urDAnxn6oEsN07HrM+GMl
 uI3h/62as7s4IworHZhQ6pUnQwXtUC9NLjLy2dtvqmsEGLV1waSsPpkf7R2hy9CzIWAKrYIZvvY
 QKx2mdu/YxLsR63fipwTGpfc+U8+INVuLAOpKGV5y31Hzex+5CCBFMwD56cMMK8OYThCz6fnHIa
 S5wxlYP9Z4VzS/BVbnk+/TavVr5nDGvdDzBQN2E2rsmnsK9D1pNvKWJ8u/TrbFsD6tX32ujxOY4
 wi8GFf7NveKtJvKS1X+k93v9Dukp9XAuepeaRIQcigfaqERFQw0Bl8uOLrqRoacmiHWG2Mm1/mY
 4KIoHDNT1KQA7uw/VAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX3VSgAH0npnOA
 FgSJOTClAa8BCy2IRqSlT10F6txHcauDF3XtMzLlGbB8EnJbjG/JhlyfTGdtqYVaG7b6W7l7FH0
 c4Ro1vY73IFKDLVMZd/nuMwnKr8NCO0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050045

If airq_iv_create() fails in __alloc_airq(), the zpci_sbv bit allocated
by airq_iv_alloc_bit() is never freed. This permanently leaks one of the
ZPCI_NR_DEVICES summary bits, reducing system capacity with each failed
device hotplug. In systems with repeated device insertion failures or
under memory pressure, all summary bits can be exhausted, preventing new
PCI devices from being added until reboot.

Add proper error handling to free the zpci_sbv bit and reset zdev->aisb
if the AIBV creation fails.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index c9520a16ca75..134f8f4a5cfa 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -313,8 +313,11 @@ static int __alloc_airq(struct zpci_dev *zdev, int msi_vecs,
 		zdev->aibv = airq_iv_create(msi_vecs,
 					    AIRQ_IV_PTR | AIRQ_IV_DATA | AIRQ_IV_BITLOCK,
 					    NULL);
-		if (!zdev->aibv)
+		if (!zdev->aibv) {
+			airq_iv_free_bit(zpci_sbv, *bit);
+			zdev->aisb = -1UL;
 			return -ENOMEM;
+		}
 
 		/* Wire up shortcut pointer */
 		zpci_ibv[*bit] = zdev->aibv;

-- 
2.53.0

