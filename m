Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728918AbfIEQ0Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Sep 2019 12:26:24 -0400
Subject: Re: [PATCH v2] s390: vfio-ap: remove unnecessary calls to disable
 queue interrupts
References: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
 <20190830180250.79804f76.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <839467aa-5743-3d56-44e2-05ba5533a31c@linux.ibm.com>
Date: Thu, 5 Sep 2019 12:26:15 -0400
MIME-Version: 1.0
In-Reply-To: <20190830180250.79804f76.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, freude@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com, frankja@linux.ibm.com, jjherne@linux.ibm.com

On 8/30/19 12:02 PM, Halil Pasic wrote:
> On Mon, 19 Aug 2019 13:48:49 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> When an AP queue is reset (zeroized), interrupts are disabled. The queue
>> reset function currently tries to disable interrupts unnecessarily. This patch
>> removes the unnecessary calls to disable interrupts after queue reset.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 0604b49a4d32..e3bcb430e214 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -1114,18 +1114,19 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>   	return NOTIFY_OK;
>>   }
>>   
>> -static void vfio_ap_irq_disable_apqn(int apqn)
>> +static struct vfio_ap_queue *vfio_ap_find_qdev(int apqn)
>>   {
>>   	struct device *dev;
>> -	struct vfio_ap_queue *q;
>> +	struct vfio_ap_queue *q = NULL;
>>   
>>   	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>>   				 &apqn, match_apqn);
>>   	if (dev) {
>>   		q = dev_get_drvdata(dev);
>> -		vfio_ap_irq_disable(q);
>>   		put_device(dev);
>>   	}
>> +
>> +	return q;
>>   }
>>   
>>   int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>> @@ -1164,6 +1165,7 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>>   	int rc = 0;
>>   	unsigned long apid, apqi;
>>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +	struct vfio_ap_queue *q;
>>   
>>   	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
>>   			     matrix_mdev->matrix.apm_max + 1) {
>> @@ -1177,7 +1179,18 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>>   			 */
>>   			if (ret)
>>   				rc = ret;
>> -			vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
>> +
>> +			/*
>> +			 * Resetting a queue disables interrupts as a side
>> +			 * effect, so there is no need to disable interrupts
>> +			 * here. Note that an error on reset indicates the
>> +			 * queue is inaccessible, so an attempt to disable
>> +			 * interrupts would fail and is therefore unnecessary.
>> +			 * Just free up the resources used by IRQ processing.
>> +			 */
> 
> I have some concerns about this patch. One thing we must ensure is that
> the machine does not poke freed memory (NIB, GISA). With the current
> design that means we must ensure that there won't be any interruption
> conditions indicated (and interrupts made pending) after this point.

If reset disables interrupts, why would we need to turn around and
disable interrupts after completion of the reset, unless reset disables
interrupts only for the duration of the reset processing? If interrupts
are disabled only for the duration of the reset, then I question whether
we need to be at all concerned about interrupts in the context of
resetting a queue.

> 
> I'm not entirely convinced this is ensured after your change. The
> relevant bits of the  documentation are particularly hard to figure out.
> I could use some clarifications for sure.
> 
> This hunk removes the wait implemented by vfio_ap_wait_for_irqclear()
> along with the hopefully overkill AQIC.
> 
> Let me name some of the scenarios I'm concerned about, along with the
> code that is currently supposed to handle these.
> 
> 
> int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>                               unsigned int retry)
> {
>          struct ap_queue_status status;
>          int retry2 = 2;
>          int apqn = AP_MKQID(apid, apqi);
>                                                                                  
>          do {
>                  status = ap_zapq(apqn);
>                  switch (status.response_code) {
>                  case AP_RESPONSE_NORMAL:
>                          while (!status.queue_empty && retry2--) {
>                                  msleep(20);
>                                  status = ap_tapq(apqn, NULL);
>                          }
>                          WARN_ON_ONCE(retry <= 0);
>                          return 0;
>                  case AP_RESPONSE_RESET_IN_PROGRESS:
>                  case AP_RESPONSE_BUSY:
>                          msleep(20);
>                          break;
>                  default:
>                          /* things are really broken, give up */
>                          return -EIO;
>                  }
>          } while (retry--);
>                                                                                  
>          return -EBUSY;
> 
> Scenario 1)
> 
> ap_zapq() returns status.response_code == AP_RESPONSE_RESET_IN_PROGRESS,
> because for example G2 did a ZAPQ before us.
> 
> The current logic retries ap_zapq() once after 20 msec. I have no idea
> if that is sufficient under all circumstances. If we get a
> AP_RESPONSE_RESET_IN_PROGRESS again, we return with -EBUSY and do nothing
> about it if the whole process was triggered by vfio_ap_mdev_release().
> Not even a warning.

