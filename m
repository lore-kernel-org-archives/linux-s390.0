Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56D53ED112;
	Mon, 16 Mar 2026 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688560; cv=none; b=OSIz6qO3ZphGG9e081xRPk6B1qZ6iJSixfw5r5tMGYN9avQUmOeeV5rZirWA9qATSnIHMzllkJzdvfLcwXJVInHoyNh5cZxk/ObKMARXEUwIvByZF61b3twfnnXIdJlJq8od4FoO+SDPeeCnrh7vsZfpcB1siCkYEdxpF7wqoHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688560; c=relaxed/simple;
	bh=RrzNQr3LTU9nXXH8ksu89D494Xkq2E2/UWWysh8wcbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nkgRBa7XqaTXSvi3mcWh7moB7225g3ASOz5H1M/AtB0rmuSEsiaOAnnoQ6ZeCZLa/3ksT/6XSACtMOArl0JwJYiVbQDN2rKXJhiBQSM78A3whpz34xIUhW1DXYZBoI2UCu4dSl9QmXk2ckLQ/Gl0nYUcLI8+yCNJfiyORoyKFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CjaLFLGU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CjaLFLGU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GHFZCC1394708;
	Mon, 16 Mar 2026 19:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=s/yLF+Ppn8uHvsXFQdCyrBoP6mVUz94kdDTWt35Ji
	Qg=; b=CjaLFLGUd1oUAJRcKLQ1jZCEghvXEbm2wbTnb8zhMmY5SLGrcwwu9Dx/P
	yYuk2WqCa3qQ7Gf3F80FyLpF0W7Kf1CZl4VXREj+3fVZcpDd4ySJlzxGGTNWq2ip
	oYklVyDP/uKFi+MUYpXvq8e4TNE5ZDF0eDRaCjAQpkG5owuWwv2u6R7rkq+9ZWzx
	oOxPIuFr0VcNd7V0LWoTUKENZ/9CY0Gndc+ZTGoWfF22b8bkkUuRBP6asfyfN0UR
	t3rvv4FSWIbBGI129WjH/5auuJy8ZYMysbqCHomB9HGt6wefOFZJWtffUNGZyLaB
	hKnJVu7O1b0VjN3NFJUKuRBD/xCXg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfbp4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:15:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GFmFLe028785;
	Mon, 16 Mar 2026 19:15:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk602q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:15:50 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GJFnuH22806824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 19:15:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FAB258055;
	Mon, 16 Mar 2026 19:15:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1760A5804B;
	Mon, 16 Mar 2026 19:15:48 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.131])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 19:15:47 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, kbusch@kernel.org,
        clg@redhat.com, stable@vger.kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v11 0/9] Error recovery for vfio-pci devices on s390x
Date: Mon, 16 Mar 2026 12:15:35 -0700
Message-ID: <20260316191544.2279-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CwiEzP66N32uiDvPiAXy_IEAwso8vbWH
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b856e8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=LUPJ9KGWmwPqNv77U3kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1MyBTYWx0ZWRfX/Cl4TTpEiTvv
 oHXDngPenSgdts3W3g49M4vxcDsZPQGcqq6EIclivv4HbqigD/Y0xVo/NAzSOOxzv5XN7RqgA/y
 FIPGCdXQx76BpIpNET66HYnXHPRWhe9fDKehcF75j0f/BuSLeclccByPiGgmBU/3dkMevJ30iBZ
 03YWvL+ngDv1BeyPYYjiAj4o/mFMw7uhqMLAoobAvQcsvicQvwrSkzESyABecwXzGwwxKky/LAT
 PqYXnuZRQa14zLcpqmt4ZMNhB13gsKo6xoOtKS8RdAcSgRJGWV5MnDm1JX8ER07lYhPdMj/gHn/
 ES9trIXzM6PrJwaEUun8FYPUBpT/j56n4rGXT4E/5VuO8k+amLr3mMMWU/jUIT/5NsvrJqVrh7L
 L2WLuiEjcBdgWuKQUb6iKNbVAzwCOxYJn15jKTLc18GCgu7wWiCEPuK+vhWWQkrBqRkmI96+VJW
 dfLK8OhHVJihj00ErmA==
