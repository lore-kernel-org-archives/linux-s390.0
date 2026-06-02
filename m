Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A5310651;
	Tue,  2 Jun 2026 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428997; cv=none; b=YGYxIzd49n7R0iB90EkM+fzyNQYq2RW9fUe4BBjrwWs8TmpNhIwa7YFU2egbrnoBpQo7GNGcP4uNuUlC9Fj3uVCIfSOm0iHCR4S3Ake9+PbPmKS+DNqEQYnLOLQ2RwgdWYkURSZzbsVbdVzpze0xD8Dh17v6DkDJNEPrq5OU1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428997; c=relaxed/simple;
	bh=Etb9LqmxcfSQA7XtpVFzX4KGMspDJ5lBTdsCMUsiqbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYalPPii+B673tAXtsSzjdMwtxswamDwnE539p9TRjG0l3wxdIeVoHgTFXwJcVJhYtzxb2qyThPw1GDO+o86m1yk77GZIhTq36Xp86CkI9IOiuIEWl4PD1o9Tg7EuBVfrpbEirh0t/vSQfkFzX9OYY3HJjjJDWttC8v3TdV99sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TyxJS5cT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TyxJS5cT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652HRGne1773281;
	Tue, 2 Jun 2026 19:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HhuSRH
	qDSxIbcSvpRdQesxfGdtEyVztezjhKlfFXjXg=; b=TyxJS5cTPZmA2psMjZnjoy
	g/hwbN6RPKkhpG/Fbu+HqiaVFhCqrhMpaWTS3PaJt1yKkiEwHZeqTHCuUcYEjeae
	Xob9pGaxyJFF/9ENNmdny7zOlezMVsIYjLf9ho9ejA8WBQ0WAxxjtAweGyxnckeW
	NLUsCl7GVOlvuqh1EtejaZXc0T7AOGLnFrRkxSHECfD+tpEM4B8Bp6/RtD6WQ6PT
	78Y0ddq2rSZUa2WyS3jml3TIEiMWDe9m0inlUV5+bCug5Z/A4PREvh8GSmUI4Qwh
	rFH68Qfygq5/2+D6L/J+FJL5yS3kP0rM9fmIURSFetTWEJWxrcvff4M9fZ1O3JXA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd47ra4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 19:36:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652JO7qI008242;
	Tue, 2 Jun 2026 19:36:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwycjnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 19:36:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652JaUPo30933674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 19:36:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D63355805C;
	Tue,  2 Jun 2026 19:36:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A312658054;
	Tue,  2 Jun 2026 19:36:29 +0000 (GMT)
Received: from [9.12.78.81] (unknown [9.12.78.81])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 19:36:29 +0000 (GMT)
Message-ID: <bda40f9c-7187-4382-b421-334b04c05e1e@linux.ibm.com>
Date: Tue, 2 Jun 2026 15:36:28 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] vfio-pci/zdev: Improved zPCI Function Measurement
 Support
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, alex@shazbot.org
References: <20260519224204.19154-1-oelghoul@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260519224204.19154-1-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE5MCBTYWx0ZWRfX2+C8tS0fflhT
 tOZWf2ohMdGEHnndeR16tkv06v0cr0YzDUcoKXmKwT35WY43UHw9doxrIZP/iJnWahoHi18KGo4
 /regxmOKbgXW+ShZqJLokEaq5m059Pc+FtzsIaiJXzZK3tO0L2E3W15a/z7d2JXYonSvVJsKv5R
 9soSITecL7RmBc2pxctXvBYSESbziw2BwfCPHBnm1WZesPrYrCk63ziuLYhA6FOawXZEiz+C+fc
 j0Rlu6yFIC5O7hoynko0BhHQ1xzgcGZ5TpT+o7TYClHLM9yXAV3rRUuC6kkIw+hEq6Ufm4j8rd5
 NwhPEimOrBr2+K7U4jfFjZb/EvhJqZP+2Po1UVqfGf/zl4b68CB6LHNSGLbdtr7wMikN/IguVtv
 7HlWtH5qHHanI02l+s3kafwSsn2i51+5/ZB7EeZgO44l5H97qpJCeHLHGLXnyi9RpzAHfGbQZ+G
 FXYckSlaaa2R5UWuVCQ==
X-Proofpoint-GUID: jdP1_4RBYd-8uY4DNu9q659hls5k2pSE
X-Proofpoint-ORIG-GUID: jdP1_4RBYd-8uY4DNu9q659hls5k2pSE
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1f30c0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=J6ZS_3muYHgI6I3YJNIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020190

Hi,

Gently pinging the series in case it has fallen out of your radars.

Thanks.

On 5/19/26 6:42 PM, Omar Elghoul wrote:
> Hi,
>
> This patch series improves support for function measurement for zPCI
> passthrough devices on s390x.
>
> Changelog
> =========
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
> Omar Elghoul (3):
>    s390/pci: Preserve FMB state in device re-enablement
>    vfio-pci/zdev: Add VFIO FMB device feature
>    s390/pci: Fence FMB enable/disable via sysfs for passthrough devices
>
>   arch/s390/include/asm/pci.h      |  1 +
>   arch/s390/pci/pci.c              | 75 ++++++++++++++++++++++++-------
>   arch/s390/pci/pci_debug.c        | 11 ++++-
>   drivers/vfio/pci/vfio_pci_core.c |  2 +
>   drivers/vfio/pci/vfio_pci_priv.h |  9 ++++
>   drivers/vfio/pci/vfio_pci_zdev.c | 77 ++++++++++++++++++++++++++++++++
>   include/uapi/linux/vfio.h        | 43 ++++++++++++++++++
>   7 files changed, 202 insertions(+), 16 deletions(-)
>
