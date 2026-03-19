Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEEE3033DC;
	Thu, 19 Mar 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935001; cv=none; b=e6XUv4LSJzE4Gyp+YH53LNbI8rg576DV5ZbmUSSQsTEMa6nM9mgteIrsqbOO0Kk21/NSXFf5wIez4aM25xTBWGwTwcmhVH18ZtjDSRDD/6U7BGRLL69lF5stw2fpKEVywmP1jNkT9wm60pgKqGs1Br02zV0fODcUdLo53it4O/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935001; c=relaxed/simple;
	bh=eUX+g//z4+mBb2sP9NcqOiJ3WfGyp8TpL9dLuFMLq/Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kc26Gn/X2OOSiHaG7RYXIULYZmBWtcXs0866xhQmDf9oBB43k8Ay1O8B45qPZYkEEKyXcY7mo38mdnBfOqr95EvwjzgnN1mY/ievCVJbUgst2AgIdvx/y4c2p169nhVeVEbly/YqEogtpNCtHhM2DTecqK+pV0KIYT7xULoAf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L6rJRlTN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L6rJRlTN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JFCx3K1368595;
	Thu, 19 Mar 2026 15:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=gBheh7gJgH51OHrfZofeLhJS68RP
	2VKWwltJQK+2Sn8=; b=L6rJRlTN9uzxMDHMuX2VZjCSIV8kZTngh6/P4n6V3CEv
	2z10zUTflDLmOhE8jkjFetQPXDjxvHA0ce0ttnHOIA9ciYcta+3xJ2+GLRAtnYIr
	QKythY3XkMFcyci1FkATVpXutGfQAeZWq5mXjyEuwMfzjbCQmfuLu8yUkjKrqUTL
	95Vivl1fQm0y3NKmIxKdJstx325dwN5/u5AYt4W0dWp9RQkv5vzk78Axxc/H763W
	F2EOyYDX3DsVcQsBEMkUnBpmlfdqQ6nZctX8kiVh2Zf7KmllDqxgHHHn8Jt60Mv3
	hIWj0Mtt5Np1BMtgylTSiKz1FyEq/LDa7OfzMiHdGQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64ysu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 15:43:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62JDQfG3013987;
	Thu, 19 Mar 2026 15:43:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcyb48q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 15:43:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JFhAdV62259576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 15:43:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A4E02004B;
	Thu, 19 Mar 2026 15:43:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B14220040;
	Thu, 19 Mar 2026 15:43:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 15:43:09 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v6 0/3] vfio/pci: Introduce vfio_pci driver for ISM devices
Date: Thu, 19 Mar 2026 16:42:53 +0100
Message-Id: <20260319-vfio_pci_ism-v6-0-c6bab675bc0a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH4ZvGkC/33STU7DMBAF4KugrEnlGdszMSvugVDlX2qJNlUCU
 VHVu+NkQwguy7H0vudJfG3GOOQ4Nk8P12aIUx5zfyoDPT40/mBPb7HNocwNCtQCkdsp5X5/9nm
 fx2MrvPcYFSMqbkrkPMSULwv38lrmQx4/+uFr0SecT2eIBID+DU3YitaTlYk06QDy+T2fPi+77
 I473x9newmWokowCRBGacky2U1wvsUk181mA8gCgA8AwUbBItxplkLXgggsmHwHwdSa1aoZ5QZ
 Q886uS5ItGnTdvWaoBRWTLhfWlBhqzXrdvN1ZF4ATGbZSOWXhbjNXgo4lqs6pqJlqzfTTjII2A
 BUgBMNSCUORqx+N/wN43p1cp0KyZCDWgG4FAGyArgBaK2G9cdj9+d8LAGsANwAUQEqJhDaUF6O
 2wO12+wZV7UAUVwMAAA==
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
X-Proofpoint-ORIG-GUID: ClGk1Ws_e3NCrLznLuLidB4XcuZQBRTm
X-Proofpoint-GUID: ClGk1Ws_e3NCrLznLuLidB4XcuZQBRTm
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69bc1994 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QCNViZDDaoB_9I-yeyYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyMCBTYWx0ZWRfXzVJoD8Bxk0mH
 PpCbcB4KSukvrhyCZxWUch4ArgjGPRAM/nYdwqcKnMKtOwEFz5rehcHOSspMsRYVSMMZNOXGxIo
 HCfR8SjtCCZe1Uz6InJDRQKFJbYPAd7YejSQCrtcuyr7MIpNKAtqi8qoY16emQN1yzx87O4XZ0E
 cc4JQ/mkBmjUzpWQRohjrH/1w+iQJApAUNtgO4JucMtVzzpOC357/dPZh9N75AeXEVh0U88SkOp
 Hj3FkG6d+JWPwbaZQv6hQfrMd7DdUlXfpalx+wRAWtq1dRVb2S/9k4U1APPDFMPB49cizpXvj36
 XFPYX4sy83tu/aANDwAEC9yYKDplEP8Vmtx+OBjvBif5dpEwO4vQQeJq2QkWh9GMwKxwoME6KPm
 LsTWe854OBf/1wJOCYFRMV+v9yNap9we87oyjmzwZ+8MeVarGHdVAk2AnX1YG27rJmu8IEWlUIY
 AXcNJh01EzTKaFkXMRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190120

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
Changes in v6:
- Introduce ism_vfio_pci_init_dev() and ism_vfio_pci_release_dev().
- Add early return for __zpci_load().
- Use kmem_cache_alloc() instead of kmem_cache_zalloc().
- Rename ivdev to ivpcd for consistency.
- Rename ism_pci_open_device() to ism_vfio_pci_open_device().
- Link to v5: https://lore.kernel.org/r/20260317-vfio_pci_ism-v5-0-b73248b4e576@linux.ibm.com

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
 drivers/vfio/pci/ism/main.c        | 400 +++++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_config.c |   8 +-
 drivers/vfio/pci/vfio_pci_priv.h   |   4 +
 8 files changed, 432 insertions(+), 3 deletions(-)
---
base-commit: 8a30aeb0d1b4e4aaf7f7bae72f20f2ae75385ccb
change-id: 20250227-vfio_pci_ism-0ccc2e472247

Best regards,
-- 
Julian Ruess <julianr@linux.ibm.com>

