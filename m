Return-Path: <SRS0=pOBU=SL=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 9 Apr 2019 15:01:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 02/12] virtio/s390: DMA support for virtio-ccw
Message-ID: <20190409150120.61abad60.cohuck@redhat.com>
In-Reply-To: <20190409132927.5df3bc50@oc2783563651>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-3-pasic@linux.ibm.com>
        <20190409115743.26e51b81.cohuck@redhat.com>
        <20190409132927.5df3bc50@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 9 Apr 2019 13:29:27 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 9 Apr 2019 11:57:43 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri,  5 Apr 2019 01:16:12 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> > > Currently we have a problem if a virtio-ccw device has
> > > VIRTIO_F_IOMMU_PLATFORM.   
> > 
> > Can you please describe what the actual problem is?
> >   
> 
> Without this patch:
> 
> WARNING: CPU: 2 PID: 26
> at [..]/kernel/dma/mapping.c:251
> dma_alloc_attrs+0x8e/0xd0 Modules linked in: CPU: 2 PID: 26 Comm:
> kworker/u6:1 Not tainted 5.1.0-rc3-00023-g1ec89ec #596 Hardware name:
> IBM 2964 NC9 712 (KVM/Linux) Workqueue: events_unbound async_run_entry_fn
> Krnl PSW : 0704c00180000000 000000000021b18e (dma_alloc_attrs+0x8e/0xd0)
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> Krnl GPRS: 0000000000000000 0000000000000000 0000000000000000
> 0000000000001406 000003e00040f838 0000000000002dc0 0000000000000100
> 0000000000000001 0000000000001000 000000000236f028 000003e00040f838
> 0000000000001406 000000004b289828 0000000000000080 000003e00040f6f8
> 000003e00040f6a0 Krnl Code: 000000000021b17e: f0e00004ebaf
> srp	4(15,%r0),2991(%r14),0 000000000021b184: f0c0000407f4
> srp	4(13,%r0),2036,0 #000000000021b18a: a7f40001
> brc	15,21b18c >000000000021b18e: ec5520bc0055	risbg
> %r5,%r5,32,188,0 000000000021b194: b9020011		ltgr
> %r1,%r1 000000000021b198: a784ffd9		brc	8,21b14a
>            000000000021b19c: e31010000002	ltg	%r1,0(%r1)
>            000000000021b1a2: a7840012		brc	8,21b1c6
> Call Trace:
> ([<0000000000000004>] 0x4)
>  [<00000000007a7d54>] vring_alloc_queue+0x74/0x90 
>  [<00000000007a8390>] vring_create_virtqueue+0xf8/0x288 
>  [<0000000000919ec0>] virtio_ccw_find_vqs+0xf8/0x950 
>  [<000000000080772e>] init_vq+0x16e/0x318 
>  [<00000000008087c4>] virtblk_probe+0xf4/0xb58 
>  [<00000000007a62a6>] virtio_dev_probe+0x1a6/0x250 
>  [<00000000007ea498>] really_probe+0x1c8/0x290 
>  [<00000000007ea746>] driver_probe_device+0x86/0x160 
>  [<00000000007e7cba>] bus_for_each_drv+0x7a/0xc0 
>  [<00000000007ea23c>] __device_attach+0xfc/0x180 
>  [<00000000007e9116>] bus_probe_device+0xae/0xc8 
>  [<00000000007e5066>] device_add+0x3fe/0x698 
>  [<00000000007a5d92>] register_virtio_device+0xca/0x120 
>  [<00000000009195a2>] virtio_ccw_online+0x1b2/0x220 
>  [<000000000089853e>] ccw_device_set_online+0x1d6/0x4d8 
>  [<0000000000918cf6>] virtio_ccw_auto_online+0x26/0x58 
>  [<00000000001a61b6>] async_run_entry_fn+0x5e/0x158 
>  [<0000000000199322>] process_one_work+0x25a/0x668 
>  [<000000000019977a>] worker_thread+0x4a/0x428 
>  [<00000000001a1ae8>] kthread+0x150/0x170 
>  [<0000000000aeab3a>] kernel_thread_starter+0x6/0xc 
>  [<0000000000aeab34>] kernel_thread_starter+0x0/0xc 
> 
> [..]
> 
> virtio_ccw 0.0.0301: no vq
> ---[ end trace d35815958c12cad3 ]---
> virtio_ccw 0.0.0300: no vq
> virtio_blk: probe of virtio1 failed with error -12
> virtio_blk: probe of virtio3 failed with error -12
> 
> Means virtio devices broken.
> 
> Should I
> s/we have a problem if a virtio-ccw device/virtio-ccw devices do not work if the device/
> ?

Much better :)

(That is, this happens if we switch on the feature bit in the
hypervisor, right?)

> 
> > > In future we do want to support DMA API with
> > > virtio-ccw.
> > > 
> > > Let us do the plumbing, so the feature VIRTIO_F_IOMMU_PLATFORM works
> > > with virtio-ccw.
> > > 
> > > Let us also switch from legacy avail/used accessors to the DMA aware
> > > ones (even if it isn't strictly necessary).  
> > 
> > I think with this change we can remove the legacy accessors, if I
> > didn't mis-grep.
> >   
> 
> That is possible, I can do that in v1.

Sounds good.

> 
> > > 
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > ---
> > >  drivers/s390/virtio/virtio_ccw.c | 23 +++++++++++++++++------
> > >  1 file changed, 17 insertions(+), 6 deletions(-)

(...)

> > > @@ -1255,6 +1254,18 @@ static int virtio_ccw_online(struct ccw_device *cdev)
> > >  		ret = -ENOMEM;
> > >  		goto out_free;
> > >  	}
> > > +	vcdev->vdev.dev.parent = &cdev->dev;  
> > 
> > That one makes sense, pci and mmio are doing that as well.
> >   
> > > +	cdev->dev.dma_mask = &vcdev->dma_mask;  
> > 
> > That one feels a bit weird. Will this change in one of the follow-on
> > patches? (Have not yet looked at the whole series.)  
> 
> I don't thinks so. Do you mean this should happen within the cio code?
> I think I started out with the idea to keep the scope as narrow as
> possible. Do you have any suggestions?

From what I see, you set the mask from the virtio-ccw side, then
propagate it up to the general ccw_device, and then the generic virtio
code will fetch it from the ccw_device. Don't you potentially need
something for other ccw_devices in that protected hipervisor case as
well (e.g for 3270)?

> 
> >   
> > > +
> > > +	ret = dma_set_mask_and_coherent(&cdev->dev, DMA_BIT_MASK(64));
> > > +	if (ret)
> > > +		ret = dma_set_mask_and_coherent(&cdev->dev,
> > > +						DMA_BIT_MASK(32));
> > > +	if (ret) {
> > > +		dev_warn(&cdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");  
> > 
> > This does not look like you'd try to continue?
> >   
> 
> I remember now. First I did continue, then I changed this to fail hard
> so I can not ignore any such problems while smoke testing ('I don't always
> check the kernel messages'), but kept the old message. This basically
> should not fail anyway, otherwise we have a problem AFAIU.
> 
> By the way virtio-pci tries to continue indeed, and this is also where
> the wording comes from ;).
> 
> What would you prefer? Try to continue or fail right away?

If it does not have a chance of working properly in the general case,
I'd fail.

> 
> Regards,
> Halil
> 
> > > +		goto out_free;
> > > +	}
> > > +
> > >  	vcdev->config_block = kzalloc(sizeof(*vcdev->config_block),
> > >  				   GFP_DMA | GFP_KERNEL);
> > >  	if (!vcdev->config_block) {  
> >   
> 
