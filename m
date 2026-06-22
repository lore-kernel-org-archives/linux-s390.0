Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A798418DB1F;
	Mon, 22 Jun 2026 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151579; cv=none; b=hi3cTKcQG6GkWuyAUFdnbCqpFQdBG5Yn7yceer3vESFs2ulzaZOwMg4l3dMpbZlFnmFdYe7q57mjbGkks2KJwf5kIgED+D92eE7SLAD7dowNjxBa4MTDa5xavze9equKr+L3utF4OPFb1qYkf7yQPl3tJYYveITchgLsTQDp9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151579; c=relaxed/simple;
	bh=jPLXENd3JR13e12DIi3Pp1yNbtoTiEHM1ElES8IPS8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t13eOAGyTgigYaQaKQqVmYJjQIzOwsg1WVmscKRlIWi03xH95u2K452EtKWItsnQqwYkvMp+oST5d8P9uBID/zXPCuhzmNfeuvvEACGmWzg6DMSfIlyhPQKSVsk6DD71y6/efFmyrUBLuTIYNMntCGBY3qof8ycm6TMxDL7Woac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VZQgoblR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VZQgoblR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmbGE3399335;
	Mon, 22 Jun 2026 18:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Fxsocm
	zuyYHEYCujXnmwAgmIQuaSFCL5Z7IW+yP4KRE=; b=VZQgoblRNIlaJbEOOrx9Eq
	6RTJAyRJ5X47JAXgysNUzsisKQiTPbLnxW1VsVLf9DwN7GxibIhb+TriOJ760Xa0
	Vh3jdiuWWsufHmyIGqcWSotdSLl/Dpv0VYB7qNnjaWjr0EGB7yAZnOH5Rz1vU4pe
	ndvm2WhHRW++HxHqNdoHhSR2fSkXndfXx242SfNz3pb6f22dtqiQm4b0pjhb7r6L
	IW+N6L59X9d82GkDB1YhCv/YIunvMoeO+DisOgC0bIMDtX+R71ciY2r4Bt+aqFCQ
	qz2PT3cUAzIQ9CF2bd6oa8VNKM9zCIUpXnLMkPrcu8ecgD3Vga81Fys5zyEoONvg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4ap2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 18:06:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MI4k75026407;
	Mon, 22 Jun 2026 18:06:14 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66jyg39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 18:06:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MI6DZQ11338402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 18:06:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15F3B58056;
	Mon, 22 Jun 2026 18:06:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C2425805D;
	Mon, 22 Jun 2026 18:06:12 +0000 (GMT)
Received: from [9.61.253.34] (unknown [9.61.253.34])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 22 Jun 2026 18:06:12 +0000 (GMT)
Message-ID: <4d576959-dbf7-4393-9179-0e31797227ca@linux.ibm.com>
Date: Mon, 22 Jun 2026 14:06:11 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] vfio-pci/zdev: Improved zPCI Function Measurement
 Support
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, alex@shazbot.org
References: <20260612181048.91548-1-oelghoul@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260612181048.91548-1-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE3NCBTYWx0ZWRfXxAYwJiWWdx8V
 TVSCJPzY9tkEShE4fCTZkwhq469fczMA+XtB7JEdrntkLb9yG38CB6H3X1F3NztkcUwkoMfm7Lh
 sDvroVnpgjXIncqFhf0fPhyD1IXbHlA=
X-Proofpoint-ORIG-GUID: k7idq4uAfFH-U15Z21URiWNfkwtbRvEl
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a397997 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=yQcrIx9_aXZK8hL8iVsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE3NCBTYWx0ZWRfXwtd6bf6+oFkl
 uz5gNbOzRLYvSjzgGZwIhoTAFu/ci72140q1eNJ+LPikrdTOHtwTykGvVeGS9bCJNN3LaeAUjsX
 sNTk5vhPjquuVdv7GLG+xFGY2QaJ1s0gpKp9vxzHoR8N8aB+BtUN8L0XVsAxbmFK6P+w2VhsVUM
 eUaa7B1UV3BUsqQPAk0dHoqWP9CHL12N/DJy6tAgxBF1QQhaOa14S0WjaJapUOyg1EWqFlRYlhG
 PKFpkl8XAK1z9GJk6UP6MnTW+B9GcaB5QSTYCTuZOsEEmd0kOoE4rjbfXMLJCHkfea5PcbnapkP
 UO4dZcwAIrTFfYxke4aNEkpuyrkBCsgZRxmGa73TameCT/n5768zuPvgsD7pa4hjiopzeFHvcQA
 VhTzpFObNQhVi7V6KWGU7XWIl8t2OClhpHLWNQl3L3AGuPPIK1U9OfM/DOi1jNLHi/XGz/GyVh1
 ANfnC3aISxMCJr4A1FQ==
