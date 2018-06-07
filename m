From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
Date: Thu, 7 Jun 2018 18:37:16 +0200
Message-ID: <86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
 <20180509154822.23510-3-cohuck@redhat.com>
 <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
 <20180515181006.0cb1dfc2.cohuck@redhat.com>
 <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
 <20180522145208.310143ea.cohuck@redhat.com>
 <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
 <20180605151449.22aafbfc.cohuck@redhat.com>
 <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
 <20180606142131.74ea2eb7.cohuck@redhat.com>
 <5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
 <20180607115442.6a779ed9.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607115442.6a779ed9.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On 07/06/2018 11:54, Cornelia Huck wrote:
> On Wed, 6 Jun 2018 16:15:31 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 06/06/2018 14:21, Cornelia Huck wrote:
>>> On Tue, 5 Jun 2018 17:23:02 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>   
>>>> On 05/06/2018 15:14, Cornelia Huck wrote:
>>>>> On Tue, 22 May 2018 17:10:44 +0200
>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>      
>>>>>> On 22/05/2018 14:52, Cornelia Huck wrote:
>>>>>>> On Wed, 16 May 2018 15:32:48 +0200
>>>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>>>         
>>>>>>>> On 15/05/2018 18:10, Cornelia Huck wrote:
>>>>>>>>> On Fri, 11 May 2018 11:33:35 +0200
>>>>>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>>>>>            
>>>>>>>>>> On 09/05/2018 17:48, Cornelia Huck wrote:
>>

snip

>> sub-channel at the same time?
>>
>> If QEMU, once asynchronous, can do this, it could just
>> halt the start before asking this to the backend. Don't it?
>>
>> Another point is that the start must have been accepted by the
>> sub-channel for the start bit in the fc field of the SCSW to be set.
> Hm, I think we need to be more precise as to what scsw we're talking
> about. Bad ascii art time:
>
> --------------
> |   scsw(g)  |  ssch
> --------------   |
>                   |                                       guest
> --------------------------------------------------------------
>                   |                                        qemu
> --------------   v
> |   scsw(q)  | emulate
> --------------   |
>                   |
> --------------   v
> |   scsw(r)  | pwrite()
> --------------   |
>                   |
> --------------------------------------------------------------
>                   |                                        vfio
>                   v
>                  ssch
>                   |
> --------------------------------------------------------------
>                   |                                    hardware
> --------------   v
> |   scsw(h)  | actually do something
> --------------
>
> The guest issues a ssch (which gets intercepted; it won't get control
> back until ssch finishes with a cc set.) scsw(g) won't change, unless
> the guest does a stsch for the subchannel on another vcpu, in which
> case it will get whatever information qemu holds in scsw(q) at that
> point in time.
>
> When qemu starts to emulate the guest's ssch, it will set the start
> function bit in the fctl field of scsw(q). It then copies scsw(q) to
> scsw(r) in the vfio region.
>
> The vfio code will then proceed to call ssch on the real subchannel.
> This is the first time we get really asynchronous, as the ssch will
> return with cc set and the start function will be performed at some
> point in time. If we would do a stsch on the real subchannel, we would
> see that scsw(h) now has the start function bit set.
>
> Currently, we won't return back up the chain until we get an interrupt
> from the hardware, at which time we update the scsw(r) from the irb.

I do not find where the thread waits for interrupt inside the
write->fsm_io_request->fsm_io_helper->ssch chain.

I must have miss it ten times. Can you point it to me?

> This will propagate into the scsw(q). At the time we finish handling
> the guest's ssch and return control to it, we're all done and if the
> guest does a stsch to update its scsw(g), it will get the current
> scsw(q) which will already contain the scsw from the interrupt's irb
> (indicating that the start function is already finished).
>
> Now let's imagine we have a future implementation that handles actually
> performing the start on the hardware asynchronously, i.e. it returns
> control to the guest without the interrupt having been posted (let's
> say that it is a longer-running I/O request). If the guest now did a
> stsch to update scsw(g), it would get the current state of scsw(q),
> which would be "start function set, but not done yet".
>
> If the guest now does a hsch, it would trap in the same way as the ssch
> before. When qemu gets control, it adds the halt bit in scsw(q) (which
> is in accordance with the architecture).

This I agree.
The scsw(q) is part of the QEMU device.

>   My proposal is to do the same
> copying to scsw(r) again, which would mean we get a request with both
> the halt and the start bit set. The vfio code now needs to do a hsch
> (instead of a ssch). The real channel subsystem should figure this out,
> as we can't reliably check whether the start function has concluded
> already (there's always a race window).

This I do not agree scsw(r) is part of the driver.
The interface here is not a device interface anymore but a driver 
interface.
SCSW is a status, it is at its place in QEMU device interface with the 
guest
but here pwrite() sends a command.


Since we do not do a STSCH on each command, scsw(q), should be
updated by QEMU depending on syscall return value.
This is not done currently, only the success path is right
because it is set before the call.

If I read right and the IRQ is asynchronous, the scsw(q) is not right,
because not updated, after the interrupt is received from the guest.

>
> For csch, things are a bit different (which the code posted here did
> not take into account). The qemu emulation of csch needs to clear any
> start/halt bits in scsw(q) when setting the clear bit there, and
> therefore scsw(r) will only have the clear bit set in that case. We
> still should do an unconditional csch for the same reasons as above;
> the hardware will do the same things (clearing start/halt, setting
> clear) in the scsw(h).
>
> Congratulations, you've reached the end :) I hope that was helpful and
> not too confusing.
>
Yes it was, thank you, and it is clear, but still... questions ... ;)

Best regards,

Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
