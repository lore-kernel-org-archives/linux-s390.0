From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC 0/8] basic vfio-ccw infrastructure
Date: Fri, 29 Apr 2016 11:17:35 -0600
Message-ID: <20160429111735.0358be80@t450s.home>
References: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 29 Apr 2016 14:11:47 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> vfio: ccw: basic vfio-ccw infrastructure
> ========================================
> 
> Introduction
> ------------
> 
> Here we describe the vfio support for Channel I/O devices (aka. CCW
> devices) for Linux/s390. Motivation for vfio-ccw is to passthrough CCW
> devices to a virtual machine, while vfio is the means.
> 
> Different than other hardware architectures, s390 has defined a unified
> I/O access method, which is so called Channel I/O. It has its own
> access patterns:
> - Channel programs run asynchronously on a separate (co)processor.
> - The channel subsystem will access any memory designated by the caller
>   in the channel program directly, i.e. there is no iommu involved.
> Thus when we introduce vfio support for these devices, we realize it
> with a no-iommu vfio implementation.
> 
> This document does not intend to explain the s390 hardware architecture
> in every detail. More information/reference could be found here:
> - A good start to know Channel I/O in general:
>   https://en.wikipedia.org/wiki/Channel_I/O
> - s390 architecture:
>   s390 Principles of Operation manual (IBM Form. No. SA22-7832)
> - The existing Qemu code which implements a simple emulated channel
>   subsystem could also be a good reference. It makes it easier to
>   follow the flow.
>   qemu/hw/s390x/css.c
> 
> Motivation of vfio-ccw
> ----------------------
> 
> Currently, a guest virtualized via qemu/kvm on s390 only sees
> paravirtualized virtio devices via the "Virtio Over Channel I/O
> (virtio-ccw)" transport. This makes virtio devices discoverable via
> standard operating system algorithms for handling channel devices.
> 
> However this is not enough. On s390 for the majority of devices, which
> use the standard Channel I/O based mechanism, we also need to provide
> the functionality of passing through them to a Qemu virtual machine.
> This includes devices that don't have a virtio counterpart (e.g. tape
> drives) or that have specific characteristics which guests want to
> exploit.
> 
> For passing a device to a guest, we want to use the same interface as
> everybody else, namely vfio. Thus, we would like to introduce vfio
> support for channel devices. And we would like to name this new vfio
> device "vfio-ccw".
> 
> Access patterns of CCW devices
> ------------------------------
> 
> s390 architecture has implemented a so called channel subsystem, that
> provides a unified view of the devices physically attached to the
> systems. Though the s390 hardware platform knows about a huge variety of
> different peripheral attachments like disk devices (aka. DASDs), tapes,
> communication controllers, etc. They can all be accessed by a well
> defined access method and they are presenting I/O completion a unified
> way: I/O interruptions.
> 
> All I/O requires the use of channel command words (CCWs). A CCW is an
> instruction to a specialized I/O channel processor. A channel program
> is a sequence of CCWs which are executed by the I/O channel subsystem.
> To issue a CCW program to the channel subsystem, it is required to
> build an operation request block (ORB), which can be used to point out
> the format of the CCW and other control information to the system. The
> operating system signals the I/O channel subsystem to begin executing
> the channel program with a SSCH (start sub-channel) instruction. The
> central processor is then free to proceed with non-I/O instructions
> until interrupted. The I/O completion result is received by the
> interrupt handler in the form of interrupt response block (IRB).
> 
> Back to vfio-ccw, in short:
> - ORBs and CCW programs are built in user space (with virtual
>   addresses).
> - ORBs and CCW programs are passed to the kernel.
> - kernel translates virtual addresses to real addresses and starts the
>   IO with issuing a privileged Channel I/O instruction (e.g SSCH).
> - CCW programs run asynchronously on a separate processor.
> - I/O completion will be signaled to the host with I/O interruptions.
>   And it will be copied as IRB to user space.
> 
> 
> vfio-ccw patches overview
> -------------------------
> 
> It follows that we need vfio-ccw with a vfio no-iommu mode. For now,
> our patches are based on the current no-iommu implementation. It's a
> good start to launch the code review for vfio-ccw. Note that the
> implementation is far from complete yet; but we'd like to get feedback
> for the general architecture.
> 
> The current no-iommu implementation would consider vfio-ccw as
> unsupported and will taint the kernel. This should be not true for
> vfio-ccw. But whether the end result will be using the existing
> no-iommu code or a new module would be an implementation detail.
> 
> * CCW translation APIs
> - Description:
>   These introduce a group of APIs (start with 'ccwchain_') to do CCW
>   translation. The CCWs passed in by a user space program are organized
>   in a buffer, with their user virtual memory addresses. These APIs will
>   copy the CCWs into the kernel space, and assemble a runnable kernel
>   CCW program by updating the user virtual addresses with their
>   corresponding physical addresses.
> - Patches:
>   vfio: ccw: introduce page array interfaces
>   vfio: ccw: introduce ccw chain interfaces
> 
> * vfio-ccw device driver
> - Description:
>   The following patches introduce vfio-ccw, which utilizes the CCW
>   translation APIs. vfio-ccw is a driver for vfio-based ccw devices
>   which can bind to any device that is passed to the guest and
>   implements the following vfio ioctls:
>     VFIO_DEVICE_GET_INFO
>     VFIO_DEVICE_CCW_HOT_RESET
>     VFIO_DEVICE_CCW_CMD_REQUEST
>   With this CMD_REQUEST ioctl, user space program can pass a CCW
>   program to the kernel, to do further CCW translation before issuing
>   them to a real device. Currently we map I/O that is basically async
>   to this synchronous interface, which means it will not return until
>   the interrupt handler got the I/O execution result.
> - Patches:
>   vfio: ccw: basic implementation for vfio_ccw driver
>   vfio: ccw: realize VFIO_DEVICE_GET_INFO ioctl
>   vfio: ccw: realize VFIO_DEVICE_CCW_HOT_RESET ioctl
>   vfio: ccw: realize VFIO_DEVICE_CCW_CMD_REQUEST ioctl
> 
> The user of vfio-ccw is not limited to Qemu, while Qemu is definitely a
> good example to get understand how these patches work. Here is a little
> bit more detail how an I/O request triggered by the Qemu guest will be
> handled (without error handling).
> 
> Explanation:
> Q1-Q4: Qemu side process.
> K1-K6: Kernel side process.
> 
> Q1. Intercept a ssch instruction.
> Q2. Translate the guest ccw program to a user space ccw program
>     (u_ccwchain).

