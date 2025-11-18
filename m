Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F436999C;
	Tue, 18 Nov 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482409; cv=none; b=oW2pAKdmOZ4pES/ij150Hx4PnYc0N/ryPk0NEycP7ZN4Tnpd0YguT+If7X4h8l74AmvdEWbZV5BxUlLjXFeSAEiBaI2mZ4D8cnuxQ/Y/QnsShd+EyaByfOYv8sc+VFIMRF3MUFP9l/Eg1OiQrK0vs9f9g3fndmsnv3NSNrQOlEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482409; c=relaxed/simple;
	bh=uieYHnqxXybBaESwbmbSpHvSnpneD5kp3x9q69jgZz8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vc5QoTQnGQTJF7xhz7JcDHEaAOo4wX42tmcptxGRwna9nLPnTwwxYckHcFGJevCb3VcJcFf8f7Bh7elsvW4SJQtrmsM3d34CVqm+n16nVsXkF4KeL9YGjP4vbmfl4UFaXIxdablSCvZJ8BqBGcTqtgwJF2YiL7dxXzxTNy+h+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aHtPAcyJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aHtPAcyJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI3ldc9030553;
	Tue, 18 Nov 2025 16:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=3H19K/DNwCMX6BFaKkZ4d+xQElm7
	Q4GATlRLnK1S5MM=; b=aHtPAcyJpGE9q1NBHKt7DU2gk7XtMNnDAxYjmHA5UkfS
	EHCNL0kBdjcAaq7JVWFBPP7C5W5bwgEycn3GyVkiJHRp3+zqN8/T6ICUEMDU3NqF
	fA/MiwTmFCrBMi4GYmF1NNcnU2G2b5nNLgrftoiY2ov4BmS8CR/jNlFewNtkYxp/
	AnJC4Oz3uvT+3TGKNYGtvbCMWE1DkfIn2AofWCcPrSox+1ADdY43bzrnWtXbjz2g
	Y/6IY/qD/3LKTzoBLAMWIXGqDzANseTBpFXznCfpJxhtKFwIf7Z0J+QJCpzJAbXD
	cueyuQJqc/Ucie8rllrJtP/hVAdxRk/5+30PRQdyWQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjtue77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 16:13:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIF4KjI030851;
	Tue, 18 Nov 2025 16:13:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47xv38d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 16:13:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AIGD8IT26542700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 16:13:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E5342004B;
	Tue, 18 Nov 2025 16:13:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D27C820043;
	Tue, 18 Nov 2025 16:13:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Nov 2025 16:13:07 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Subject: [PATCH v3 0/2] genirq: s390/pci: Migrate MSI interrupts to
 irqdomain API
Date: Tue, 18 Nov 2025 17:13:04 +0100
Message-Id: <20251118-implement-msi-domain-v3-0-6fe8feb2a93f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABGbHGkC/33QwQrCMAwG4FeRnu1I0m5TT76HeJhrpgHbjVWHM
 vbuduJBRD3+hXz501FF7oWj2ixG1fMgUdqQglkuVH2qwpG1uJQVAeWIYLX47syew0X7KNq1vpK
 gXY1cAdp8BazSaNdzI7cnu9unfJJ4afv7c8uA8+sLRPgODqhBEzjKi0NtCN32LOF6y+Tgs7r18
 44XQH8ABOMcknGM9gOYWw303gR/QJSgpoCSC2vWa7Y/m5R/gCpdmn6oJGz4s8k0TQ8tFD5rhwE
 AAA==
