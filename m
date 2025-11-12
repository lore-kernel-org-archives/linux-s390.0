Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEC13396E5;
	Wed, 12 Nov 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962060; cv=none; b=HpTRFjxy1uPNUxHIiudNVrCagwr19InUUP+8/dPbgS7OhHlZ3ZdNsT/6p2U+fQWo9eubQzJlhHBDzEH1+8kKaK0KelQ7uxZxefz6+Axkb20NiKe17T3qki5iirt6ncXD49XwJogBWMcchtHOHEem6tSzmfbvhAVRrqXFXpYlFwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962060; c=relaxed/simple;
	bh=56oIiIxjRjHbcosJpMRlVvkX6VZcRwx2qtum8cebNYA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OkQ2MaVZETBC3rTNF7ZRnnCBE0yfGYGVgVTW4I6+yq5KLf9aQ/kEpyfY0yI9eEQ8I1S1ZUOGfmCWUxSHBvG4ecmzL/Iu8Jo55QWk9oeJhT+vnAcks48kZYcnpXiQNE4z2GYaxSYuPcEaX7DPbpRLzCw2zlg0roi8wyg0upXr1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a3g2VSp/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a3g2VSp/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC6U5PV028706;
	Wed, 12 Nov 2025 15:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=fOUdlZ7Xpv82bnzaOS/n0TqiHqpO
	idPgTMvsGbc/9hc=; b=a3g2VSp/hbV/alUV78pFuSE0cs+m62TxgnhdPwhFvT9O
	28iDj/HmjgiXLALo7GYvlD4SuyZ5X9rFsmhmokDVOKo+psluiNg1+jN8NsGy+ppJ
	x1rRXgGBgW4G3VTkJzetEnYp3eDYbXeuAkZ6epoLliYUuF8X73RbIhPUjuYTnAKL
	iO8owtAOnm5bV1D4ZiPPqS9gvaJQ7/xphONkzdo8a1TjXNpbnCqJmm/Fb8TJs6eI
	FODNUqXn2ZwbCgx1X8/LohxIaZcVtL2kAHfHZM+jlUirw7uBOE6AYUYzTcPVGQ32
	eqrqTzQ4ENd3mwKr/Q6t4JECJ2adyKYE7zpqmyJ4lQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m8970x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACDHUCj014759;
	Wed, 12 Nov 2025 15:40:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpk8xee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACFeiKW43254142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:40:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C842F2004D;
	Wed, 12 Nov 2025 15:40:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9804E20043;
	Wed, 12 Nov 2025 15:40:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 15:40:44 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Subject: [PATCH 0/2] genirq: s390/pci: Migrate MSI interrupts to irqdomain
 API
Date: Wed, 12 Nov 2025 16:40:43 +0100
Message-Id: <20251112-implement-msi-domain-v1-0-103dd123de14@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHuqFGkC/3XNQQ6CMBCF4auQri3plILiynsYF9AOMgltCUWCI
 dzdQlwYo8v/JfPNwgIOhIGdk4UNOFEg72LAIWG6rdwdOZnYTAqZAwjFyfYdWnQjt4G48bYix40
 GrASo/CSQxdN+wIbmnb3eYrcURj889y8TbOsbBPEbnIALLoWReVHrTIK5dOQec0q1TbW3bEMn+
 QnBH0hGqCnEEQuVlSWqb2hd1xfnAXx4BQEAAA==
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
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=6914aa81 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=pqOt2YAaywMWknw-Ev4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Rey2d7S2hmuvynMUMYiWQvHgDSjvocIB
X-Proofpoint-ORIG-GUID: Rey2d7S2hmuvynMUMYiWQvHgDSjvocIB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX9+ztPLvVFU06
 4RNuzMbBpPNI88sblZSHP/GBzos0zwbhGYMS1ZEi+kfnZsgb8In0b45PCmiYWCUFjU3I03ExcPT
 dLvakKaonasMwe6666g+5ohLvL3GB18DVSVqAtT54QBqRR6ei+5UJ2FqL3SUG3augq0pFoR4ubz
 H6GRAP6d3jV6wabE00BF2rjHf9SZrrqkZyKJBAraHi2WI6939+FGnsg+w4OJgSdlPsS3/FEUkA4
 5UJ6ec3QdT915eAlMoV/OlWC+waQ4j3dJ8zpXTY1IzDpToYzJ0XnAmFWMVaGr6gulPCQm/fY4Hx
 ad4+a0JmU59qu3zNl0qkhQ9/i9vSa7T6yQMcCOKN8T/iTjIKZtTBXFZX0zRnpf+iNwbaaoz9xpS
 GlDcnMskUoezlw4xvxz4CEUVigxZCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

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
      correspoding PCI config space.

* Patch 1 fixes an inconsistency in the irqdomain API. Internally, hw
  irqs are represented by an unsigned long int (irq_hw_number_t) while
  the external API in some cases takes an unsigned int as parameter.
  This must be fixed to allow for the hwirq encoding used for s390. 
* Patch 2 implements IRQ domains for s390 PCI

Since patch 1 changes common APIs, some build tests were done for x86_64
and arm64. 

Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
Tobias Schumacher (2):
      genirq: Change hwirq parameter to irq_hw_number_t
      s390/pci: Migrate s390 IRQ logic to IRQ domain API

 arch/s390/Kconfig           |   1 +
 arch/s390/include/asm/pci.h |   1 +
 arch/s390/pci/pci_bus.c     |   1 +
 arch/s390/pci/pci_irq.c     | 323 +++++++++++++++++++++++++++-----------------
 include/linux/irqdesc.h     |   6 +-
 kernel/irq/irqdesc.c        |   6 +-
 6 files changed, 209 insertions(+), 129 deletions(-)
---
base-commit: 882489402b556fa6d916cba86051276fcc9a8953
change-id: 20251104-implement-msi-domain-dc1ea014580e

Best regards,
-- 
Tobias Schumacher <ts@linux.ibm.com>

