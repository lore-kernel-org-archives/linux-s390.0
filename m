Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF63264EF;
	Mon,  1 Jun 2026 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332432; cv=none; b=oswNAAKKgwFJs8R3wJQOf2jdYysXuP0ZB2ucmqPB0Zpj+0BW8VQOQ+qbmXeh3D7jAZFgTiecTE7RQUPUcMESZSbaX7F3oSpcdB/3pnu6wTpKYM2nmWMn3FDCNnICGLCCXZoIjSRLp1LwJRBY4oAELOI4zIPgtqJyEhgfvXwQjGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332432; c=relaxed/simple;
	bh=tC6Mo/JAYQTMmLmX7TuLwVCsngSFj/dhYzuyCWwUA2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPnZNKp41dBZOKY82BOHv/tAjS4vgw+w4savNMvIFxJ8aa6Xvqbn5TMXGWCji37mTDtvF8XLtxDJzdynz+cMR3BRVXOWDeBPVbkE6xUBZEXxbiDedjXxF9Kx4qlBhfFdg7BZq4qgOg0b1cXkTvzSsn+642vdhF9Ix3keXM1/Xtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GVW0xf9y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GVW0xf9y"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651EYsUJ867987;
	Mon, 1 Jun 2026 16:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s+BmeI
	5xTNzMoRMydQ15AXYPMYbrPfDO7z8yS2N8hVs=; b=GVW0xf9yOr4hNPagribgfo
	j85sLLfOtW/BNiRovM1nkvv70ai9GRkjeHvxXFp6fPzQgO2xxSEV9ykf4gUidhDB
	dMd/AdubmeCFPzjYVojvZQEjs9W9XukZ38MwNw4eBMNeHM+E0Op0F5SeTgFnD+Sh
	1ll0f2qZ2faUnhuf5Q1uV+TkZIQS0FCi7NQqfzhWDWOue2yoSj6jL0ANjMQXhFq5
	956WGq8TidMVFGEe/zlL2ppZj04ZrSpJsxPrPKCoY95wtZOAbu9cB85VxQ+LTrWQ
	uC6Z7Q4v+sr/sBn9ZGy0AKCRXkBetKyIilXZzNXzi2XjQkVZMjxRSYDD/4Or/y8w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq1v32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 16:47:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Gd7bs014774;
	Mon, 1 Jun 2026 16:47:05 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7q7av2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 16:47:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651Gl4a119202626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 16:47:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 850F75805A;
	Mon,  1 Jun 2026 16:47:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0308F5805E;
	Mon,  1 Jun 2026 16:47:04 +0000 (GMT)
Received: from [9.61.244.202] (unknown [9.61.244.202])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 16:47:03 +0000 (GMT)
Message-ID: <770e5ce9-2921-4549-85d8-b9ff5ae48719@linux.ibm.com>
Date: Mon, 1 Jun 2026 09:47:03 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 0/7] Error recovery for vfio-pci devices on s390x
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260520171113.1111-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260520171113.1111-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dSfPQo96fomKr0WqCIXaop8_dxQm2pAG
X-Proofpoint-GUID: dSfPQo96fomKr0WqCIXaop8_dxQm2pAG
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1db78a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=YSX99c8Ctloknu6a8eYA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2NSBTYWx0ZWRfX4BKeNvUa/cAz
 5Z4/WX0VuxYsvbDEaf8wU3eD65ZNBPLMSPgdbdHzYcN5TavNw0mIUao7zOXN4RkmHOKSr7SvYi2
 Bl9G2WnWWZxhMtBZZmk8wGgpG08LDcaX3wdtwY86J/NGr5/UuLBZB4EjUvZLaJxGtXp6rjAhkQF
 dScHC1z94T8kaGF6xHw2TVhj27soYzkfwmMIwmet2S+LDPMqEmHUcbySu989dGe0E6IzkpK+UTe
 rFYtAfz08YfCOXrltWC4jzl2AKedx1G5L5FFq9tA7p/9bMpqQD54efj0YqiWRiLz6htdRVrRsxW
 HPjRXgB65OhvSdQJyVdQMvylqiyy30wv5YTOiSWqK20dOXU54IK4BxgKi9itOtDVtl1tau36w1p
 PxK6t6I3yHXI7EcWeoD05u1/0NLMHSMbxktao/hGOl7AIY2EIazxNIctzhgHET/KiEsc1THGfUe
 miv4JQDhcPslqbG/yBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010165

