Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628237BE66;
	Mon, 23 Mar 2026 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258384; cv=none; b=bTodHxoroTPcm7z+Ctr4xrE/5WI1INYx13gcwIPQyYjYBAlr557yvy5m9xS1ot3FQFSH6nlM0DN0BNX047vY8tW+KhqN2mkNz8tL63ovDnPpQDSmnSOZvwk/JQ3+8BVgthMRMlpZ/yeVhh+ssymzLfB8QgRmWqyT6Zc01eu6bK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258384; c=relaxed/simple;
	bh=Sco13AuclG5+PYUoU4+I2bi13CiQHYq0ETNqADo91dU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MwFIZBYoSOn6EgdiauAZ8kBsmbtYXQ57IJFX12IX072hz4vszGC5COqgTi2aJO9y34hXfephLiofknQ7ncyjERF7YpxiWfSFjbWPMivoRvmq2tgrDsFecXPcWGdiAm9D20uf6/k7PManh9IRFSarjGc+H5kFSP4FWcSbQkCDwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jrlQwUDQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jrlQwUDQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MLkW2Y768705;
	Mon, 23 Mar 2026 09:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=RpFR1iYftcsMB4DzfT2d8dlry5qt
	IN+u+sCs1jmM6nQ=; b=jrlQwUDQ+tnDpa3vorASv7bOM3w8Zr/qk0c/qwQunzAQ
	AukwIzXnSokXHgDYdS6P4JLDV2wJb4a1r9f15lMpcovZWdc7mwqNtLe9u2geiYNm
	4siG29tMOqGIkVpOGwtUxxsetAjlIML6WSNcuxHNX0A4FNkngwBjR8isIspY8T74
	qaSg3Vp8oYohlXQg9XitRwerVSJ0XyQIgs+DtMD1o0yBgZejbpsmWEij6OZC3ZVS
	XWgvZP6DDZI+6pws5Z8EoRbEZwOeUZMPGdN+o/6TZHRTQpOpg2Se6YQ4T/I9vhrI
	wEv3KUQlPSMeTo8puOMUDCTyyyjv8xessK0PXlv+oA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq66xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:32:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N6TMx7005964;
	Mon, 23 Mar 2026 09:32:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ycw9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:32:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N9WspE59703636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 09:32:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0369F20043;
	Mon, 23 Mar 2026 09:32:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD3A52004B;
	Mon, 23 Mar 2026 09:32:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 09:32:53 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v7 0/3] vfio/pci: Introduce vfio_pci driver for ISM devices
Date: Mon, 23 Mar 2026 10:32:44 +0100
Message-Id: <20260323-vfio_pci_ism-v7-0-abf537150408@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALwIwWkC/32Sy07DMBAAfwXlTCrv2t6NOfEfCFV+Uku0qRKIi
 qr+O04uhOByXEsz49e1GeOQ49g8PVybIU55zP2pDPz40PiDPb3FNocyNyhQC0Rup5T7/dnnfR6
 PrfDeY1SMqLgpyHmIKV8W3ctrmQ95/OiHr8U+4bw6i0gA6N+iCVvRerIykSYdQD6/59PnZZfdc
 ef74+xewBKqgEmAMEpLlsluwHkXk1yXzUYgiwB8AAg2ChbhTlkKXQMRWDD5DoKpldWqjHIjUPO
 ZXZckWzTountlqIGKSZcNa0oMtbJel7dn1kXAiQxbqZyycLfMFdCxRNU5FTVTrUw/ZRS0EVARh
 GBYKmEosrlbNhXQk7OOWDsvqu/M/5V5vjRynQrJkoFYE3QrAcBG0BWB1kpYbxx2fz7KIoC1ADc
 CKAIpJRLaUL6a2gput9s3HfZzGZADAAA=
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
X-Proofpoint-ORIG-GUID: 33k3iQj0GtDMcefr0mEeXYl9W6wd8kiz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA3MSBTYWx0ZWRfXzS8iAqOj67AZ
 CphsDX06CH/OKXjhL71Km6r0b/8RVOP9ycMW2cwabdirS2Jg6fx5qtSOSnevNd8Ps6gc5RV6JOR
 CT/VF/CdIZDFIEMHQ1s/gP9ZOgS3Bh3Ljlpi/qGhCVouL7vDIefrcY9yr5jlvrt677OFCFPBVX9
 NXcIQP2ea0+M0BA0cnDTKMOHXXBoGO0b/5AVTopTrZopZ2WGwTG16z16WZZPSdfTmNKmTJGtgn8
 PEGBXxbSaWePVbWi/6/XzElnIxUHDx8XvQdTYhozXm7V0euTr+pm4pEObXNr21yhBHn8FC70vAI
 5sza8HlPYAzAQuwvqmxtQdu1gDum0fuMQ14ZV3Ecbd3qgqQXwpYhDv2G+ldPxmVJkHBJDeF2DGp
 nl11C2nu8Db7QNaX9ZwIAyQtSST2UUsye1yw8UdtgIsmWfHtOmAqb+Bm/EMk7/JJpvc9tYjyseI
 dWMijwPYxwitf0nfElQ==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c108cb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=S08g_WpIHce721ZfF44A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 33k3iQj0GtDMcefr0mEeXYl9W6wd8kiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230071

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
Changes in v7:
- Add 4k alignment and to kmem_cache_create() to do not cross the integral
  boundary.
- Add SLAB_RECLAIM_ACCOUNT ans SLAB_ACCOUNT to kmem_cache_create() for memcg accounting.
- Link to v6: https://lore.kernel.org/r/20260319-vfio_pci_ism-v6-0-c6bab675bc0a@linux.ibm.com

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
 drivers/vfio/pci/ism/main.c        | 401 +++++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_config.c |   8 +-
 drivers/vfio/pci/vfio_pci_priv.h   |   4 +
 8 files changed, 433 insertions(+), 3 deletions(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20250227-vfio_pci_ism-0ccc2e472247

Best regards,
-- 
Julian Ruess <julianr@linux.ibm.com>

