Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105751;
	b=gknHU2mgzdi3AMc455DKkF05gLoE9V98W9013cdcybPcz0lM+a1UYeuQJ0yF4ZipYlin
	 coP7RKrf9y3/FLOmKw4a2e9+mAxxfOQRDZ2gYsd8YgTKBaEc/cKYsDjTUS/Un7au1yB4A
	 jI47UrD4Yxgs/gP4mZnj8fvXs3vPJyabvcmYpwyad2tdFMzQUFnq3Mx9CqOiQjVhhRd6u
	 hWP2ALCnn85SQpJHOIVxU8HVuHgE5piTTzrg4rrdEC8YAKzwV8y0ZBRezWOfD7k8oAnIG
	 9jFX5y31epttU5o9WUxXHqFhQ5ejy7tihZ1pc1f9PI3ef/YAsCko+qn6PqR77YGXZ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105751;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=V4Ti7QECuOCWcX8sxonoOjHmQwctYghDJX9WWm8VVNI=;
	b=MY8sQ5130an4rMoNQe0WQM/zo0TD3XXmSrDPx5pZA5sfhvrhypjCUBxnBRRZat8B2qvm
	 GpHSwZw5HL5z4SAiyXtO+mG5bs3zw3S9vz7gZFjA8Ns06TVmUM2E83qFnJ6suv//b/2W2
	 iJG8r9mYUaf9xhlnEC2EHp6PkNJtuBk50OlJd/2xSz1BtSuqpm1RKwcnPEl8dtQG2XZUG
	 hm1RMXUfxotBiBgA2smUucUpvXd45PsUBWu81gFBQfRyQx/xf8R9xxoln8Ya0Sbxb9FyO
	 Xe2mGk7gxRxn2juzLp2DMccsUshzwP5K0wZGlwTzi3rnxNu/D2lRpmAGJdVHbbO0IaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qiziYuPp;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2864606A32F;
	Thu, 19 Nov 2026 16:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2864606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qiziYuPp
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJFQNVh321020;
	Thu, 19 Nov 2026 16:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=V4Ti7QECuOCWcX8sxonoOjHmQwctYg
	hDJX9WWm8VVNI=; b=qiziYuPp/8gMtQadrq4m7u3Sd3LmUc50O6WMCNNcj1TbU+
	FtjgvgAizYfNoyer4A0QcaHUKzuAQUj4DNyE44VBPUKFxjW+OEORIw4SY43uYI/M
	hGOtEStL/EeLC38SZhLDwwvg0l+Aahvr6ixcUcCWpVWKN1yr2YVOlUTdx4WZY4+C
	89EmPQo16BO8wxRh2JH08RHaodVSiiAVNaJhBToxpU0WwGikoKK6aoxSBdPflPB8
	CwjiTxYKU+FD2AuTPgsszWc1E17lGfvoN58zVsX15s9VWTdnLJR1LlYINhzFNAJX
	6ovt+foBabVzUOzaoX2Wc0WWzafTpWz9dVAztvOw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x269m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 16:29:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJF5xOi1052573;
	Thu, 19 Nov 2026 16:29:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6wen4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 16:29:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJGT3jN48365874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 16:29:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4124E20040;
	Thu, 19 Nov 2026 16:29:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0ABA22004E;
	Thu, 19 Nov 2026 16:29:03 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.68.17.117])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 19 Nov 2026 16:29:02 +0000 (GMT)
Date: Thu, 19 Nov 2026 17:29:01 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, Alex Williamson <alex@shazbot.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: Re: [PATCH v13 0/5] vfio-pci/zdev: Improved zPCI Function
 Measurement Support
Message-ID: <05ba9f68-58b7-4629-9a9b-cb87fcd7eb99-agordeev@linux.ibm.com>
References: <20261111162758.9792-1-oelghoul@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111162758.9792-1-oelghoul@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hvoxb-symRQX-A7gLBaP2Lkq-5dbk8Tg
X-Proofpoint-GUID: hvoxb-symRQX-A7gLBaP2Lkq-5dbk8Tg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2NSBTYWx0ZWRfX4dMlUVSvvldS
 aNYqRuogeLOw6Kh41bLqNlEH5dLVImjP11qwxHmC1uc11wSN5hLp98X15H/SPDvGQcY9O41LDzr
 qgNNCY+TeDGZprvrIVyB24H27F+Co9gXcrEkOXv4bYDao7cp3zkRGAXg3Cd/3Pz9c9YFILxTVJj
 h4MIbN+wWDIv4vSbAuHghIqKdUkpg2OfOyV5iRIbx7an812xRoiX3192fopQpQVNb3jT5ql/Ida
 O5xEAVtctSKgYhHUTlDQSsGPQNAvqi+n/8yFqmygPNruNzuozquj3mU6h1jizkCYqoVH6F0k2jl
 RUmgAZJ7V0XU3DI5mAgNAXIASbHLYemNvOW9hE1FzsHxaQKSvS+FASTrnrQC0JN/soBu9vF/U1J
 MGU0grY0q0jSoLE6p0QWU5XZqgLh51PRjy14tvv6yfewp8LHOad8l3na54vRBxoVyQNJ9GYHJOR
 ggP5ru9jqpQbUjO7g7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2NSBTYWx0ZWRfX9ll3nMZHJZDi
 kqwi5WBexg6Ns4FSE5XG0sO/DmGixhUEJghhzbvsS/UEuvc1MaJJmyiFnZwIWDcZFVeLDcJtc5h
 G/4UvblJovOaNOmFYgqcHXzz5GY8PgA=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6aff23d4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=_RPdNGorA9cjcCUAOnoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190065

On Wed, Nov 11, 2026 at 11:27:53AM -0500, Omar Elghoul wrote:
> This patch series improves support for function measurement for zPCI
> passthrough devices on s390.
...
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
> Omar Elghoul (5):
>   s390/pci: Hold fmb_lock when enabling or disabling PCI devices
>   s390/pci: Improve function measurement state management
>   s390/pci: Improve FMB memory management
>   s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
>   vfio-pci/zdev: Add VFIO FMB device features
> 
>  arch/s390/include/asm/pci.h      |   8 +-
>  arch/s390/pci/pci.c              | 123 +++++++++++++++++++++++--------
>  arch/s390/pci/pci_debug.c        |  15 +++-
>  drivers/vfio/pci/vfio_pci_core.c |   4 +
>  drivers/vfio/pci/vfio_pci_priv.h |  18 +++++
>  drivers/vfio/pci/vfio_pci_zdev.c |  64 ++++++++++++++++
>  include/uapi/linux/vfio.h        |  30 ++++++++
>  7 files changed, 226 insertions(+), 36 deletions(-)

Applied and put on a branch, as agreed:

git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git zpci-meas-enh

Thanks!

