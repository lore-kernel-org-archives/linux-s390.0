Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730064AbfISU4L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Sep 2019 16:56:11 -0400
Subject: Re: [PATCH v4 3/4] vfio: zpci: defining the VFIO headers
References: <1567815231-17940-1-git-send-email-mjrosato@linux.ibm.com>
 <1567815231-17940-4-git-send-email-mjrosato@linux.ibm.com>
 <20190919172009.71b1c246.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <0a62aba7-578a-6875-da4d-13e8b145cf9b@linux.ibm.com>
Date: Thu, 19 Sep 2019 16:55:57 -0400
MIME-Version: 1.0
In-Reply-To: <20190919172009.71b1c246.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: sebott@linux.ibm.com, gerald.schaefer@de.ibm.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, kvm@vger.kernel.org, heiko.carstens@de.ibm.com, robin.murphy@arm.com, gor@linux.ibm.com, pmorel@linux.ibm.com

On 9/19/19 11:20 AM, Cornelia Huck wrote:
> On Fri,  6 Sep 2019 20:13:50 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> From: Pierre Morel <pmorel@linux.ibm.com>
>>
>> We define a new device region in vfio.h to be able to
>> get the ZPCI CLP information by reading this region from
>> userland.
>>
>> We create a new file, vfio_zdev.h to define the structure
>> of the new region we defined in vfio.h
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>  include/uapi/linux/vfio.h      |  1 +
>>  include/uapi/linux/vfio_zdev.h | 35 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 36 insertions(+)
>>  create mode 100644 include/uapi/linux/vfio_zdev.h
>>
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 8f10748..8328c87 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -371,6 +371,7 @@ struct vfio_region_gfx_edid {
>>   * to do TLB invalidation on a GPU.
>>   */
>>  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
>> +#define VFIO_REGION_SUBTYPE_ZDEV_CLP		(2)
> 
> Using a subtype is fine, but maybe add a comment what this is for?
> 

Fair point.  Maybe something like "IBM ZDEV CLP is used to pass zPCI
device features to guest"

>>  
>>  /*
>>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>> diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
>> new file mode 100644
>> index 0000000..55e0d6d
>> --- /dev/null
>> +++ b/include/uapi/linux/vfio_zdev.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Region definition for ZPCI devices
>> + *
>> + * Copyright IBM Corp. 2019
>> + *
>> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
>> + */
>> +
>> +#ifndef _VFIO_ZDEV_H_
>> +#define _VFIO_ZDEV_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/**
>> + * struct vfio_region_zpci_info - ZPCI information.
> 
> Hm... probably should also get some more explanation. E.g. is that
> derived from a hardware structure?
> 

The structure itself is not mapped 1:1 to a hardware structure, but it
does serve as a collection of information that was derived from other
hardware structures.

"Used for passing hardware feature information about a zpci device
between the host and guest" ?

>> + *
>> + */
>> +struct vfio_region_zpci_info {
>> +	__u64 dasm;
>> +	__u64 start_dma;
>> +	__u64 end_dma;
>> +	__u64 msi_addr;
>> +	__u64 flags;
>> +	__u16 pchid;
>> +	__u16 mui;
>> +	__u16 noi;
>> +	__u16 maxstbl;
>> +	__u8 version;
>> +	__u8 gid;
>> +#define VFIO_PCI_ZDEV_FLAGS_REFRESH 1
>> +	__u8 util_str[];
>> +} __packed;
>> +
>> +#endif
> 
> 
