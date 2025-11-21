Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3860241A8F;
	Fri, 21 Nov 2025 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703151; cv=none; b=YThc6UHZ9azl/EYJ/GefwpWSjY3TvOF5wRmsAM4KoUJygycGNP/IphQN+KJJYRFtNM9IIcyEq1Chq2UHFwrd0771QltxB4uyTTBeB6c+wyhjSnGWvsPMiN4IYkBzK9dnDnCzgsU4qXukTUr73TgnCDx8tk5EMLumypJTu43tlqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703151; c=relaxed/simple;
	bh=jagZeuStltn/B83PriVmJSjUBMr0LWK7fD5Qd0fMJmk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gaxdXENMQBBRGgSTTbdIjK/ptv76KHHh70cnsGovlTdzVrpky9GTkFJ4YrKV1n24v9T1XWFyDfcxRcKwUiE5sOy326hFHM4tAl44n49AeqUQW5HJlwcEMeqiOxPw15Z///PHjwqi/U3dBoO8Tv7yKAph9T4tXdFAQpRtTW8tQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UyLNKeum; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UyLNKeum"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKKxMOG027988;
	Fri, 21 Nov 2025 05:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=RWeHmKtWht04ne5zWa1jcJyIV4yQ
	Pu5yWJKnAKjlfFs=; b=UyLNKeumvPur9UpzrG2TRS+wiTySVENxaU+gLZa48IzS
	xG6eBOmFWroaMup/Ji2o8q+flCln2BRkl5gOjaiV0W2ew0Np6A960PEkK8l39f7p
	4ZTIYKx/S4MwUrBbh0Ci6bjs8abEjNkcfX17vJVNkMjZpwRPbyP/pf/xGJhbVJwr
	PNVpxuArrTliPC6Y/Kgk9gjM4byqBj3fYlHYTG4HgrVU+qcs/N3duVQ+F2rcEfLE
	MlPoyVTs/lvm8itvvpKLshFRUOC3IYVeS8RMFdcKx+EtP4ShJViqFiANHk8eTLdw
	AlIZCKyxWfVgJwazDt2lB7K2BYKvdOA0/JzkXcPJvw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejkaa3md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 05:32:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AL3eHCs030795;
	Fri, 21 Nov 2025 05:32:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47yan41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 05:32:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AL5WLVT24248790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 05:32:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE27320043;
	Fri, 21 Nov 2025 05:32:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AAE220040;
	Fri, 21 Nov 2025 05:32:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 05:32:21 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Subject: [PATCH v5 0/2] genirq: s390/pci: Migrate MSI interrupts to
 irqdomain API
Date: Fri, 21 Nov 2025 06:32:17 +0100
Message-Id: <20251121-implement-msi-domain-v5-0-d7e717dfd3f7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGH5H2kC/33QTY7CMAwF4KugrCcodpL+sJp7IBZp4wyWSIsap
 mKEevdJEYsKtSyfpXx+8UMkGpiSOOweYqCRE/ddDvZrJ9qz635Iss9ZoEILoIzkeL1QpO4mY2L
 p++i4k74FcgqMrRSJ/PQ6UOD7kz2ecj5zuvXD33PLCPP0BYJaB0eQSqLyaIum1Qj++8Ld733PT
 dy3fZx3vAD8AIDS3gNqT2DegLnViMsmsAFhhkKhSiqMrmsym03KD4DLP80XKhECrTXRyybVBqQ
 zVASqAjXoah3WILOAcOu4Zm6koCFbEdjKvUPTNP0DFRYn6BkCAAA=
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
X-Proofpoint-GUID: kxtGab2FX4zF4VtC_Xt_Mk930gFz5kQw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX1pkNNbwNgQG8
 GkEYgHDCV5sMrwB9QkuCnRKyziawVb82YLkqxchOTQUmrXlTDQmNHFpYdxDjbchn9AkIxi7Z91V
 v2U/L24shGY63JpO43/c6okKaDsS0IgV2z65FkjGBsFXZZp08ko7GEtBYe+OlJuaOsjdUVf9kwe
 sGsn5bpGXYaSdn5p8n8pc3h5BbK0rgKuAgvJPdY81YMNE3vtUupu+TQlhXDwO7LskscH7BTsHIB
 98NyNEj9I/faXYFtEjg0oZmoV11zH9CFeSGHXQ1G8KNbFpgw7Dl4V2bv5qLX9TEDLiV1RPOd84A
 s4Zsdzouz4x2zIovK443krxOgQ/MsTUFtp/CtAZsTIQjouoBr9FUnVJ5ETLJfw3cLTGGivRHKJ9
 03eVrbzEr4kmjDWae5DIbCsJyGDzlg==
X-Proofpoint-ORIG-GUID: kxtGab2FX4zF4VtC_Xt_Mk930gFz5kQw
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=691ff96b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=qu2NodEISbj6-X0eVIsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_02,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
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
 arch/s390/include/asm/pci.h |   4 +
 arch/s390/pci/pci_bus.c     |  21 ++-
 arch/s390/pci/pci_irq.c     | 333 +++++++++++++++++++++++++++-----------------
 include/linux/irqdesc.h     |   6 +-
 kernel/irq/irqdesc.c        |   6 +-
 6 files changed, 233 insertions(+), 138 deletions(-)
---
base-commit: 82ef9f0fac73cca3e7d776b095b5a7de1b0b88fc
change-id: 20251104-implement-msi-domain-dc1ea014580e

Best regards,
-- 
Tobias Schumacher <ts@linux.ibm.com>

