Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726540AbgGGLSA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 07:18:00 -0400
Subject: Re: [PATCH v4 1/2] virtio: let arch validate VIRTIO features
References: <1594111477-15401-1-git-send-email-pmorel@linux.ibm.com>
 <1594111477-15401-2-git-send-email-pmorel@linux.ibm.com>
 <20200707112652.42fcab80.cohuck@redhat.com>
 <afbb9979-9136-3d52-e6cb-4c6905f73b6d@de.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <8dd35508-8863-9a61-9535-5fa6f6b399fa@linux.ibm.com>
Date: Tue, 7 Jul 2020 13:17:47 +0200
MIME-Version: 1.0
In-Reply-To: <afbb9979-9136-3d52-e6cb-4c6905f73b6d@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com



On 2020-07-07 13:09, Christian Borntraeger wrote:
> 
> 
> On 07.07.20 11:26, Cornelia Huck wrote:
>> On Tue,  7 Jul 2020 10:44:36 +0200
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> An architecture may need to validate the VIRTIO devices features
>>> based on architecture specificities.
>>
>> s/specifities/specifics/

yes

>>
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   drivers/virtio/virtio.c       | 19 +++++++++++++++++++
>>>   include/linux/virtio_config.h |  1 +
>>>   2 files changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>> index a977e32a88f2..3179a8aa76f5 100644
>>> --- a/drivers/virtio/virtio.c
>>> +++ b/drivers/virtio/virtio.c
>>> @@ -167,6 +167,21 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>>>   }
>>>   EXPORT_SYMBOL_GPL(virtio_add_status);
>>>   
>>> +/*
>>> + * arch_needs_virtio_iommu_platform - provide arch specific hook when finalizing
>>
>> s/arch_needs_virtio_iommu_platform/arch_validate_virtio_features/
> 
> With the things from Conny fixed,
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
