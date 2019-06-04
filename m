Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727274AbfFDNI3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 09:08:29 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54D3fHh045014
        for <linux-s390@vger.kernel.org>; Tue, 4 Jun 2019 09:08:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swqd6nc7e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 04 Jun 2019 09:08:27 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 4 Jun 2019 14:08:25 +0100
Date: Tue, 4 Jun 2019 15:08:19 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 7/8] virtio/s390: use DMA memory for ccw I/O and
 classic notifiers
In-Reply-To: <20190603181716.325101d9.cohuck@redhat.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
        <20190529122657.166148-8-mimu@linux.ibm.com>
        <20190603181716.325101d9.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190604150819.1f8707b5.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>

On Mon, 3 Jun 2019 18:17:16 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 29 May 2019 14:26:56 +0200
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
> > From: Halil Pasic <pasic@linux.ibm.com>
> > 
> > Before virtio-ccw could get away with not using DMA API for the pieces of
> > memory it does ccw I/O with. With protected virtualization this has to
> > change, since the hypervisor needs to read and sometimes also write these
> > pieces of memory.
> > 
> > The hypervisor is supposed to poke the classic notifiers, if these are
> > used, out of band with regards to ccw I/O. So these need to be allocated
> > as DMA memory (which is shared memory for protected virtualization
> > guests).
> > 
> > Let us factor out everything from struct virtio_ccw_device that needs to
> > be DMA memory in a satellite that is allocated as such.
> > 
> > Note: The control blocks of I/O instructions do not need to be shared.
> > These are marshalled by the ultravisor.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> > Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> > ---
> >  drivers/s390/virtio/virtio_ccw.c | 177 +++++++++++++++++++++------------------
> >  1 file changed, 96 insertions(+), 81 deletions(-)
> > 
> 
> (...)
> 
> > @@ -176,6 +180,22 @@ static struct virtio_ccw_device *to_vc_device(struct virtio_device *vdev)
> >  	return container_of(vdev, struct virtio_ccw_device, vdev);
> >  }
> >  
> > +static inline void *__vc_dma_alloc(struct virtio_device *vdev, size_t size)
> > +{
> > +	return ccw_device_dma_zalloc(to_vc_device(vdev)->cdev, size);
> > +}
> > +
> > +static inline void __vc_dma_free(struct virtio_device *vdev, size_t size,
> > +				 void *cpu_addr)
> > +{
> > +	return ccw_device_dma_free(to_vc_device(vdev)->cdev, cpu_addr, size);
> > +}
> > +
> > +#define vc_dma_alloc_struct(vdev, ptr) \
> > +	({ptr = __vc_dma_alloc(vdev, sizeof(*(ptr))); })
> > +#define vc_dma_free_struct(vdev, ptr) \
> > +	__vc_dma_free(vdev, sizeof(*(ptr)), (ptr))
> > +
> 
> I *still* don't like these #defines (and the __vc_dma_* functions), as I
> already commented last time. I think they make it harder to follow the
> code.
> 

Sorry! I think we simply forgot to address this comment of yours. 

> >  static void drop_airq_indicator(struct virtqueue *vq, struct airq_info *info)
> >  {
> >  	unsigned long i, flags;
> > @@ -336,8 +356,7 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
> >  	struct airq_info *airq_info = vcdev->airq_info;
> >  
> >  	if (vcdev->is_thinint) {
> > -		thinint_area = kzalloc(sizeof(*thinint_area),
> > -				       GFP_DMA | GFP_KERNEL);
> > +		vc_dma_alloc_struct(&vcdev->vdev, thinint_area);
> 
> Last time I wrote:
> 
> "Any reason why this takes a detour via the virtio device? The ccw
>  device is already referenced in vcdev, isn't it?
>
> thinint_area = ccw_device_dma_zalloc(vcdev->cdev, sizeof(*thinint_area));
> 
>  looks much more obvious to me."
> 
> It still seems more obvious to me.
>


The reason why I decided to introduce __vc_dma_alloc() back then is
because I had no clarity what do we want to do there. If you take a look
the body of __vc_dma_alloc() changed quite a lot, while I the usage not
so much. 

Regarding why is the first argument a pointer struct virtio_device, the
idea was probably to keep the needs to be ZONE_DMA and can use the full
64 bit address space separate. But I abandoned the ideal.

Also vc_dma_alloc_struct() started out more elaborate (I used to manage
a dma_addr_t as well -- see RFC).

I'm not quite sure what is your problem with the these. As far as I
understand, this is another of those matter of taste things. But it ain't
a big deal. 

I will change this for v4 as you requested. Again sorry for missing it!

Regards,
Halil

 
> >  		if (!thinint_area)
> >  			return;
> >  		thinint_area->summary_indicator =
> 
