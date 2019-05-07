Return-Path: <SRS0=KhOk=TH=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 1/7] s390: vfio-ap: wait for queue empty on queue reset
References: <1556918073-13171-1-git-send-email-akrowiak@linux.ibm.com>
 <1556918073-13171-2-git-send-email-akrowiak@linux.ibm.com>
 <0bdb1655-4c4e-1982-a842-9dfc7c02a576@linux.ibm.com>
 <ecc5d1d5-a1ea-64ed-2af0-b2a6ca00d748@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 7 May 2019 10:10:41 +0200
MIME-Version: 1.0
In-Reply-To: <ecc5d1d5-a1ea-64ed-2af0-b2a6ca00d748@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <23915628-a517-1749-a0c0-e73e6e20f911@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 06/05/2019 21:37, Tony Krowiak wrote:
> On 5/6/19 2:41 AM, Pierre Morel wrote:
>> On 03/05/2019 23:14, Tony Krowiak wrote:
>>> Refactors the AP queue reset function to wait until the queue is empty
>>> after the PQAP(ZAPQ) instruction is executed to zero out the queue as
>>> required by the AP architecture.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_ops.c | 35 
>>> ++++++++++++++++++++++++++++++++---
>>>   1 file changed, 32 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>> index 900b9cf20ca5..b88a2a2ba075 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -271,6 +271,32 @@ static int vfio_ap_mdev_verify_no_sharing(struct 
>>> ap_matrix_mdev *matrix_mdev)
>>>       return 0;
>>>   }
>>> +static void vfio_ap_mdev_wait_for_qempty(unsigned long apid, 
>>> unsigned long apqi)
>>> +{
>>> +    struct ap_queue_status status;
>>> +    ap_qid_t qid = AP_MKQID(apid, apqi);
>>> +    int retry = 5;
>>> +
>>> +    do {
>>> +        status = ap_tapq(qid, NULL);
>>> +        switch (status.response_code) {
>>> +        case AP_RESPONSE_NORMAL:
>>> +            if (status.queue_empty)
>>> +                return;
>>> +            msleep(20);
>>
>> NIT:     Fall through ?
> 
> Yes
> 
>>
>>> +            break;
>>> +        case AP_RESPONSE_RESET_IN_PROGRESS:
>>> +        case AP_RESPONSE_BUSY:
>>> +            msleep(20);
>>> +            break;
>>> +        default:
>>> +            pr_warn("%s: tapq err %02x: %04lx.%02lx may not be 
>>> empty\n",
>>> +                __func__, status.response_code, apid, apqi);
>>
>> I do not thing the warning sentence is appropriate:
>> The only possible errors here are if the AP is not available due to AP 
>> checkstop, deconfigured AP or invalid APQN.
> 
> Right you are! I'll work on a new message.
> 
>>
>>
>>> +            return;
>>> +        }
>>> +    } while (--retry);
>>> +}
>>> +
>>>   /**
>>>    * assign_adapter_store
>>>    *
>>> @@ -790,15 +816,18 @@ static int vfio_ap_mdev_group_notifier(struct 
>>> notifier_block *nb,
>>>       return NOTIFY_OK;
>>>   }
>>> -static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int 
>>> apqi,
>>> -                    unsigned int retry)
>>> +int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi)
>>>   {
>>>       struct ap_queue_status status;
>>> +    int retry = 5;
>>>       do {
>>>           status = ap_zapq(AP_MKQID(apid, apqi));
>>>           switch (status.response_code) {
>>>           case AP_RESPONSE_NORMAL:
>>> +            vfio_ap_mdev_wait_for_qempty(apid, apqi);
>>> +            return 0;
>>> +        case AP_RESPONSE_DECONFIGURED:
>>
>> Since you modify the switch, you can return for all the following cases:
>> AP_RESPONSE_DECONFIGURE
>> ..._CHECKSTOP
>> ..._INVALID_APQN
>>
>>
>> And you should wait for qempty on AP_RESET_IN_PROGRESS along with 
>> AP_RESPONSE_NORMAL
> 
> If a queue reset is in progress, we retry the zapq. Are you saying we
> should wait for qempty then reissue the zapq?


Yes, I fear that if we reissue the zapq while RESET is in progress we 
could fall in a loop depending on the reset hardware time and the 
software retry .

> 
>>
>>>               return 0;
>>>           case AP_RESPONSE_RESET_IN_PROGRESS:
>>>           case AP_RESPONSE_BUSY:
>>
>> While at modifying this function, the AP_RESPONSE_BUSY is not a valid 
>> code for ZAPQ, you can remove this.
> 
> Okay
> 
>>
>>> @@ -824,7 +853,7 @@ static int vfio_ap_mdev_reset_queues(struct 
>>> mdev_device *mdev)
>>>                    matrix_mdev->matrix.apm_max + 1) {
>>>           for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>>>                        matrix_mdev->matrix.aqm_max + 1) {
>>> -            ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
>>> +            ret = vfio_ap_mdev_reset_queue(apid, apqi);
>>
>> IMHO, since you are at changing this call, passing the apqn as 
>> parameter would be a good simplification.
> 
> Okay.

Sorry, I should have add: NIT.

> 
>>
>>
>>
>>>               /*
>>>                * Regardless whether a queue turns out to be busy, or
>>>                * is not operational, we need to continue resetting
>>
>> Depends on why the reset failed, but this is out of scope.
> 
> I'm not sure what you mean by out of scope here, but you do make a valid
> point. If the response code for the zapq is AP_RESPONSE_DECONFIGURED,
> there is probably no sense in continuing to reset queues for that
> particular adapter. I'll consider a change here.

Yes, this was the point, but I consider this as a enhancement, trying a 
reset on bad queues AFAIK do no arm.

> 
>>
>>>
>>
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
