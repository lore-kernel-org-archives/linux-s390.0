Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
 <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
 <20200618002956.5f179de4.pasic@linux.ibm.com>
 <20200619112051.74babdb1.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <7fe6e9ab-fd5a-3f92-1f3a-f9e6805d3730@linux.ibm.com>
Date: Mon, 29 Jun 2020 15:14:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200619112051.74babdb1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com



On 2020-06-19 11:20, Cornelia Huck wrote:
> On Thu, 18 Jun 2020 00:29:56 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Wed, 17 Jun 2020 12:43:57 +0200
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
...
>>
>> But since this can be rewritten any time, let's go with the option
>> people already agree with, instead of more discussion.
> 
> Yes, there's nothing wrong with the patch as-is.
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Thanks,


> 
> Which tree should this go through? Virtio? s390? >
>>
>> Just another question. Do we want this backported? Do we need cc stable?
> 
> It does change behaviour of virtio-ccw devices; but then, it only
> fences off configurations that would not have worked anyway.
> Distributions should probably pick this; but I do not consider it
> strictly a "fix" (more a mitigation for broken configurations), so I'm
> not sure whether stable applies.
> 
>> [..]
>>
>>
>>>   int virtio_finalize_features(struct virtio_device *dev)
>>>   {
>>>   	int ret = dev->config->finalize_features(dev);
>>> @@ -179,6 +194,13 @@ int virtio_finalize_features(struct virtio_device *dev)
>>>   	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
>>>   		return 0;
>>>   
>>> +	if (arch_needs_virtio_iommu_platform(dev) &&
>>> +		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
>>> +		dev_warn(&dev->dev,
>>> +			 "virtio: device must provide VIRTIO_F_IOMMU_PLATFORM\n");
>>
>> I'm not sure, divulging the current Linux name of this feature bit is a
>> good idea, but if everybody else is fine with this, I don't care that
> 
> Not sure if that feature name will ever change, as it is exported in
> headers. At most, we might want to add the new ACCESS_PLATFORM define
> and keep the old one, but that would still mean some churn.
> 
>> much. An alternative would be:
>> "virtio: device falsely claims to have full access to the memory,
>> aborting the device"
> 
> "virtio: device does not work with limited memory access" ?
> 
> But no issue with keeping the current message.
> 

If it is OK, I would like to specify that the arch is responsible to 
accept or not the device.
The reason why the device is not accepted without IOMMU_PLATFORM is arch 
specific.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
