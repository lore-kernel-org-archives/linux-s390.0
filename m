Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494E23EAAF;
	Wed, 25 Mar 2026 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774445514; cv=none; b=u8gnFK5r7EpCnooSON0gW9AyzMJBfbvXhvsVg/jd8oTwqcQU6RdJv9gUPCG8hGq6wN5nYrdVp7pLaJ9Z2zKoRRNbWLjbz3j/A0mE9y5oQJ3DW8X/lQsQ2njG+XT9ssRcBNosM8yqJ9QOVMPDOG9bzj1iydggOJBWFR68bJbGkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774445514; c=relaxed/simple;
	bh=l/ThwHA7jmh8hAWnUiyNu0+SkkTGpVEwAXYQkHY1qJg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qRCcnx1tg1yWIRQYCkj+Hc3xulIYNiy1e0gVgCt/sVsZNp0x5j7z8TrzBEplYD5g+0m0IwLSzrWu5eTXmaNMKmM+87UYkwDEXzlbBhJjwYsEYe/q5+JwYRH/CZEEePJ2jITrDA3+B0CnFbHdHf+D4LuzPaUg/XpmQdO0++b72VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FDOa9F7b; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FDOa9F7b"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P9IRMQ406889;
	Wed, 25 Mar 2026 13:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=AX4NGUAiA6LuFkInZ2FGwECGSS3f
	mHNNp2JM0udvmYU=; b=FDOa9F7bRiSgDo5aXpZ0l4Yk9kiqGRxTlHH8KUvFcfxC
	FqjioQ7iffAYnMY1mePmTx8dFh4Pt7eNfqV/K5J+PFjWiG1QX0RONhdaqFnDSezL
	QAAq8Ug8J7240GDUYguZo/22rqY62+ykOnFxEN+xF7SFvfpyD6FNOrwthSv/00+y
	0NjzSfi5d9K/c08HtuY6NgGof2f3PmR+l+fbsmyyP1K6dOhCYAnXCTGrZsuvql25
	0d0mH0Ox7eeyXKtGWPxIot6JUK5uwaaXPhPLRuta91xQmKIheEV8rZXuswHt4yhU
	BZBP+4iKD8q/oEqaZ/Yo+ITnf/cG7t6WYJ/ZHWu1BQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqgmvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 13:31:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PAeJdL005983;
	Wed, 25 Mar 2026 13:31:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ypste-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 13:31:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PDVfu636045290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 13:31:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DD5620043;
	Wed, 25 Mar 2026 13:31:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE0B02004B;
	Wed, 25 Mar 2026 13:31:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 13:31:40 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v8 0/3] vfio/pci: Introduce vfio_pci driver for ISM devices
Date: Wed, 25 Mar 2026 14:31:22 +0100
Message-Id: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKrjw2kC/32Sy27bMBAAfyXQuQp2l+QumVP+owgMPhMCtR1Yj
 ZDC8L+X8qWqQuW4AmaGFPc6TPlS8zQ8PVyHS57rVM+nNtgfD0N886fXPNbU5oGADBDJOJd6Prz
 HeqjTcYQYI2UtRFqGhrxfcqmfd93Plza/1en3+fLnbp9p+bqIGBDN/6KZRhgje1XYsEmonn/V0
 8fnYw3Hx3g+Lu472EIdsACC00aJKn4DLqeY1brsNgLVBBgTYvIZBNJOWYHpgYQCwtFicr2yXpV
 JbQR6uXOwRYknR8HulbEHamHTDmy4CPbKZl3e3tk0gRR24pUO2uNuWTpgEEXaBp2NcK/M/8oEv
 BFwE6TkRGlwnMXtll0HjBx8YDEhQved5buyLD+Ng9WpeHaY98pfnmkBfShtvdCABtsr21UZcSO
 wTWCMBh9dIPtlw+4CXAtoI8AmUEoRk09tR/VWcLvd/gJ/V0IUyQMAAA==
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
X-Proofpoint-ORIG-GUID: 5myxCgrO0ytfx_W2wgjp7fWPh22yLOni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA5NSBTYWx0ZWRfXxvf05h+A/+Z2
 CpviZTRVOHSn4JTLqAekHOjQYNKuhhntwLE4w/f0FLu55KGuCPwDtRoo+Jyje7zEbBeeI4nGuQI
 LBgqSl7dLHf9jrrvqLQt2n9qIWKSbzBRkMK2I+MmW9V2gkcELeQ2gs+JDy8bCxtEm4XGQbz9VcO
 7WzShwVsF0cwIyZO7q5QU1bi8WfebPOJVpIqNmrn2QtDAVGBLtYmXP1quy2cTwVoVIEaBe6U2+J
 4l9HFiHHXlCWWp67OFuMPpx4Z1i98DArXhD+CCrtbIGyvq49GwmDmJ8Sv6vyjznw9QQz8qJjdQN
 vinhVW6c6MhbcJKJvf9GVA/gz7Odin5jvcnIt7IqTYrE2TuEj0Rl/jb8xv+blYQgg54ypRYiar2
 MEXj2eePNsF4mrGw3pqYcEBTr5R5JdY+DzWkQBN99ThT8FkA/zKnlYymIQ+crH6CTXI358WEtF7
 Cn1R5kj6i1ZU8b2EO1g==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c3e3c2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3XGxXiOqMMHeIvAuhUYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5myxCgrO0ytfx_W2wgjp7fWPh22yLOni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250095

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
over from function-handle-based PCI load/stores instructions to PCI
memory-I/O (MIO) loads/stores when these are available and not
explicitly disabled. Since these instructions cannot be used with ISM
devices, ensure that classic function-handle-based PCI instructions are
used instead.

The driver is still required even when MIO instructions are disabled, as
the ISM device relies on the PCI store‑block (PCISTB) instruction to
perform write operations.

Thank you,
Julian

Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
---
Changes in v8:
- Format vfio_pci_config_rw_single().
- Add () around the off macro argument in ISM_VFIO_PCI_OFFSET_TO_INDEX.
- Use function-handle-based wording consistently.
- Return -EINVAL in default case in ism_vfio_pci_ioctl_get_region_info().
- Change ssize_t to size_t in ISM_READ macro.
- Use kmem_cache_args with with kmem_cache_create() to prevent kernel
  panic when using HARDENED_USERCOPY.
- Link to v7: https://lore.kernel.org/r/20260323-vfio_pci_ism-v7-0-abf537150408@linux.ibm.com

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
 drivers/vfio/pci/ism/main.c        | 408 +++++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_config.c |   8 +-
 drivers/vfio/pci/vfio_pci_priv.h   |   4 +
 8 files changed, 440 insertions(+), 3 deletions(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20250227-vfio_pci_ism-0ccc2e472247

Best regards,
-- 
Julian Ruess <julianr@linux.ibm.com>

