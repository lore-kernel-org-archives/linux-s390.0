Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0431F19A;
	Thu,  8 Aug 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136761; cv=none; b=i6YOssLe2iodo/Tqp3WzRHKhW/qVBD+mePhoKMJU2umE1t5ayT9eD3m5qNXtplqlKbfELWmIrTET+NyyyQLa5thY8QltM8ZYw8UgIys8Z5OgMXNpwAynITh+/831OymrTS8rlUbIwmv3BkyONbli2WykQyYnTmgMMAYAGooHcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136761; c=relaxed/simple;
	bh=KKt5dGvczCSpcSGyLA/w7pIAU09EpP5zg7eXHigoRlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NimsTXZfspkMMXanAXFsYvl/rXIPOXX1zFzCySCYaDtrqEWyULQqH2oQYBAJamsGDQXUV6XKPu7wox2sDQHlKErEm2jRL73Y9NCm5YhSN73ZtLPOeE8OlAxokhMJGChixk8IBL9s+/vgdPebo5+6I768V3pRCp6W54M9y7eMIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JRFA6P+/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JRFA6P+/"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478CaYl2010832;
	Thu, 8 Aug 2024 17:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=C
	jICzhJg3JDGr91/MDwlUKmoReoHKNNM1dLXQCMAeJ0=; b=JRFA6P+/f6zZ5lht5
	xwBN2StyAPPAdN9v8NeJg6H9WJxzgdTFvxH1bnXVR3LCfl1qmY13xIl0r41ApRfz
	D4gaVeTxOMOjKYpEK3EY3E25tpXp014flrz7fXnC8hDZRTVmdb4tP5ltltrm9jvm
	j6D83z3TUbZjF70fJ904Q1STyBMFlib430onrqOkBkEZv67yRSrmr7Q68iS91Doq
	2sthotw2HU4OkpJxM4yY3Hoicv33643KW/rV7VdDFi1RI6TIbwi33kbu94TMKFl3
	pjo5HBU4kkfBKwCSMfwGPq2KcFcbbn3mZNr+Pb25m3K1JYtAAqKZ0fs4XXSmbVj/
	+m4mg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkbgr7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 17:05:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 478GmmZR030238;
	Thu, 8 Aug 2024 17:05:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t1k3eyt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 17:05:42 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 478H5cuG7799314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Aug 2024 17:05:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B51A558065;
	Thu,  8 Aug 2024 17:05:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0323158068;
	Thu,  8 Aug 2024 17:05:37 +0000 (GMT)
Received: from [9.61.42.196] (unknown [9.61.42.196])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Aug 2024 17:05:36 +0000 (GMT)
Message-ID: <0abe7286-ae33-4637-b0ea-f1f2e352eb21@linux.ibm.com>
Date: Thu, 8 Aug 2024 13:05:36 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/s390: Implement blocking domain
To: Jason Gunthorpe <jgg@ziepe.ca>, Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20240806-blocking_domain-v1-1-8abc18e37e52@linux.ibm.com>
 <20240808134451.GC1985367@ziepe.ca>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20240808134451.GC1985367@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MfO4kFm-HwXWXQ0cGAKeSoUKnYj2i1CD
X-Proofpoint-ORIG-GUID: MfO4kFm-HwXWXQ0cGAKeSoUKnYj2i1CD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_17,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=925 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080118

On 8/8/24 9:44 AM, Jason Gunthorpe wrote:
> On Tue, Aug 06, 2024 at 03:45:15PM +0200, Niklas Schnelle wrote:
>> This fixes a crash when surprise hot-unplugging a PCI device. This crash
>> happens because during hot-unplug __iommu_group_set_domain_nofail()
>> attaching the default domain fails when the platform no longer
>> recognizes the device as it has already been removed and we end up with
>> a NULL domain pointer and UAF.
> 
> Huh?
> 
> A device can't be removed before telling the iommu subsystem about
> it. How did the domain become NULL asynchronously while the iommu side
> thought it was still alive?? That seems like the main bug here..
> 

Nilkas is away for a while, so I'll take this over -- So, peeling back the onion on this patch, it's actually trying to solve a few things simultaneously. 

Since c76c067e488c ("s390/pci: Use dma-iommu layer"), we stopped checking for a NULL zdev->s390_domain during s390_iommu_release_device.  This causes a crash specifically if the last attach_device call failed (we exit on -EIO with a NULL zdev->s390_domain).  I suppose we could also fix the specific crash by restoring the NULL check in s390_iommu_release_device, but this seems like a band-aid and I'm concerned that there's more lurking here when get to this state...  So instead implementing the blocking domain ensures we always fall back to it when attach fails, so we no longer can have that NULL pointer during iommu_release_device / always have at bare-minimum the blocked domain attached (once I address your probe_device comment below).


