From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH 04/10] vfio: ccw: replace IO_REQ event with SSCH_REQ event
Date: Wed, 23 May 2018 10:19:18 +0200
Message-ID: <3746e8a0-415f-3ba7-d7dc-be7835adc42f@linux.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-5-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180425104138.1337aff5.cohuck@redhat.com>
 <24f638e4-2f7e-00e1-1efb-ff3fe524bca0@linux.vnet.ibm.com>
 <20180430173028.0dca976c.cohuck@redhat.com>
 <3c5a0677-4ed2-9bde-e6d8-d02ab69e0c2c@linux.vnet.ibm.com>
 <20180522173831.08f3b481.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180522173831.08f3b481.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 22/05/2018 17:38, Cornelia Huck wrote:
> [still backlog processing...]
>
> On Thu, 3 May 2018 14:06:51 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> On 30/04/2018 17:30, Cornelia Huck wrote:
>>> On Wed, 25 Apr 2018 15:52:19 +0200
>>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>>   
>>>> On 25/04/2018 10:41, Cornelia Huck wrote:
>>>>> On Thu, 19 Apr 2018 16:48:07 +0200
>>>>> Pierre Morel<pmorel@linux.vnet.ibm.com>  wrote:
>>>>>> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
>>>>>> index 3284e64..93aab87 100644
>>>>>> --- a/drivers/s390/cio/vfio_ccw_private.h
>>>>>> +++ b/drivers/s390/cio/vfio_ccw_private.h
>>>>>> @@ -76,7 +76,7 @@ enum vfio_ccw_state {
>>>>>>      */
>>>>>>     enum vfio_ccw_event {
>>>>>>     	VFIO_CCW_EVENT_NOT_OPER,
>>>>>> -	VFIO_CCW_EVENT_IO_REQ,
>>>>>> +	VFIO_CCW_EVENT_SSCH_REQ,
>>>>>>     	VFIO_CCW_EVENT_INTERRUPT,
>>>>>>     	VFIO_CCW_EVENT_SCH_EVENT,
>>>>>>     	/* last element! */
>>>>> I don't think we should separate the ssch handling. The major
>>>>> difference to halt/clear is that it needs channel program translation.
>>>>> Everything else (issuing the instruction and processing the interrupt)
>>>>> are basically the same. If we just throw everything at the hardware
>>>>> and let the host's channel subsystem figure it out, we already should
>>>>> be fine with regard to most of the races.
>>>> We must test at a moment or another the kind of request we do,
>>>> cancel, halt and clear only need the subchannel id in register 1 and as
>>>> you said are much more direct to implement.
>>>>
>>>> If we do not separate them here, we need a switch in the "do_io_request"
>>>> function.
>>>> Is it what you mean?
>>> Yes. Most of the handling should be the same for any function.
>> I really don't know, the 4 functions are quite different.
>>
>> - SSCH uses an ORB, and has a quite long kernel execution time for VFIO
>> - there is a race between SSCH and the others instructions
>> - XSCH makes subchannel no longer start pending, also reset the busy
>> indications
>> - CSCH cancels both SSCH and HSCH instruction, and perform path management
>> - HSCH has different busy (entry) conditions
> Roughly speaking, we have two categories: An asynchronous function is
> performed (SSCH, HSCH, CSCH) or not (XSCH). So I would split out XSCH
> in any case.
>
> SSCH, HSCH, CSCH all perform path management. I see them as kind of
> escalating (i.e. CSCH 'beats' HSCH which 'beats' SSCH). I think they
> are all similar enough, though, as we can call through to the real
> hardware and have it sorted out there.
>
> Looking through the channel I/O instructions:
> - RSCH should be handled with SSCH (as a special case).
> - MSCH should also be handled in the long run, STSCH as well.
> - SCHM is interesting, as it's not per-subchannel. We have some basic
>    handling of the instruction in QEMU, but it only emulates some ssch
>    counters and completely lacks support for the other fields.
> - IIRC, there's also a CHSC command dealing with channel monitoring. We
>    currently fence off any CHSC that is not needed for Linux to run, but
>    there are some that might be useful for the guest (path handling
>    etc.) Hard to come to a conclusion here without access to the
>    documentation.
> - I don't think we need to care about TSCH (other than keeping the
>    schib up to date, which we also need to do for STSCH).
> - Likewise, TPI should be handled via emulation.
>
> Coming back to the original issue, I think we can easily handle SSCH
> (and RSCH), HSCH and CSCH together (with the actual hardware doing the
> heavy lifting anyway). For other instructions, we need separate
> states/processing.
>

OK, I make the next version with this in mind.

Thanks

Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
