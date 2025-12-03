Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481732FE579;
	Wed,  3 Dec 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764772612; cv=none; b=XANkiq77CxQJekRPU+MZfswfLI+DBuEwkjEBogwQLDJw+PCDd+G4HG+yFj5YGma1IiFmSoweMEz9Bwwhe3UFl+D+dZHnG1A86X+ucNS6L2pV+H+tSa9vLSbd1psIe1OwTfJyUalY5xOCzVlIxsBVvnsUzUP6e6IAW1NyTBKXINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764772612; c=relaxed/simple;
	bh=SHKSocU0ijEmxd+M4Py2uhmsfk3crxxA2a5c7nXyhQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mqE8VMmMdOI1rIuGx9yHQ81Dn5/sTNiY/Y7XdcNW1FXjek+XldCwvTZY/FYhEAJvO4j37NMTOFajzpdoaajTTIkU5P1GdCTqrCJK0JYcvaR1WviVlNKO+4tCXdmvM20MtW6Brq+ix3gwBCY7wEyIPsUNrdig+ooRNOtaa+cdBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VZYlPqYk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VZYlPqYk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3BvSEX021298;
	Wed, 3 Dec 2025 14:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=C9Ty+a4TtYm6rkb0uFetykP9538B
	zgpT9sbx5UGIQXg=; b=VZYlPqYk8oeeob4orazHfDDRf/OtrFg9ydP4w5CEINzr
	25KpCyX7lwBvzC/NQ0VKHX6+iqpvIZ9OAb/qplT3bQEE1e1JvLnoZO2QOt3xMXkM
	afWbg5NIw5l+Dgn3UReOe44Hd9OrPPMWMpnQ35P0tj99oUcEKl8XO4WB7lWsf3y8
	zyMuyvotYGYiIj5NRTxC1Uwi7VYR1F+TcLNBXtXG+4i9JvvzKd5KgwoZ1aogMwHI
	/Ax9eHSZ0a3oMNTBpSLtzcgoyM25+psxgxC2WxXNhyqTmOW9YrhvUABhnY1nEcfa
	93TIGCQv2xFcT9oMlOWwIwh6sOpFNc/dePt2QIn3Uw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh737s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 14:36:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3Cd0B1019133;
	Wed, 3 Dec 2025 14:36:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhy2kx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 14:36:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B3EafRi31064512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Dec 2025 14:36:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4248920043;
	Wed,  3 Dec 2025 14:36:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FD3420040;
	Wed,  3 Dec 2025 14:36:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Dec 2025 14:36:41 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Subject: [PATCH v8 0/2] genirq: s390/pci: Migrate MSI interrupts to
 irqdomain API
Date: Wed, 03 Dec 2025 15:36:28 +0100
Message-Id: <20251203-implement-msi-domain-v8-0-94836907490b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOxKMGkC/43QTWrDMBAF4KsEr6ugkUY/7qr3KF3I0qgRRHawU
 5MScvfKIQsTrNDlDOibp3dtJhoTTc377tqMNKcpDX0Z7Nuu8QfXfxNLocyN4EIBcGQpn46UqT+
 zPCUWhuxSz4IHchxQWU5NeXoaKabLnf38KvMhTedh/L1fmWHZPkDg2+AMjDPBg1C681JA+Dim/
 ueyT13e+yEvNx6AeAEAlyGAkIEAn4Al1SzWSaACiQJFzQ1plG1LWE1iXgCu/LQ0ZARE2koi10l
 sBZIF0pFspE64VsYtCFeQqJWLSyIOHSlLoKzbgtQaqnWjChQMGTAhBhnNFqT/A+kCIWJEp9G0X
 m5BZg3VyjYFstq3Dq00ZP0zdLvd/gBfZ9cJ9AIAAA==
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
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=69304afe cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=2TmbXSxUbq1jSBLvIGMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fJ_EjJq6niznN9J0aFw-uu-fwhUnCbeW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX0nVtylX6HLff
 DnqPMOJKzg6p2LBrJBdULzURZoRo8SKIL1C1+cKBth7/gic73nG0hBv52hHEuFBHVxnnDH1zaV2
 NPuRmVvBk2ae+ozqw1wd4qNeQ0ZKxsGK0zcPcFJp6hSsH1iemxI6C3JXHPZYaxWpdHExURgftHJ
 ilhvo3VE1+jX/3XnNOwkLuQga0LSjx/gHR18H9Ewib3PVALRfp2TPF2sHzvoPBU0fR4ZjXGISjA
 WK7BhlJWfIMCfqdm+3oCV6mflriZkXAxHcZVxhdkaLPDllvo6km0ty7WsvaBXRim58MlpxrOOjt
 pIFszQP7GFSveuRXfHkgZ46/aDMjWgeK0KHrvglOg7hBJ2NmhWFK9K3jsCOPrq4bVmDgIgYOB/t
 1My+C01R1Mzeu5ocaXih0qOrhGjeFQ==
X-Proofpoint-ORIG-GUID: fJ_EjJq6niznN9J0aFw-uu-fwhUnCbeW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

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
 arch/s390/pci/pci_irq.c     | 329 +++++++++++++++++++++++++++++---------------
 include/linux/irqdesc.h     |   6 +-
 kernel/irq/irqdesc.c        |   6 +-
 7 files changed, 250 insertions(+), 121 deletions(-)
---
base-commit: 82ef9f0fac73cca3e7d776b095b5a7de1b0b88fc
change-id: 20251104-implement-msi-domain-dc1ea014580e

Best regards,
-- 
Tobias Schumacher <ts@linux.ibm.com>

