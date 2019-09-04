Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731263AbfIDPFg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Sep 2019 11:05:36 -0400
Subject: Re: [PATCH v2] s390: vfio-ap: remove unnecessary calls to disable
 queue interrupts
References: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
 <20190830180250.79804f76.pasic@linux.ibm.com>
 <f3e8d65e-bad4-c639-c53e-57585b90986d@de.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <206538dc-c86b-6509-78ba-7228d2eb75c9@linux.ibm.com>
Date: Wed, 4 Sep 2019 11:05:24 -0400
MIME-Version: 1.0
In-Reply-To: <f3e8d65e-bad4-c639-c53e-57585b90986d@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, freude@de.ibm.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com, frankja@linux.ibm.com, jjherne@linux.ibm.com

On 9/4/19 3:35 AM, Christian Borntraeger wrote:
> Halil,
> 
> can you also send this patch as a separate mail. This also requires a much better
> patch description about the why and it certainly should also have an agreement from
> Anthony.
> 
> On 30.08.19 18:02, Halil Pasic wrote:
>> From: Halil Pasic <pasic@linux.ibm.com>
>> Date: Fri, 30 Aug 2019 17:39:47 +0200
>> Subject: [PATCH 2/2] s390: vfio-ap: don't wait after AQIC interpretation
>>
>> Waiting for the asynchronous part of AQIC to complete as a part
>> AQIC implementation is unnecessary and silly.
>>
>> Let's get rid of vfio_ap_wait_for_irqclear().
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 50 ++-------------------------------------
>>   1 file changed, 2 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index dd07ebf..8d098f0 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -68,47 +68,6 @@ static struct vfio_ap_queue *vfio_ap_get_queue(
>>   }
>>   
>>   /**
>> - * vfio_ap_wait_for_irqclear
>> - * @apqn: The AP Queue number
>> - *
>> - * Checks the IRQ bit for the status of this APQN using ap_tapq.
>> - * Returns if the ap_tapq function succeeded and the bit is clear.
>> - * Returns if ap_tapq function failed with invalid, deconfigured or
>> - * checkstopped AP.
>> - * Otherwise retries up to 5 times after waiting 20ms.
>> - *
>> - */
>> -static void vfio_ap_wait_for_irqclear(int apqn)
>> -{
>> -	struct ap_queue_status status;
>> -	int retry = 5;
>> -
>> -	do {
>> -		status = ap_tapq(apqn, NULL);
>> -		switch (status.response_code) {
>> -		case AP_RESPONSE_NORMAL:
>> -		case AP_RESPONSE_RESET_IN_PROGRESS:
>> -			if (!status.irq_enabled)
>> -				return;
>> -			/* Fall through */
>> -		case AP_RESPONSE_BUSY:
>> -			msleep(20);
>> -			break;
>> -		case AP_RESPONSE_Q_NOT_AVAIL:
>> -		case AP_RESPONSE_DECONFIGURED:
>> -		case AP_RESPONSE_CHECKSTOPPED:
>> -		default:
>> -			WARN_ONCE(1, "%s: tapq rc %02x: %04x\n", __func__,
>> -				  status.response_code, apqn);
>> -			return;
>> -		}
>> -	} while (--retry);
>> -
>> -	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
>> -		  __func__, status.response_code, apqn);
>> -}
>> -
>> -/**
>>    * vfio_ap_free_aqic_resources
>>    * @q: The vfio_ap_queue
>>    *
>> @@ -133,14 +92,10 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
>>    * @q: The vfio_ap_queue
>>    *
>>    * Uses ap_aqic to disable the interruption and in case of success, reset
>> - * in progress or IRQ disable command already proceeded: calls
>> - * vfio_ap_wait_for_irqclear() to check for the IRQ bit to be clear
>> - * and calls vfio_ap_free_aqic_resources() to free the resources associated
>> + * in progress or IRQ disable command already proceeded :calls
>> + * vfio_ap_free_aqic_resources() to free the resources associated
>>    * with the AP interrupt handling.
>>    *
>> - * In the case the AP is busy, or a reset is in progress,
>> - * retries after 20ms, up to 5 times.
>> - *
>>    * Returns if ap_aqic function failed with invalid, deconfigured or
>>    * checkstopped AP.
>>    */
>> @@ -155,7 +110,6 @@ struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
>>   		switch (status.response_code) {
>>   		case AP_RESPONSE_OTHERWISE_CHANGED:
>>   		case AP_RESPONSE_NORMAL:
>> -			vfio_ap_wait_for_irqclear(q->apqn);

I am not sure why you consider the wait unnecessary and silly. Notice
the response code AP_RESPONSE_OTHERWISE_CHANGED above which means that
the AP queue is already disabled for interrupts or the enablement
process has not yet completed. Shouldn't we wait for the IRQ to clear
in this case? I do agree that there is no need to wait if the
response code is 0.

>>   			goto end_free;
>>   		case AP_RESPONSE_RESET_IN_PROGRESS:
>>   		case AP_RESPONSE_BUSY:
>> -- 2.5.5
> 
