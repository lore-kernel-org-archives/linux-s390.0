Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1113A3E7C;
	Fri, 13 Mar 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412850; cv=none; b=Rk07z09teFsObiqSd2/vXw3DWk4KB2NYgYknwozuyCqkp7AzN8X2c/wIQHsBi4yF3EJH5aVsKM0MuL1js8SFADGvuNDWXl7Wwu6QRmFOXmCLGvfgH0moByecy0aa9D3zMtB7022GUZAJ6XG54uinfqTPp7Y8aXBag/tNeMg+JJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412850; c=relaxed/simple;
	bh=9vHhgmNNsBYrRJYJuWBOLyJEUr570bESVgKuTnb6SEo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mzy8GFLenibaszrQOwN3orpFgWi+AmUXZOELU4CSKE5vZXM3CPBsEvJfM04kLOA2UiThFBz+8FM4vqlBkBzbIcpDz+YcS7ZIoTHX4DVcpdx0TTuOUNMVHNLZ1mLg9MJtMp0/TxNTcjwdG6aaalJr+LJKms9nuYhFD0yejfgOyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bz7LGT6F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bz7LGT6F"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6suC92256628;
	Fri, 13 Mar 2026 14:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=7isFUTZZTAIHxK3HFmANfgTDmC+b
	wKY6UpdApQt4NaQ=; b=Bz7LGT6F6BituM4KqBQosUPQW8/uMmzCXQ2DLsEvA6rh
	j3Pz498RPTlvk0zvIhZ9fb6Uoey6GFkcGYB05Fh+zNpDi9LH77Vg12gj1grLh4KZ
	jwl9t3Y2X9NbjmaLVbK5Ip/vTRdpSedZSAWd5qP/LQ5cg1G5T6zBde35iWcnjEBZ
	JccuhCmRCsWBQ5Mi2oKM0BU4Q57KVouHLGPGOJZqeufEG5eEvqaHPaFiRsA9WPlE
	z2xmiX9pAC58BXa2YRJywfacCXc63EleRy5vaqKV0y/6NurRhE8EVWM+4yWmdnVt
	geBN24QUmNWihFPvyWryjid+nDI/ZOm5J7lahDDE0w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92g8tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:40:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAUI5w006130;
	Fri, 13 Mar 2026 14:40:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9q0yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 14:40:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DEed8p50069850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 14:40:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 787112004F;
	Fri, 13 Mar 2026 14:40:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E7822004D;
	Fri, 13 Mar 2026 14:40:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 14:40:39 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v4 0/3] vfio/pci: Introduce vfio_pci driver for ISM devices
Date: Fri, 13 Mar 2026 15:40:27 +0100
Message-Id: <20260313-vfio_pci_ism-v4-0-4765ae056f71@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANshtGkC/33RTU7DMBAF4KtUWZPKM2N7YlbcA6HK8Q+1RJsqg
 aio6t1xsiEYw3Isve+N7VszhTGFqXnc3ZoxzGlKwzkP8mHXuKM9v4Y2+Tw3KFAJRG7nmIbDxaV
 Dmk6tcM5hkIwoucmRyxhiuq7c80uej2l6H8bPVZ9xOV0gLQDUT2jGVrROW4paaeWBnt7S+eO6T
 /1p74bTYq/BXFQJRgHCSEVM0RbBZYuZts2mACgD4DyAt0Gw8H80k1C1IAIL1q4Db2rNctOMVAB
 yuXPfRWKLBvuuBqgtUK6uMsBRG7Yke2mhBuhvAIUuAJ0B7w2TFEYHrl6B/wM4A1L3nfTRagOhB
 nQbAKAAugwoJYV1psfu1+uvAGwBLADIABGhRuvz/8kSuN/vX9uB8VTlAgAA
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
X-Proofpoint-ORIG-GUID: yac7QH6tEPRvCmaW8vDDXMXLlW35cet8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExNiBTYWx0ZWRfX80DDIEuMj7D3
 dnJxXioxpaT6mxSKhR7NZWP0m8KyQgGumc9AUKKAZP76xwc+7YR2Y2vwBHNGZ7DG/x9ILRUixTd
 a4ZVpRhlvpd2IEy+BskWBRzbnyVEqZs4Wc4CPKaU+PWNv1YXb/knSJm/0ZR+3Uuaz1jTMNa84OP
 ZJziD34XzYyoDFEnwJr+0h0KMobU8Xp0uSXykVY74nBgU1LslBFu+o10BgjwriaamI5qgbVNSDI
 ZG2NDIoYNp3rGyFYmId0dEZGqzV80xNTLbDsxsGiBfVPodi1Tmxm5T1KFpGaLdqW0/SxKwRg3Vo
 MOmSHDnojmbWjJFR/w9HaUEXL9/26SSIWgparNIx2k6txatMMT+Aeno7KFfzHWYrFqdM5s4lxUJ
 2QWtMkeaFRLTA+J7VvR2kDD1XmFVj+ezmVQIuhySon9s+8z3pFE08WuDwmPSWoaOtAPUyq77+rJ
 JRj3cB4RcuCVH+l5Flg==
X-Proofpoint-GUID: yac7QH6tEPRvCmaW8vDDXMXLlW35cet8
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b421ec cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=N9cWH81oVO2ky6WQpksA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130116

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
 drivers/vfio/pci/ism/Kconfig       |  10 ++
 drivers/vfio/pci/ism/Makefile      |   3 +
 drivers/vfio/pci/ism/main.c        | 345 +++++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_config.c |   8 +-
 drivers/vfio/pci/vfio_pci_priv.h   |   4 +
 8 files changed, 377 insertions(+), 3 deletions(-)
---
base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
change-id: 20250227-vfio_pci_ism-0ccc2e472247

Best regards,
-- 
Julian Ruess <julianr@linux.ibm.com>

