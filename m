Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD21339A4;
	Wed, 12 Nov 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962068; cv=none; b=Vc3AStEZuq73fo3iN5kcJUq6oTBu2wuYkOTRceg9gfI34PEbWM9D4H8nqkk50XZzhKNYoEFE2+hhUvkXsXwgeCOTOcdt2q131DUlvu43k/+vsxBMK7wyJiy9S3RbY4YL28OkokxjKQwvVR2OsiD1HQEj9oKnZZcYEy8tHiTq7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962068; c=relaxed/simple;
	bh=zD22bqyKwraBRhUj83aMTd4RxFbbpXqMswP7Be1a3AE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYrXE8+DPpJ+fxphTV/vrq0myAxOpp7GgdxmfE03QCRlw91HNtW8BRpqJW3YHRS39H45fq7p3ekwuXCEZgeuPvbmn8XrK5pCtmJTmv6dc/JoQwfXRDM9/gRGJw5UUIMSdwOsujaeuW/6qxnBBW7gekyzgXlhRiA3ociXk0p6fmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L5gynTM0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L5gynTM0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC5KrsF020676;
	Wed, 12 Nov 2025 15:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WPtCvj
	Oy8xf8UDGt47QzHjX1Zr0mV/mEOHG069OitmU=; b=L5gynTM0TQBic8Im+fs2n6
	m7poozeiPpZ2I4TIk5o93YWmeafFJkFSh7V7NHnMagknRwchBJZ3ko/foPtyGliv
	6KR29EL/HsCfJvlLmyobhqIyBVPt/WXex4ajKU/PbC+aZaa6tWpcPtOwf8H/PQaX
	asRK1eNMvUbQwrfw4JFuAUSJF7FZdwJpqa+8tS1JCLlbtjD2BilF69AtmFk9A19x
	G6NZNN1rCgvIbHFaDZkompqV6XIB42zPa+3AkSNRifxRphbcGYiDrFPtfsEqo1cQ
	NjLF0q5cdiuI/E2280bnsZ3rll78zSaXwTHARnGpmDd2As/rO/kQ6AjBuYWXSpoA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8ba9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACDVFFd011600;
	Wed, 12 Nov 2025 15:40:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1gnm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACFej4D49283384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:40:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0762F20040;
	Wed, 12 Nov 2025 15:40:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCC702004E;
	Wed, 12 Nov 2025 15:40:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 15:40:44 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Wed, 12 Nov 2025 16:40:44 +0100
Subject: [PATCH 1/2] genirq: Change hwirq parameter to irq_hw_number_t
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-implement-msi-domain-v1-1-103dd123de14@linux.ibm.com>
References: <20251112-implement-msi-domain-v1-0-103dd123de14@linux.ibm.com>
In-Reply-To: <20251112-implement-msi-domain-v1-0-103dd123de14@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Tobias Schumacher <ts@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfXyHIMdCWvSq6F
 wYYNweChsITjyZR2aXjUlnDVryqIYMQJQ//ouTXp15hWVDiWRusufX+beFPtPzmWwZ1OG7b685b
 +vlu2AL3tmYtXRrXJKmAHWW6ZUGP/HHrdxQCL6NeFWZLotEa3wMXckN+63wnzVQupkb79z/hLjc
 yXE1bgBIVjs3l49GAgCnFugPTI7pYVRYjPzkbdzef85CVOjOdm7+k/YlvBgO7IIUD7AXsDyTqcO
 DDOL1jrXZqEbAe3iaGkW+/54l0rjEP7aitsxo5Eku6r7TxsGRe6SwOxfBKCUUDP7u83sToh/gm3
 AmMILDkagB+gME+rUg7t0xeB1leuxkIczaPSw9NEqCmlv6sMICAhxzUOVng/WNeoVl4Mu82+seL
 zgA57IagvHsLW8UW+W/sWUJOYwDg9g==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6914aa81 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=ksSNG-jg9v29UnNErXoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dd0i4D_0VNAskw4ManR5GHeElUGjHHvf
X-Proofpoint-GUID: dd0i4D_0VNAskw4ManR5GHeElUGjHHvf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

The irqdomain implementation internally represents hardware IRQs as
irq_hw_number_t, which is defined as unsigned long int. When providing
an irq_hw_number_t to the generic_handle_domain() functions that expect
and unsigned int hwirq, this can lead to a loss of information. Change
the hwirq parameter to irq_hw_number_t to support the full range of
hwirqs.

Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 include/linux/irqdesc.h | 6 +++---
 kernel/irq/irqdesc.c    | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index fd091c35d5721eee37a2fd3d5526559671d5048d..03b63aea73bb21ae1456910afa534d60f9cfa94d 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -183,9 +183,9 @@ int generic_handle_irq_safe(unsigned int irq);
  * and handle the result interrupt number. Return -EINVAL if
  * conversion failed.
  */
-int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq);
-int generic_handle_domain_irq_safe(struct irq_domain *domain, unsigned int hwirq);
-int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq);
+int generic_handle_domain_irq(struct irq_domain *domain, irq_hw_number_t hwirq);
+int generic_handle_domain_irq_safe(struct irq_domain *domain, irq_hw_number_t hwirq);
+int generic_handle_domain_nmi(struct irq_domain *domain, irq_hw_number_t hwirq);
 #endif
 
 /* Test to see if a driver has successfully requested an irq */
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index db714d3014b5f7b62403ea04b80331ec6b1dc642..0cd3198496bc0766c81c353c3ff80ea184793d6a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -720,7 +720,7 @@ EXPORT_SYMBOL_GPL(generic_handle_irq_safe);
  * 		This function must be called from an IRQ context with irq regs
  * 		initialized.
  */
-int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
+int generic_handle_domain_irq(struct irq_domain *domain, irq_hw_number_t hwirq)
 {
 	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
 }
@@ -738,7 +738,7 @@ EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
  * context). If the interrupt is marked as 'enforce IRQ-context only' then
  * the function must be invoked from hard interrupt context.
  */
-int generic_handle_domain_irq_safe(struct irq_domain *domain, unsigned int hwirq)
+int generic_handle_domain_irq_safe(struct irq_domain *domain, irq_hw_number_t hwirq)
 {
 	unsigned long flags;
 	int ret;
@@ -761,7 +761,7 @@ EXPORT_SYMBOL_GPL(generic_handle_domain_irq_safe);
  * 		This function must be called from an NMI context with irq regs
  * 		initialized.
  **/
-int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq)
+int generic_handle_domain_nmi(struct irq_domain *domain, irq_hw_number_t hwirq)
 {
 	WARN_ON_ONCE(!in_nmi());
 	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));

-- 
2.48.1

