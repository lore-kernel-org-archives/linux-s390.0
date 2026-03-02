Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7483750B5;
	Mon,  2 Mar 2026 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483617; cv=none; b=qXmrHWsJXdPNo2+nppzykUtSS1MqGVph8HqhTujvjrRIinScgt7qAnZU+lHqCI/n7+77+nySg3VJf+eynRYQkIvjOqpVGyUcXJQ8YFGNptS5/m1InccteyToP7j4oO9DSIp+I2Wpygb5FLODl8q67DjhPeeVRkVs/lLXYZQPogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483617; c=relaxed/simple;
	bh=elnDTfWo1fjzhLNmlfafMUb9MY94m59sTWNkc9yYV8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Km/Q2fdBGW+WNJKB6sIAAS62ayFrHXFpQv9l/06aJeRgl90AdctCQ4QhHMejw1lz8jHJ7n1BuU21hlKD8HEZWdq53bHASeYpCrBjvtc1cdy2L1mHe82KnzWNT+WNQnks+7wr8ICON6glMhwPHd2TGG5LBQ3VayhzLRN3GKcxA7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EYlhCg2R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EYlhCg2R"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622ApV3J1171368;
	Mon, 2 Mar 2026 20:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=q1vw4ohzrC9pXXrDKHGEpYg+0OiLN+RFta2r48P0f
	Cw=; b=EYlhCg2RLAy5aaVbobPXoRKTK+lzkUhFuW1lH9J4rYqnMWRHkzfjedY7E
	koJgc5KhfGfNJxSVoeCAjhUHqFIKCpcozNo0AVqpcu10uP/+Pg2gYUGH7Cbu8d+f
	93R5AdxGjW1kMrMPQy9GbhPt67WsbLTXZhPGAYbNMX1rfd02DSkI7tytCPglVjyc
	r9sYM3vBxR7z+8oguS6f2YWW8aPx5NlMr8ekBE/u3h0XY8BnIAiI6sBUB+7RdLRA
	sV4PEbRIsVLYEVa3dPXr5mOTv7VlD3q1/A5Wm4rBnmgnzevkPLQQdtwYDpH+bmAo
	OOkM3o+NeGzKGbexyjhc8vrfZVYVg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3r5jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622Ix7RQ027725;
	Mon, 2 Mar 2026 20:33:28 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwj7bs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:28 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622KXQsP22479416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 20:33:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCBA458053;
	Mon,  2 Mar 2026 20:33:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 664BD58043;
	Mon,  2 Mar 2026 20:33:25 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.18])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 20:33:25 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, kbusch@kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v10 0/9] Error recovery for vfio-pci devices on s390x
Date: Mon,  2 Mar 2026 12:33:15 -0800
Message-ID: <20260302203325.3826-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2uZ1x5KD4v4zIcoeI1vOfXAVuc6wImUI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1NSBTYWx0ZWRfX2tatbAdy5T8x
 N7naXOsfjUd0wviwF2Mr3oNJJkP5aztpZqyls9cV9C/ne82Juvs2qM1AKXsFInFWgxYFHG01M0f
 k5Yq82IuBkl8c/SDzvyERczrkox9m9K6dmKEvtb9mfGsI9CDtRM89U7yPZYQiEpvfyJl/L2/xCR
 afsR3Ghn5GqYH5f4nwVbyg1EPo8naAprFZwwT8XJmqL3BFrG6kRZOCv874ijMubGeLyQvyLpm4U
 ukB6WpelBTzqZogLAnX0pCtiiLUjdu8FwQA2ceEb4uU3v9g70oHOPIKx4ncbS9FX7/9vGk0Fj5h
 SnHXJdVYYJ9Tste+FAE1j4i26OCxy1BwbleRJDGtwk5LsRdi6VjlZpYqSGrnSw8iEmFpAfZTHhi
 a6UgtsDuuzLLetvpdSU95snttgXsJ6Gi6vghc9gPVXwVm3uiVH5huFUWcL7GEjuV8xPvZ2vvgBg
 +vJ9uxmhy53y3RuRiNA==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a5f419 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=LUPJ9KGWmwPqNv77U3kA:9
X-Proofpoint-GUID: 2uZ1x5KD4v4zIcoeI1vOfXAVuc6wImUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020155

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
 arch/s390/pci/pci_event.c         | 107 +++++++++++++++++-------------
 drivers/pci/host-bridge.c         |   8 +--
 drivers/pci/pci.c                 |  26 +++++++-
 drivers/pci/slot.c                |  27 ++++++--
 drivers/vfio/pci/vfio_pci_core.c  |  22 ++++--
 drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
 drivers/vfio/pci/vfio_pci_priv.h  |   9 +++
 drivers/vfio/pci/vfio_pci_zdev.c  |  47 ++++++++++++-
 include/linux/pci.h               |   3 +-
 include/uapi/linux/vfio.h         |  17 +++++
 12 files changed, 306 insertions(+), 67 deletions(-)

-- 
2.43.0

