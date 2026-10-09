Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306B440642;
	Fri,  9 Oct 2026 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526662; cv=none; b=DhO1KOhuxeEQWxPmXEzp6oVSNZa4C2EYKHLm9WiJr9zspLV23xm85Xdcqs7kW8+mPnGohJvCEypsnVrQkWAtGOvBnT+FPTSlvUrGEXw7HEG6ZS1gOc9UNfr6LDLTZFyEiyeexxWWqbfyyGFrzDYzny24vVZzZ0rKJWXsPRkIGBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526662; c=relaxed/simple;
	bh=wMvSlDJ8ixIFy6vCY2q1s0WdG8SysHeHX0h3B+Qhiw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MDYCgXal0Vqe34jSXhFRe4KDwonsmd3Kdv+LfqShjo5gBtSGTegoJqDcddbsvsgCRnHr0TGJK1bfT6/CcpjCGtamazKeA66JObiESnn8J+1JNJkDZQulWHSMVypaZ4p/Fgoh7qzg44YoETRkR6ToO+1OOTkc2qzO+eQAhM26W20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sk6Psn/7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sk6Psn/7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993a7Xo3209943;
	Fri, 9 Oct 2026 06:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FAecKX
	FZYIYzcrIlmHnerdxpa7BEl4OZte093UrLtS0=; b=sk6Psn/7qx8IGunmQDsLaL
	hKmt5bodfUV9qGeGD4nvM8DEbL0kizs/2yeTF4eVF80+mB38mubeCBU+tah2+HyP
	sMJ8uMgV9OQEVFpDP/KkHOEErnS5PWkhA8TBgpTc6CSPr91kA4zAQr+qptAYGpP7
	eKp/5/3BwVWTS6RCFM/WkugT50SVcQrYihauDQQ9efuTJXptyuwM0/Qubl0ap7nw
	CzT8/qDfeerEIFLLy07BaSHMyIgxkjDf//1MuNvD7kn9i9F+czdzO0vYxiJqwVII
	+Etsta6n7di++JehxFCfW9/4gz2qsB0a2re+zkDHfZ4bQ9jrEm2Q1oiOWwskrHxg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvr6g1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HkSH290369;
	Fri, 9 Oct 2026 06:17:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnhs7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6996HZld28574008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 06:17:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD7A220040;
	Fri,  9 Oct 2026 06:17:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 775F320049;
	Fri,  9 Oct 2026 06:17:35 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 06:17:35 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Fri, 09 Oct 2026 08:15:55 +0200
Subject: [PATCH v3 8/8] s390/pci: Unregister the adapter interrupt first in
 zpci_irq_exit()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-s390_irq_domain_fixes-v3-8-ced19028da3c@linux.ibm.com>
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
X-Proofpoint-GUID: bQavVcDxs9y6_ZK9hstN9Xf81PErpZfI
X-Proofpoint-ORIG-GUID: bQavVcDxs9y6_ZK9hstN9Xf81PErpZfI
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac88704 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=hZ4bbspKaRqrB7aK3PIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX/D21rX3MwyYe
 /o7AsGuvJ/gfyVqsho42uMuCfJXcC1J+7HZIqv0nELr8lns0QNvcuFjnZ/nPmtSAFIwlLP529HR
 WL+i9GPNZtG4TXYrqwM5aNxkXCj6C7Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX5WDlm6FJcXIW
 iDOr0UrGsiHOstD/O+HS5gt1EGCuXOfNMm7HdPWe/2dFsO696V8Zdu0wVmiWMnwmIBQ5NIq6nEK
 hybN9L8UySd5bZUOTMpXEKYB56v9jFmH+lEx8kwP9obu8Tb2tt89HtlbH2P99hrNt5X2q3N1WSK
 iJxq/kO35vdMZP9STm3U01D7p/Uks+O2hLV1Yfz4u4+P2ZFTOqVIItS8bnCa8HKO/Ug8rSaCQMA
 Qq2Gt3WDzEnGng10FE2tARqPHILKOjW39c/ju43DizzadrP5lN8/RNxFRvMIhLOiKN9pmMHdQ9G
 X+vn8I0J56ocdQZIAsczxsmisxEVZXq6iy6P4ep5YHzcagRoERnq4aHxJ8+PsdtxTxqrx7S+NC+
 L2relCNpe1Fo5qu951Cg/1eE6tYgDn6qnvvX7QevWcn67RsRTw16Dn9eOsrpqEWpnrWO9OOjS5e
 R3njWhsdAyv83yRBHLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090024

zpci_irq_exit() frees the interrupt bit vectors before unregistering the
adapter interrupt whose handler uses them. This is only called from the
pci_base_init() error path, where no handler is expected to run, but
unregister first anyway so the vectors are never freed under a live
handler.

Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 4b8ebb987580..16ae80ed2d13 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -674,6 +674,7 @@ void __init zpci_irq_exit(void)
 {
 	unsigned int cpu;
 
+	unregister_adapter_interrupt(&zpci_airq);
 	if (irq_delivery == DIRECTED) {
 		for_each_possible_cpu(cpu) {
 			airq_iv_release(zpci_dibv[cpu]);
@@ -684,5 +685,4 @@ void __init zpci_irq_exit(void)
 	}
 	if (zpci_sbv)
 		airq_iv_release(zpci_sbv);
-	unregister_adapter_interrupt(&zpci_airq);
 }

-- 
2.53.0

