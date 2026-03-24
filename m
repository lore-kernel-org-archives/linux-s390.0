Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D842E11D2;
	Tue, 24 Mar 2026 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380866; cv=none; b=ZjfSv9EIpC8YBupz8J60VH0vaqT5NXbScIQ+esweZM6dPd5nt8b64fDVmVVbFoxs5mybi+TfM4W2Tg0ahz/vZSr/pxLXSl3ypb7kpvwv+Q2NNW/qfHFDJ6nUxe3/uVG7H9PAGYfASb+hGZ+oVyGqApqVCDUj9JCP8VFdijScLl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380866; c=relaxed/simple;
	bh=Bc5l4pIBeiiPgT/7rux76ObCIYFem7KpEcL8vce6haw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUy8j/Gf9UxjaZPNIoYnMKY9FjTpdwZQw9qXrSHIiGJ8uLDOMOqlB+/5jFtf1xCXR8e1cnf1rTvnZvAFNsG04TVANvBT5N+Wo5hoN+WWzylZLlQslB69zdQku+tijSF80s+3OMGWhymK6SS+R+FVei6GspWHRRuHinRwP4r7oPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dLo7lh2F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dLo7lh2F"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OHqFbh552077;
	Tue, 24 Mar 2026 19:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wa034R
	kjRmkHyMwVHyN9YR1qpLJT9Dt37rUSQmpCTzw=; b=dLo7lh2FYN7STYJtHybIjS
	Q5zR1qPu0cJSuo6Idr/jnLy4KEjYynAs8dwTn5rlUnOcj0+/ZrrZIxyJvpOc65zZ
	Jim2c7BRZpr6C1dZ96jvzqmykM0QF/tF/tv8g2IZaYR2aaclTPY6fRb0LHgUrdfw
	uFnYzCFEo3jF5eFckvR38InNQ8MM8AjBMGKK9apxTtP5odoLDHZ7farkalYtoUI/
	2xpbw2YaXRvUDa3h8oZv1/l2OqwPPo6WxeACe1K0U7V9DuBGO/2sn6zeQIEcM1GY
	pKwpK33abpl+i6jLaH8W6AUrwZLVD3DjPfRm0C5lERwLErdzzuxSCsUroHs5xttA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky04pmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 19:34:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OIxPUI009118;
	Tue, 24 Mar 2026 19:34:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnkk0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 19:34:17 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OJYGb727460110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 19:34:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3112E58059;
	Tue, 24 Mar 2026 19:34:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 664CD58055;
	Tue, 24 Mar 2026 19:34:15 +0000 (GMT)
Received: from [9.61.253.153] (unknown [9.61.253.153])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 19:34:15 +0000 (GMT)
Message-ID: <f171af52-87f5-4b1e-9caf-6d7b4e161534@linux.ibm.com>
Date: Tue, 24 Mar 2026 12:34:13 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/9] Error recovery for vfio-pci devices on s390x
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lukas@wunner.de, alex@shazbot.org, kbusch@kernel.org, clg@redhat.com,
        stable@vger.kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <20260316191544.2279-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260316191544.2279-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE0OSBTYWx0ZWRfX8V7bYqJMvxC9
 iITahyh+MEIkR58YKLn4RoSTUSY+t6HwaxZ9XIe0PaLF70ysIdmFJumKmYRni4gCqwi/IE0ydhI
 0P0RY97qX8+zyApXMPP9qDrn8GIeMG3j4v0kFJlymHx9yWA3XbdDIYagT+FsVp1hXFXNm4uj6Gv
 uGIi+V5xazWawYdwURhvJAZI0CBdVoTmI+TdRNUN2VX7EAIZ9JrQrpIIyWm2jhv5wvtHg8LLW8A
 0NA1vDg8l7PuZpnfm6tc0DcaDpbo0W1+UWGIcWsQnT10JS0NMRb/qpzGISeyV4ZItj4fNqGdSxw
 I7QsojsBOvIho39eK0WCq3RZ80nK/L9Ds31ZOXbM28Z9qaFY5VmZTy9ZG2r/y22DfY/rLzJfagX
 zYnlOdKvJp7G63Fogh+A4SHerDM93OQqIN8J47N/BR3+3DuXzHVmqYKf/VVhaCYLHNv8c6pBAyt
 JkOSddqZgIuWSxKQNOQ==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c2e73a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=VYs1Kb8SrcD_bOuB75gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3BHBDvEwVUs_s58Vkjact9JfNmqaTstB