X-Proofpoint-GUID: CwiEzP66N32uiDvPiAXy_IEAwso8vbWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160153

Hi,

This Linux kernel patch series introduces support for error recovery for
passthrough PCI devices on System Z (s390x). 

Background
----------
For PCI devices on s390x an operating system receives platform specific
error events from firmware rather than through AER.Today for
passthrough/userspace devices, we don't attempt any error recovery and
ignore any error events for the devices. The passthrough/userspace devices
are managed by the vfio-pci driver. The driver does register error handling
callbacks (error_detected), and on an error trigger an eventfd to
userspace.  But we need a mechanism to notify userspace
(QEMU/guest/userspace drivers) about the error event. 

Proposal
--------
We can expose this error information (currently only the PCI Error Code)
via a device feature. Userspace can then obtain the error information 
via VFIO_DEVICE_FEATURE ioctl and take appropriate actions such as driving 
a device reset.

This is how a typical flow for passthrough devices to a VM would work:
For passthrough devices to a VM, the driver bound to the device on the host 
is vfio-pci. vfio-pci driver does support the error_detected() callback 
(vfio_pci_core_aer_err_detected()), and on an PCI error s390x recovery 
code on the host will call the vfio-pci error_detected() callback. The 
vfio-pci error_detected() callback will notify userspace/QEMU via an 
eventfd, and return PCI_ERS_RESULT_CAN_RECOVER. At this point the s390x 
error recovery on the host will skip any further action(see patch 6) and 
let userspace drive the error recovery.

Once userspace/QEMU is notified, it then injects this error into the VM 
so device drivers in the VM can take recovery actions. For example for a 
passthrough NVMe device, the VM's OS NVMe driver will access the device. 
At this point the VM's NVMe driver's error_detected() will drive the 
recovery by returning PCI_ERS_RESULT_NEED_RESET, and the s390x error 
recovery in the VM's OS will try to do a reset. Resets are privileged 
operations and so the VM will need intervention from QEMU to perform the 
reset. QEMU will invoke the VFIO_DEVICE_RESET ioctl to now notify the 
host that the VM is requesting a reset of the device. The vfio-pci driver 
on the host will then perform the reset on the device to recover it.


Thanks
Farhan

ChangeLog
---------
v10 series https://lore.kernel.org/all/20260302203325.3826-1-alifm@linux.ibm.com/
v10 -> v11
    - Rebase on pci/next to handle merge conflicts with patch 1.

    - Typo fixup in commit message (patch 4) and use guard() for mutex
    (patch 6).

v9 series https://lore.kernel.org/all/20260217182257.1582-1-alifm@linux.ibm.com/
v9 -> v10
   - Change pci_slot number to u16 (patch 1).

   - Avoid saving invalid config space state if config space is
   inaccessible in the device reset path. It uses the same patch as in v8
   with R-b from Niklas.

   - Rebase on 7.0.0-rc2


v8 series https://lore.kernel.org/all/20260122194437.1903-1-alifm@linux.ibm.com/
v8 -> v9
   - Avoid saving PCI config space state in reset path (patch 3) (suggested by Bjorn)
   
   - Add explicit version to struct vfio_device_feature_zpci_err (patch 7).

   - Rebase on 6.19


v7 series https://lore.kernel.org/all/20260107183217.1365-1-alifm@linux.ibm.com/
v7 -> v8
   - Rebase on 6.19-rc4

   - Address feedback from Niklas and Julien.


v6 series https://lore.kernel.org/all/2c609e61-1861-4bf3-b019-a11c137d26a5@linux.ibm.com/
v6 -> v7
    - Rebase on 6.19-rc4

    - Update commit message based on Niklas's suggestion (patch 3).

