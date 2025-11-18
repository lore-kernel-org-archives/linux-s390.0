Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8012136CDE3;
	Tue, 18 Nov 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482409; cv=none; b=aBNPrmKLqiIFrrHdD9yXnfUUkf9nypE9ltRD58CzE4BlS5R6Pe3Xb5+rHDcm/UqmknEQYvyCmH4dU0WYqXXQr6mLtvCiKQGeCsMPeCa7O9PqOzGZ5JDQhjCS1ddXBCi2UQzMa1EwisrD0i9Gi8NQOVXIzbTURFCpyujBHi8UPMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482409; c=relaxed/simple;
	bh=oAgeMxQ+c0k5R8Zm6rJJS8z3j6np1W6NcBM2vBaJ7pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SL8thipE8T0oHpynJFGBEJsrmpvjVGeuLcfBKjnYOVUCe+kE9mbsKf/0dpgcPJuNrDGeP6mwHeyYzq6ygbz1qojOll8bnd3f82Zcgy5f0ZJTTvEaD1LHwZ1WaLVXFCCOx7voJfqVL7IPpmhANQv8LZyoCqRslRwzedfdhTedlHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Af7MY83r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Af7MY83r"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIFb4x5028393;
	Tue, 18 Nov 2025 16:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6T7wC7
	9xoMCQ2U7t7iJ+GPmWhQ4lqDODQNt2r7sPG3Q=; b=Af7MY83rGFlzQvvYIdy9fx
	Ved/AzD+DAokJffTLKd4N+W6qCPFTqdRYgFyEmuY/5Z88xHqQH//e5XSV4cISjLL
	Cy3HcyMmpWji7WO7hFeeSJwDmRTzvdT5EwdoF/O4nRDSTNxKc5WDvQcgdqukxmGq
	netwCBlID0H9LgS29iw8rgG4EuHNhgbnTuo2GuVlxDDfc55wYTjOnE6xIoei4njx
	3VtAozs1gHsoCR600f0/hdfePbdCTrLLxMGkoc9WkpVGvEJQOAFFSTuNip41oJQ9
	j0VHuVbmApPNAYSYYmG8I3nd9hbmpWx0jUHpzT16uEcLce1ecbwwKby25qJggLgg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmskfhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 16:13:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AICxOsl017404;
	Tue, 18 Nov 2025 16:13:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j1kpu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 16:13:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AIGD8D914811564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 16:13:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41DBE20043;
	Tue, 18 Nov 2025 16:13:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12BEA2004D;
	Tue, 18 Nov 2025 16:13:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Nov 2025 16:13:08 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Tue, 18 Nov 2025 17:13:05 +0100
Subject: [PATCH v3 1/2] genirq: Change hwirq parameter to irq_hw_number_t
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-implement-msi-domain-v3-1-6fe8feb2a93f@linux.ibm.com>
References: <20251118-implement-msi-domain-v3-0-6fe8feb2a93f@linux.ibm.com>
In-Reply-To: <20251118-implement-msi-domain-v3-0-6fe8feb2a93f@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 0CtF8I1bN6O9N9QfhEAKKXtq1mBZkHNV
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691c9b18 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=apPMBW2BC5_Ovgk0KuUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0CtF8I1bN6O9N9QfhEAKKXtq1mBZkHNV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX6lsokHG9HCpg
 YjslYJXTdWccOn9mGPPsijnE5aSQVNcDh9u3hpfB2tMymfApmOOeTaO1S3FUbAz2aeR4GCQjYsh
 KttsVPoT0Li38nfQ/s63+GkZAXHFMWBkPIeQVSXbB569v52WjfkfULVrJ/4VK7VCWeKDqfK8jhQ
 kFqXYK8Bb17pqbGwXuBA2vm1eEnAoh+Ujic0lkxZ9BI41dcQPs41FbOGylcGPLX068sD9pif/9L
 QjE4R6R2g6aGSFNb6AnqgsyfmxaIG8VZBc86R7LMQWWZSvwmmXpXVw21i6d4F2Wc66OIR4kn+uu
 rlNXll5bH/f60n6zfVfaZumUZcXECazgKenYLNPn6RUfALFMMqhwF1irMbAPhFhuixFc1OG1pyM
 tR3NjmuSL2SLlk1VPS0CLYnUR5EZMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

The irqdomain implementation internally represents hardware IRQs as
irq_hw_number_t, which is defined as unsigned long int. When providing
an irq_hw_number_t to the generic_handle_domain() functions that expect
and unsigned int hwirq, this can lead to a loss of information. Change
the hwirq parameter to irq_hw_number_t to support the full range of
hwirqs.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
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

