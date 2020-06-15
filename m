Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729682AbgFOLvF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jun 2020 07:51:05 -0400
Subject: Re: [PATCH] s390: protvirt: virtio: Refuse device without IOMMU
References: <1591794711-5915-1-git-send-email-pmorel@linux.ibm.com>
 <467d5b58-b70c-1c45-4130-76b6e18c05af@redhat.com>
 <f7eb1154-0f52-0f12-129f-2b511f5a4685@linux.ibm.com>
 <6356ba7f-afab-75e1-05ff-4a22b88c610e@linux.ibm.com>
 <a02b9f94-eb48-4ae2-0ade-a4ce26b61ad8@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <52cde80c-f33a-dbb7-d0b0-2733b3eb85c3@linux.ibm.com>
Date: Mon, 15 Jun 2020 13:50:56 +0200
MIME-Version: 1.0
In-Reply-To: <a02b9f94-eb48-4ae2-0ade-a4ce26b61ad8@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org



On 2020-06-15 05:01, Jason Wang wrote:
> 
> On 2020/6/12 下午7:38, Pierre Morel wrote:
>>
>>
>> On 2020-06-12 11:21, Pierre Morel wrote:
>>>
>>>
>>> On 2020-06-11 05:10, Jason Wang wrote:
>>>>
>>>> On 2020/6/10 下午9:11, Pierre Morel wrote:
>>>>> Protected Virtualisation protects the memory of the guest and
>>>>> do not allow a the host to access all of its memory.
>>>>>
>>>>> Let's refuse a VIRTIO device which does not use IOMMU
>>>>> protected access.
>>>>>
>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>> ---
>>>>>   drivers/s390/virtio/virtio_ccw.c | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/s390/virtio/virtio_ccw.c 
>>>>> b/drivers/s390/virtio/virtio_ccw.c
>>>>> index 5730572b52cd..06ffbc96587a 100644
>>>>> --- a/drivers/s390/virtio/virtio_ccw.c
>>>>> +++ b/drivers/s390/virtio/virtio_ccw.c
>>>>> @@ -986,6 +986,11 @@ static void virtio_ccw_set_status(struct 
>>>>> virtio_device *vdev, u8 status)
>>>>>       if (!ccw)
>>>>>           return;
>>>>> +    /* Protected Virtualisation guest needs IOMMU */
>>>>> +    if (is_prot_virt_guest() &&
>>>>> +        !__virtio_test_bit(vdev, VIRTIO_F_IOMMU_PLATFORM))
>>>>> +            status &= ~VIRTIO_CONFIG_S_FEATURES_OK;
>>>>> +
>>>>>       /* Write the status to the host. */
>>>>>       vcdev->dma_area->status = status;
>>>>>       ccw->cmd_code = CCW_CMD_WRITE_STATUS;
>>>>
>>>>
>>>> I wonder whether we need move it to virtio core instead of ccw.
>>>>
>>>> I think the other memory protection technologies may suffer from 
>>>> this as well.
>>>>
>>>> Thanks
>>>>
>>>
>>>
>>> What would you think of the following, also taking into account 
>>> Connie's comment on where the test should be done:
>>>
>>> - declare a weak function in virtio.c code, returning that memory 
>>> protection is not in use.
>>>
>>> - overwrite the function in the arch code
>>>
>>> - call this function inside core virtio_finalize_features() and if 
>>> required fail if the device don't have VIRTIO_F_IOMMU_PLATFORM.
> 
> 
> I think this is fine.
> 

Thanks,
I try this.

Regards,
Pierre




-- 
Pierre Morel
IBM Lab Boeblingen
