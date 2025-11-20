Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FB2EFD8A;
	Thu, 20 Nov 2025 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634470; cv=none; b=t9HL7TQP8hHB3L1KcIQHw5bzWrEBYK7vguM6AUEE9tyuhaA55Ge+KZf25s2mSl0Bi8Uyzo4jNt4S28m6j56oyNWc1jxO1byI8Swyrk87BdVT3ihprjjlIFyQ/U+gIxkOspbLIDzZzjS7YHzF1SHCeCwhMeypMMRtO5KHFcr4rXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634470; c=relaxed/simple;
	bh=2JQ88f1XWggOE0vV4n0wRiAmSdPDWYyuzLlF4tXv5k8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Objg0GJjhzcjggUk39Kf1WEsnDKIPd9YhCWHsuxWdPB0Squs39isTEmBBFw5/PJmYx89itaDs62wbptfA0BNQRHUWu0WyNIUe7sf8XprncgjpY+asgaytGTbl72DyLOqFChznDJAd4d1aZZLLMlGYuBjTt9pajSD1c1AW5156dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LQ8yWRnI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LQ8yWRnI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJLksgF029060;
	Thu, 20 Nov 2025 10:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=3bwwCQqB81wzDSGyl0qp7uLbaabZ
	7Y9M4ENmnWRk7cI=; b=LQ8yWRnIwL+LDzsYpN2Evf+aX+n+QeB1Um50jur5BK1s
	BYC713vBBQR8D6RDmgT98bEQv/H6zbo01ioAz4vzLOoRIv3lm9TVCuLCRRB198hp
	rabvO3Gl6zVRU9La4WHBsjDCUpPAqn0N+h+MOyteC0dBGiYX5CohfSp8hR1wsCrZ
	wkBbK6eifUYtEKHMOOmCh45Sf2mKHYMpbKvbJ5N5Kk7XM31iTLg71rRrGTWbfrAa
	dZIWBtyA1Po2B55EfwsZf01rVDVBvSYH23K5uD/6lukWBQaPtMfTl9M81TnGYs1i
	ahg5NUgGywg6jFj7fTqcMPCEcvnHt7n0H1cDj6vbnw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1nuwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 10:27:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKA4TB2005137;
	Thu, 20 Nov 2025 10:27:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bkdugk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 10:27:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AKARRRV43712868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 10:27:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E16D20063;
	Thu, 20 Nov 2025 10:27:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D96E32005A;
	Thu, 20 Nov 2025 10:27:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Nov 2025 10:27:26 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Subject: [PATCH v4 0/2] genirq: s390/pci: Migrate MSI interrupts to
 irqdomain API
Date: Thu, 20 Nov 2025 11:27:25 +0100
Message-Id: <20251120-implement-msi-domain-v4-0-a01be58e158a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3tHmkC/33QTY7CMAwF4KugrCcodtI/VtwDsUgbZ7BE0qqBi
 hHq3SdFLBCiLF8kf37OXSQamZLYbe5ipIkT9zEH87MR3cnGX5LschaosABQRnIYzhQoXmRILF0
 fLEfpOiCrwBS1IpFHh5E83x7s4ZjzidOlH/8eWyZYXp8gqM/gBFJJVA6Lsu00gtufOV5vW27Dt
 uvDsuMJ4BcAlHYOUDsC8wYsrSZ8bQIrEGbIl6qi0uimIbPapPoC2Hxp/qEKwdOnJvq1Sb0C6Qy
 VnmpPLdpG+3donud/jFLyhNABAAA=
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
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691eed14 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pqOt2YAaywMWknw-Ev4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: doL6ybKgcnJa2wPWV-VoRF5gr8Cd2qz0
X-Proofpoint-ORIG-GUID: doL6ybKgcnJa2wPWV-VoRF5gr8Cd2qz0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX+u+o1hzIfYLw
 DclslpthWSVhzMWT1CtOTkQBqurq0fkI+PAJaOlMjhWx58+9/hLRbrNmM5Ffv3XMD5S+agRZ5JT
 NdR4D3XtH8CGvy8Th9cU8or8yBrPE2Z9TYnHa6E47jwbESywHpcR52T+5AoYuP9Jln4di5+eJmj
 MiV3iPWStUUBORVYoiCsAJl5mlIMldSscLrm6rw4pDfm8T2my0kWJJGRBwO8zt4vsYI30TnqUid
 ibz2rTQHnz3Y3bOhrex9Qv455uf1Peaq6UwFbLchU6knWsLsAI8EqYLrhqc4AGXOUPivM3i54Hz
 xLft+V0OKD4T7m67nOmRAowc4OVY4i819B5N14/JKzjD7xVyxmTw8DvwdGFLupn++uvdaikrcLA
 q/DZWUzaS9CdOxdhkIL+SYfc3GrsrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

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
 arch/s390/include/asm/pci.h |   4 +
 arch/s390/pci/pci_bus.c     |  21 ++-
 arch/s390/pci/pci_irq.c     | 335 +++++++++++++++++++++++++++-----------------
 include/linux/irqdesc.h     |   6 +-
 kernel/irq/irqdesc.c        |   6 +-
 6 files changed, 235 insertions(+), 138 deletions(-)
---
base-commit: 882489402b556fa6d916cba86051276fcc9a8953
change-id: 20251104-implement-msi-domain-dc1ea014580e

Best regards,
-- 
Tobias Schumacher <ts@linux.ibm.com>

