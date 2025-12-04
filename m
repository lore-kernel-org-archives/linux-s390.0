Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18EC2FC038;
	Thu,  4 Dec 2025 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764824721; cv=none; b=D/RYUR5yconXm8+j9Vb2n7lEDJIAIyTm50Q0iFqvHOUrLBhOBprRmc4yn+OGo/9RqzIE3O52gbXiWz/qbfiLrBpqD1X7x4nJ6hm8A/syDJhRlOCH1Z4nbVQ8hzby0NntFBS2l5MfzB7W1SflgcJqua5RpyIIvDoFYRl65eTPBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764824721; c=relaxed/simple;
	bh=shvolcFcBsCi4mztCyHGjDekPVeaCTrMjjOV7OYceBQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=URKPXjaTDZtsOBkuXbSYbs3R1rbv+Jzriz8gS6e7rpnpONzK1ECcedG+rp9ThD9utOQOzRzuT0uGjf+RaMctHx0Sf6HZdT9t55Fs6Gd6KIGdWgfUpiAw1f/MtCl+fMXXw9a2qLAJoRcaMeEQZqy5+D9AOLQLg+5HMCQw++JdtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WAp2lgry; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WAp2lgry"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B44RHgK008240;
	Thu, 4 Dec 2025 05:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=wERhrsgd/ksX8wfIU4UP65oiN0My
	Vlc/8iR+0PPFowo=; b=WAp2lgryFkQPeQp6m2nZJPezM/lqJqtd9P17z/PGdTbC
	IKWYHze2VDDwz20zxhhnUcpuLwBdCClGVvESXr9NyGzNrfUkJzxcJnnPmT9GqdwC
	yjmY2xyPxbEC8N52FELukAXTdvtrDKb9HUbtkaWY1j26DeOg8LAwf4965Gj8WFEI
	iIg9pU3QwlieidFOCqLVbyx1G/oQuDssE1tfOHLP8MlzgosvQziMCT0QF9HEJDni
	GAExNcs8xI6PCcJm/UhfbHt69UTMbs8zknjMU0D9jT1lnt3swAzgiixWaxtNPu7y
	k9CSWn86B/Urz+wxo8Ja7sY0hyQdEA6gLAVo3KXZvg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbgenk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 05:05:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B40cP7F029323;
	Thu, 4 Dec 2025 05:05:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1nqbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 05:05:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B455Cua33423664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 05:05:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E23AB20049;
	Thu,  4 Dec 2025 05:05:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B52F220040;
	Thu,  4 Dec 2025 05:05:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 05:05:11 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Subject: [PATCH v9 0/2] genirq: s390/pci: Migrate MSI interrupts to
 irqdomain API
Date: Thu, 04 Dec 2025 06:05:00 +0100
Message-Id: <20251204-implement-msi-domain-v9-0-d2152235701b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHwWMWkC/43QTWrDMBAF4KsEr6ugkcb66ar3KF3I0qgR1HawU
 5MScvfKIVATpNDlDOibp3dpZpoSzc3r7tJMtKQ5jUMe7Muu8Qc3fBJLIc+N4KIF4MhSf/yinoY
 T6+fEwti7NLDggRwHbA2nJj89ThTT+ca+f+T5kObTOP3criywbu8g8DK4AONM8CBa1XkpILx9p
 eH7vE9dv/djv964A+IJAFyGAEIGAnwA1lSL2CaBCiQyFBXXpFBaS1hNop8ALv80N6QFRColkds
 kpgLJDKlIJlInnJWxBOEGErVycU3EoaPWELTGlaB2C9W6aTMUNGnQIQYZdQlS/4FUhhAxolOor
 ZclSG+hWtk6Q0Z569BITcaXIPMHCS4rkMmQzYiyXKPl3SN0vV5/AWq+WSw9AwAA
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
        Tobias Schumacher <ts@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m1SZDOwE60JeyYc1wJ2L1hK-mTbd5-jo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX9YxNh8tRK4xD
 XohP9Cv3c+9KtuUf9X8pxVWkEW/8DRhtkpcqlV5Fare+RSDvzhr+zKzEHIrE1FZUqs6YbUQzIN/
 T5ik6MoHiiztJ2p+NKWsR1IIeBKTLM1T7FdOqf5WiZcvv0Li1nWhh3gKk67YsSnuKXobTF8AHCr
 JjnnYtP6VE+N7U/Q5tfkvku9qq8e/+tVxuWg58Q6x6AT5JnWSb5tSc8fGPdONn6H8/qcXX2xLUv
 CwfsC4VfME1c/wh+RT33ME6EMSCHH4yuT7G4pqy3SCBfkiiMGT9f4VYWCpV0oJHGpfPTAFkxynJ
 BYUVRTzKezE88pKVVIO82uXg6bCLFAwNzAZk18p7v8qmnQYz9mGwi3GUAtRreRBDOs41quMMjJo
 MckFtH/v/7sAE3SVZ0AGLesf7dwX7g==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=6931168c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=_im-F_UWinld5LRGUTsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: m1SZDOwE60JeyYc1wJ2L1hK-mTbd5-jo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_01,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

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
Changes in v9:
- abstract airq cleanup into separate function to improve readability
- Link to v8: https://lore.kernel.org/r/20251203-implement-msi-domain-v8-0-94836907490b@linux.ibm.com

Changes in v8:
- Change parameter of zpci_decode_hwirq_msi_index to irq_hw_number_t 
- clear airq data and ptr field in zpci_msi_domain_free()
- Collect R-b from Niklas and Farhan since there are only minor changes
- Link to v7: https://lore.kernel.org/r/20251127-implement-msi-domain-v7-0-86c9a4837e8c@linux.ibm.com

Changes in v7:
- call zpci_set_irq() in zpci_reenable_device() to fix recovery after
  zpcictl --reset-fw
- add commas at end of initializers
- remove unused variables in free()
- removed R-b for patch 2 because of bug fixes
- Link to v6: https://lore.kernel.org/r/20251121-implement-msi-domain-v6-0-444f4a6479c3@linux.ibm.com

Changes in v6:
- removed obsolete function zpci_decode_hwirq_msi_index()
- removed some code duplication
- fixed some coding style issues
- corrected hwirq encoding in commit message
- Link to v5: https://lore.kernel.org/r/20251121-implement-msi-domain-v5-0-d7e717dfd3f7@linux.ibm.com

Changes in v5:
- removed two lines of superfluous code
- Link to v4: https://lore.kernel.org/r/20251120-implement-msi-domain-v4-0-a01be58e158a@linux.ibm.com

Changes in v4:
- remove flag MSI_FLAG_PCI_MSI_MASK_PARENT and mask/unmask callbacks
- use goto statements in zpci_bus_create_pci_bus()
- Link to v3: https://lore.kernel.org/r/20251118-implement-msi-domain-v3-0-6fe8feb2a93f@linux.ibm.com

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
 arch/s390/include/asm/pci.h |   5 +
 arch/s390/pci/pci.c         |   6 +
 arch/s390/pci/pci_bus.c     |  18 ++-
 arch/s390/pci/pci_irq.c     | 332 +++++++++++++++++++++++++++++---------------
 include/linux/irqdesc.h     |   6 +-
 kernel/irq/irqdesc.c        |   6 +-
 7 files changed, 253 insertions(+), 121 deletions(-)
---
base-commit: 82ef9f0fac73cca3e7d776b095b5a7de1b0b88fc
change-id: 20251104-implement-msi-domain-dc1ea014580e

Best regards,
-- 
Tobias Schumacher <ts@linux.ibm.com>

