Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F03115A6;
	Thu, 27 Nov 2025 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256069; cv=none; b=s6w8VIpr9rnw0Vv2rc2USwUa9lSlJ+jmk83VEbLXNNl3SOkWJdVaBbGIh+imprHDypSuSSiH8stuEKflCj8AtKFWigFyLYgrfJvbKMbZ5w47QJZgMnWpydbHGIKU2p5dyXjMdQtSt1z69YQJQ8atQY/ku3LkZsf3LuDXTHvpKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256069; c=relaxed/simple;
	bh=h+0JO5F1BsCL6T/czUkyOQMStbUrks45PvRwGKRVQak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuLn8MfIbdm/fc57NDbllvTl4JrREfeSWjyIQ+SR3ldIety4HTAjvBT5GIgOf59qxI+gXb4hSGAE9Iqn+iKsjcXU1kG3EsO5NO6WLu+3zgtRE5QA5YXvsRZs/Y3jgze9lIlli5H+hXQKwsAcTjF01U/Jo04jLe6DgtBNRuyTrMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BJDpwno9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BJDpwno9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARF0Asg007406;
	Thu, 27 Nov 2025 15:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8fugNI
	aWueeCYJGLShvhSZYH/P22+ioQYQT4sBg2aJs=; b=BJDpwno9+JAn357MS8ICCr
	wdQw72uLeUNyYNb6FztxhhxuA3T9HUBoxRLPZfnzcMrpgjk3D2qIh5OeKw3PQdXu
	8rJit4oIaaY/4JBF1xNLasZzA+ivDxitT7vIC+4SZ+imvWfXq08YVG5f6kHBTRKu
	lsYfgYRoFOkujrBtZ486PzvscPrGY4WKCvFtDQ+urTdq9F/VZ+VXHqVahZLvPVDe
	MUc6njg6EHERnl9EPQ0N9IEm+xElmxOh15wmojo/crNqb9N2xJxd//EG2ZdUa2x9
	W4j5BTsx6adx4/9nLd5g9KSnUZ7+wZ6ykOFrmAB3KCxZY/DtZZDPeZ0BoO/BKgRA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kq91cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 15:07:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARBO3b3025127;
	Thu, 27 Nov 2025 15:07:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt71rc0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 15:07:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ARF7eoN16712086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 15:07:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED84A20040;
	Thu, 27 Nov 2025 15:07:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD1F72004B;
	Thu, 27 Nov 2025 15:07:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Nov 2025 15:07:39 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Thu, 27 Nov 2025 16:07:37 +0100
Subject: [PATCH v7 1/2] genirq: Change hwirq parameter to irq_hw_number_t
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-implement-msi-domain-v7-1-86c9a4837e8c@linux.ibm.com>
References: <20251127-implement-msi-domain-v7-0-86c9a4837e8c@linux.ibm.com>
In-Reply-To: <20251127-implement-msi-domain-v7-0-86c9a4837e8c@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwMCBTYWx0ZWRfX+fQIaXVC/SNi
 at3f0nOJwQn1vcjf4CrGXvjPcYyAC82H1ovhbDl3rsF67xhkhz/bOtzeCIW6RiyTR/YdOUrqwJa
 45/gdo0PVrvWi6p1d9WDdBozWs+EwsczM7jetND7RwJgWrj+nS6m+76473ITL2sC1wVOO9kSthJ
 YykVOsoKsIwaOQiA3UiisbOMzFqe+bz6TKa/NZRB6qYuRhzsF/ESBGMZoE34P89xDOTFN1kmsFQ
 GVb6Rk61+hH1IsLtJN/EBYEtZw5k+ieeVKQHooqmzoDni/+rAW8I/0p2Ii3wte7q5k8aN5MkJD0
 dRRSjyclsPA5y62MjyPArtAIEcswZaivzvTfTZ++rMLRGiTpuz7qd+QXO6bNstZY7OgNWa0/ySz
 rCdtc3U+VdZR46Nd/BrRBgdJV5H95g==
X-Authority-Analysis: v=2.4 cv=fJM0HJae c=1 sm=1 tr=0 ts=69286940 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=apPMBW2BC5_Ovgk0KuUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: roILs9m1TKNI_4xC3SzX318WrQ30zrQF
X-Proofpoint-ORIG-GUID: roILs9m1TKNI_4xC3SzX318WrQ30zrQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220000

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

