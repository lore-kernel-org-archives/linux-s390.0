Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F23D6465;
	Tue,  5 May 2026 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011521; cv=none; b=Dnr4OUHLH3CsvAwh6HbqaMnhuNpnIdiDuh9StFu8ngxyrjRiP3xW172sv/CHTKO/1wugd7k0nWemoSFteE+NvWr4EzcdKsR9G+6xuSe152cIPcSmjJmS3xfM5/iBhI+jC6K5OY1grhjE641drpxi2s2x463KAFwXTh5XNVrEomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011521; c=relaxed/simple;
	bh=OxrNVPWMOar/igoc0kzdRKgi2YjXHjsejeCP8GcY6Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LnhmCJSCnx6+ee2U3uGUpO2OSLIUCqvSgjsZ8afCwP0/7iPi/76nuZwwCHIpdSDz6fvjgy6KFQB+bOWayvHAMsibg6uHaRF8/PQWghvpeeEONH0P6PYvBYBCRZBE5xUONzg36/OWKU/j5tePGbcah5lqegucBD8mAFij/6hoFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gS7oJTjU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gS7oJTjU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645II9bn2606962;
	Tue, 5 May 2026 20:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=f9m8uZgl60NrXjuBZMnFmGaI9h6MtJWWa2rNTm/Vh
	88=; b=gS7oJTjUl1AfloEHTxwkQ85GQbAd640d9VNlaBv604b1H6BJj3Mz/u7vx
	odbIeuvKttDjsYRH98Y1hp902kLUkdxRJ33dEgI/okJ8yGRtZsm3aaY+n0PlVqsg
	9IzmjsOf6Wj5wGu3+pyN84bH4wLhL2YH3LyJM/Mk1eI0+zb8bJAeaxbFl6g3sWZj
	ujeTZDqxQSpTGzY/7i/oEIkzgxLAQa9nOZJqD/dH8fhPopu4q4BkAvvfYlHKSCQr
	0f+WpElFCjZsMe5eDpCB2Ae6xDpFan+GzfztbsNU9d71LYGDLMVV1+VCpEaAe7ZN
	5cJ55yAUMMZi6tRPmUyaMENLFffQw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7dkur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 20:05:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645JsbEI019201;
	Tue, 5 May 2026 20:05:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkju83g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 20:05:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645K5B8h35979836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 20:05:11 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49C2C5805D;
	Tue,  5 May 2026 20:05:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 873D358043;
	Tue,  5 May 2026 20:05:10 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.219])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 20:05:10 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v15 0/7] Error recovery for vfio-pci devices on s390x
Date: Tue,  5 May 2026 13:05:03 -0700
Message-ID: <20260505200510.2954-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5MSBTYWx0ZWRfXwW96ap90qzZn
 7qbY6tf7wp4hWvQ3nlMJsXgQQVN0a1efZi1vULs6+bkc57f4qPoVwF0lGPNd04ucLNjR6ngN6x1
 LuQGPRpC5GigA4Jtaq4MNBGo5cqUmi5PA2HW256eZQV/0IH9rSdkUb7Qb1/pr8+pxUHoRjN7CKk
 6BTRyEysMir3Vijc7U4371OKxRcwGlIri2BNXHKTQJmOBHIEBL1nlAt8Gfa3M45tAKA+ZqLZIm+
 BXlsaBQvuXC5zepV5sV65KvsEX2D+aCx/Zdm/daJIAxZ4ZpeNgZvMQdg835xmtyzfvs+NnmVOAa
 ZL4QWcGnjSRGgS9Mv1vB5u5bJ8JfFKt7exGjlgmzT4ZaflCq9o6+4VrHtycDYKOodcSkSc3AVMl
 1wYYtGSseQDeNdG0asZKKyBoEMPpUt3jTyujP6nq/Fga/m3C8tBcb9G6PLPEd4Mme/cyinmEA8r
 sPL/xWCW3UCif9uZ5fQ==
X-Proofpoint-GUID: o03peR38ZGDbbQqZZOUmZbkLthSy_ekV
X-Proofpoint-ORIG-GUID: o03peR38ZGDbbQqZZOUmZbkLthSy_ekV
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fa4d7a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4zu8aI-QVnT60ftJUTQA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050191

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
available in v14 cover letter.

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


v10 series https://lore.kernel.org/all/20260302203325.3826-1-alifm@linux.ibm.com/
v10 -> v11
   - Rebase on pci/next to handle merge conflicts with patch 1.

   - Typo fixup in commit message (patch 4) and use guard() for mutex
    (patch 6).



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

