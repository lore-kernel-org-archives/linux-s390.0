Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C621531C1;
	Thu,  4 Dec 2025 05:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764824722; cv=none; b=XemPpPnXpdW4nb0c4qFNvxuHwcd6CCCYMfS05ijBAceqY6iWcKqS81OthpyhosbAX0qadDTKdBvdA9zAdzBDqm5qGGylZr9kWhhX8s3Y+QYCg0fNSw9YmWkrMvshlUfEtqdsov7HSyLywViVqOonSzgzjQtQ2ybAbBJNUXvnikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764824722; c=relaxed/simple;
	bh=h+0JO5F1BsCL6T/czUkyOQMStbUrks45PvRwGKRVQak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfzxFnwSfSDDGLuIA5UbEnu9ipjXaJYJCdBa519JtT4CrEYTk8gJwvSZQbaj7wAaailIzNEIkUVBchAA2ZCRIZrhCyIX9GVLTVTlLtsBLN05uCHtfJ+/6QhHfAjOMd/OXiE1Rlmlfmg9dyhJY3NVcczbN63Hx7p9a7uLv/D8hSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k5i0C5FP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k5i0C5FP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3NhX2o006817;
	Thu, 4 Dec 2025 05:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8fugNI
	aWueeCYJGLShvhSZYH/P22+ioQYQT4sBg2aJs=; b=k5i0C5FPcKiTQYYbgRqfQA
	TNCO7VH1ks5xbF04AUXBscFEvgdA2eB3aKmCrXF+XKA9IpAQ6htKFmTuBriOHWnw
	jkWIWojEFuDC4qkC9RLHLYua2mGTSSy71zS0pJAMXl44MKgt0Gs/frBnWZhgRK6t
	honnfgLyjzefg9uIa5ujP6CZAAR9Mdb2ovaNX9nqh93DSduUDG4YFg1OOrVJrh7q
	G6efQB7cDCtO4vRytZwBYO+tyIfZBKQUgW2baRFTJIeBzug25OBL3w1KqY4e01GR
	sBWO/7K+SoBmboI9JP9n6z3OHzBExG4FDY2OMgs4WFSFfnsgOPyyc3ps3vvEeUcA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbgenk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 05:05:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B43G3lb019035;
	Thu, 4 Dec 2025 05:05:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhy61vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 05:05:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B455COl59179348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 05:05:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B70420040;
	Thu,  4 Dec 2025 05:05:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E54B02004B;
	Thu,  4 Dec 2025 05:05:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 05:05:11 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Thu, 04 Dec 2025 06:05:01 +0100
Subject: [PATCH v9 1/2] genirq: Change hwirq parameter to irq_hw_number_t
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-implement-msi-domain-v9-1-d2152235701b@linux.ibm.com>
References: <20251204-implement-msi-domain-v9-0-d2152235701b@linux.ibm.com>
In-Reply-To: <20251204-implement-msi-domain-v9-0-d2152235701b@linux.ibm.com>
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
        Tobias Schumacher <ts@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -cLa3txQWTNOQStWR0FMiRKwgiZ6017o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX4SBfJ5CWYZi1
 BNEQvQVw2rLsvvIoAfcH1t5medyw1Lz9qu9ty/wk67lqyAk1PtxXTyv6xl1udCL7W3yjk4TV09w
 LGFVVyH2DsMI8Fhke6tQskpn6UJ6xgaHNRkEaLREcM2EjQ7Xor4aTz8W5XVSzSxINqky0TWfZfY
 kLOlGhpHHHe4l6d5Vd8JDwX199rLhKrA3xYDM795/Dd+TJs9fu8U+Y4i+8nRgRROz1MOtZvphAV
 9z/kK+y0q3gmqZq90JGfoRARRNnAyw4iXWiYwn3jD0eGHCuwMhdosZT29HTJo5q6k2GEZj6/PG/
 CO7q7MPp2NXPvL82+XeZC0/+vrgUu64f9gXocBHikOs6eYJzFZ1AIAXy5ZHZ0zL1OaLmOHO48vl
 +cXGKsA8hi1hzz5Hn+UAxYUFvqE2Vw==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=6931168d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=apPMBW2BC5_Ovgk0KuUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -cLa3txQWTNOQStWR0FMiRKwgiZ6017o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_01,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

The irqdomain implementation internally represents hardware IRQs as
irq_hw_number_t, which is defined as unsigned long int. When providing
an irq_hw_number_t to the generic_handle_domain() functions that expect
and unsigned int hwirq, this can lead to a loss of information. Change
the hwirq parameter to irq_hw_number_t to support the full range of
hwirqs.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
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
2.51.0

