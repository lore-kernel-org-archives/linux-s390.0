From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC 0/8] basic vfio-ccw infrastructure
Date: Wed, 4 May 2016 13:26:53 -0600
Message-ID: <20160504132653.766c54db@t450s.home>
References: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
	<20160429111735.0358be80@t450s.home>
	<20160504172629.77226d35@oc7835276234>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160504172629.77226d35@oc7835276234>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 4 May 2016 17:26:29 +0800
Dong Jia <bjsdjshi@linux.vnet.ibm.com> wrote:

> On Fri, 29 Apr 2016 11:17:35 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> Dear Alex:
> 
> Thanks for the comments.
> 
> [...]
> 
> > > 
> > > The user of vfio-ccw is not limited to Qemu, while Qemu is definitely a
> > > good example to get understand how these patches work. Here is a little
> > > bit more detail how an I/O request triggered by the Qemu guest will be
> > > handled (without error handling).
> > > 
> > > Explanation:
> > > Q1-Q4: Qemu side process.
> > > K1-K6: Kernel side process.
> > > 
> > > Q1. Intercept a ssch instruction.
> > > Q2. Translate the guest ccw program to a user space ccw program
> > >     (u_ccwchain).  
> > 
> > Is this replacing guest physical address in the program with QEMU
> > virtual addresses?  
> Yes.
> 
> >   
> > > Q3. Call VFIO_DEVICE_CCW_CMD_REQUEST (u_ccwchain, orb, irb).
> > >     K1. Copy from u_ccwchain to kernel (k_ccwchain).
> > >     K2. Translate the user space ccw program to a kernel space ccw
> > >         program, which becomes runnable for a real device.  
> > 
> > And here we translate and likely pin QEMU virtual address to physical
> > addresses to further modify the program sent into the channel?  
> Yes. Exactly.
> 
> >   
> > >     K3. With the necessary information contained in the orb passed in
> > >         by Qemu, issue the k_ccwchain to the device, and wait event q
> > >         for the I/O result.
> > >     K4. Interrupt handler gets the I/O result, and wakes up the wait q.
> > >     K5. CMD_REQUEST ioctl gets the I/O result, and uses the result to
> > >         update the user space irb.
> > >     K6. Copy irb and scsw back to user space.
> > > Q4. Update the irb for the guest.  
> > 
> > If the answers to my questions above are both yes,  
> Yes, they are.
> 
> > then this is really a mediated interface, not a direct assignment.  
> Right. This is true.
> 
> > We don't need an iommu
> > because we're policing and translating the program for the device
> > before it gets sent to hardware.  I think there are better ways than
> > noiommu to handle such devices perhaps even with better performance
> > than this two-stage translation.  In fact, I think the solution we plan
> > to implement for vGPU support would work here.
> > 
> > Like your device, a vGPU is mediated, we don't have IOMMU level
> > translation or isolation since a vGPU is largely a software construct,
> > but we do have software policing and translating how the GPU is
> > programmed.  To do this we're creating a type1 compatible vfio iommu
> > backend that uses the existing map and unmap ioctls, but rather than
> > programming them into an IOMMU for a device, it simply stores the
> > translations for use by later requests.  This means that a device
> > programmed in a VM with guest physical addresses can have the
> > vfio kernel convert that address to process virtual address, pin the
> > page and program the hardware with the host physical address in one
> > step.  
> I've read through the mail threads those discuss how to add vGPU
> support in VFIO. I'm afraid that proposal could not be simply addressed
> to this case, especially if we want to make the vfio api completely
> compatible with the existing usage.
> 
> AFAIU, a PCI device (or a vGPU device) uses a dedicated, exclusive and
> fixed range of address in the memory space for DMA operations. Any
> address inside this range will not be used for other purpose. Thus we
> can add memory listener on this range, and pin the pages for further
> use (DMA operation). And we can keep the pages pinned during the life
> cycle of the VM (not quite accurate, or I should say 'the target
> device').

That's not entirely accurate.  Ignoring a guest IOMMU, current device
assignment pins all of guest memory, not just a dedicated, exclusive
range of it, in order to map it through the hardware IOMMU.  That gives
the guest the ability to transparently perform DMA with the device
since the IOMMU maps the guest physical to host physical translations.

That's not what vGPU is about.  In the case of vGPU the proposal is to
use the same QEMU vfio MemoryListener API, but only for the purpose of
having an accurate database of guest physical to process virtual
translations for the VM.  In your above example, this means step Q2 is
eliminated because step K2 has the information to perform both a guest
physical to process virtual translation and to pin the page to get a
host physical address.  So you'd only need to modify the program once.

> Well, a Subchannel Device does not have such a range of address. The
> device driver simply calls kalloc() to get a piece of memory, and
> assembles a ccw program with it, before issuing the ccw program to
> perform an I/O operation. So the Qemu memory listener can't tell if an
> address is for an I/O operation, or for whatever else. And this makes
> the memory listener unnecessary for our case.

It's only unnecessary because QEMU is manipulating the program to
replace those addresses with process virtual addresses.  The purpose
of the MemoryListener in the vGPU approach is only to inform the
kernel so that it can perform that translation itself.
 
> The only time point that we know we should pin pages for I/O, is the
> time that an I/O instruction (e.g. ssch) was intercepted. At this
> point, we know the address contented in the parameter of the ssch
> instruction points to a piece of memory that contents a ccw program.
> Then we do: pin the pages --> convert the ccw program --> perform the
> I/O --> return the I/O result --> and unpin the pages.

And you could do exactly the same with the vGPU model, it's simply a
difference of how many times the program is converted and using the
MemoryListener to update guest physical to process virtual addresses in
the kernel.

> > This architecture also makes the vfio api completely compatible with
> > existing usage without tainting QEMU with support for noiommu devices.
> > I would strongly suggest following a similar approach and dropping the
> > noiommu interface.  We really do not need to confuse users with noiommu
> > devices that are safe and assignable and devices where noiommu should
> > warn them to stay away.  Thanks,  
> Understand. But like explained above, even if we introduce a new vfio
> iommu backend, what it does would probably look quite like what the
> no-iommu backend does. Any idea about this?

It's not, a mediated device simply shifts the isolation guarantees from
hardware protection in an IOMMU to software protection in a mediated
vfio bus driver.  The IOMMU interface simply becomes a database through
which we can perform in-kernel translations.  All you want is the vfio
device model and you have the ability to do that in a secure way, which
is the same as vGPU.  The no-iommu code is intended to provide the vfio
device model in a known-to-be-insecure means.  I don't think you want
to build on that and I don't think we want no-iommu anywhere near
QEMU.  Thanks,

Alex
