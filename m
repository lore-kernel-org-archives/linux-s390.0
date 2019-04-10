Return-Path: <SRS0=rkwH=SM=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 10 Apr 2019 15:02:25 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 05/12] s390/cio: add protected virtualization
 support to cio
In-Reply-To: <20190410102557.1ba89d96.cohuck@redhat.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-6-pasic@linux.ibm.com>
        <20190409195548.6dea6e40.cohuck@redhat.com>
        <20190410021044.4da3e847@oc2783563651>
        <20190410102557.1ba89d96.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410150225.61b86cd9@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 10 Apr 2019 10:25:57 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 10 Apr 2019 02:10:44 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Tue, 9 Apr 2019 19:55:48 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > On Fri,  5 Apr 2019 01:16:15 +0200
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > > > Thus we need to make sure any memory that is used for communication with
> > > > the hypervisor is shared.  
> > > 
> > > In this context, does 'hypervisor' always mean 'QEMU/KVM'? If Other
> > > Hypervisors implement protected virtualization, we probably need to
> > > make sure that all common I/O layer control blocks are in the dma area
> > > (including e.g. QDIO), not just what virtio-ccw devices use.
> > >   
> > 
> > Hypervisor could theoretically be something different than QEMU/KVM. Yet,
> > as stated before, this series is about getting virtio-ccw working
> > (modulo the TODOs). 
> 
> Sure, just wanted to point it out. If this is "enable the common I/O
> layer, except for QDIO" or so, that would sound fine to me :)
> 

Right except QDIO. Series cares only about the bits relevant for
virtio-ccw. I guess I should make that clearer in the commit message.


> > 
> > [..]
> > 
> > > >    
> > > 
> > > So, this leaves some things I'm not sure about, especially as I do not
> > > know the architecture of this new feature.
> > > 
> > > - This applies only to asynchronously handled things, it seems? So
> > >   things like control blocks modified by stsch/msch/etc does not need
> > >   special treatment?  
> > 
> > I had a feeble attempt at explaining this in the cover letter:
> > 
> > * make sure that virtio-ccw specific stuff uses shared memory when
> >   talking to the hypervisor (except communication blocks like ORB, these
> >   are handled by the hypervisor)
> > 
> > Unfortunately the last 'hypervisor' was supposed to be 'ultravisor'.
> > 
> > I.e. the ultravisor will take care of exposing the control blocks
> > to the hypervisor (and of changes as well).
> 
> Yeah, that "control blocks" or "communication blocks" leaves me a bit
> fuzzy :)

Yeah. I don't know if there is an official name for the stuff. For
the ORB of SSCH control block seems quite fitting. For the SCHIB of
STSCH communication seems a better fit.

> 
> So, what is a high-level summary of areas that need the treatment?
> What I get from looking at the patches so far, it's:
> - stuff that is written by the hypervisor's interrupt injection code:
>   IRB, indicators, etc.

In interrupt context IRB behaves like a control block. We don't have
to make it shared.

I moved IRB because of snse:


@@ -329,9 +329,9 @@ ccw_device_do_sense(struct ccw_device *cdev, struct
irb *irb) /*
         * We have ending status but no sense information. Do a basic
sense. */
-       sense_ccw = &to_io_private(sch)->sense_ccw;
+       sense_ccw = &to_io_private(sch)->dma_area->sense_ccw;
        sense_ccw->cmd_code = CCW_CMD_BASIC_SENSE;
-       sense_ccw->cda = (__u32) __pa(cdev->private->irb.ecw);
+       sense_ccw->cda = (__u32) __pa(cdev->private->dma_area->irb.ecw);

as the irb.ecw is used as channel program data. And that needs to be
shared.

> - buffers that are filled by a channel program: sense, sense id, etc.
> - ccws themselves (because of translation?)
> 

Right. The idea is: smallish, basically fixed size a readily available
control blocks (specified as a ) are copied back and forth by the
ultravisor (via SIE SD).

Regards,
Halil
