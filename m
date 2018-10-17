From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 17 Oct 2018 10:58:40 +0000
Subject: Re: [PATCH 0/5] RFC: VFIO CCW cleanup
Message-Id: <4b0462b1-17e7-4cda-6cb8-091784ef9553@linux.ibm.com>
In-Reply-To: <20181017112846.18c8e605.cohuck@redhat.com>
References: <20181017112846.18c8e605.cohuck@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 17/10/2018 11:28, Cornelia Huck wrote:
> On Wed, 17 Oct 2018 11:18:38 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> Hi Connie, and all,
>>
>> I come back on the consolidation of the VFIO CCW driver,
>> this time by making smaller steps.
>> Here a first proposal, as RFC, therefore I only CC to
>> the linux-s390 list.
> 
> I'll not get around to looking at it in detail until after KVM Forum,

of course. :)

> but...
> 
>>
>> The first patch of this serie is essentially cosmetic
>> to clarify the code.
>>
>> The second patch is a bug correction.
> 
> ...this looks small enough to queue right now. It makes sense
> standalone AFAICS.

Yes, I think it does.
So I make a v1 with only these two patches.

Thanks for the comments

Pierre

> 
>>
>> The last three patches clarify the linux device state changes.
>>
>> Currently the VFIO CCW driver may be used while it is
>> not completely initialized or not dedicated to a guest.
>> - Let's consolidate this by moving state change and initialization
>>    inside the mediated device open callback.
>> - quiesce the device when the mediated device is released.
>> - refuse to remove a mediated device when it is in use.
>> - do not change the linux state on subchannel events.
>>
>> Regards,
>>
>> Pierre
>>
>>
>> Pierre Morel (5):
>>    vfio: ccw: Merge BUSY and BOXED states
>>    vfio: ccw: Register mediated device once all structures are
>>      initialized
>>    vfio: ccw: Set subchannel state STANDBY on open
>>    vfio: ccw: Refactoring state changes
>>    vfio: ccw: Do not change the mediated device state on sch events
>>
>>   drivers/s390/cio/vfio_ccw_drv.c     | 38 ++++++++++++++++-------------------
>>   drivers/s390/cio/vfio_ccw_fsm.c     |  7 +------
>>   drivers/s390/cio/vfio_ccw_ops.c     | 40 +++++++++++++++++++++++++++----------
>>   drivers/s390/cio/vfio_ccw_private.h |  1 -
>>   4 files changed, 47 insertions(+), 39 deletions(-)
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
