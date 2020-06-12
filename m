Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgFLPPZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jun 2020 11:15:25 -0400
Subject: Re: [PATCH] s390: protvirt: virtio: Refuse device without IOMMU
References: <1591794711-5915-1-git-send-email-pmorel@linux.ibm.com>
 <CAHEKYV6edAHyrW-VQtW5ufZkqpXbfd1sU9N4BqOktezdffHTsg@mail.gmail.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <56545c29-c906-0020-6727-0e35c21741f5@linux.ibm.com>
Date: Fri, 12 Jun 2020 17:15:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAHEKYV6edAHyrW-VQtW5ufZkqpXbfd1sU9N4BqOktezdffHTsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mauricio Tavares <raubvogel@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org



On 2020-06-12 15:45, Mauricio Tavares wrote:
> On Wed, Jun 10, 2020 at 12:32 PM Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>> Protected Virtualisation protects the memory of the guest and
>> do not allow a the host to access all of its memory.
>>
>> Let's refuse a VIRTIO device which does not use IOMMU
>> protected access.
>>
>        Stupid questions:

not stupid at all. :)

> 
> 1. Do all CPU families we care about (which are?) support IOMMU? Ex:
> would it recognize an ARM thingie with SMMU? [1]

In Message-ID: <6356ba7f-afab-75e1-05ff-4a22b88c610e@linux.ibm.com>
(as answer to Jason) I modified the patch and propose to take care of 
this problem by using force_dma_unencrypted() inside virtio core instead 
of a S390 specific test.

If we use force_dma_unencrypted(dev) to check if we must refuse a device 
without the VIRTIO_F_IOMMU_PLATFORM feature, we are safe:
only architectures defining CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED will 
have to define force_dma_unencrypted(dev), and they can choose what to 
do by checking the architecture functionalities and/or the device.

> 2. Would it make sense to have some kind of
> yes-I-know-the-consequences-but-I-need-to-have-a-virtio-device-without-iommu-in-this-guest
> flag?

Yes, two ways:

Never refuse a device without VIRTIO_F_IOMMU_PLATFORM, by not defining 
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED or by always return 0 in 
force_dma_unencrypted()

have force_dma_unencrypted() selectively answer by checking the device 
and/or architecture state.

> 
...snip...
>>
> 
> [1] https://developer.arm.com/architectures/system-architectures/system-components/system-mmu-support
> 

Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
