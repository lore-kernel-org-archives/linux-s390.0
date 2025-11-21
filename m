Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D233971F;
	Fri, 21 Nov 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763739962; cv=none; b=pS4JlOQ2sBrqMjPDHJ7xTiFuvLn9bqr8ZVqZraoA0jNIKnYA2jKH72zKllLQgTPdWbZo+NdN2kBiacd18bZ06WhHic9hssUxTFAOVQO1jEEvWduCLjF0XFLQ1KJsmHxCtydJGleANbiW8Q38Q4HF8H11w/TADYVr4CALlMb/eIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763739962; c=relaxed/simple;
	bh=INWItcoGkpumNU5f7ZVuopebJyJ0F/+7sWfQ9RHppnA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j8vq9G0EkxgAXXxS6xMtnXPlPa33DYeye9qxgDRxtgSZz28/bRS/52TcihQh3xEoEGGKyGoeAPXc4kJ251efmZSdwKiYLvCt4jCKXVPYrr5o9JOqQlB3GDbad0T+avO2WzJv4l2JbmFONGCUVvnOHOfN8ScEw8CPEgDOwlsEQFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JJZRH+vQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JJZRH+vQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEHRLt012624;
	Fri, 21 Nov 2025 15:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=4r5KJugvycJxHPEA0z4DHHIorJSt
	IeMnKmnDm/Dy4ic=; b=JJZRH+vQKHR8NgC/kge0BNzIMzTq/6Nj66MmCKvYo1VA
	3sXgWW5RjxHqLAtS95Nzj3h8wYJxJE7fEmovNkzCVL8juPna46hxL0tzZyl5FbPV
	UBOLQShbWFPtOYle73YXZFQ+tDP+PXosQpcYIRrgaS7rpt9W5YnjX4+zS/so6SEX
	pUROWQjbzTwQlpPIJJaNRFF/rVbleBLhYbXU9PVHeqiuhlnTGX5oehQJczrPiaaA
	B6LnvCMpj+bTQeWM6uPqc9/5kiCIQgggIdcznXX1kxqf8ydJCVdJGeb25qNY6vZx
	wzfzW8vIY5xzsiJX7SwRAxu6NJNEPzkbv0ImcPLjrA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejgxb8a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 15:45:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALFR4BF005244;
	Fri, 21 Nov 2025 15:45:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bkn069-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 15:45:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALFjmWK11010534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 15:45:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5614720040;
	Fri, 21 Nov 2025 15:45:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21A082004B;
	Fri, 21 Nov 2025 15:45:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Nov 2025 15:45:48 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Subject: [PATCH v6 0/2] genirq: s390/pci: Migrate MSI interrupts to
 irqdomain API
Date: Fri, 21 Nov 2025 16:45:41 +0100
Message-Id: <20251121-implement-msi-domain-v6-0-444f4a6479c3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACWJIGkC/33QwY6CMBAG4FcxPW9NZ9pS8LTvYTwUZro2sWDAJ
 W4M777FeCAGPM4k/ebv/xAD95EHcdg9RM9jHGLX5qH42onm7NsflpHyLFChBVBGxnS9cOL2JtM
 QJXXJx1ZSA+wVGFsqFvnptecQ70/2eMrzOQ63rv97Xhlh3r5AUOvgCFJJVIS2qBuNQN+X2P7e9
 7FO+6ZL840XgB8AUJoIUBODeQPmVCMuk8AGhBkKhXJcGF1VbDaTuA+Azz/NDTmEwGtJ9DJJuQH
 pDBWBy8A1+kqHNcgsINwq18yJFNRsSwZb+jXILqGtbmyGyLEDR4F0cO/QNE3/pIbCzWICAAA=
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
X-Proofpoint-GUID: sTAmIYlXCvCByVo9ZSafQfwpPFJrLIzZ
X-Authority-Analysis: v=2.4 cv=YqwChoYX c=1 sm=1 tr=0 ts=69208931 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=qu2NodEISbj6-X0eVIsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sTAmIYlXCvCByVo9ZSafQfwpPFJrLIzZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX4SOXnGqzSfla
 9PY8qBrpIQTNFeRjZZf1TVAMGYXCAogdBq46xgaYWo+v3+NLZVMkqwYNBf2iFlxMm8/AxW1fPWS
 f0Os9oPoCgWz7YR/8vaqguKhbyVFDcUe+FpJrZ4YYUe0fSKv+JDBMtw8EfOvCAVUs13jMy+fu67
 ngju1dSOG53M5R9A5rt+i1A0aPypIWO7ppVPAu+SFVCEvNqpoDRdLLjJph7zKBeIw3PRcgwEPVX
 PTJztLlv/VP3dOCzsCBAc5RxNgzZvqSPQhA92QQYtqo3/YG2uvJGUkt3PmmHOJYCagwS7ze46HJ
 lf0rcA+AlWnzeIB4FHxWmq9nS+t2veKPvTRpyyVt8MgRgS+yRiDA2jPENSp8/UPkswklPUcB72D
 FkO2CZtB2hk3AsNLgfOs8ezhF83/Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
 arch/s390/include/asm/pci.h |   4 +
 arch/s390/pci/pci_bus.c     |  18 ++-
 arch/s390/pci/pci_irq.c     | 304 ++++++++++++++++++++++++++++----------------
 include/linux/irqdesc.h     |   6 +-
 kernel/irq/irqdesc.c        |   6 +-
 6 files changed, 218 insertions(+), 121 deletions(-)
---
base-commit: 82ef9f0fac73cca3e7d776b095b5a7de1b0b88fc
change-id: 20251104-implement-msi-domain-dc1ea014580e

Best regards,
-- 
Tobias Schumacher <ts@linux.ibm.com>

