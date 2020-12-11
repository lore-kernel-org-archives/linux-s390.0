Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437557AbgLKPC1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Dec 2020 10:02:27 -0500
Subject: Re: [RFC 0/4] vfio-pci/zdev: Fixing s390 vfio-pci ISM support
References: <1607545670-1557-1-git-send-email-mjrosato@linux.ibm.com>
 <20201210133306.70d1a556.cohuck@redhat.com>
 <ce9d4ef2-2629-59b7-99ed-4c8212cb004f@linux.ibm.com>
 <20201211153501.7767a603.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <6c9528f3-f012-ba15-1d68-7caefb942356@linux.ibm.com>
Date: Fri, 11 Dec 2020 10:01:29 -0500
MIME-Version: 1.0
In-Reply-To: <20201211153501.7767a603.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: alex.williamson@redhat.com, schnelle@linux.ibm.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/11/20 9:35 AM, Cornelia Huck wrote:
> On Thu, 10 Dec 2020 10:51:23 -0500
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> On 12/10/20 7:33 AM, Cornelia Huck wrote:
>>> On Wed,  9 Dec 2020 15:27:46 -0500
>>> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>>>    
>>>> Today, ISM devices are completely disallowed for vfio-pci passthrough as
>>>> QEMU will reject the device due to an (inappropriate) MSI-X check.
>>>> However, in an effort to enable ISM device passthrough, I realized that the
>>>> manner in which ISM performs block write operations is highly incompatible
>>>> with the way that QEMU s390 PCI instruction interception and
>>>> vfio_pci_bar_rw break up I/O operations into 8B and 4B operations -- ISM
>>>> devices have particular requirements in regards to the alignment, size and
>>>> order of writes performed.  Furthermore, they require that legacy/non-MIO
>>>> s390 PCI instructions are used, which is also not guaranteed when the I/O
>>>> is passed through the typical userspace channels.
>>>
>>> The part about the non-MIO instructions confuses me. How can MIO
>>> instructions be generated with the current code, and why does changing
>>
>> So to be clear, they are not being generated at all in the guest as the
>> necessary facility is reported as unavailable.
>>
>> Let's talk about Linux in LPAR / the host kernel:  When hardware that
>> supports MIO instructions is available, all userspace I/O traffic is
>> going to be routed through the MIO variants of the s390 PCI
>> instructions.  This is working well for other device types, but does not
>> work for ISM which does not support these variants.  However, the ISM
>> driver also does not invoke the userspace I/O routines for the kernel,
>> it invokes the s390 PCI layer directly, which in turn ensures the proper
>> PCI instructions are used -- This approach falls apart when the guest
>> ISM driver invokes those routines in the guest -- we (qemu) pass those
>> non-MIO instructions from the guest as memory operations through
>> vfio-pci, traversing through the vfio I/O layer in the guest
>> (vfio_pci_bar_rw and friends), where we then arrive in the host s390 PCI
>> layer -- where the MIO variant is used because the facility is available.
>>
>> Per conversations with Niklas (on CC), it's not trivial to decide by the
>> time we reach the s390 PCI I/O layer to switch gears and use the non-MIO
>> instruction set.
>>
>>> the write pattern help?
>>
>> The write pattern is a separate issue from non-MIO instruction
>> requirements...  Certain address spaces require specific instructions to
>> be used (so, no substituting PCISTG for PCISTB - that happens too by
>> default for any writes coming into the host s390 PCI layer that are
>> <=8B, and they all are when the PCISTB is broken up into 8B memory
>> operations that travel through vfio_pci_bar_rw, which further breaks
>> those up into 4B operations).  There's also a requirement for some
>> writes that the data, if broken up, be written in a certain order in
>> order to properly trigger events. :(  The ability to pass the entire
>> PCISTB payload vs breaking it into 8B chunks is also significantly faster.
> 
> Let me summarize this to make sure I understand this new region
> correctly:
> 
> - some devices may have relaxed alignment/length requirements for
>    pcistb (and friends?)

The relaxed alignment bit is really specific to PCISTB behavior, so the 
"and friends" doesn't apply there.

> - some devices may actually require writes to be done in a large chunk
>    instead of being broken up (is that a strict subset of the devices
>    above?)

Yes, this is specific to ISM devices, which are always a relaxed 
alignment/length device.

The inverse is an interesting question though (relaxed alignment devices 
that are not ISM, which you've posed as a possible future extension for 
emulated devices).  I'm not sure that any (real devices) exist where 
(relaxed_alignment && !ism), but 'what if' -- I guess the right approach 
would mean additional code in QEMU to handle relaxed alignment for the 
vfio mmio path as well (seen as pcistb_default in my qemu patchset) and 
being very specific in QEMU to only enable the region for an ism device.

> - some devices do not support the new MIO instructions (is that a
>    subset of the relaxed alignment devices? I'm not familiar with the
>    MIO instructions)
> 

The non-MIO requirement is again specific to ISM, which is a subset of 
the relaxed alignment devices.  In this case, the requirement is not 
limited to PCISTB, and that's why PCILG is also included here.  The ISM 
driver does not use PCISTG, and the only PCISTG instructions coming from 
the guest against an ISM device would be against the config space and 
those are OK to go through vfio still; so what was provided via the 
region is effectively the bare-minimum requirement to allow ISM to 
function properly in the guest.

> The patchsets introduce a new region that (a) is used by QEMU to submit
> writes in one go, and (b) makes sure to call into the non-MIO
> instructions directly; it's basically killing two birds with one stone
> for ISM devices. Are these two requirements (large writes and non-MIO)
> always going hand-in-hand, or is ISM just an odd device?

I would say that ISM is definitely a special-case device, even just 
looking at the way it's implemented in the base kernel (interacting 
directly with the s390 kernel PCI layer in order to avoid use of MIO 
instructions -- no other driver does this).  But that said, having the 
two requirements hand-in-hand I think is not bad, though -- This 
approach ensures the specific instruction the guest wanted (or in this 
case, needed) is actually executed on the underlying host.

That said, the ability to re-use the large write for other devices would 
be nice -- but as hinted in the QEMU cover letter, this approach only 
works because ISM does not support MSI-X; using this approach for 
MSI-X-enabled devices breaks the MSI-X masking that vfio-pci does in 
QEMU (I tried an approach that used this region approach for all 3 
instructions as a test, PCISTG/PCISTB/PCILG, and threw it against mlx -- 
any writes against an MSI-X enabled bar will miss the msi-x notifiers 
since we aren't performing memory operations against the typical 
vfio-pci bar).

> 
> If there's an expectation that the new region will always use the
> non-MIO instructions (in addition to the changed write handling), it
> should be noted in the description for the region as well.
> 

Yes, this is indeed the expectation; I can clarify that.