I'm not sure this is a major concern, If the response code is
AP_RESPONSE_RESET_IN_PROGRESS due to a ZAPQ issued by G2 before us,
then once that completes the queue will be reset which accomplishes
the goal anyway. Maybe what should be done in this case is to wait
for the queue to empty?

> 
> Please notice that this was almost fine before IRQ support, because the
> queue will get reset ASAP, and ...

I'm not sure what IRQ support has to do with how soon the queue is
reset.

> 
> Scenario 2)
> 
> It takes longer than 40 msec for the reset to complete. I don't know if
> this is a possibility, but before your patch we used to wait of 1 sec.

Where are you coming up with 1 sec? The only thing my patch did was
remove the disable IRQ. Even if you include the the wait for IRQ disable
to complete, I don't see 1 second of wait time. By my calculations:

5 x 20ms = 100ms  Max wait for ZAPQ response code 0
2 x 20ms =  40ms  Max wait time for qempty
5 x 20ms = 100ms  Max wait for AQIC response code 0
5 x 20ms = 100ms  Max wait time for IRQ clear
----------------
            340ms  Max total wait time

> 
> I guess the we need the timeouts because do this with matrix_dev->lock
> held. I'm not sure it's a good idea long term.

It looks like your concern here is making sure we wait a
sufficient amount of time for the reset to complete. That may be
a question for the firmware folks.

> 
> Scenario 3)
> 
> ap_zapq() returns status.response_code == AP_RESPONSE_DECONFIGURED. In
> this case we would give up right away. Again so that we don't even know
> we hit this case. There ain't much I can think about we could do here.

The only thing I can think of is to log an error. I am introducing
logging in the dynamic configuration series if that helps.

> 
> I hope we are guaranteed to  not get any bits set at this point, but I could
> use some help.

I don't know what your concern is here. If the card is not in the
configuration, then no activity can take place until it is reconfigured.

> 
>                                    *
> 
> The good thing is I'm pretty sure that we are safe (i.e. no bits will be
> poked by the hardware) after seeing the queue empty after we issued a
> reset request.

You expressed several concerns above, yet now you say you think we're
safe; I don't understand.

> 
> So my concerns basically boil down to are the cumulative timeouts big enough
> so we never time out (including are timeouts really the way to go)?
> 
> We should probably take any discussion about from which point on is it safe
> to assume that NIB and GISA won't be poked by HW offline as the guys
> without documentation can't contribute.

Just a couple of thoughts. The only reason the vfio_ap driver is
concerned with interrupts is because it is intercepting the PQAP(AQIC)
instruction. Shouldn't enabling and disabling interrupts, therefore, be 
solely under the control of the guest? In other words, maybe the vfio_ap
driver should only allocate/deallocate the interrupt controls (i.e., the
NIB and GISA) in response to PQAP(AQIC) interception. When the guest
shuts down, I assume that the PQAP(AQIC) will be executed to disable
interrupts. The driver can do a final cleanup if the NIB and GISA when
the mdev fd is released by the guest if they are still hanging around.

> 
> 
> Two issues not directly related to your patch. I formulated those as two
> follow up patches on top of yours .please take a look at them.
> 
> -------------------------------8<------------------------------------------
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Fri, 30 Aug 2019 16:03:42 +0200
> Subject: [PATCH 1/2] s390: vfio-ap: fix warning reset not completed
> 
> The intention seems to be to warn once when we don't wait enough for the
> reset to complete. Let's use the right retry counter to accomplish that
> semantic.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index e3bcb43..dd07ebf 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1144,7 +1144,7 @@ int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>   				msleep(20);
>   				status = ap_tapq(apqn, NULL);
>   			}
> -			WARN_ON_ONCE(retry <= 0);
> +			WARN_ON_ONCE(retry2 <= 0);
>   			return 0;
>   		case AP_RESPONSE_RESET_IN_PROGRESS:
>   		case AP_RESPONSE_BUSY:
> 
