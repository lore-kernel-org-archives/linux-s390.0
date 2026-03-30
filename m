Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F53126A0;
	Mon, 30 Mar 2026 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892425; cv=none; b=IhgljtgDSpBI53hc5Ym4P6K0xCb7L/DeVpk727hJ2InRkJDa408JYkvbJBo3ebOVlj0ixt0rgoww+tIiCCQoGZwE77DmKJGQBCaDTpkIcTmFDGS/x+8oEweZevBCU/hgvj6cUQ1EJBAEPZwWqnBLe+f3rgBE2Q6h73jb12lhUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892425; c=relaxed/simple;
	bh=T337hOKff8oCp8nowJzz7orVI5G6Qq8GEwjZkz5jFoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEZhP76k7QV5h0YkVrb/izbRNZbPIN+hpgPcNlPdjj+TkGgvlpjoRXrF4S+yix3pnZEU6KnXZwQmmDyvvX6RTttaLfcYsYVBhTzyyRC7vXBSWX+y2GGN5E7jmEZU1mcJYHmAQf0A29XoDvkirtJIMnPTLpE6mjVNPe8rRDRxaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FNuZ2JIt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FNuZ2JIt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UESOZK115373;
	Mon, 30 Mar 2026 17:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=65M6hJzQ8Nl9hWQP6B/+Ao7LCZRcc6emmL/qtJYSZ
	Xs=; b=FNuZ2JIt7OSHy6j3Fx0xgoUbAhXrTVz5ObFDODLbqdKEVZjV6mmgJE81d
	SwD6tEuTOFiP9ACusnrEJ8Pq+nkBfuHvGud8PGAWCFN2YB5dxX/Mh5EA2GDrKk5Q
	qGDKjNAXoQOzQqhFA6YUU/87IQWKOJte6gA5qUGcdsjbqZBffZtTsxFfJEN5onAU
	blZvHmHNiWaxyQCa/3TFOqolYJchj479W7NS6KtYTgtFqLTv8b77oclX0L4P+vX8
	gYmW27cadAcZlVjJl6MIkCb9nBfRYaNqQrubH6eK44Hjab9DJT7QG2Yq96ljTtOJ
	PYL3S3SdLC0vgfLDqqaQEstC/iSVQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q2yyrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:40:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UF0txp013897;
	Mon, 30 Mar 2026 17:40:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkdsfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:40:15 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UHeEmw36438778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 17:40:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAC795805A;
	Mon, 30 Mar 2026 17:40:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 217D158052;
	Mon, 30 Mar 2026 17:40:13 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.214])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 17:40:13 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v12 0/7] Error recovery for vfio-pci devices on s390x
Date: Mon, 30 Mar 2026 10:40:04 -0700
Message-ID: <20260330174011.1161-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a_4fv9VptW3RBX40WnwXdKylNqoP7QmF
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cab580 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=H5O81k4uhyXwW133l-cA:9
X-Proofpoint-ORIG-GUID: a_4fv9VptW3RBX40WnwXdKylNqoP7QmF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MSBTYWx0ZWRfX6Xtk7m38uJU2
 uv4VN4nrrLffQ9zNzi8IzRRs7EssBKp9l7r0QUm/5MGKLS/0B1FUHKPySqVGy9ATxRD773flPK9
 3C36DXPr6z23W32iiHjz2ENJmwG9cIFuN72YtYFvVGHTZ2AMaYV9Bd6Eyt0n8bNauJkIqbKIxjp
 uaJkopRV2HNSGwz3EODM3nhC0E3LCYgs3xyfc2a7H7uMrZnOYhnMMqZo48wzADC653YWEQOATbn
 qB8BQ8o63NRnRd4whbrePUaTdxUTLJV6plxmbyLQOPUQwEtk+aNqImjch69SeUPMmOpZgrl1W7+
 LzIikOXbe1sSIL2DELmNPklmXvZNMZzcoZW9rY/7MtJl/p7MZBgBPozZltUE3Tjdox0KIZa0p2h
 qZkC/lk2ovGnn1s6+1zHxDYmTgP734v6yMIr2jzkEhEOXrgDy7xj+L99IsS+EL1WH2ncnqQC9Y9
 iePFgutPjTZ+oQuTLbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300141

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
error recovery on the host will skip any further action(see patch 4) and 
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
v11 series https://lore.kernel.org/all/20260316191544.2279-1-alifm@linux.ibm.com/
   - Address Bjorn's comments from v11 (patches 1-3).

   - Create a common function to check config space accessibility 
   (patch 2).

   - Address Alex's comments from v11 (patches 4, 5, 7).

   - Protect the mediated_recovery flag with the pending_errs_lock.
   Doing that it made sense to squash patches 5 and 6 from v11 
   (current patch 4). Even though the code didn't change significantly 
   I have dropped R-b tags for it. Would appreciate another look at the
   patch (current patch 4).

   - Dropped arch specific pcibios_resource_to_bus and
   pcibios_bus_to_resource as its not needed for this series. Will address
   the issue as a standalone patch separate from this series.

   - Rebased on pci/next, with head at f8a1c947ccc6 ("Merge branch 'pci/misc'") 


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


Farhan Ali (7):
  PCI: Allow per function PCI slots to fix slot reset on s390
  PCI: Avoid saving config space state if inaccessible
  PCI: Fail FLR when config space is inaccessible
  s390/pci: Store PCI error information for passthrough devices
  vfio-pci/zdev: Add a device feature for error information
  vfio/pci: Add a reset_done callback for vfio-pci driver
  vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX

 arch/s390/include/asm/pci.h       |  30 ++++++++
 arch/s390/pci/pci.c               |   1 +
 arch/s390/pci/pci_event.c         | 113 +++++++++++++++++-------------
 drivers/pci/hotplug/rpaphp_slot.c |   2 +-
 drivers/pci/pci.c                 |  32 ++++++++-
 drivers/pci/slot.c                |  33 ++++++---
 drivers/vfio/pci/vfio_pci_core.c  |  22 ++++--
 drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
 drivers/vfio/pci/vfio_pci_priv.h  |   9 +++
 drivers/vfio/pci/vfio_pci_zdev.c  |  45 +++++++++++-
 include/linux/pci.h               |   8 ++-
 include/uapi/linux/vfio.h         |  18 +++++
 12 files changed, 247 insertions(+), 69 deletions(-)

-- 
2.43.0