v5 series https://lore.kernel.org/all/20251113183502.2388-1-alifm@linux.ibm.com/
v5 -> v6
   - Rebase on 6.18 + Lukas's PCI: Universal error recoverability of
   devices series (https://lore.kernel.org/all/cover.1763483367.git.lukas@wunner.de/)

   - Re-work config space accessibility check to pci_dev_save_and_disable() (patch 3).
   This avoids saving the config space, in the reset path, if the device's config space is
   corrupted or inaccessible.

v4 series https://lore.kernel.org/all/20250924171628.826-1-alifm@linux.ibm.com/
v4 -> v5
    - Rebase on 6.18-rc5

    - Move bug fixes to the beginning of the series (patch 1 and 2). These patches
    were posted as a separate fixes series 
https://lore.kernel.org/all/a14936ac-47d6-461b-816f-0fd66f869b0f@linux.ibm.com/

    - Add matching pci_put_dev() for pci_get_slot() (patch 6).

v3 series https://lore.kernel.org/all/20250911183307.1910-1-alifm@linux.ibm.com/
v3 -> v4
    - Remove warn messages for each PCI capability not restored (patch 1)

    - Check PCI_COMMAND and PCI_STATUS register for error value instead of device id 
    (patch 1)

    - Fix kernel crash in patch 3

    - Added reviewed by tags

    - Address comments from Niklas's (patches 4, 5, 7)

    - Fix compilation error non s390x system (patch 8)

    - Explicitly align struct vfio_device_feature_zpci_err (patch 8)


v2 series https://lore.kernel.org/all/20250825171226.1602-1-alifm@linux.ibm.com/
v2 -> v3
   - Patch 1 avoids saving any config space state if the device is in error
   (suggested by Alex)

   - Patch 2 adds additional check only for FLR reset to try other function 
     reset method (suggested by Alex).

   - Patch 3 fixes a bug in s390 for resetting PCI devices with multiple
     functions. Creates a new flag pci_slot to allow per function slot.

   - Patch 4 fixes a bug in s390 for resource to bus address translation.

   - Rebase on 6.17-rc5


v1 series https://lore.kernel.org/all/20250813170821.1115-1-alifm@linux.ibm.com/
v1 - > v2
   - Patches 1 and 2 adds some additional checks for FLR/PM reset to 
     try other function reset method (suggested by Alex).

   - Patch 3 fixes a bug in s390 for resetting PCI devices with multiple
     functions.

   - Patch 7 adds a new device feature for zPCI devices for the VFIO_DEVICE_FEATURE 
     ioctl. The ioctl is used by userspace to retriece any PCI error
     information for the device (suggested by Alex).

   - Patch 8 adds a reset_done() callback for the vfio-pci driver, to
     restore the state of the device after a reset.

   - Patch 9 removes the pcie check for triggering VFIO_PCI_ERR_IRQ_INDEX.

Farhan Ali (9):
  PCI: Allow per function PCI slots
  s390/pci: Add architecture specific resource/bus address translation
  PCI: Avoid saving config space state if inaccessible
  PCI: Add additional checks for flr reset
  s390/pci: Update the logic for detecting passthrough device
  s390/pci: Store PCI error information for passthrough devices
  vfio-pci/zdev: Add a device feature for error information
  vfio: Add a reset_done callback for vfio-pci driver
  vfio: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX

 arch/s390/include/asm/pci.h       |  29 ++++++++
 arch/s390/pci/pci.c               |  75 +++++++++++++++++++++
 arch/s390/pci/pci_event.c         | 106 +++++++++++++++++-------------
 drivers/pci/host-bridge.c         |   8 +--
 drivers/pci/pci.c                 |  26 +++++++-
 drivers/pci/slot.c                |  31 +++++++--
 drivers/vfio/pci/vfio_pci_core.c  |  22 +++++--
 drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
 drivers/vfio/pci/vfio_pci_priv.h  |   9 +++
 drivers/vfio/pci/vfio_pci_zdev.c  |  47 ++++++++++++-
 include/linux/pci.h               |   5 +-
 include/uapi/linux/vfio.h         |  17 +++++
 12 files changed, 307 insertions(+), 71 deletions(-)

-- 
2.43.0

