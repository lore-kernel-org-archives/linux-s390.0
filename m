Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC 0/4] vfio-pci/zdev: Fixing s390 vfio-pci ISM support
References: <1607545670-1557-1-git-send-email-mjrosato@linux.ibm.com>
 <20201210133306.70d1a556.cohuck@redhat.com>
 <ce9d4ef2-2629-59b7-99ed-4c8212cb004f@linux.ibm.com>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <7bce88b2-8c7d-c0f4-89a0-b1e8f511ad0b@linux.ibm.com>
Date: Thu, 10 Dec 2020 17:14:24 +0100
MIME-Version: 1.0
In-Reply-To: <ce9d4ef2-2629-59b7-99ed-4c8212cb004f@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: alex.williamson@redhat.com, pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org



On 12/10/20 4:51 PM, Matthew Rosato wrote:
> On 12/10/20 7:33 AM, Cornelia Huck wrote:
>> On Wed,  9 Dec 2020 15:27:46 -0500
>> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>>
>>> Today, ISM devices are completely disallowed for vfio-pci passthrough as
>>> QEMU will reject the device due to an (inappropriate) MSI-X check.
>>> However, in an effort to enable ISM device passthrough, I realized that the
>>> manner in which ISM performs block write operations is highly incompatible
>>> with the way that QEMU s390 PCI instruction interception and
>>> vfio_pci_bar_rw break up I/O operations into 8B and 4B operations -- ISM
>>> devices have particular requirements in regards to the alignment, size and
>>> order of writes performed.  Furthermore, they require that legacy/non-MIO
>>> s390 PCI instructions are used, which is also not guaranteed when the I/O
>>> is passed through the typical userspace channels.
>>
>> The part about the non-MIO instructions confuses me. How can MIO
>> instructions be generated with the current code, and why does changing
> 
> So to be clear, they are not being generated at all in the guest as the necessary facility is reported as unavailable.
> 
> Let's talk about Linux in LPAR / the host kernel:  When hardware that supports MIO instructions is available, all userspace I/O traffic is going to be routed through the MIO variants of the s390 PCI instructions.  This is working well for other device types, but does not work for ISM which does not support these variants.  However, the ISM driver also does not invoke the userspace I/O routines for the kernel, it invokes the s390 PCI layer directly, which in turn ensures the proper PCI instructions are used -- This approach falls apart when the guest ISM driver invokes those routines in the guest -- we (qemu) pass those non-MIO instructions from the guest as memory operations through vfio-pci, traversing through the vfio I/O layer in the guest (vfio_pci_bar_rw and friends), where we then arrive in the host s390 PCI layer -- where the MIO variant is used because the facility is available.

Slight clarification since I think the word "userspace" is a bit overloaded as
KVM folks often use it to talk about the guest even when that calls through vfio.
Application userspace (i.e. things like DPDK) can use PCI MIO Load/Stores
directly on mmap()ed/ioremap()ed memory these don't go through the Kernel at
all.
QEMU while also in userspace on the other hand goes through the vfio_bar_rw()
region which uses the common code _Kernel_ ioread()/iowrite() API. This Kernel
ioread()/iowrite() API uses PCI MIO Load/Stores by default on machines that
support them (z15 currently).  The ISM driver, knowing that its device does not
support MIO, goes around this API and directly calls zpci_store()/zpci_load().


> 
> Per conversations with Niklas (on CC), it's not trivial to decide by the time we reach the s390 PCI I/O layer to switch gears and use the non-MIO instruction set.

Yes, we have some ideas about dynamically switching to legacy PCI stores in
ioread()/iowrite() for devices that are set up for it but since that only gets
an ioremap()ed address, a value and a size it would evolve such nasty things as
looking at this virtual address to determine if it includes a ZPCI_ADDR()
cookie that we use to get to the function handle needed for the legacy PCI
Load/Stores, while MIO PCI Load/Stores directly work on virtual addresses.

Now purely for the Kernel API we think this could work since that always
allocates between VMALLOC_START and VMALLOC_END and we control where we put the
ZPCI_ADDR() cookie but I'm very hesitant to add something like that.

As for application userspace (DPDK) we do have a syscall
(arch/s390/pci/pci_mmio.c) API that had a similar problem but we could make use
of the fact that our Architecture is pretty nifty with address spaces and just
execute the MIO PCI Load/Store in the syscall _as if_ by the calling userspace
application.


> 
>> the write pattern help?
> 
... snip ...
