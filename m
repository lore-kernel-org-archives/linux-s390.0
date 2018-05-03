From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/10] vfio: ccw: Suppress unused event parameter
Date: Thu, 3 May 2018 12:34:21 +0200
Message-ID: <24fb88a3-450c-01d3-c00a-2b4bcbe10ca6@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-6-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180426073618.GA12194@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180426073618.GA12194@bjsdjshi@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 26/04/2018 09:36, Dong Jia Shi wrote:
> * Pierre Morel <pmorel@linux.vnet.ibm.com> [2018-04-19 16:48:08 +0200]:
>
>> The fsm_func_t function type definition does not need the event
>> parameter since all functions are in a state/event table.
> Not sure if this will still be right after you addressed all of the
> comments on this version. But no hurt to point out some nits that I
> noticed below.
>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 34 +++++++++++-----------------------
>>   drivers/s390/cio/vfio_ccw_private.h |  5 ++---
>>   2 files changed, 13 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
>> index f9855cd..f8ded70 100644
>> --- a/drivers/s390/cio/vfio_ccw_fsm.c
>> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
>> @@ -55,8 +55,7 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>>   	}
>>   }
>>
>> -static int fsm_notoper(struct vfio_ccw_private *private,
>> -			enum vfio_ccw_event event)
>> +static int fsm_notoper(struct vfio_ccw_private *private)
>>   {
>>   	struct subchannel *sch = private->sch;
>>
>> @@ -65,36 +64,31 @@ static int fsm_notoper(struct vfio_ccw_private *private,
>>   	 * Probably we should send the machine check to the guest.
>>   	 */
>>   	css_sched_sch_todo(sch, SCH_TODO_UNREG);
>> -	private->state = VFIO_CCW_STATE_NOT_OPER;
>> -	return private->state;
>> +	return VFIO_CCW_STATE_NOT_OPER;
> This change should belong to a former patch.
>
> [...]
>
>> @@ -109,17 +103,14 @@ static int fsm_disabled_irq(struct vfio_ccw_private *private,
>>   /*
>>    * Deal with the ccw command request from the userspace.
>>    */
>> -static int fsm_io_request(struct vfio_ccw_private *private,
>> -			   enum vfio_ccw_event event)
>> +static int fsm_io_request(struct vfio_ccw_private *private)
>>   {
>> -	union orb *orb;
>>   	struct ccw_io_region *io_region = &private->io_region;
>> +	union orb *orb = (union orb *)io_region->orb_area;
>>   	struct mdev_device *mdev = private->mdev;
>>
>>   	private->state = VFIO_CCW_STATE_BOXED;
>>
>> -	orb = (union orb *)io_region->orb_area;
>> -
> Irrelevant change for this patch.
>
>>   	io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev), orb);
>>   	if (io_region->ret_code)
>>   		goto err_out;
>> @@ -139,15 +130,13 @@ static int fsm_io_request(struct vfio_ccw_private *private,
>>   	return VFIO_CCW_STATE_BUSY;
>>
>>   err_out:
>> -	private->state = VFIO_CCW_STATE_IDLE;
>> -	return private->state;
>> +	return VFIO_CCW_STATE_IDLE;
> Should move to other patch.
>
> [...]
>
OK, I will move these changes in patch 4/10.

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
