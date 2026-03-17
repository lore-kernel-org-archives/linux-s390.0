Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9843C6A31;
	Tue, 17 Mar 2026 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752355; cv=none; b=PSupX7ENVShPYWZo5Ji2/7O25SrJ9EERSa956YE1kwF/3PhNJCzx9Sjl2fuCzrdyHCT4DtUyXm7hEjgCXOawOwO7rikv4QHUBIdX6nXVzeD7PpVT3sKD79knJV0uRn1SUngxy0a+MSDHWsJvwuutsD+uQKEGvQUcHSKOHSYBCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752355; c=relaxed/simple;
	bh=OSpqysuza/5AI5e7uhGhDxwMrF0394VeQzprNaAiwUc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gluGnX/xJebQCnPM3hQnYQl0+ze9MzOSmklyBse0hhXYSkpihziIXjYCY3IxcDVypa6lSgHYbO5AlZPga7f39h8WiFszXNlq1/6brDbRXNISqnjtSGKtQayc6X8+OycYpSiBzQbJeYwWLvsQRtt4imOeTohj3yifTzUjvEo62ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F1/qkYwf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F1/qkYwf"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H9eEbI983279;
	Tue, 17 Mar 2026 12:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=gTQgEa9DmPKCT/CgAUgeycydy11I
	Q5NONdz/EY6ZmbM=; b=F1/qkYwf8r96uqAupQ6OH7/I4cCga0t4anOmPWGRnIK/
	VJB/IwsZU5cCTg4/gJTBPiuT4Y8QEQJudwePTEFxEOCXCp7R9ZowBrZStswFOzRr
	GpOwCDXOTwosUh0hdCdMt9IAGchbinw34v4acO3UuwCz6SGZzub92JurqJ9GjcUG
	E8c0Sv251/QbSKmRojdmE/qRs06qV/sys6E6asLU6sx9Tz2saMrkIvYRtrLxTxIQ
	8LPE0wOMyJWE6IqK4QF3VpzZK/+VgAmC1sWF/qumPr2K6JCTG4ZtNuqQVyPdnGAx
	T4ZfyFN/v8ql69l+ZobaOGjzkl7Tg3TujhBhfWS0pg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauc8qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:59:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HC4V91032346;
	Tue, 17 Mar 2026 12:59:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7js223-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:59:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HCx3mN27656834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 12:59:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C21F2004E;
	Tue, 17 Mar 2026 12:59:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5E5820040;
	Tue, 17 Mar 2026 12:59:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 12:59:02 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v5 0/3] vfio/pci: Introduce vfio_pci driver for ISM devices
Date: Tue, 17 Mar 2026 13:58:48 +0100
Message-Id: <20260317-vfio_pci_ism-v5-0-b73248b4e576@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAhQuWkC/33RTU7DMBAF4KugrEnlGdszMSvugVDl+Idaok2VQ
 FRU9e442RCMy3Isve95NNdmCmMKU/P0cG3GMKcpDac86MeHxh3s6S20yee5QYFaIHI7xzTszy7
 t03RshXMOg2JExU2OnMcQ02XlXl7zfEjTxzB+rfqMy+sCkQDQv6EZW9E6sjKSJu1BPr+n0+dll
 /rjzg3HxV6DuagSjAKEUVqyjLYILr+Y5bbZFIDMADgP4G0QLPydZil0LYjAgsl14E2tWW2aURa
 AWnbuuyjZosG+u9cMtaBi0vnDmiJDrVlvm8uddQY4kmErVa9sFaAfAAUVAGXAe8NSCUOBq7vzf
 wAvK1DfKR8tGQg1oNsAAAXQZUBrJawzPXZ/zrYCsAWwACADUkoktD4fXpXA7Xb7BoREpLgeAwA
 A
X-Change-ID: 20250227-vfio_pci_ism-0ccc2e472247
To: schnelle@linux.ibm.com, wintera@linux.ibm.com, ts@linux.ibm.com,
        oberpar@linux.ibm.com, gbayer@linux.ibm.com,
        Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        julianr@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExMiBTYWx0ZWRfXw2LZcOxaNMd1
 pvyBHOc/p9mIzvMaexxHgYZQOHHEtoyW70C/0rOfexVG+IaiOwE+1YUZZ9KgMqTM6RfgrMM9f7S
 uhm72TQ6mH3P9uE2gnOeudPNpIJ+M2VcluF4ODYcrqZBIvc0lHrBmiKI7wjIWan9JcRBFLfqzOd
 h32Ur+K2Tw0mT5ArCxO3gDa+g3jnqx/3iE3ElibWkyXCOVfQLXgyNAOhtw2znlyrSy4cPNkgiC3
 IbS9G1pZYewP9ARgk0SFV2pN/ha4eNnVdAipkjXSmb53YHYNKyDunaJmVT0pP0bRgj5Oo8JNXDV
 2mqerpeQUnTr1CUeRLnB3YZnBzzLQZemW9e8V6lSNGqpCuebWdkgBuk0gHdqscPJKHNeXgxgWhD
 T194l03+2xTTA7xIUT354m+hed0Noy6U9zKq7+3LHSZrTbIJJo0biLCixhizWPHWegIt4aqvOH9
 9lFbGVAOh8F52a4naIQ==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b9501b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QCNViZDDaoB_9I-yeyYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8XSXkvTbm73eQbWVMbqjhsOT6gHt717L