X-Proofpoint-GUID: 3BHBDvEwVUs_s58Vkjact9JfNmqaTstB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240149

Hi Bjorn,

Polite ping for the PCI patches in the series. I would appreciate any 
feedback for these patches :) .

Thanks

Farhan

On 3/16/2026 12:15 PM, Farhan Ali wrote:
> Hi,
>
> This Linux kernel patch series introduces support for error recovery for
> passthrough PCI devices on System Z (s390x).
>
> Background
> ----------
> For PCI devices on s390x an operating system receives platform specific
> error events from firmware rather than through AER.Today for
> passthrough/userspace devices, we don't attempt any error recovery and
> ignore any error events for the devices. The passthrough/userspace devices
> are managed by the vfio-pci driver. The driver does register error handling
> callbacks (error_detected), and on an error trigger an eventfd to
> userspace.  But we need a mechanism to notify userspace
> (QEMU/guest/userspace drivers) about the error event.
>
> Proposal
> --------
> We can expose this error information (currently only the PCI Error Code)
> via a device feature. Userspace can then obtain the error information
> via VFIO_DEVICE_FEATURE ioctl and take appropriate actions such as driving
> a device reset.
>
> This is how a typical flow for passthrough devices to a VM would work:
> For passthrough devices to a VM, the driver bound to the device on the host
> is vfio-pci. vfio-pci driver does support the error_detected() callback
> (vfio_pci_core_aer_err_detected()), and on an PCI error s390x recovery
> code on the host will call the vfio-pci error_detected() callback. The
> vfio-pci error_detected() callback will notify userspace/QEMU via an
> eventfd, and return PCI_ERS_RESULT_CAN_RECOVER. At this point the s390x
> error recovery on the host will skip any further action(see patch 6) and
> let userspace drive the error recovery.
>
> Once userspace/QEMU is notified, it then injects this error into the VM
> so device drivers in the VM can take recovery actions. For example for a
> passthrough NVMe device, the VM's OS NVMe driver will access the device.
> At this point the VM's NVMe driver's error_detected() will drive the
> recovery by returning PCI_ERS_RESULT_NEED_RESET, and the s390x error
> recovery in the VM's OS will try to do a reset. Resets are privileged
> operations and so the VM will need intervention from QEMU to perform the
> reset. QEMU will invoke the VFIO_DEVICE_RESET ioctl to now notify the
> host that the VM is requesting a reset of the device. The vfio-pci driver
> on the host will then perform the reset on the device to recover it.
>
>
> Thanks
> Farhan
>
> ChangeLog
> ---------
> v10 series https://lore.kernel.org/all/20260302203325.3826-1-alifm@linux.ibm.com/
> v10 -> v11
>      - Rebase on pci/next to handle merge conflicts with patch 1.
>
>      - Typo fixup in commit message (patch 4) and use guard() for mutex
>      (patch 6).
>
> v9 series https://lore.kernel.org/all/20260217182257.1582-1-alifm@linux.ibm.com/
> v9 -> v10
>     - Change pci_slot number to u16 (patch 1).
>
>     - Avoid saving invalid config space state if config space is
>     inaccessible in the device reset path. It uses the same patch as in v8
>     with R-b from Niklas.
>
>     - Rebase on 7.0.0-rc2
>
>
> v8 series https://lore.kernel.org/all/20260122194437.1903-1-alifm@linux.ibm.com/
> v8 -> v9
>     - Avoid saving PCI config space state in reset path (patch 3) (suggested by Bjorn)
>     
>     - Add explicit version to struct vfio_device_feature_zpci_err (patch 7).
>
>     - Rebase on 6.19
>
>
> v7 series https://lore.kernel.org/all/20260107183217.1365-1-alifm@linux.ibm.com/
> v7 -> v8
>     - Rebase on 6.19-rc4
>
>     - Address feedback from Niklas and Julien.
>
>
> v6 series https://lore.kernel.org/all/2c609e61-1861-4bf3-b019-a11c137d26a5@linux.ibm.com/
> v6 -> v7
>      - Rebase on 6.19-rc4
>
>      - Update commit message based on Niklas's suggestion (patch 3).
>
> v5 series https://lore.kernel.org/all/20251113183502.2388-1-alifm@linux.ibm.com/
> v5 -> v6
>     - Rebase on 6.18 + Lukas's PCI: Universal error recoverability of
>     devices series (https://lore.kernel.org/all/cover.1763483367.git.lukas@wunner.de/)
>
>     - Re-work config space accessibility check to pci_dev_save_and_disable() (patch 3).
>     This avoids saving the config space, in the reset path, if the device's config space is
>     corrupted or inaccessible.
>
> v4 series https://lore.kernel.org/all/20250924171628.826-1-alifm@linux.ibm.com/
> v4 -> v5
>      - Rebase on 6.18-rc5
>
>      - Move bug fixes to the beginning of the series (patch 1 and 2). These patches
>      were posted as a separate fixes series
> https://lore.kernel.org/all/a14936ac-47d6-461b-816f-0fd66f869b0f@linux.ibm.com/
>
>      - Add matching pci_put_dev() for pci_get_slot() (patch 6).
>
> v3 series https://lore.kernel.org/all/20250911183307.1910-1-alifm@linux.ibm.com/
> v3 -> v4
>      - Remove warn messages for each PCI capability not restored (patch 1)
>
>      - Check PCI_COMMAND and PCI_STATUS register for error value instead of device id
>      (patch 1)
>
>      - Fix kernel crash in patch 3
>
>      - Added reviewed by tags
>
>      - Address comments from Niklas's (patches 4, 5, 7)
>
>      - Fix compilation error non s390x system (patch 8)
>
>      - Explicitly align struct vfio_device_feature_zpci_err (patch 8)
>
>
> v2 series https://lore.kernel.org/all/20250825171226.1602-1-alifm@linux.ibm.com/
> v2 -> v3
>     - Patch 1 avoids saving any config space state if the device is in error
>     (suggested by Alex)
>
>     - Patch 2 adds additional check only for FLR reset to try other function
>       reset method (suggested by Alex).
>
>     - Patch 3 fixes a bug in s390 for resetting PCI devices with multiple
>       functions. Creates a new flag pci_slot to allow per function slot.
>
>     - Patch 4 fixes a bug in s390 for resource to bus address translation.
>
>     - Rebase on 6.17-rc5
>
>
> v1 series https://lore.kernel.org/all/20250813170821.1115-1-alifm@linux.ibm.com/
> v1 - > v2
>     - Patches 1 and 2 adds some additional checks for FLR/PM reset to
>       try other function reset method (suggested by Alex).
>
>     - Patch 3 fixes a bug in s390 for resetting PCI devices with multiple
>       functions.
>
>     - Patch 7 adds a new device feature for zPCI devices for the VFIO_DEVICE_FEATURE
>       ioctl. The ioctl is used by userspace to retriece any PCI error
>       information for the device (suggested by Alex).
>
>     - Patch 8 adds a reset_done() callback for the vfio-pci driver, to
>       restore the state of the device after a reset.
>
>     - Patch 9 removes the pcie check for triggering VFIO_PCI_ERR_IRQ_INDEX.
>
> Farhan Ali (9):
>    PCI: Allow per function PCI slots
>    s390/pci: Add architecture specific resource/bus address translation
>    PCI: Avoid saving config space state if inaccessible
>    PCI: Add additional checks for flr reset
>    s390/pci: Update the logic for detecting passthrough device
>    s390/pci: Store PCI error information for passthrough devices
>    vfio-pci/zdev: Add a device feature for error information
>    vfio: Add a reset_done callback for vfio-pci driver
>    vfio: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
>
>   arch/s390/include/asm/pci.h       |  29 ++++++++
>   arch/s390/pci/pci.c               |  75 +++++++++++++++++++++
>   arch/s390/pci/pci_event.c         | 106 +++++++++++++++++-------------
>   drivers/pci/host-bridge.c         |   8 +--
>   drivers/pci/pci.c                 |  26 +++++++-
>   drivers/pci/slot.c                |  31 +++++++--
>   drivers/vfio/pci/vfio_pci_core.c  |  22 +++++--
>   drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
>   drivers/vfio/pci/vfio_pci_priv.h  |   9 +++
>   drivers/vfio/pci/vfio_pci_zdev.c  |  47 ++++++++++++-
>   include/linux/pci.h               |   5 +-
>   include/uapi/linux/vfio.h         |  17 +++++
>   12 files changed, 307 insertions(+), 71 deletions(-)
>
