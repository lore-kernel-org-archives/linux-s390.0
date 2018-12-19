From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 2/6] vfio: ccw: Rework subchannel state on setup
Date: Wed, 19 Dec 2018 10:51:03 +0100
Message-ID: <f75dd1ca-c975-6cdf-45bf-7a73a34082c0@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
 <1543408867-16465-3-git-send-email-pmorel@linux.ibm.com>
 <ccead686-3c35-9a4a-3d9e-b88fd7170205@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ccead686-3c35-9a4a-3d9e-b88fd7170205@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, pasic@linux.vnet.ibm.com
Cc: cohuck@redhat.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 18/12/2018 18:44, Eric Farman wrote:
> My questions to this patch from the original RFC series are still 
> outstanding.  :(
> 
> https://marc.info/?l=linux-s390&m=154223063716128&w=2


Hi Eric,

Thanks for the following of this patch series.

For your question about quiece during remove I do not think it should be 
a NOP, we must make sure the channel is disabled at that time.

> 
> On 11/28/2018 07:41 AM, Pierre Morel wrote:
>> The subchannel enablement and the according setting to the
>> VFIO_CCW_STATE_STANDBY state should only be done when all
>> parts of the VFIO mediated device have been initialized
>> i.e. after the mediated device has been successfully opened.
>>
>> Let's stay in VFIO_CCW_STATE_NOT_OPER until the mediated
>> device has been opened and set the VFIO_CCW_STATE_STANDBY
>> on a successful open.
>>
>> On release the state is set back to VFIO_CCW_STATE_NOT_OPER
>> by vfio_ccw_sch_quiesce().
>>
>> When the mediated device is closed,  disable the sub channel
>> by calling vfio_ccw_sch_quiesce().
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_async.c   | 11 +++++++++++
> 
> Ah, this series is built on Connie's async changes.  Okay.  [1]

Yes, and after reflections I think the timing is bad so I prefer to wait 
for the series from Connie on hsch/csch to be finished before going on 
with this series.
Otherwise I fear to only add noise to the current discussions.


> 
>>   drivers/s390/cio/vfio_ccw_drv.c     | 10 +---------
>>   drivers/s390/cio/vfio_ccw_ops.c     | 27 +++++++++++++++++++++------
...snip...
>> @@ -170,6 +184,7 @@ static void vfio_ccw_mdev_release(struct 
>> mdev_device *mdev)
>>           dev_get_drvdata(mdev_parent_dev(mdev));
>>       int i;
>> +    vfio_ccw_sch_quiesce(private->sch);
>>       vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>>                    &private->nb);
> 
> [1] If Connie's async patches go in first, then the stuff in your 
> "vfio_ccw_unregister_async_dev_regions" is also added here.  That could 
> be removed and replaced with a call to your new function, yes?

certainly.
Thanks for your comments.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
