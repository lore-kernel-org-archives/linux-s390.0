From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
Date: Thu, 17 Jan 2019 14:02:12 +0100
Message-ID: <c5e7e9c6-15ed-99fb-3cd6-81ec8f2d3dff@linux.ibm.com>
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
 <5FC3163CFD30C246ABAA99954A238FA83928BF16@lhreml524-mbs.china.huawei.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83928BF16@lhreml524-mbs.china.huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "walling@linux.ibm.com" <walling@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 17/01/2019 10:23, Shameerali Kolothum Thodi wrote:
> Hi Pierre,
> 
>> -----Original Message-----
>> From: Pierre Morel [mailto:pmorel@linux.ibm.com]
>> Sent: 15 January 2019 17:37
>> To: gerald.schaefer@de.ibm.com
>> Cc: joro@8bytes.org; linux-s390@vger.kernel.org;
>> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
>> alex.williamson@redhat.com; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; walling@linux.ibm.com
>> Subject: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
>>
>> The s390 iommu can only allow DMA transactions between the zPCI device
>> entries start_dma and end_dma.
>>
>> Let's declare the regions before start_dma and after end_dma as
>> reserved regions using the appropriate callback in iommu_ops.
>>
>> The reserved region may later be retrieved from sysfs or from
>> the vfio iommu internal interface.
> 
> Just in case you are planning to use the sysfs interface to retrieve the valid
> regions, and intend to use that in Qemu vfio path, please see the discussion
> here [1] (If you haven't seen this already)
> 
> Thanks,
> Shameer
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03651.html
>   
>> This seems to me related with the work Shameer has started on
>> vfio_iommu_type1 so I add Alex and Shameer to the CC list.
>>
>> Pierre Morel (1):
>>    iommu/s390: Declare s390 iommu reserved regions
>>
>>   drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> --
>> 2.7.4
> 

Thanks Shameer,

Interesting discussion indeed.

AFAIK the patch series you are working on will provide a way to retrieve 
the reserved region through the VFIO IOMMU interface, using capabilities 
in the VFIO_IOMMU_GET_INFO.
Before this patch, the iommu_type1 was not able to retrieve the 
forbidden region from the s390_iommu.

See this patch is a contribution, so that these regions will appear in 
the reserved list when the VFIO_IOMM_GET_INFO will be able to report the 
information.

I am expecting to be able to to retrieve this information from the 
VFIO_IOMMU_GET_INFO syscall as soon as it is available.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
