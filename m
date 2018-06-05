From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 01/10] vfio: ccw: Moving state change out of IRQ
 context
Date: Tue, 5 Jun 2018 16:22:58 +0200
Message-ID: <f17c58bd-b8ab-aeda-04af-db6ba64e87af@linux.ibm.com>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1527243678-3140-2-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180604155231.42c139ac.cohuck@redhat.com>
 <5330d3e5-4098-e936-de57-5f4cb2d8f564@linux.ibm.com>
 <20180605155231.7d4d3f96.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605155231.7d4d3f96.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05/06/2018 15:52, Cornelia Huck wrote:
> On Tue, 5 Jun 2018 15:34:52 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 04/06/2018 15:52, Cornelia Huck wrote:
>>> On Fri, 25 May 2018 12:21:09 +0200
>>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>>   
>>>> Let's move the state change from the IRQ routine to the
>>>> workqueue callback.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>>> ---
>>>>    drivers/s390/cio/vfio_ccw_drv.c | 20 +++++++-------------
>>>>    drivers/s390/cio/vfio_ccw_fsm.c | 14 ++++++++------
>>>>    2 files changed, 15 insertions(+), 19 deletions(-)
>>> This causes a change in behaviour for devices in the notoper state.
>>>
>>> Now:
>>> - vfio_ccw_sch_irq is called
>> This should not be done if the subchannel is not operational.
>>
>>> - via the state machine, disabling the subchannel is (re-)triggered
>> I removed the fsm_disabled_irq() callback from VFIO_CCW_STATE_NOT_OPER
>> because the subchannel is not even initialized at that moment.
>> We have no reference to the subchannel.
>>
>> In the previous driver NOT_OPER and STANDBY were quite the same.
>> Now NOT_OPER means "we can not operate on this sub channel"
>> because we do not have it in a correct state (no ISC, no mediated device,
>> the probe is not finiched)
>>
>> Now STANDBY means we have the device ready but is disabled.
>> In this case the software infrastructure is ready and if an interrupt comes
>> (what should not happen) we will disable the subchannel again.
>>
>>> With your patch:
>>> - the work function is queued in any case; eventually, it will change
>>>     the device's state to idle (unless we don't have an mdev at that
>>>     point in time)
>>> - completion is signaled
>>>
>>> I'm not sure that's what we want.
>>>   
>> Yes it is queued in any case but the IRQ is really treated only if the
>> subchannel is in the right state (STANDBY, BUSY, IDLE and QUIESCING).
>>
>> In the NOT_OPER state we do not have the mdev not the driver initialized.
> But all of this is only true after the whole series has been applied,
> isn't it? Is there any way to do the changes without breaking things
> inbetween?

I will think about this.
May be just disable the all thing untill all patches applied?

>
> What would also be very helpful is a sketch of the state machine after
> your rework is done. Otherwise, this leaves me a bit unsure about the
> intended semantics if I just look at the individual patches.
>

Right, I must enhance the cover letter.


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
