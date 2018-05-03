From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH 04/10] vfio: ccw: replace IO_REQ event with SSCH_REQ event
Date: Thu, 3 May 2018 16:26:29 +0200
Message-ID: <5816643d-5406-06b9-0727-fdcd771aba63@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-5-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180426073053.GZ12194@bjsdjshi@linux.vnet.ibm.com>
 <20180426074806.GB12194@bjsdjshi@linux.vnet.ibm.com>
 <20180430173305.632faa80.cohuck@redhat.com>
 <20180502074622.GV5428@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502074622.GV5428@bjsdjshi@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 02/05/2018 09:46, Dong Jia Shi wrote:
> * Cornelia Huck <cohuck@redhat.com> [2018-04-30 17:33:05 +0200]:
>
>> On Thu, 26 Apr 2018 15:48:06 +0800
>> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
>>
>>> * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2018-04-26 15:30:54 +0800]:
>>>
>>> [...]
>>>
>>>>> @@ -179,7 +160,7 @@ static int fsm_irq(struct vfio_ccw_private *private,
>>>>>   	if (private->io_trigger)
>>>>>   		eventfd_signal(private->io_trigger, 1);
>>>>>
>>>>> -	return private->state;
>>>>> +	return VFIO_CCW_STATE_IDLE;
>>>> This is not right. For example, if we are in STANDBY state (subch driver
>>>> is probed, but mdev device is not created), we can not jump to IDLE
>>>> state.
>>>>    
>>> I see my problem, for STANDBY state, we should introduce another event
>>> callback for VFIO_CCW_EVENT_INTERRUPT. It doesn't make sense to call
>>> fsm_irq() which tries to signal userspace with interrupt notification
>>> when mdev is not created yet... So we'd need a separated fix for this
>>> issue too.
>> But how do we even get into that situation when we don't have an mdev
>> yet?
>>
> We cann't... So let's assign fsm_nop() as the interrupt callback for
> STANDBY state?
>

:) Isn't it exactly what my patch series handle?


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