X-Change-ID: 20251104-implement-msi-domain-dc1ea014580e
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
X-Proofpoint-GUID: v-5GPBcHJsW8AOcTf7FU_lc0EUxXSCoo
X-Proofpoint-ORIG-GUID: v-5GPBcHJsW8AOcTf7FU_lc0EUxXSCoo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXz7FmdKRsMyNb
 04cOyNgjr76qIDKKonIyXlF5qE7vK10loY6+KpshIhSGdvkGeLhqMZTlFhwl0sULED7PP126QAK
 X4lq+NRiPciy9Q/Ax79crBOE3t0s4nWW3g6i5ZwcpKzAk2zonyA/nGZvhTh2eXpYOuIXHerSQcX
 5qq/voIoEh4x9Sa0Y4sKl+zHbutHHzCvEodHNtjnEgFztFlIX63bjXXnOAgZJUgknmqelLhupbi
 OMZHjOEXSn6rx5KCXLwowyV4dOYtDkxA1C+yb8QedfNUB01xNzfjqRxSNZEqNSCEXf1+r5a605E
 hTdIri2XapolIyQ/saEjgYtrOCR5LTrJZ3F/3y9FP05tnSgQG1mtzr+AMFGDCJt5UD8Q23awLUQ
 +LOFcZqUU0oK2jVwbIge0auhhTP+mQ==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=691c9b18 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pqOt2YAaywMWknw-Ev4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032

This patch series reworks the PCIe interrupt handling on s390 by
migrating it to use a proper MSI parent domain. Introducing a dedicated
MSI domain hierarchy aligns s390 PCIe support with the generic Linux IRQ
domain model. Currently s390 is one of the last architectures still using
the legacy API.

The migration splits the existing code in the legacy functions
arch_setup_msi_irqs() and arch_teardown_msi_irqs() into different
callbacks of the newly created MSI parent domain:

- zpci_msi_prepare(): prepare the allocation of per-device MSI IRQs.
      will be called once for each device before allocating individual
      IRQs and sets up for example the adapter aisb and aibv.
- zpci_msi_teardown(): reverts the effects of zpci_msi_prepare() and is
      called after all MSI IRQs are freed.
- zpci_msi_domain_alloc(): the allocation function for interrupts
- zpci_msi_domain_free(): revert the effects of zpci_msi_domain_alloc()
- zpci_compose_msi_msg(): create the MSI message to be written into the
      corresponding PCI config space.

* Patch 1 fixes an inconsistency in the irqdomain API. Internally, hw
  irqs are represented by an unsigned long int (irq_hw_number_t) while
  the external API in some cases takes an unsigned int as parameter.
  This fix was required in V2 of the patchset. Due to conceptual changes
  in patch 2 it is not required anymore for s390, but still seems
  sensible.
* Patch 2 implements IRQ domains for s390 PCI

Since patch 1 changes common APIs, some build tests were done for x86_64
and arm64. 

Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
Changes in v3:
- implement one MSI parent domain per PCI domain to further align the
  implementation with other architectures.
- Link to v2: https://lore.kernel.org/r/20251117-implement-msi-domain-v2-0-a110ea0721fe@linux.ibm.com

Changes in v2:
- fix directed interrupt setup and handling
- add flag MSI_FLAG_NO_AFFINITY in case of floating interrupts
- style adjustments according to review comments
- Link to v1: https://lore.kernel.org/r/20251112-implement-msi-domain-v1-0-103dd123de14@linux.ibm.com

---
Tobias Schumacher (2):
      genirq: Change hwirq parameter to irq_hw_number_t
      s390/pci: Migrate s390 IRQ logic to IRQ domain API

 arch/s390/Kconfig           |   1 +
 arch/s390/include/asm/pci.h |   4 +
 arch/s390/pci/pci_bus.c     |  11 ++
 arch/s390/pci/pci_irq.c     | 334 +++++++++++++++++++++++++++-----------------
 include/linux/irqdesc.h     |   6 +-
 kernel/irq/irqdesc.c        |   6 +-
 6 files changed, 231 insertions(+), 131 deletions(-)
---
base-commit: 882489402b556fa6d916cba86051276fcc9a8953
change-id: 20251104-implement-msi-domain-dc1ea014580e

Best regards,
-- 
Tobias Schumacher <ts@linux.ibm.com>

