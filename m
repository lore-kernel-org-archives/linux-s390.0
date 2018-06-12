From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
Date: Tue, 12 Jun 2018 15:56:06 +0200
Message-ID: <d5416c61-252a-5bb8-aebe-46d883e5822e@linux.ibm.com>
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
 <86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
 <20180608142022.7dd6a658.cohuck@redhat.com>
 <d68340a2-bb1b-cef9-e394-f0d55983c0bb@linux.ibm.com>
 <20180608164514.2e8248f4.cohuck@redhat.com>
 <99ca65a2-ee33-6353-b6b7-aa4c07a34e2a@linux.ibm.com>
 <20180612115900.4aa319d1.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612115900.4aa319d1.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On 12/06/2018 11:59, Cornelia Huck wrote:
> On Fri, 8 Jun 2018 17:51:27 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 08/06/2018 16:45, Cornelia Huck wrote:
>>> On Fri, 8 Jun 2018 15:13:28 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>   
>>>> On 06/08/2018 02:20 PM, Cornelia Huck wrote:
>>>>>>> My proposal is to do the same
>>>>>>> copying to scsw(r) again, which would mean we get a request with both
>>>>>>> the halt and the start bit set. The vfio code now needs to do a hsch
>>>>>>> (instead of a ssch). The real channel subsystem should figure this out,
>>>>>>> as we can't reliably check whether the start function has concluded
>>>>>>> already (there's always a race window).
>>>>>> This I do not agree scsw(r) is part of the driver.
>>>>>> The interface here is not a device interface anymore but a driver
>>>>>> interface.
>>>>>> SCSW is a status, it is at its place in QEMU device interface with the
>>>>>> guest
>>>>>> but here pwrite() sends a command.
>>>>> Hm, I rather consider that "we write a status, and the backend figures
>>>>> out what to do based on that status".
>>>>>       
>>>> The status of what? Kind of a target status?
>>>>
>>>> I think this approach is the source of lots of complications. For instance
>>>> take xsch. How are we supposed to react to a guest xsch (in QEMU and
>>>> in the kernel module)? My guess is that the right thing to do is to issue
>>>> an xsch in the vfio-ccw kernel module on the passed through subchannel.
>>>> But there is no bit in fctl for cancel.
>>>>
>>>> Bottom line is: I'm not happy with the current design but I'm not sure
>>>> if it's practical to do something about it (i.e. change it radically).
>>> It might make sense to keep this for ssch, maybe reuse it for hsch/csch,
>> I do not think we need to change the interface radically but
>> I also do not thing we should extend it by using multiple commands
>> in a single syscall.
>>
>> Currently:
>>     - only SSCH bit is used
>>     - only the SSCH instruction is implemented
>>     - all other bits, CSCH,HSCH produce an error when used alone
>>       or are ignored in conjonction with SSCH
>>      - there is no implementation using the other bits
>>      - It is not specified in the documentation that multiple commands
>>        can be used.
> Looking at Documentation/s390/vfio-ccw.txt, it states that "scsw_area
> should be filled with the SCSW of the Virtual Subchannel". This seems
> to indicate that this is really intended to be a scsw... but I agree,
> it does lack details.
>
>> Looking at these, I think there is no trouble to modify the way
>> the Kernel interface is implemented without impact on current QEMU.
>>
>> But if we begin to allow ssch/hsch/csch in a single command
>> in a new implementation we will be stuck with it.
> Yes, we're currently still free to go in different directions; adding
> support for hsch/csch to the interface in the way I did would fix it.
> In any case, we need better documentation :/
>
>>> and think about something else for other things we want to handle
>> Yes we will need to have another interface, ioctl, or new region,
>> all possible, but really more complex.
>>
>>> (xsch, channel monitoring, the path handling stuff for which we already
>> We can use another region for getting up information on path handling
>> or monitoring, as does the patch IIRC.
>> This is not a problem.
> Not a problem, I agree (and yes, the patch did that).
>
> For xsch, I like Halil's suggestion of simply always setting cc 2.
>
> Channel monitoring is a difficult beast (need to pass through msch, mix
> of virtual and passthrough devices on the machine which have different
> semantics etc.) I put some of my concerns into
> https://wiki.qemu.org/ToDo/Channel_I/O_Passthrough; please add to that
> if you have further thoughts.
>
> We should keep those requirements in mind, even if we won't implement
> support for it right now.
>
>>> had a prototype etc.) It's probably not practical to do radical surgery
>>> on the existing code.
>> There is no need for radical surgery, no change is required to older or
>> current QEMU code.
>> My concern is to avoid a future implementation merging multiple commands
>> in a single syscall.
>> It is not only a problem of beauty of the interface,
>> using a status is for the up-stream, from device to program.
>> Using the same construct, same name and same location, to produce commands
>> for the down stream is misleading and source of incoherence.
> OK, I think I see your concern now.
>
> What happens on the real hardware is that we do a ssch etc. and this
> triggers a change that is visible in the scsw when we do a stsch.
>
> What happens here is that the guest doing a ssch triggers a change in
> our virtual scsw in QEMU (so far, so good); then we send this scsw to
> the vfio module, which looks at the scsw to figure out that it should
> do a ssch on the host. This works fine to figure out that a ssch needs
> to be done, and would also work for hsch and csch, but it is really a
> bit of reverse engineering, and it would probably fail for rsch
> (haven't thought about that yet). To parse the intention of doing a
> halt or clear out of the scsw_area, we need to rely (a) on user space
> doing the right thing, and (b) on us implementing the rules for which
> function can be initiated when correctly. If we treat fctl as a simple
> command field, we'll just do what user space asks of us directly.
>
> So, what are you proposing? Being more specific and stating that the
> scsw is not necessarily a real scsw, but merely a vehicle for sending a
> command? Or keeping it as it is now for ssch, and adding a second
> interface for hsch/csch (and maybe rsch, msch, ...)?
>


I said no radical surgery, but after thinking more about it...
I am not sure.

Let's explain this:

I see 2 ways to proceed but my favorite is definitively to introduce 
versioning.


Way 1)

This was the way I first thought about.
We keep the existing IO Regionand structures, and are more
specific by stating that the io_region is a command region during write
entry and a status region during interrupt handling:
This allow us to use the 3 bits of the FCTL field of the SCSW to pass
commands to the kernel and stay backward compatible.
The FCTL field has 3 bits => we can have 8 commands.

PRO: small change

CONTRA: This is still confusing, we do not really solve this
         unclarity problem since QEMU view / documentation and
         Linux view / documentation differ or we update QEMU.
         Moreover this does not allow for long term extensions
         and/or re-design.



Way 2)

We use the device VFIO versioning using the capability chain to advertise
a new interface.

This the preferred way, it is sane, allows for the userland backward
compatibility and allows to have a new command interface, extensible
for future use.

In this case we can extend the interface to be any kind we want
in a next version, pwrite with new io_region, mmap on new
IO regions, status region...

PRO: Extensible and also goes in the VFIO INFO extension direction
      proposed by Alex

CONTRA: I see none outer more work to do (but is it a problem?)


====================

Extra argumentation for versioning support


Suppose a future implementation with 4 mapped regions like
the following:

- A Status region (RO updated as result of command and IRQ)

- A command region (WO where the user send its commands)
   userland write here to trigger IO (quite as currently)

- A CCW program region (RW where the CCW chain is handled)
   most handling done from userspace, last translations in kernel,
   double buffering...

- A performance / measurement / statistics region (RO)
   This is updated asynchronously by hardware and/or driver

This is purely theoretical and we do not need to do all at once
but if we want to extend the implementation without problems
and continue backward compatibility the versioning and capability
handling is a must.

====================


Regards,

Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
