Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4FF1EB5FD;
	Thu, 14 May 2026 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781672; cv=none; b=MgigAhnZqmyNAeDmMUfyjFOHUTf+EC917Bh0uL0n1LyDmMfGR5Tg9DxBWMJwPWhVbej+PT9RciViu0CXTgb/9NayKlBUeqrBWOfKhZBKLS5gBtryz6ipt1Aj7pLudLd90o7t/KfArP9U308u3aWtRvT0YJXn6+k2nrapSvmtA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781672; c=relaxed/simple;
	bh=m7BLakxpKZCPOaClEdaTvGjk7blGTAjE4Dm9WYW3sWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUrh6VXex9WyFXFIgqrEc4UVK9hctb+B8IZOP3jCF4VDqv9he6mfV8g2jyBgCy8M2BKSTvDoAgFlwf44XAWC/dGTEIzNaM4KyFe8/NbPKp+l8K8yy5HiHzjPawgm/J26SFK6CswvHfL3+CwWb0/wIMrxv+ivKUWzr80almSQ0LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BH0ZwTiO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BH0ZwTiO"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E91uwd2612176;
	Thu, 14 May 2026 18:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Fp//nfQtB+3rmICylPI6SLsL6AtIBDjuao+UNoU7w
	lA=; b=BH0ZwTiOMpN1D0IWQVj6koAdwpyYvTuvRDrLKZUJAeRWawQbd5JCki57W
	KyZRhy6LWULDLQ1QTeFKkpSCSllchm2WKwScMB4RrEbIPfAV1nt1MMoJBOnvHKzK
	mxvn9obdGdYSNxKZm+yQzqfduvclp+mMV8yYNSqzCWhelfROGFh16Pi55mDrAJDO
	hvesQoxW92aiTPeCR3ySL6dP/sPfHUUL9xuwtibNQH3Dj9CpNMPn8C7qB2kQJ27L
	sGBOw0ygdpCRT0FG0nR/b5BdHVZyRQ3+syqwNP87SSPC4JOX0U18+kULy/e969vz
	VKXbXloP+j/vWjpauyRjzVJ8HOk4g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nve5tka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:01:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64EHsYwN019384;
	Thu, 14 May 2026 18:01:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgnj0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:01:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64EI13WO33030888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 18:01:03 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1856658054;
	Thu, 14 May 2026 18:01:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 182A058052;
	Thu, 14 May 2026 18:01:02 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.43])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 May 2026 18:01:01 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v16 0/7] Error recovery for vfio-pci devices on s390x
Date: Thu, 14 May 2026 11:00:52 -0700
Message-ID: <20260514180059.1553-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a060de1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4zu8aI-QVnT60ftJUTQA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: MyZoSdsHOM3aHuYUnl0yeILCUyuYDzPI
X-Proofpoint-ORIG-GUID: MyZoSdsHOM3aHuYUnl0yeILCUyuYDzPI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NiBTYWx0ZWRfX7iC1DPAAUOzm
 z7iyuqvzKhFRpib8a61XuuQ44DdHj2FCURTSGdejKHjz9PNFDtthFdEEnIU5VOhVkl6IL0ynm/V
 qHeB0QuDTdUvUMkguK454Ke87xK6RgsfUAyeN9+Nf86FZnzCEmjiNo1WV0irovWoDQyL0V196Jz
 Mlcj8B4Vwb9iFFTDi46WhJjlU7Z4k4EFzU5bLLD8oAwOu2zALsv5DdTyH+M+mVI6QW9FNINBVlk
 JPa+Uzb6EkAVAqkwiY1Qf44W7j2bAGYQwLOgrLh7qM7m6Ju4UfLFTDnAinESNPJDfgFXvWtCa1u
 487wb7GYL3wy/iQ8wETI6K9n/q/ReAo0bqFMv5znl6kPYdHFXNtKrY+bajH5EdVxI2tjHANDlH3
 AUi70xANd57mLjOC0KYOyAM08pTB3e9xUx+FlankQ28VYvBwxbdiXcsX1f3UMIsjSt8JJcmzZgm
 gCkOA2KmYa/AzsTIm/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140176

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
This only includes change log from last 5 revision. Older change log is
available in previous version cover letter.

v15 https://lore.kernel.org/all/20260505200510.2954-1-alifm@linux.ibm.com/
v15 -> v16
   - Implement error recovery to be handled in user space mode or host mode
   based on checking mediated_recovery only once (suggested by Niklas).

   - Rebase on 7.1-rc3


v14 https://lore.kernel.org/all/20260421163031.704-1-alifm@linux.ibm.com/
v14 -> v15
   - Fix issues identified by Sashiko (patch 4).

   - Address Niklas feedback (patch 4 and patch 5).

   - Rebase on 7.1-rc2.


v13 series https://lore.kernel.org/all/20260413210608.2912-1-alifm@linux.ibm.com/
v13 -> v14
   - Remove version from vfio uAPI struct. Instead reserve additional space
   and add a flags field. The flags will be used to indicate any usage of
   the reserved space (patch 5).

   - Remove pending_errors from vfio uAPI struct and instead return an
   error to indicate no more pending error for userspace to handle (patch 5).

   - Rebase on recent linux master

v12 series https://lore.kernel.org/all/20260330174011.1161-1-alifm@linux.ibm.com/
v12 -> v13
   - Add the mediated_recovery flag as part of struct zpci_ccdf_pending
   and protect the struct with pending_errs_lock (patch 4).

   - Move dequeing pending error logic to a helper function (patch 5).

   - Update device feature number for VFIO_DEVICE_FEATURE_ZPCI_ERROR (patch 5).

   - Rebase on linux-next with tag next-20260410

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


Farhan Ali (7):
  PCI: Allow per function PCI slots to fix slot reset on s390
  PCI: Avoid saving config space state if inaccessible
  PCI: Fail FLR when config space is inaccessible
  s390/pci: Store PCI error information for passthrough devices
  vfio-pci/zdev: Add a device feature for error information
  vfio/pci: Add a reset_done callback for vfio-pci driver
  vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX

 arch/s390/include/asm/pci.h       |  32 +++++++
 arch/s390/pci/pci.c               |   1 +
 arch/s390/pci/pci_event.c         | 133 ++++++++++++++++++------------
 drivers/pci/hotplug/rpaphp_slot.c |   2 +-
 drivers/pci/pci.c                 |  32 ++++++-
 drivers/pci/slot.c                |  33 ++++++--
 drivers/vfio/pci/vfio_pci_core.c  |  22 +++--
 drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
 drivers/vfio/pci/vfio_pci_priv.h  |   9 ++
 drivers/vfio/pci/vfio_pci_zdev.c  |  57 ++++++++++++-
 include/linux/pci.h               |   8 +-
 include/uapi/linux/vfio.h         |  30 +++++++
 12 files changed, 287 insertions(+), 75 deletions(-)

-- 
2.43.0

