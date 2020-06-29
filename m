Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] s390: virtio: let arch accept devices without
 IOMMU feature
References: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
 <1592390637-17441-2-git-send-email-pmorel@linux.ibm.com>
 <20200618002956.5f179de4.pasic@linux.ibm.com>
 <20200619112051.74babdb1.cohuck@redhat.com>
 <20200619140213.69f4992d.pasic@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <833c71f2-0057-896a-5e21-2c6263834402@linux.ibm.com>
Date: Mon, 29 Jun 2020 15:15:49 +0200
MIME-Version: 1.0
In-Reply-To: <20200619140213.69f4992d.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com



On 2020-06-19 14:02, Halil Pasic wrote:
> On Fri, 19 Jun 2020 11:20:51 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>>>> +	if (arch_needs_virtio_iommu_platform(dev) &&
>>>> +		!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
>>>> +		dev_warn(&dev->dev,
>>>> +			 "virtio: device must provide VIRTIO_F_IOMMU_PLATFORM\n");
>>>
>>> I'm not sure, divulging the current Linux name of this feature bit is a
>>> good idea, but if everybody else is fine with this, I don't care that
>>
>> Not sure if that feature name will ever change, as it is exported in
>> headers. At most, we might want to add the new ACCESS_PLATFORM define
>> and keep the old one, but that would still mean some churn.
>>
>>> much. An alternative would be:
>>> "virtio: device falsely claims to have full access to the memory,
>>> aborting the device"
>>
>> "virtio: device does not work with limited memory access" ?
>>
>> But no issue with keeping the current message.
> 
> I think I prefer Conny's version, but no strong feelings here.
> 


The reason why the device is not accepted without IOMMU_PLATFORM is arch 
specific, I think it should be clearly stated.
If no strong oposition...

Thanks,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
