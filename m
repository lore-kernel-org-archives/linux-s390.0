From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v1] iommu/s390: Declare s390 iommu reserved regions
Date: Mon, 21 Jan 2019 12:51:14 +0100
Message-ID: <d180bb2d-354f-0d05-8773-7a196a4de3cb@linux.ibm.com>
References: <1547573850-9459-1-git-send-email-pmorel@linux.ibm.com>
 <cc070df1-e7dc-8cce-f443-879e0e5e2903@arm.com>
 <3cd790d6-aa6f-e817-27ce-56d7a9b6b6e5@linux.ibm.com>
 <668fe734-e4bf-0342-ab8c-df54d9022db4@arm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <668fe734-e4bf-0342-ab8c-df54d9022db4@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, gerald.schaefer@de.ibm.com
Cc: linux-s390@vger.kernel.org, walling@linux.ibm.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 18/01/2019 14:51, Jean-Philippe Brucker wrote:
> Hi Pierre,
> 
> On 18/01/2019 13:29, Pierre Morel wrote:
>> On 17/01/2019 14:02, Robin Murphy wrote:
>>> On 15/01/2019 17:37, Pierre Morel wrote:
>>>> The s390 iommu can only allow DMA transactions between the zPCI device
>>>> entries start_dma and end_dma.
>>>>

...

>>
>> I already posted a patch retrieving the geometry through
>> VFIO_IOMMU_GET_INFO using a specific capability for the geometry [1],
>> and AFAIU, Alex did not agree with this.
> 
> On arm we also need to report the IOMMU geometry to userspace (max IOVA
> size in particular). Shameer has been working on a solution [2] that
> presents a unified view of both geometry and reserved regions into the
> VFIO_IOMMU_GET_INFO call, and I think we should go with that. If I
> understand correctly it's currently blocked on the RMRR problem and
> we're waiting for Jacob or Ashok to take a look at it, as Kevin pinged
> them on thread [1]?
> 
> [2] https://lkml.org/lkml/2018/4/18/293
> 
> Thanks,
> Jean
> 

Hi Jean,

I hopped that this proposition went in the same direction based on the 
following assumptions:


- The goal of the get_resv_region is defined in iommu.h as:
-----
* @get_resv_regions: Request list of reserved regions for a device
-----

- A iommu reserve region is a region which should not be mapped.
Isn't it exactly what happens outside the aperture?
Shouldn't it be reported by the iommu reserved region?

- If we use VFIO and want to get all reserved region we will have the 
VFIO_IOMMU_GET_INFO call provided by Shameer and it can get all reserved 
regions depending from the iommu driver itself at once by calling the 
get_reserved_region callback instead of having to merge them with the 
aperture.

- If there are other reserved region, depending on the system 
configuration and not on the IOMMU itself, the VFIO_IOMMU_GET_INFO call 
will have to merge them with the region gotten from the iommu driver.

- If we do not use QEMU nor VFIO at all, AFAIU, the standard way to 
retrieve the reserved regions associated with a device is to call the 
get_reserved_region callback from the associated iommu.

Please tell me were I am wrong.

Regards,
Pierre


>>
>> What is different in what you propose?
>>
>> @Alex: I was hoping that this patch goes in your direction. What do you
>> think?
>>
>> Thanks,
>> Pierre
>>
>> [1]: https://lore.kernel.org/patchwork/patch/1030369/
>>
>>>
>>>>
>>>> This seems to me related with the work Shameer has started on
>>>> vfio_iommu_type1 so I add Alex and Shameer to the CC list.
>>>>
>>>>
>>>> Pierre Morel (1):
>>>>     iommu/s390: Declare s390 iommu reserved regions
>>>>
>>>>    drivers/iommu/s390-iommu.c | 29 +++++++++++++++++++++++++++++
>>>>    1 file changed, 29 insertions(+)
>>>>
>>>
>>
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
