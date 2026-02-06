Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B86426D23;
	Fri,  6 Feb 2026 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404626; cv=none; b=j7J/a8jY1aNpIXvit3w26naHITaeYDeZiKUAM7P09FQkDEcAiRTqdukK+E/rRjJO8nezzjbV8kxGpw7oDb0PnIYTmN5IwIUPxnVOzcSKTF6fRz4r8+8i5J2DTYK1KKqZqO5nhMn3GanJhSnfn2CxZLABuE82aMweZ5R+d9CIids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404626; c=relaxed/simple;
	bh=2kdCpGEK0RW4QRIr2Qu2N7HF86ohhEsoPK9DPgU5+mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/K+18sxminJKP/3QMvGcEpYjLCQ3v1kiGOxZ7aPcyExfltlaSPA584TbghAPlXsrd+aG8ZzsHk/7Kcfwqvl5Uxhr6rxjhcuahCL4R7QXl8MtixPuwUROPcRxcV1zeP6bXOGM44ByzoOHyjVGs2zBzjps4M8xNBghbvXQUGRFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dH5w/LMx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dH5w/LMx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616EuM8V021371;
	Fri, 6 Feb 2026 19:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uMJezO
	A/M9A+HeFl4CBT3frJjBA2ELn1XRI0ooUswOI=; b=dH5w/LMxIJqH4AueYp+f21
	mlI9GOiIQDMjsyPwZlORnKQqWmiuW3t562HIFcdcTJKLdrBeexKoCKz18pFxkwOL
	uzKZr7kfnKTq+1iSs9a9mJ9kH/YOajjNu3WDzM+R2RJtWPNfEFH/rbLpDHiC9/sj
	0B6ZoN+FZSvdG0Ix/AgAU+7PW0+yBXAhbtuJSDHqbhPq86ryxYZCKskexBQKy8FV
	VrVYrsL718wsoSNbSb75c4hSwVTemgvJJYxqVL+uHBMubyV+mjvZMFE3XAmsCX8g
	R19n/SBLRS4eS0e1kDeEMP7bUa4Ld/Gb3iAoAgrr7/MX2vEA6P1FhrzjVD62BLUg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6w4rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 19:03:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616FXdS9015755;
	Fri, 6 Feb 2026 19:03:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c4gsgysq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 19:03:38 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 616J3akx3015556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Feb 2026 19:03:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC39858043;
	Fri,  6 Feb 2026 19:03:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9473358053;
	Fri,  6 Feb 2026 19:03:35 +0000 (GMT)
Received: from [9.61.245.175] (unknown [9.61.245.175])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Feb 2026 19:03:35 +0000 (GMT)
Message-ID: <850b39b5-9f6f-4c1c-a83d-234c300cb7ad@linux.ibm.com>
Date: Fri, 6 Feb 2026 11:03:35 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/9] Error recovery for vfio-pci devices on s390x
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        julianr@linux.ibm.com
References: <20260122194437.1903-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260122194437.1903-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lXYzi0_oV8B4qtflDsHZbzWgWJA7s_q1
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=69863b0b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=VYs1Kb8SrcD_bOuB75gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lXYzi0_oV8B4qtflDsHZbzWgWJA7s_q1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEzOSBTYWx0ZWRfX/DrQJ3knHeeT
 sq1VYQqMq79Gyk/EK4VUHA/JWdYhqkDM4rRYyBgNqxgdH7aKK7TfhrGDDj5mJU8x+LMEhzULTlr
 fa6qD/TPkHSHL3SHijDgZAlJeJb2KqGluxGfrJcYKGDGuGZP9kdi7i3/2k+T1Ngy1dldIr1iC2t
 7baegMFBO7xBir5ut/RNRrs/y3qxhEOkUbDqoTCktheIgkFUmm5+zbOdF1DyAGEeC6kE2y/vyiB
 WUwJlfoNvBYPuRR60lvrpDgWNWne0qGD+VRycy92u/hTFlk3OheoXyRUe5XXiNiOtigIWcVDBup
 NSHTyuoU/QFBCF/0XpxjUPuDQxisFhGhNAhBN1Vc3/QAWcm3UcIFhVKhGalXSnnfREPTUhaVywu
 4D1Pzfq3l43qZQkCXO65STYhM+y0/Pmj0ZVKmOkUliQWN8lxvUWWVbGuu/1FQ7+rXNzMheDMmey
 qRnG2Gb7q+jElkXxCbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060139

Hi Bjorn/Lukas,

Polite ping on the series :) . I would appreciate some feedback on the 
PCI patches touching PCI common code. Also would it be helpful if I 
split out the PCI core patches (patches 1-4) into a separate series?

Thanks

Farhan

On 1/22/2026 11:44 AM, Farhan Ali wrote:
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
> v7 series https://lore.kernel.org/all/20260107183217.1365-1-alifm@linux.ibm.com/
> v7 - v8
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
>   arch/s390/pci/pci_event.c         | 107 +++++++++++++++++-------------
>   drivers/pci/host-bridge.c         |   8 +--
>   drivers/pci/pci.c                 |  26 +++++++-
>   drivers/pci/slot.c                |  25 ++++++-
>   drivers/vfio/pci/vfio_pci_core.c  |  22 ++++--
>   drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
>   drivers/vfio/pci/vfio_pci_priv.h  |   9 +++
>   drivers/vfio/pci/vfio_pci_zdev.c  |  46 ++++++++++++-
>   include/linux/pci.h               |   1 +
>   include/uapi/linux/vfio.h         |  16 +++++
>   12 files changed, 302 insertions(+), 65 deletions(-)
>