Polite ping on the series :)

Thanks

Farhan

On 5/20/2026 10:11 AM, Farhan Ali wrote:
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
> error recovery on the host will skip any further action(see patch 4) and
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
> This only includes change log from last 5 revision. Older change log is
> available in previous version cover letter.
>
> v16 https://lore.kernel.org/all/20260514180059.1553-1-alifm@linux.ibm.com/
> v16 -> v17
>     - Handle ENOMEM case and remove unnecessary mutex_unlock (patch 4).
>     - Rebase on 7.1-rc4
>
> v15 https://lore.kernel.org/all/20260505200510.2954-1-alifm@linux.ibm.com/
> v15 -> v16
>     - Implement error recovery to be handled in user space mode or host mode
>     based on checking mediated_recovery only once (suggested by Niklas).
>
>     - Rebase on 7.1-rc3
>
>
> v14 https://lore.kernel.org/all/20260421163031.704-1-alifm@linux.ibm.com/
> v14 -> v15
>     - Fix issues identified by Sashiko (patch 4).
>
>     - Address Niklas feedback (patch 4 and patch 5).
>
>     - Rebase on 7.1-rc2.
>
>
> v13 series https://lore.kernel.org/all/20260413210608.2912-1-alifm@linux.ibm.com/
> v13 -> v14
>     - Remove version from vfio uAPI struct. Instead reserve additional space
>     and add a flags field. The flags will be used to indicate any usage of
>     the reserved space (patch 5).
>
>     - Remove pending_errors from vfio uAPI struct and instead return an
>     error to indicate no more pending error for userspace to handle (patch 5).
>
>     - Rebase on recent linux master
>
> v12 series https://lore.kernel.org/all/20260330174011.1161-1-alifm@linux.ibm.com/
> v12 -> v13
>     - Add the mediated_recovery flag as part of struct zpci_ccdf_pending
>     and protect the struct with pending_errs_lock (patch 4).
>
>     - Move dequeing pending error logic to a helper function (patch 5).
>
>     - Update device feature number for VFIO_DEVICE_FEATURE_ZPCI_ERROR (patch 5).
>
>     - Rebase on linux-next with tag next-20260410
>
>
> Farhan Ali (7):
>    PCI: Allow per function PCI slots to fix slot reset on s390
>    PCI: Avoid saving config space state if inaccessible
>    PCI: Fail FLR when config space is inaccessible
>    s390/pci: Store PCI error information for passthrough devices
>    vfio-pci/zdev: Add a device feature for error information
>    vfio/pci: Add a reset_done callback for vfio-pci driver
>    vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
>
>   arch/s390/include/asm/pci.h       |  32 +++++++
>   arch/s390/pci/pci.c               |   1 +
>   arch/s390/pci/pci_event.c         | 135 +++++++++++++++++++-----------
>   drivers/pci/hotplug/rpaphp_slot.c |   2 +-
>   drivers/pci/pci.c                 |  32 ++++++-
>   drivers/pci/slot.c                |  33 ++++++--
>   drivers/vfio/pci/vfio_pci_core.c  |  22 +++--
>   drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
>   drivers/vfio/pci/vfio_pci_priv.h  |   9 ++
>   drivers/vfio/pci/vfio_pci_zdev.c  |  57 ++++++++++++-
>   include/linux/pci.h               |   8 +-
>   include/uapi/linux/vfio.h         |  30 +++++++
>   12 files changed, 289 insertions(+), 75 deletions(-)
>