X-Proofpoint-GUID: 8XSXkvTbm73eQbWVMbqjhsOT6gHt717L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170112

Hi all,

This series adds a vfio_pci variant driver for the s390-specific
Internal Shared Memory (ISM) devices used for inter-VM communication
including SMC-D.

This is a prerequisite for an in-development open-source user space
driver stack that will allow to use ISM devices to provide remote
console and block device functionality. This stack will be part of
s390-tools.

This driver would also allow QEMU to mediate access to an ISM device,
enabling a form of PCI pass-through even for guests whose hardware
cannot directly execute PCI accesses, such as nested guests.

On s390, kernel primitives such as ioread() and iowrite() are switched
over from function handle based PCI load/stores instructions to PCI
memory-I/O (MIO) loads/stores when these are available and not
explicitly disabled. Since these instructions cannot be used with ISM
devices, ensure that classic function handle-based PCI instructions are
used instead.

The driver is still required even when MIO instructions are disabled, as
the ISM device relies on the PCI store‑block (PCISTB) instruction to
perform write operations.

Thank you,
Julian

Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
---
Changes in v5:
- Support reads < 8 bytes.
- Link to v4: https://lore.kernel.org/r/20260313-vfio_pci_ism-v4-0-4765ae056f71@linux.ibm.com

Changes in v4:
- Fix bug with < 8 byte reads. For code simplicity, only support 8 byte reads.
- Fix leak of ivpcd.
- Fix cache replacement by implementing a per-device kmem_cache.
- Link to v3: https://lore.kernel.org/r/20260305-vfio_pci_ism-v3-0-1217076c81d9@linux.ibm.com

Changes in v3:
- Add comments to ism_vfio_pci_do_io_r() and ism_vfio_pci_do_io_w().
- Format Kconfig.
- Add 4k boundary check to ism_vfio_pci_do_io_w().
- Use kmem_cache instead of kzalloc in ism_vfio_pci_do_io_w().
- Add error handler to struct ism_vfio_pci_driver.
- Link to v2: https://lore.kernel.org/r/20260224-vfio_pci_ism-v2-0-f010945373fa@linux.ibm.com

Changes in v2:
- Remove common code patch that sets VFIO_PCI_OFFSET_SHIFT to 48.
- Implement ism_vfio_pci_ioctl_get_region_info() to have own region
  offsets.
- For config space accesses, rename vfio_config_do_rw() to
  vfio_pci_config_rw_single() and export it.
- Use zdev->maxstbl instead of ZPCI_BOUNDARY_SIZE.
- Add comment that zPCI must not use MIO instructions for config space
  access.
- Rework patch descriptions.
- Update license info.
- Link to v1: https://lore.kernel.org/r/20260212-vfio_pci_ism-v1-0-333262ade074@linux.ibm.com

---
Julian Ruess (3):
      vfio/pci: Rename vfio_config_do_rw() to vfio_pci_config_rw_single() and export it
      vfio/ism: Implement vfio_pci driver for ISM devices
      MAINTAINERS: add VFIO ISM PCI DRIVER section

 MAINTAINERS                        |   6 +
 drivers/vfio/pci/Kconfig           |   2 +
 drivers/vfio/pci/Makefile          |   2 +
 drivers/vfio/pci/ism/Kconfig       |  10 +
 drivers/vfio/pci/ism/Makefile      |   3 +
 drivers/vfio/pci/ism/main.c        | 379 +++++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_config.c |   8 +-
 drivers/vfio/pci/vfio_pci_priv.h   |   4 +
 8 files changed, 411 insertions(+), 3 deletions(-)
---
base-commit: 2d1373e4246da3b58e1df058374ed6b101804e07
change-id: 20250227-vfio_pci_ism-0ccc2e472247

Best regards,
-- 
Julian Ruess <julianr@linux.ibm.com>

