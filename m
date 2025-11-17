Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49523EAAE;
	Mon, 17 Nov 2025 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763369996; cv=none; b=OCTOiNM3aTOT6nVYdVJ/gcsTN15ZaZ23qAmEARhOEBdYj64TISUy88DzSVGET36Xi429RPJ6NHz6M9fs0mkk1FEMiy6nICtgPge14GCW/xlYMLY/gu4HQ/GTzqbb+NsD959hJTQ7a+MSAuM2ovFBMHg/QWLp4kuo1Gf6LCGVDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763369996; c=relaxed/simple;
	bh=sepmU1CtFJjCthnvdvlgZA7GGNk9mIssDCYgPebhyuo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qpfrwedDjac8nmbbNdM4YENuDarkLlZvob1R6H+S8ls6mT1nHucl1ghZ6fggKXe91WDZF/NuzbJCOe8WV/ROCxrQQ0tdVa4gNLSxFpQDlbINbU/HjUexei6HJNuKI9NyYXeisJ95NjuwSGPG+vxFTLE6WmnH4W09qYYiFk9CCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R5ZVgURe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R5ZVgURe"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGK5UQF018097;
	Mon, 17 Nov 2025 08:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=hvjxuBviXlL96rQWl7djAKSO8a5R
	TWtoaJSROtb2UXc=; b=R5ZVgURe/sJ0MqqAiXba5MttqcsO/IeoabpklaSTad4O
	+fkQqBaPuSOhVz3q7S51LWtESpLorc8A1iJ6PkcNFOwaV62YtcEXGxlscUtocCEs
	uvlkeBUnzlVRBwoDytfPJALowjWOO6gHTbOUGB06ZenHsacFvIffpZmG6SfqZK61
	QbKGY1XyMs5OzLS3ROv6WKZdzL12waaBf4ge1JVN5N0mtibq1pnbd9oT8Ku5Nwy7
	nLR/1QaN6DtfT86APsTtX5kXiSFTDB7KFoaJVbDMf+pAsW0L/p2X3blgvrvSGDkK
	v7CgTQy4KHu/Naj3Rw0w4h03pRCwTlaEOxrTibiVAQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk9n7mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 08:59:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH76wEg030778;
	Mon, 17 Nov 2025 08:59:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47xn045-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 08:59:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AH8xYUn10027382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 08:59:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAC4B20043;
	Mon, 17 Nov 2025 08:59:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2B0D20040;
	Mon, 17 Nov 2025 08:59:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 08:59:33 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Subject: [PATCH v2 0/2] genirq: s390/pci: Migrate MSI interrupts to
 irqdomain API
Date: Mon, 17 Nov 2025 09:59:15 +0100
Message-Id: <20251117-implement-msi-domain-v2-0-a110ea0721fe@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOPjGmkC/33OSw7CMAwE0KugrAmynbZ8VtwDsSiNAUskRQ1ER
 VXvTlp1gfgtx5LfTKcCN8JBbWadajhKkNqnQPOZqs6lP7EWm7IioBwRMi3uemHH/qZdEG1rV4r
 XtkIuAbN8BazS67Xho7Qju9unfJZwq5vH2BJxuE4gwncwogZNYCkvDpUhtNuL+Hu7kINbVLUbO
 iaA/gAIxlokYxmzN2BYFel1Cf6AKEHHApZcZGa95g+o7/snWRLm/UYBAAA=
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
X-Proofpoint-GUID: hRMSCs5ldDfYahJHHdMKN_LuJpK-yJ5h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX4iSS5qSY90BS
 SSR99aHKeXBYipGJodnEQLWVOPahMGNoWrO4McCFKr5wQOrURwxBdPmrS+eQPRVyWC+L4iUOWHA
 Xyv34qSwwvta1Lln+jCnb612AfxW3ibr5yUqdViPee9hlVne9DAlDeA8BLo3SMbpwPSDWWhOwS+
 PUQEkWEifiwbCsEdtaKCNjsuuwGGyH7leyGxmxJFAsUD1QE7FGvJIFZrcjfHtLG/uTF51kpY1gz
 YRHR0Yj/DOkgj0TcAhTW/5M0du9nS6bcbRaN7NEjExPzjjsFvqrdVZOLoYe/oE59lB4cEu6xqZz
 QT/Etv/6F/fV2LRGvxotHwSgmIC9buVBS37x6d+SHGl91yDQ9Tv+ISr4SYYyt7fTU4wLesiqhDo
 AQZsGTN+3CRpbnAXcpESkFhUnVcQlw==
X-Proofpoint-ORIG-GUID: hRMSCs5ldDfYahJHHdMKN_LuJpK-yJ5h
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=691ae3fb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pqOt2YAaywMWknw-Ev4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
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
  This must be fixed to allow for the hwirq encoding used for s390. 
* Patch 2 implements IRQ domains for s390 PCI

Since patch 1 changes common APIs, some build tests were done for x86_64
and arm64. 

Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
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
 arch/s390/include/asm/pci.h |   1 +
 arch/s390/pci/pci_bus.c     |   1 +
 arch/s390/pci/pci_irq.c     | 335 +++++++++++++++++++++++++++-----------------
 include/linux/irqdesc.h     |   6 +-
 kernel/irq/irqdesc.c        |   6 +-
 6 files changed, 214 insertions(+), 136 deletions(-)
---
base-commit: 882489402b556fa6d916cba86051276fcc9a8953
change-id: 20251104-implement-msi-domain-dc1ea014580e

Best regards,
-- 
Tobias Schumacher <ts@linux.ibm.com>