X-Proofpoint-GUID: k7idq4uAfFH-U15Z21URiWNfkwtbRvEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220174

Polite ping :)

Thanks in advance.

On 6/12/26 2:10 PM, Omar Elghoul wrote:
> Hi,
> 
> This patch series improves support for function measurement for zPCI
> passthrough devices on s390x.
> 
> Changelog
> =========
> v3 -> v4:
> * Patch 2/3:
>    - Replace mutex_lock/unlock in zpci_reenable_device() with a guard
> 
> * Patch 3/4:
>    - Allow usercopy of the FMB when initializing its kmem_cache
>    - Move the guard in vfio_pci_zdev_feature_fmb_enable() lower to only
>      protect the FMB
>    - Ensure vfio_pci_zdev_feature_fmb_enable() fails on double-enable for
>      consistency with the documentation
>    - Eliminate the bounce buffer in vfio_pci_zdev_feature_fmb_read()
>    - Replace the void pointer with __aligned_u64 in the FMB read uAPI
>      structure
> 
> v2 -> v3:
> * Patch 1/4 (new patch):
>    - Fix race conditions in pcibios_enable/disable_device() with regard to
>      the FMB enable/disable
>    - Assert that fmb_lock is held within zpci_fmb_enable_device() and
>      zpci_fmb_disable_device()
> 
> * Patch 2/4 (previously 1/3):
>    - Move the FMB enable logic into a static function zpci_fmb_do_enable()
>      to reduce code duplication between zpci_fmb_enable_device() and
>      zpci_fmb_reenable_device()
>    - Reword commit message to use the imperative voice more consistently
> 
> * Patch 3/4 (previously 2/3):
>    - Split the previous VFIO feature into a SET-only and a GET-only feature
>      for enabling/disabling and reading the FMB respectively
>    - Remove FMB definitions from the VFIO uAPI and instead treat it as an
>      opaque structure
> 
> * Patch 4/4 (previously 3/3):
>    - Clarify goto label name to reduce misunderstandings
> 
> v1 -> v2:
> * Patch 1/3:
>    - Address a possible race condition in zpci_reenable_device() caused by
>      calling zpci_fmb_reenable_device() without holding fmb_lock
>    - Assert that fmb_lock is held within zpci_fmb_reenable_device()
> 
> * Patch 3/3:
>    - Address a possible race condition in pci_perf_seq_write() caused by
>      consuming zdev->kzdev without holding kzdev_lock
> 
> Motivation
> ==========
> The firmware on s390x machines allows for tracking a variety of statistics
> relating to zPCI devices in a function measurement block (FMB). However,
> the kernel currently lacks a structured mechanism of sharing this
> information with userspace, beyond /sys/kernel/debug/pci/ID/statistics.
> This can lead to shortcomings when running a guest on KVM with PCI
> passthrough devices, as QEMU is unable to provide an accurate FMB snapshot
> to the guest.
> 
> Proposal
> ========
> We propose adding a new VFIO device feature to zPCI passthrough devices,
> allowing userspace programs to read the latest FMB snapshot as it is
> written by the firmware. We ensure that function measurement enablement is
> preserved across device resets on the host. Furthermore, we guard against
> host tampering with the FMB via sysfs when the zPCI device is in
> passthrough to protect the VM's state.
> 
> I'd appreciate some feedback on these patches.
> 
> Thanks in advance.
> 
> Omar Elghoul (4):
>    s390/pci: Hold fmb_lock when enabling or disabling PCI devices
>    s390/pci: Preserve FMB state in device re-enablement
>    vfio-pci/zdev: Add VFIO FMB device features
>    s390/pci: Fence FMB enable/disable via sysfs for passthrough devices
> 
>   arch/s390/include/asm/pci.h      |   1 +
>   arch/s390/pci/pci.c              | 107 +++++++++++++++++++++++++------
>   arch/s390/pci/pci_debug.c        |  11 +++-
>   drivers/vfio/pci/vfio_pci_core.c |   4 ++
>   drivers/vfio/pci/vfio_pci_priv.h |  18 ++++++
>   drivers/vfio/pci/vfio_pci_zdev.c |  55 ++++++++++++++++
>   include/uapi/linux/vfio.h        |  29 +++++++++
>   7 files changed, 206 insertions(+), 19 deletions(-)
> 

