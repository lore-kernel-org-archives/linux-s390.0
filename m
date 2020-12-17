Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC 0/4] vfio-pci/zdev: Fixing s390 vfio-pci ISM support
References: <1607545670-1557-1-git-send-email-mjrosato@linux.ibm.com>
 <20201210133306.70d1a556.cohuck@redhat.com>
 <ce9d4ef2-2629-59b7-99ed-4c8212cb004f@linux.ibm.com>
 <20201211153501.7767a603.cohuck@redhat.com>
 <6c9528f3-f012-ba15-1d68-7caefb942356@linux.ibm.com>
 <a974c5cc-fc42-7bf0-66a6-df095da7105f@linux.ibm.com>
 <20201217135919.46d5c43f.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <f9f312d8-1948-d5b8-22fe-82f1975c8a18@linux.ibm.com>
Date: Thu, 17 Dec 2020 11:04:48 -0500
MIME-Version: 1.0
In-Reply-To: <20201217135919.46d5c43f.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/17/20 7:59 AM, Cornelia Huck wrote:
> On Fri, 11 Dec 2020 10:04:43 -0500
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> On 12/11/20 10:01 AM, Matthew Rosato wrote:
>>> On 12/11/20 9:35 AM, Cornelia Huck wrote:
> 
>>>> Let me summarize this to make sure I understand this new region
>>>> correctly:
>>>>
>>>> - some devices may have relaxed alignment/length requirements for
>>>>     pcistb (and friends?)
>>>
>>> The relaxed alignment bit is really specific to PCISTB behavior, so the
>>> "and friends" doesn't apply there.
> 
> Ok.
> 
>>>    
>>>> - some devices may actually require writes to be done in a large chunk
>>>>     instead of being broken up (is that a strict subset of the devices
>>>>     above?)
>>>
>>> Yes, this is specific to ISM devices, which are always a relaxed
>>> alignment/length device.
>>>
>>> The inverse is an interesting question though (relaxed alignment devices
>>> that are not ISM, which you've posed as a possible future extension for
>>> emulated devices).  I'm not sure that any (real devices) exist where
>>> (relaxed_alignment && !ism), but 'what if' -- I guess the right approach
>>> would mean additional code in QEMU to handle relaxed alignment for the
>>> vfio mmio path as well (seen as pcistb_default in my qemu patchset) and
>>> being very specific in QEMU to only enable the region for an ism device.
>>
>> Let me be more precise there...  It would be additional code to handle
>> relaxed alignment for the default pcistb path (pcistb_default) which
>> would include BOTH emulated devices (should we ever surface the relaxed
>> alignment CLP bit and the guest kernel honor it) as well as any s390x
>> vfio-pci device that doesn't use this new I/O region described here.
> 
> Understood. Not sure if it is useful, but the important part is that we
> could extend it if we wanted.
> 
>>
>>>    
>>>> - some devices do not support the new MIO instructions (is that a
>>>>     subset of the relaxed alignment devices? I'm not familiar with the
>>>>     MIO instructions)
>>>>   
>>>
>>> The non-MIO requirement is again specific to ISM, which is a subset of
>>> the relaxed alignment devices.  In this case, the requirement is not
>>> limited to PCISTB, and that's why PCILG is also included here.  The ISM
>>> driver does not use PCISTG, and the only PCISTG instructions coming from
>>> the guest against an ISM device would be against the config space and
>>> those are OK to go through vfio still; so what was provided via the
>>> region is effectively the bare-minimum requirement to allow ISM to
>>> function properly in the guest.
>>>    
>>>> The patchsets introduce a new region that (a) is used by QEMU to submit
>>>> writes in one go, and (b) makes sure to call into the non-MIO
>>>> instructions directly; it's basically killing two birds with one stone
>>>> for ISM devices. Are these two requirements (large writes and non-MIO)
>>>> always going hand-in-hand, or is ISM just an odd device?
>>>
>>> I would say that ISM is definitely a special-case device, even just
>>> looking at the way it's implemented in the base kernel (interacting
>>> directly with the s390 kernel PCI layer in order to avoid use of MIO
>>> instructions -- no other driver does this).  But that said, having the
>>> two requirements hand-in-hand I think is not bad, though -- This
>>> approach ensures the specific instruction the guest wanted (or in this
>>> case, needed) is actually executed on the underlying host.
> 
> The basic question I have is whether it makes sense to specialcase the
> ISM device (can we even find out that we're dealing with an ISM device
> here?) to force the non-MIO instructions, as it is just a device with

Yes, with the addition of the CLP data passed from the host via vfio 
capabilities, we can tell this is an ISM device specifically via the 
'pft' field in VFOI_DEVICE_INFO_CAP_ZPCI_BASE.  We don't actually 
surface that field to the guest itself in the Q PCI FN clp rsponse (has 
to do with Function Measurement Block requirements) but we can certainly 
use that information in QEMU to restrict this behavior to only ISM devices.

> some special requirements, or tie non-MIO to relaxed alignment. (Could
> relaxed alignment devices in theory be served by MIO instructions as
> well?)

In practice, I think there are none today, but per the architecture it 
IS possible to have relaxed alignment devices served by MIO 
instructions, so we shouldn't rely on that bit alone as I'm doing in 
this RFC.  I think instead relying on the pft value as I mention above 
is what we have to do.

> 
> Another thing that came to my mind is whether we consider the guest to
> be using a pci device and needing weird instructions to do that because
> it's on s390, or whether it is issuing instructions for a device that
> happens to be a pci device (sorry if that sounds a bit meta :)
> 

Typically, I'd classify things as the former but I think ISM seems more 
like the latter -- To me, ISM seems like less a classic PCI device and 
more a device that happens to be using s390 PCI interfaces to accomplish 
its goal.  But it's probably more of a case of this particular device 
(and it's driver) are s390-specific and therefore built with the unique 
s390 interface in-mind (and in fact invokes it directly rather than 
through the general PCI layer), rather than fitting the typical PCI 
device architecture on top of the s390 interface.


>>>
>>> That said, the ability to re-use the large write for other devices would
>>> be nice -- but as hinted in the QEMU cover letter, this approach only
>>> works because ISM does not support MSI-X; using this approach for
>>> MSI-X-enabled devices breaks the MSI-X masking that vfio-pci does in
>>> QEMU (I tried an approach that used this region approach for all 3
>>> instructions as a test, PCISTG/PCISTB/PCILG, and threw it against mlx --
>>> any writes against an MSI-X enabled bar will miss the msi-x notifiers
>>> since we aren't performing memory operations against the typical
>>> vfio-pci bar).
> 
> Ugh. I wonder why ISM is so different from anything else.
> 

...  I've asked myself that alot lately :)

>>>    
>>>>
>>>> If there's an expectation that the new region will always use the
>>>> non-MIO instructions (in addition to the changed write handling), it
>>>> should be noted in the description for the region as well.
>>>>   
>>>
>>> Yes, this is indeed the expectation; I can clarify that.
>>>    
> 
> Thanks!
> 