Is this replacing guest physical address in the program with QEMU
virtual addresses?

> Q3. Call VFIO_DEVICE_CCW_CMD_REQUEST (u_ccwchain, orb, irb).
>     K1. Copy from u_ccwchain to kernel (k_ccwchain).
>     K2. Translate the user space ccw program to a kernel space ccw
>         program, which becomes runnable for a real device.

And here we translate and likely pin QEMU virtual address to physical
addresses to further modify the program sent into the channel?

>     K3. With the necessary information contained in the orb passed in
>         by Qemu, issue the k_ccwchain to the device, and wait event q
>         for the I/O result.
>     K4. Interrupt handler gets the I/O result, and wakes up the wait q.
>     K5. CMD_REQUEST ioctl gets the I/O result, and uses the result to
>         update the user space irb.
>     K6. Copy irb and scsw back to user space.
> Q4. Update the irb for the guest.

If the answers to my questions above are both yes, then this is really
a mediated interface, not a direct assignment.  We don't need an iommu
because we're policing and translating the program for the device
before it gets sent to hardware.  I think there are better ways than
noiommu to handle such devices perhaps even with better performance
than this two-stage translation.  In fact, I think the solution we plan
to implement for vGPU support would work here.

Like your device, a vGPU is mediated, we don't have IOMMU level
translation or isolation since a vGPU is largely a software construct,
but we do have software policing and translating how the GPU is
programmed.  To do this we're creating a type1 compatible vfio iommu
backend that uses the existing map and unmap ioctls, but rather than
programming them into an IOMMU for a device, it simply stores the
translations for use by later requests.  This means that a device
programmed in a VM with guest physical addresses can have the
vfio kernel convert that address to process virtual address, pin the
page and program the hardware with the host physical address in one
step.

This architecture also makes the vfio api completely compatible with
existing usage without tainting QEMU with support for noiommu devices.
I would strongly suggest following a similar approach and dropping the
noiommu interface.  We really do not need to confuse users with noiommu
devices that are safe and assignable and devices where noiommu should
warn them to stay away.  Thanks,

Alex
