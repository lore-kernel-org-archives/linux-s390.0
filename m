From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] vfio-ccw: update documentation
Date: Tue, 16 Jan 2018 16:57:13 +0100
Message-ID: <20180116165713.666cce5b.cohuck@redhat.com>
References: <20180115104353.27413-1-cohuck@redhat.com>
        <20180115104353.27413-2-cohuck@redhat.com>
        <20180116065703.GF12499@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116065703.GF12499@bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 16 Jan 2018 14:57:03 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2018-01-15 11:43:53 +0100]:
> 
> > The vfio-ccw documentation comes from the cover letter of the
> > original patch submission, which shows in some parts. Give it some
> > love; in particular:
> > 
> > - Remove/rework statements that make sense in a cover letter, but not
> >   in regular documentation.
> > - Fix some typos.
> > - Describe the current limitations in more detail.  
> Nice.
> 
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  Documentation/s390/vfio-ccw.txt | 78 +++++++++++++++++++----------------------
> >  1 file changed, 37 insertions(+), 41 deletions(-)
> > 
> > diff --git a/Documentation/s390/vfio-ccw.txt b/Documentation/s390/vfio-ccw.txt
> > index 90b3dfead81b..c3dfbdcf0c8d 100644
> > --- a/Documentation/s390/vfio-ccw.txt
> > +++ b/Documentation/s390/vfio-ccw.txt
> > @@ -28,7 +28,7 @@ every detail. More information/reference could be found here:
> >    https://en.wikipedia.org/wiki/Channel_I/O
> >  - s390 architecture:
> >    s390 Principles of Operation manual (IBM Form. No. SA22-7832)
> > -- The existing Qemu code which implements a simple emulated channel
> > +- The existing QEMU code which implements a simple emulated channel
> >    subsystem could also be a good reference. It makes it easier to follow
> >    the flow.
> >    qemu/hw/s390x/css.c
> > @@ -39,22 +39,21 @@ For vfio mediated device framework:
> >  Motivation of vfio-ccw
> >  ----------------------
> > 
> > -Currently, a guest virtualized via qemu/kvm on s390 only sees
> > +Typically, a guest virtualized via qemu/kvm on s390 only sees  
> No need to s/qemu/QEMU/ here?

Ah, I looked only for Qemu, not qemu. I'll make that QEMU/KVM.

> 
> >  paravirtualized virtio devices via the "Virtio Over Channel I/O
> >  (virtio-ccw)" transport. This makes virtio devices discoverable via
> >  standard operating system algorithms for handling channel devices.
> > 
> >  However this is not enough. On s390 for the majority of devices, which
> >  use the standard Channel I/O based mechanism, we also need to provide
> > -the functionality of passing through them to a Qemu virtual machine.
> > +the functionality of passing through them to a QEMU virtual machine.
> >  This includes devices that don't have a virtio counterpart (e.g. tape
> >  drives) or that have specific characteristics which guests want to
> >  exploit.
> > 
> >  For passing a device to a guest, we want to use the same interface as
> > -everybody else, namely vfio. Thus, we would like to introduce vfio
> > -support for channel devices. And we would like to name this new vfio
> > -device "vfio-ccw".
> > +everybody else, namely vfio. We implement this vfio support for channel
> > +devices via the vfio device "vfio-ccw".  
> The vfio-ccw device implementation was used in one iteration in the
> passed. We now implement via the mediated device stuff, and vfio-ccw
> subchannel device driver. So, how about changing the above line to:
>   devices via the vfio mediated device framework and the new added
>   subchannel device driver "vfio_ccw".

OK, will change that.

> 
> Otherwise, LGTM.

Thanks for looking!
