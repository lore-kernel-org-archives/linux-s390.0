Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727903AbgKSOgs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 09:36:48 -0500
Subject: Re: [RFC PATCH 1/2] vfio-mdev: Wire in a request handler for mdev
 parent
References: <20201117032139.50988-1-farman@linux.ibm.com>
 <20201117032139.50988-2-farman@linux.ibm.com>
 <20201119123026.1353cb3c.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <6eb37afb-a1b4-a6e5-3b5c-e7e93489faa4@linux.ibm.com>
Date: Thu, 19 Nov 2020 09:36:43 -0500
MIME-Version: 1.0
In-Reply-To: <20201119123026.1353cb3c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 11/19/20 6:30 AM, Cornelia Huck wrote:
> On Tue, 17 Nov 2020 04:21:38 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> While performing some destructive tests with vfio-ccw, where the
>> paths to a device are forcible removed and thus the device itself
>> is unreachable, it is rather easy to end up in an endless loop in
>> vfio_del_group_dev() due to the lack of a request callback for the
>> associated device.
>>
>> In this example, one MDEV (77c) is used by a guest, while another
>> (77b) is not. The symptom is that the iommu is detached from the
>> mdev for 77b, but not 77c, until that guest is shutdown:
>>
>>      [  238.794867] vfio_ccw 0.0.077b: MDEV: Unregistering
>>      [  238.794996] vfio_mdev 11f2d2bc-4083-431d-a023-eff72715c4f0: Removing from iommu group 2
>>      [  238.795001] vfio_mdev 11f2d2bc-4083-431d-a023-eff72715c4f0: MDEV: detaching iommu
>>      [  238.795036] vfio_ccw 0.0.077c: MDEV: Unregistering
>>      ...silence...
>>
>> Let's wire in the request call back to the mdev device, so that a hot
>> unplug can be (gracefully?) handled by the parent device at the time
>> the device is being removed.
> 
> I think it makes a lot of sense to give the vendor driver a way to
> handle requests.
> 
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   drivers/vfio/mdev/vfio_mdev.c | 11 +++++++++++
>>   include/linux/mdev.h          |  4 ++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/vfio/mdev/vfio_mdev.c b/drivers/vfio/mdev/vfio_mdev.c
>> index 30964a4e0a28..2dd243f73945 100644
>> --- a/drivers/vfio/mdev/vfio_mdev.c
>> +++ b/drivers/vfio/mdev/vfio_mdev.c
>> @@ -98,6 +98,16 @@ static int vfio_mdev_mmap(void *device_data, struct vm_area_struct *vma)
>>   	return parent->ops->mmap(mdev, vma);
>>   }
>>   
>> +static void vfio_mdev_request(void *device_data, unsigned int count)
>> +{
>> +	struct mdev_device *mdev = device_data;
>> +	struct mdev_parent *parent = mdev->parent;
>> +
>> +	if (unlikely(!parent->ops->request))
> 
> Hm. Do you think that all drivers should implement a ->request()
> callback?

Hrm... Good question. Don't know the profile of other drivers; so maybe 
the unlikely() is unecessary. But probably need to check that parent is 
not NULL also, in case things are really in the weeds.

> 
>> +		return;
>> +	parent->ops->request(mdev, count);
>> +}
>> +
>>   static const struct vfio_device_ops vfio_mdev_dev_ops = {
>>   	.name		= "vfio-mdev",
>>   	.open		= vfio_mdev_open,
> 