>> Note: I somewhat suspect this to be related to the following discussion
>> or at least we have seen the same backtraces in reports that we suspect
>> to be caused by the issue fixed with this patch.
> 
> No, it shouldn't be. That bug is because the netstack is continuing to
> use a struct device with the DMA API after the device driver has been
> removed. That is just illegal.> 

I wonder if the presence of a blocking domain masks it somehow.  We just happened to notice that we were unable to reproduce a similar backtrace once a blocking domain was implemented;  I'll have to go back to the repro scenario and have a closer look.

>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index ed6c5cb60c5a..91b3b23bf55c 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -119,8 +119,11 @@ static int __iommu_group_set_domain(struct iommu_group *group,
>>  static void __iommu_group_set_domain_nofail(struct iommu_group *group,
>>  					    struct iommu_domain *new_domain)
>>  {
>> -	WARN_ON(__iommu_group_set_domain_internal(
>> -		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
>> +	int ret = __iommu_group_set_domain_internal(
>> +		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>> +
>> +	/* Allow attach to fail when the device is gone */
>> +	WARN_ON(ret && ret != -ENODEV);
>>  }
> 
> Like this doesn't really make sense. Until the iommu subystem removes
> the device from the group it really cannot be "gone".
 
The device isn't actually gone from the perspective of the kernel so much as known to be in the process of going way / in a state where we know that DMA is no longer possible.

> The hypervisor could fail attachment because the hypervisor has
> already fenced the device. Sure, that make sense, but it is not really
> that the device is gone from a Linux perspective, it is just now in a
> forced-blocked state.

Yes.  So, once we implement the blocking domain, no more crashes and we always fall back to the static blocking domain.  But, if the device were unceremoniously switched off while bound to vfio we would still get WARNed from __iommu_group_set_domain_nofail, because attempts to hand the device back from vfio->dma-iommu (e.g. _iommu_release_dma_ownership) are unable to attach the requested default domain and instead fall back to the blocking domain because we've effectively already fenced the device.  That is specifically what this change to drivers/iommu/iommu.c was attempting to resolve.

What about we fix the crash and implement the s390 blocking domain with this patch but drop this change to drivers/iommu/iommu.c.  This leaves us still hitting WARNs in this case for now, but then I would still like to try to sort that out as a follow-on so that we eventually can handle this DMA-owned+force-blocked scenario cleanly.

> 
> Like Lu says, if we need to add a new flow for devices that are now
> force-blocking and cannot be changed then it will need its own error
> code.
Makes sense.

> 
> But what is the backtrace that runs into this warn on? VFIO exiting
> and trying to put the device back to the DMA API?

Yes, exactly

[  198.067373] ------------[ cut here ]------------
[  198.067377] WARNING: CPU: 44 PID: 394 at drivers/iommu/iommu.c:122 __iommu_release_dma_ownership+0x72/0x80
[  198.067386] Modules linked in: macvtap macvlan tap vfio_pci vfio_pci_core irqbypass kvm sunrpc s390_trng eadm_sch tape_34xx tape tape_class vfio_ccw mdev vfio_iommu_type1 vfio zcrypt_cex4 sch_fq_codel loop configfs nfnetlink lcs ctcm fsm ghash_s390 prng chacha_s390 libchacha aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 nvme sha512_s390 sha256_s390 nvme_core sha1_s390 sha_common zfcp scsi_transport_fc 8021q garp pkey zcrypt rng_core autofs4
[  198.067424] CPU: 44 UID: 0 PID: 394 Comm: kmcheck Not tainted 6.11.0-rc2 #111
[  198.067427] Hardware name: IBM 3906 M05 780 (LPAR)
[  198.067429] Krnl PSW : 0704c00180000000 000002bbfc744576 (__iommu_release_dma_ownership+0x76/0x80)
[  198.067433]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[  198.067437] Krnl GPRS: 0000000000000290 0000000000000000 fffffffffffffffb 000001b386842098
[  198.067439]            0000000000000000 000001b3865b5c00 000000000000255b 000002bb7c586068
[  198.067442]            000001b3ab82a018 000001b7ff0af6c0 000001b5d0e4af68 000001b5d0e4af00
[  198.067444]            000001b389772300 0000023bffe33e28 000002bbfc744560 0000023bffe339d0
[  198.067452] Krnl Code: 000002bbfc744568: f0a0000407fe	srp	4(11,%r0),2046,0
                          000002bbfc74456e: 47000700		bc	0,1792
                         #000002bbfc744572: af000000		mc	0,0
                         >000002bbfc744576: a7f4fff8		brc	15,000002bbfc744566
                          000002bbfc74457a: 0707		bcr	0,%r7
                          000002bbfc74457c: 0707		bcr	0,%r7
                          000002bbfc74457e: 0707		bcr	0,%r7
                          000002bbfc744580: c0040025f71c	brcl	0,000002bbfcc033b8
[  198.067468] Call Trace:
[  198.067482]  [<000002bbfc744576>] __iommu_release_dma_ownership+0x76/0x80 
[  198.067486] ([<000002bbfc744560>] __iommu_release_dma_ownership+0x60/0x80)
[  198.067488]  [<000002bbfc7445b8>] iommu_group_release_dma_owner+0x38/0x50 
[  198.067491]  [<000002bb7c2a1e24>] vfio_group_detach_container+0x154/0x180 [vfio] 
[  198.067500]  [<000002bb7c2a0d88>] vfio_device_remove_group+0xd8/0x140 [vfio] 
[  198.067505]  [<000002bb7c5648b4>] vfio_pci_core_unregister_device+0x34/0x80 [vfio_pci_core] 
[  198.067513]  [<000002bb7c5841cc>] vfio_pci_remove+0x2c/0x40 [vfio_pci] 
[  198.067517]  [<000002bbfc6ec7bc>] pci_device_remove+0x3c/0x90 
[  198.067520]  [<000002bbfc75dda4>] device_release_driver_internal+0x1b4/0x260 
[  198.067527]  [<000002bbfc6e2844>] pci_stop_bus_device+0x94/0xc0 
[  198.067531]  [<000002bbfc6e2b66>] pci_stop_and_remove_bus_device+0x26/0x40 
[  198.067534]  [<000002bbfc6e2bb0>] pci_stop_and_remove_bus_device_locked+0x30/0x40 
[  198.067537]  [<000002bbfbde2838>] zpci_bus_remove_device+0x68/0xb0 
[  198.067541]  [<000002bbfbde0780>] __zpci_event_availability+0x250/0x3a0 
[  198.067543]  [<000002bbfc7e4528>] chsc_process_crw+0x2a8/0x2c0 
[  198.067548]  [<000002bbfc7ec690>] crw_collect_info+0x2e0/0x360 
[  198.067550]  [<000002bbfbe15bde>] kthread+0x11e/0x130 
[  198.067556]  [<000002bbfbd930ec>] __ret_from_fork+0x3c/0x60 
[  198.067558]  [<000002bbfcb233aa>] ret_from_fork+0xa/0x38 
[  198.067564] Last Breaking-Event-Address:
[  198.067565]  [<000002bbfc744560>] __iommu_release_dma_ownership+0x60/0x80
[  198.067569] ---[ end trace 0000000000000000 ]---



> 
> Though I feel like more is needed here if you expect to allow the
> nofail version of this to actually fail.. For instance a force-blocked
> device should block driver binding through the dma_owner APIs.

Yeah, that makes sense too. 

> 
>> +static int blocking_domain_attach_device(struct iommu_domain *domain,
>> +					 struct device *dev)
>> +{
>> +	struct s390_domain *s390_domain = to_s390_domain(domain);
>> +	struct zpci_dev *zdev = to_zpci_dev(dev);
>> +	unsigned long flags;
>> +
>> +	if (!zdev)
>> +		return 0;
>> +
>> +	/* Detach sets the blocking domain */
>> +	if (zdev->s390_domain)
>> +		s390_iommu_detach_device(&zdev->s390_domain->domain, dev);
> 
> When I've done these conversions on other drivers it was the case that
> zdev->s390_domain is never NULL. Instead probe_device immediately
> starts it as a blocking_domain or fails to probe.

Good point, I'll look at setting in probe.

> 
> This way we don't ever have the ill defined notion of NULL here.
> 
>> @@ -777,6 +812,8 @@ static int __init s390_iommu_init(void)
>>  subsys_initcall(s390_iommu_init);
>>  
>>  static const struct iommu_ops s390_iommu_ops = {
>> +	.blocked_domain		= &s390_blocking_domain.domain,
>> +	.release_domain		= &s390_blocking_domain.domain,
> 
> If you set release_domain then remove s390_iommu_release_device(), it
> is the same code.
> 

Oh I see, via blocking_domain_attach_device.  Agree

