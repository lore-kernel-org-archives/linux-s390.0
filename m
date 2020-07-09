Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18396 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgGIOvU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jul 2020 10:51:20 -0400
Subject: Re: [PATCH v5 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
References: <1594283959-13742-1-git-send-email-pmorel@linux.ibm.com>
 <1594283959-13742-3-git-send-email-pmorel@linux.ibm.com>
 <20200709105733.6d68fa53.cohuck@redhat.com>
 <270d8674-0f73-0a38-a2a7-fbc1caa44301@linux.ibm.com>
 <20200709164700.09a83069.pasic@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <c9be019f-236e-5e44-64b6-0875cd40ab11@linux.ibm.com>
Date: Thu, 9 Jul 2020 16:51:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200709164700.09a83069.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com



On 2020-07-09 16:47, Halil Pasic wrote:
> On Thu, 9 Jul 2020 12:51:58 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>>>> +int arch_validate_virtio_features(struct virtio_device *dev)
>>>> +{
>>>> +	if (!is_prot_virt_guest())
>>>> +		return 0;
>>>> +
>>>> +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
>>>> +		dev_warn(&dev->dev, "device must provide VIRTIO_F_VERSION_1\n");
>>>
>>> I'd probably use "legacy virtio not supported with protected
>>> virtualization".
>>>    
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
>>>> +		dev_warn(&dev->dev,
>>>> +			 "device must provide VIRTIO_F_IOMMU_PLATFORM\n");
>>>
>>> "support for limited memory access required for protected
>>> virtualization"
>>>
>>> ?
>>>
>>> Mentioning the feature flag is shorter in both cases, though.
>>
>> And I think easier to look for in case of debugging purpose.
>> I change it if there is more demands.
> 
> Not all our end users are kernel and/or qemu developers. I find the
> messages from v4 less technical, more informative, and way better.
> 
> Regards,
> Halil
> 

Can you please tell me the messages you are speaking of, because for me 
the warning's messages are exactly the same in v4 and v5!?

I checked many times, but may be I still missed something.

Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
