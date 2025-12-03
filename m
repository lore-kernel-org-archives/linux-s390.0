Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2322FFDDA;
	Wed,  3 Dec 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764772624; cv=none; b=a8JqTd94LMYHgVwfpLvGpcEmjpZLvdpG114fj/1Is1tLLir5KexDqlkBSlDBrO2SP64nNgtBaypLDAqQqRU6JbOvk1FO4FeM5+LVuEYupbVew9HZnHX1hgBUfVah9E1PkdcQyFOBWTyK0S84HwzsqUidRu6bg3UXLFb4Sa6dyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764772624; c=relaxed/simple;
	bh=h+0JO5F1BsCL6T/czUkyOQMStbUrks45PvRwGKRVQak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A93opzAUmTSiKplFUXHID308ceXq8W4rRVmPBPM7pljfOCUcN/WRB94u8TKTcbolmGsvS7/e4viQePBCmufUl+kDpRFT6YQcBoPtH9oVQrEaXPY7UTKONbTbdYXox6v0NclIKRcKAekm+B+JN1R2HE0LPynz6ySIZrdY0VStJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WSqatb1R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WSqatb1R"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B33hGGk018535;
	Wed, 3 Dec 2025 14:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8fugNI
	aWueeCYJGLShvhSZYH/P22+ioQYQT4sBg2aJs=; b=WSqatb1R6UjJzSNlXawwGo
	URQvD+MHHMFmh9qkyEvSANAKSU5JYb+PDwKUWHhtQCvySleAgOdmEg4Zv8fQhtjc
	2O+7Ygwv6TQdFfH4y99TN/j/FepBf/1z6wVK7rqbdOo6UFKIHx1tZibx5JTnqCAK
	JryqFtlu5MAaJS2U/2Z6HMz+D5r02l69CYElxFcIbCFjYDDvVDPsh2trdrXYCsIC
	WbrCDxqqnl4LFlgeNMqhKL9wWAEHUHEp6oPJ3dSMvPlItpCFFJXfnnAaWPRUNb+m
	0kNr8GZfDOo4yW2OaUXwxG9av8PE6Jueo/i+GzjVOH4xPUuIZQufAjJAMjfXyCIg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8q2xrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 14:36:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3Djoi8010237;
	Wed, 3 Dec 2025 14:36:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnkafxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 14:36:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B3EafFl24904164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Dec 2025 14:36:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7842120040;
	Wed,  3 Dec 2025 14:36:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46C3A2004B;
	Wed,  3 Dec 2025 14:36:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Dec 2025 14:36:41 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Wed, 03 Dec 2025 15:36:29 +0100
Subject: [PATCH v8 1/2] genirq: Change hwirq parameter to irq_hw_number_t
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-implement-msi-domain-v8-1-94836907490b@linux.ibm.com>
References: <20251203-implement-msi-domain-v8-0-94836907490b@linux.ibm.com>
In-Reply-To: <20251203-implement-msi-domain-v8-0-94836907490b@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX5LyXBATSuTUU
 LRlWBQyDDqFU21vUAWpB9lLK01gp+aFHIlTAHLvrd5AUPSZeNHYqsktWBG76acHLl8O/Odk8qNK
 C3WjOHaUlQVEqfRYRyT/ij9SCHDXqSuRpoRvk2fvLSEUPfy2psjibt1+n5Ly1zlXDrQb0Ya1Pbd
 Kr+4b7uSWBuqZMw10r9y+DmT0PeAQmQgrDNyJOq9o2O8oy4Jg4ZLmkCzSGmknUW2n22o9ulG33x
 RrmDDn8bpG8/xdb0WgCnZykZYz3QsLESebmkfnuMiPonkjLr1XvyNnUXLxG2ihS/41HSrEqR4yi
 8rVuE5wQ0+PNMjQkhToIomWdZDeqbKDb18f9o+qQdM+nb4ggWvQvI0iO3DCdFuo4Sm7Mb2tV/xk
 kUNK8YgJsQwR/XAQYbGG6IAulD/bGA==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=69304afe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=apPMBW2BC5_Ovgk0KuUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -v4slcApNUbSLxjliS8xVpXu83Tpo2J6
X-Proofpoint-GUID: -v4slcApNUbSLxjliS8xVpXu83Tpo2J6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

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

