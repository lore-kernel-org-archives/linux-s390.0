Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C3143D50C;
	Fri,  9 Oct 2026 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526661; cv=none; b=Y+psxg4+ZR93XLHg6hRw3bXmP2NbNXlkmaQefm8Bo1a4YuDQuIhSJ4UQdaugAvdBJyqzKhM1H6wxNpMO5QyL0ACwtfH5inr9k3QzVvcIhoybCBTIqSE+nhSFYcBpwjfrk6dMCvfJkIGb35Z8THL0YswiOUs+hf9LNT7+uRPAkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526661; c=relaxed/simple;
	bh=T2eKHicn4bMS1R3Mgo1fpdXIUydDC0QIhhpI1x0VnSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jf55gMNlj61IDfvlg0Nrj8xMs0yGQFom24xQMgmDjwd2sgZpNs1uTFo+bOco//JH4ZUfaBm8X1UkT3HWuV5eV9MFFLK1DaDbzdsOEj3f+TQeGayXYJBCz5jcspDzhJ47CuNhApOL/ItLvYbgxHENS180rFLgqMKfH8gZ+nfrUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nJl7iwUg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nJl7iwUg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993ZTPo1992250;
	Fri, 9 Oct 2026 06:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KGjH4c
	/OSs6j4M/ZRChDLvBczGMg1NfDJ5Wpru97FKw=; b=nJl7iwUgP6b48Q9EIqxLkH
	Ayp3slbbKw+bt9d28Dh275YfrWoStepM1Juq2vyuQGK/5M7bUWCnBnEOC7f0BWQl
	O9lOhB/p6jeGejHmQbYs7bgsgwnZySRf9yegvwESxGjWw+tQKglAjx5a/dP2phNy
	Oq8DRp0rP8LWpiwPZpF+QSfJce+TgLbk9J8A8T7F9RZk4rTHcTCG6jh2czP1JT54
	LcA6KDr5b98fVJOKYo2SovFm0snsVNZEjKP6KvSxEVcdDgMhdEvuU1J6FQu7R1vz
	zxf5yHmgC5KcN7Ad1lZuNl30B46u5jS5oNf1fxTjF906pv0jDlt145c7S3xGLRbw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1g66x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6993I5ar227534;
	Fri, 9 Oct 2026 06:17:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5u0dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6996HY5E50004310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 06:17:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A104F20040;
	Fri,  9 Oct 2026 06:17:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AD542004B;
	Fri,  9 Oct 2026 06:17:34 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 06:17:34 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Fri, 09 Oct 2026 08:15:52 +0200
Subject: [PATCH v3 5/8] s390/pci: Add error cleanup in
 zpci_directed_irq_init()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-s390_irq_domain_fixes-v3-5-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac88703 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=G5X6WIfzd73FwtgFMMAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX0znnBsXEYCkV
 CzPGX1PYGtVyYg8MuIzAG2NqlWCvS48bmDiKMTtDOTTPww5XbLwbOHfihth7WJzsJiEDZsw0vSg
 61R5huyugXq9XQI/EYGydYMQjUwqy65bQp6A04SmPXNXAF82MEFvKR/ss9HZXfQJJ0gO5NfHTCo
 EZPj7Fe7uEMAUYLw8RnlttcKPjkj28mpJYdMZ0Zy427tTe5jrd9HM2xPT1KFF+HaC25YGaVVEnD
 Hom5rIO3y5OSlPWBHBFOSafDSUAlOHHkZ+eVNK2Gdl6scTUCca0+UPF0LTWE54uB0nEzYyESMD6
 dy+GbCNEbemmP1q9yDcceuo6g4jNQhQ3E5exk007SNDcM+vGQb2mjJVIiFkjxOqsV4SHME4OfXp
 3n6plGfFGNkJFLGZe+2zGQtlUWZY+0kHnOxiPz6KFK+2yTOsXeUtG7axr+afBmaKhkpvj6M1g5l
 k99XSlMKkBPHaUfOK1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX04416HdYsmfr
 xPnkKGqWytg8hl5yl4Y4IaCdApeFG2FuI8SJH2uNmDC+TWGEP2DfEiLzchRXyC775qxj7IT/dTE
 yo1tLJsozK1LMdVPaWJ9YpUY+vnEA+4=
X-Proofpoint-GUID: RqDIB6Y_KaJItbVoS13eoP6P0Cdf3dLD
X-Proofpoint-ORIG-GUID: RqDIB6Y_KaJItbVoS13eoP6P0Cdf3dLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090024

If per-CPU airq_iv allocation fails in the loop, previously allocated
vectors and arrays leak. Add proper error path to release all resources
on failure.

The error path frees zpci_sbv, but SIC_IRQ_MODE_DIRECT has already
programmed its address into the hardware. Set the directed interrupt
mode only after all allocations have succeeded, so a failed init leaves
no freed memory registered with the hardware.

Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index c5fabad38139..bcf11585df8d 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -569,14 +569,9 @@ static int __init zpci_directed_irq_init(void)
 	if (!zpci_sbv)
 		return -ENOMEM;
 
-	iib.diib.isc = PCI_ISC;
-	iib.diib.nr_cpus = num_possible_cpus();
-	iib.diib.disb_addr = virt_to_phys(zpci_sbv->vector);
-	zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);
-
 	zpci_dibv = kzalloc_objs(*zpci_dibv, num_possible_cpus());
 	if (!zpci_dibv)
-		return -ENOMEM;
+		goto out_free_sbv;
 
 	for_each_possible_cpu(cpu) {
 		/*
@@ -589,13 +584,30 @@ static int __init zpci_directed_irq_init(void)
 						AIRQ_IV_CACHELINE |
 						(!cpu ? AIRQ_IV_ALLOC : 0), NULL);
 		if (!zpci_dibv[cpu])
-			return -ENOMEM;
+			goto out_free_dibv;
 	}
+
+	iib.diib.isc = PCI_ISC;
+	iib.diib.nr_cpus = num_possible_cpus();
+	iib.diib.disb_addr = virt_to_phys(zpci_sbv->vector);
+	zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);
 	on_each_cpu(cpu_enable_directed_irq, NULL, 1);
 
 	zpci_irq_chip.irq_set_affinity = zpci_set_irq_affinity;
 
 	return 0;
+
+out_free_dibv:
+	for_each_possible_cpu(cpu) {
+		if (zpci_dibv[cpu])
+			airq_iv_release(zpci_dibv[cpu]);
+	}
+	kfree(zpci_dibv);
+	zpci_dibv = NULL;
+out_free_sbv:
+	airq_iv_release(zpci_sbv);
+	zpci_sbv = NULL;
+	return -ENOMEM;
 }
 
 static int __init zpci_floating_irq_init(void)

-- 
2.53.0

