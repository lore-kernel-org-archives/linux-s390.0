Return-Path: <SRS0=pOBU=SL=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 9 Apr 2019 15:23:13 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 02/12] virtio/s390: DMA support for virtio-ccw
In-Reply-To: <20190409150120.61abad60.cohuck@redhat.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-3-pasic@linux.ibm.com>
        <20190409115743.26e51b81.cohuck@redhat.com>
        <20190409132927.5df3bc50@oc2783563651>
        <20190409150120.61abad60.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190409152313.0296e8f1@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 9 Apr 2019 15:01:20 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 9 Apr 2019 13:29:27 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Tue, 9 Apr 2019 11:57:43 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > On Fri,  5 Apr 2019 01:16:12 +0200
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > >   
> > > > Currently we have a problem if a virtio-ccw device has
> > > > VIRTIO_F_IOMMU_PLATFORM.   
> > > 
> > > Can you please describe what the actual problem is?
> > >   
> > 
> > Without this patch:

[..]

> > virtio_ccw 0.0.0300: no vq
> > virtio_blk: probe of virtio1 failed with error -12
> > virtio_blk: probe of virtio3 failed with error -12
> > 
> > Means virtio devices broken.
> > 
> > Should I
> > s/we have a problem if a virtio-ccw device/virtio-ccw devices do not work if the device/
> > ?
> 
> Much better :)
> 
> (That is, this happens if we switch on the feature bit in the
> hypervisor, right?)
> 

Yes, that is with qemu -device virtio-blk-ccw,iommu_platform=on (and no
PV whatsoever).

I will change the commit message accordingly. 

[..]

> > > > @@ -1255,6 +1254,18 @@ static int virtio_ccw_online(struct ccw_device *cdev)
> > > >  		ret = -ENOMEM;
> > > >  		goto out_free;
> > > >  	}
> > > > +	vcdev->vdev.dev.parent = &cdev->dev;  
> > > 
> > > That one makes sense, pci and mmio are doing that as well.
> > >   
> > > > +	cdev->dev.dma_mask = &vcdev->dma_mask;  
> > > 
> > > That one feels a bit weird. Will this change in one of the follow-on
> > > patches? (Have not yet looked at the whole series.)  
> > 
> > I don't thinks so. Do you mean this should happen within the cio code?
> > I think I started out with the idea to keep the scope as narrow as
> > possible. Do you have any suggestions?
> 
> From what I see, you set the mask from the virtio-ccw side, then
> propagate it up to the general ccw_device, and then the generic virtio
> code will fetch it from the ccw_device.

Right! For some reason dma_mask is a pointer. And I need virtio core to
use a sane value for virtio_ccw devices.

> Don't you potentially need
> something for other ccw_devices in that protected hipervisor case as
> well (e.g for 3270)?


Maybe, maybe not. The first stage is likely to be virito only. I would
prefer sorting out stuff like 3270 as the need arises. Also see my
response to patch 4 (Message-Id: <20190409141114.7dcce94a@oc2783563651>).

> 
> > 
> > >   
> > > > +
> > > > +	ret = dma_set_mask_and_coherent(&cdev->dev,
> > > > DMA_BIT_MASK(64));
> > > > +	if (ret)
> > > > +		ret = dma_set_mask_and_coherent(&cdev->dev,
> > > > +
> > > > DMA_BIT_MASK(32));
> > > > +	if (ret) {
> > > > +		dev_warn(&cdev->dev, "Failed to enable 64-bit
> > > > or 32-bit DMA.  Trying to continue, but this might not
> > > > work.\n");  
> > > 
> > > This does not look like you'd try to continue?
> > >   
> > 
> > I remember now. First I did continue, then I changed this to fail
> > hard so I can not ignore any such problems while smoke testing ('I
> > don't always check the kernel messages'), but kept the old message.
> > This basically should not fail anyway, otherwise we have a problem
> > AFAIU.
> > 
> > By the way virtio-pci tries to continue indeed, and this is also
> > where the wording comes from ;).
> > 
> > What would you prefer? Try to continue or fail right away?
> 
> If it does not have a chance of working properly in the general case,
> I'd fail.
> 

Agreed! I will make it so. Would dropping '  Trying to continue, but
this might not work.' from the warning message work for you?

I could also drop the attempt to set a 32 bit mask if you agree. Do you?

Many thanks for your review!

Regards,
Halil
