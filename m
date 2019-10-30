Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390: vfio-ap: disable IRQ in remove callback results in
 kernel OOPS
References: <1572386946-22566-1-git-send-email-akrowiak@linux.ibm.com>
 <0565c250-726f-dd99-f933-f91162dc107e@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 30 Oct 2019 15:00:18 +0100
MIME-Version: 1.0
In-Reply-To: <0565c250-726f-dd99-f933-f91162dc107e@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-Id: <97cf7863-d6d0-418a-09c1-50d9e84fd855@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com




On 10/30/19 8:44 AM, Harald Freudenberger wrote:
> On 29.10.19 23:09, Tony Krowiak wrote:
>> From: aekrowia <akrowiak@linux.ibm.com>
>>
>> When an AP adapter card is configured off via the SE or the SCLP
>> Deconfigure Adjunct Processor command and the AP bus subsequently detects
>> that the adapter card is no longer in the AP configuration, the card
>> device representing the adapter card as well as each of its associated
>> AP queue devices will be removed by the AP bus. If one or more of the
>> affected queue devices is bound to the VFIO AP device driver, its remove
>> callback will be invoked for each queue to be removed. The remove callback
>> resets the queue and disables IRQ processing. If interrupt processing was
>> never enabled for the queue, disabling IRQ processing will fail resulting
>> in a kernel OOPS.
>>
>> This patch verifies IRQ processing is enabled before attempting to disable
>> interrupts for the queue.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Signed-off-by: aekrowia <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index be2520cc010b..42d8308fd3a1 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -79,7 +79,8 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>>   	apid = AP_QID_CARD(q->apqn);
>>   	apqi = AP_QID_QUEUE(q->apqn);
>>   	vfio_ap_mdev_reset_queue(apid, apqi, 1);
>> -	vfio_ap_irq_disable(q);
>> +	if (q->saved_isc != VFIO_AP_ISC_INVALID)
>> +		vfio_ap_irq_disable(q);
>>   	kfree(q);
>>   	mutex_unlock(&matrix_dev->lock);
>>   }
> Reset of an APQN does also clear IRQ processing. I don't say that the
> resources associated with IRQ handling for the APQN are also cleared.
> But when you call PQAP(AQIC) after an PQAP(RAPQ) or PQAP(ZAPQ)
> it is superfluous. However, there should not appear any kernel OOPS.
> So can you please give me more details about this kernel oops - maybe
> I need to add exception handler code to the inline ap_aqic() function.
>
> regards, Harald Freudenberger
>

Hi Tony,

wasn't it already solved by the patch 5c4c2126  from Christian ?

Can you send the trace to me please?

Thanks,

Pierre



-- 
Pierre Morel
IBM Lab Boeblingen
