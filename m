Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB88251AFF6;
	Wed, 30 Sep 2026 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790530; cv=none; b=XrqYCERc0h/UKYJeLBhtr/JcsLrspRgnCoWFqIbUm4jhWKftd8pIS8YpwqRn/3OBe2PPLbI+h0MU7OMxGI/82fuo3M3HBJz8MuopP/5NhHynPKAhyUzwrGz5o79UINxMZE/acW/itM1JqC9ukiSqGMdiCxoPSXUhKFDBV6HuFy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790530; c=relaxed/simple;
	bh=JqBWUslX8llxI/9CNqypfUiZQmMnRYjfn+w2MQwCxzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDFwK2cexX5UZ8MCJ1+OokbW0nbUjKZrOkHfwgLhxk0KEjSgI86JPkkAC2/cfrQ6xGRytYzwxFmOWyUIO6DRTe3fjaG9w9CB5KlKetKRIX5mxqwTHuB705KS5HGGrwyWC2ct2RPd7bt1OWzMdcxra33V4g9bKVaXyJX1lg8QvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hm3Qs76Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hm3Qs76Y"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5pVI3167084;
	Wed, 30 Sep 2026 17:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bhpKuF
	emjA9e6ytUzmpGgsODeYjcJcFt9+8t+Cp/aUc=; b=Hm3Qs76Y27eWzfmECcoyNq
	zHIxN57tSw1rtXc+TAVbH6OYAbEYqMp+jHQpMemkpEpQX6TAJdaVcBhqPdbUOwsk
	4InULhi5RVlO8KT0SIK7rXARDHmBQ8oCr2Yp+I34nftaiIzkEd2bwEBd6aCi1xnG
	kiVvg+dLz3Cai2AZkw57iV9R4jY5/Xp3MyIpB9/X6pruZQLagkFXRe5wmlaJOLht
	xAyFd94gPGznJ8WWytT6CWSrmT2ucVthw8lgBPq/rsUT8dPF9u1rIJDssEw26KxW
	pf48jDS28dBMR5ArcUSOUusR+SExz16VlQ+hfqhBApFZf1+VJD4pxj4iYSr5b4Mg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptdm5e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:48:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UEI6vg3569577;
	Wed, 30 Sep 2026 17:48:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsa7np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:48:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHmh3d3146562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:48:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA8715803F;
	Wed, 30 Sep 2026 17:48:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC47358061;
	Wed, 30 Sep 2026 17:48:42 +0000 (GMT)
Received: from [9.12.71.245] (unknown [9.12.71.245])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 30 Sep 2026 17:48:42 +0000 (GMT)
Message-ID: <04c262f6-988c-4105-8578-a482036d3e3b@linux.ibm.com>
Date: Wed, 30 Sep 2026 13:48:42 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/4] vfio-pci/zdev: Improved zPCI Function Measurement
 Support
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260922195141.94548-1-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qbSvyLp5izuuCU0-PF3FavX7hjRIv1Kt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX3liLzLVpGkNc
 lk+Fh4PqfVh6qpmU80WXsqa/ZSxE/BOx8BEKfjHtAZBFWux4blIy+i5JmvF20vSWn4RG0xGsCCe
 xlxe3LUdn8U0yO4ctgZ3d8TD5zM0bnzv2tJ8zMlXLlj18q470II55gO8eSmfRvpF6n7zqoaBxUT
 Mh3kKiHtx7ovhwu5HLuWkFAHmc4caBTGZN8izCz9VPt6u9Atz2u5wB2c4kB9eV6K3TGdM8dgMr7
 wJMejof27KOFC80J8gK3QLgmsLRuh2jZrzpY9WKjKYRfKoTJdbClR1Hfx9Z2ey+9jKSBbLq2L5n
 B4nH6QsCgrgNxXl4yDLPTBKaAYz+pEJOc0XsTnnxOIBoAuAtKo3d1L5ED6G+8Y+15xT/ELUPm7Y
 I+twZ5G152TRT1v3v2lq1ojEerM+99e4+wNmifAdE4UB0Nv/0iZDLgcBkPD0WfihRWyR1juGkBt
 3v1CZTIPbOFGEOsYEWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX5au8eepatbqN
 idrqOvCcdNEfWWxeQZ6svTVrY1kdHYLemD14HJe7zSppqejxZyXiTMQjHJ4YYIEQSopa+6GsV75
 jLzDFRawqIBwodgWXwNaVQixwfAy2CE=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abd4b7d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=7vWDO2iPrCp4wXnLPUkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qbSvyLp5izuuCU0-PF3FavX7hjRIv1Kt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300070

Polite ping c:

Thanks

On 9/22/26 3:51 PM, Omar Elghoul wrote:
> Hi,
> 
> This patch series improves support for function measurement for zPCI
> passthrough devices on s390.
> 
> Changelog
> =========
> v6 -> v7:
> * Patch 2/4:
>    - Don't re-enable FMB if it wasn't already enabled
> 
> v5 -> v6:
> * Patch 2/4:
>    - Rework the FMB re-enablement code to reuse the same buffer again
>    - Make the FMB buffer persistent once allocated for as long as the
>      device's lifetime to accommodate an architectural quirk
> * Patch 4/4:
>    - Update the liveness check to use the new FMB enabled bool
> 
> v4 -> v5:
> * Typo in the cover letter
> * Swap the ordering of patches 3/4 and 4/4 to ease merging (i.e., to
>    ensure the three s390 patches are ordered before the VFIO patch)
> * Patch 2/4:
>    - Drop the refactor of zpci_fmb_enable_device() and the separation of
>      zpci_fmb_clear_iommu_ctrs() and zpci_fmb_do_enable()
>    - Allocate a new buffer in zpci_fmb_reenable_device() rather than
>      reusing the same buffer to avoid firmware edge cases
> 
> * Patch 3/4 (previously 4/4):
>    - Avoid reading from userspace while holding kzdev_lock unnecessarily
> 
> * Patch 4/4 (previously 3/4):
>    - Drop allowing usercopy of the FMB when initializing the kmem_cache
>    - Avoid copying to userspace while holding fmb_lock unnecessarily
>      - Restore the FMB bounce buffer to achieve this one
>    - Clarify uAPI documentation and ensure it accurately describes the
>      behavior of the VFIO features
> 
> v3 -> v4:
> * Patch 2/4:
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
>    s390/pci: Reuse FMB buffer and preserve state in device re-enablement
>    s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
>    vfio-pci/zdev: Add VFIO FMB device features
> 
>   arch/s390/include/asm/pci.h      |  2 +
>   arch/s390/pci/pci.c              | 85 +++++++++++++++++++++++++-------
>   arch/s390/pci/pci_debug.c        | 11 ++++-
>   drivers/vfio/pci/vfio_pci_core.c |  4 ++
>   drivers/vfio/pci/vfio_pci_priv.h | 18 +++++++
>   drivers/vfio/pci/vfio_pci_zdev.c | 60 ++++++++++++++++++++++
>   include/uapi/linux/vfio.h        | 29 +++++++++++
>   7 files changed, 191 insertions(+), 18 deletions(-)
> 

