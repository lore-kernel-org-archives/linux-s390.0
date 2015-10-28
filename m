From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 4/4] s390/virtio: use noop dma ops
Date: Wed, 28 Oct 2015 09:44:09 +0100
Message-ID: <20151028094409.0538745b.cornelia.huck@de.ibm.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
	<1445986131-239566-5-git-send-email-borntraeger@de.ibm.com>
	<20151028004334.GD2805@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20151028004334.GD2805@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 28 Oct 2015 09:43:34 +0900
Joerg Roedel <jroedel@suse.de> wrote:

> On Tue, Oct 27, 2015 at 11:48:51PM +0100, Christian Borntraeger wrote:
> > @@ -1093,6 +1094,7 @@ static void virtio_ccw_auto_online(void *data, async_cookie_t cookie)
> >  	struct ccw_device *cdev = data;
> >  	int ret;
> >  
> > +	cdev->dev.archdata.dma_ops = &dma_noop_ops;
> >  	ret = ccw_device_set_online(cdev);
> >  	if (ret)
> >  		dev_warn(&cdev->dev, "Failed to set online: %d\n", ret);
> 
> Hmm, drivers usually don't deal with setting the dma_ops for their
> devices, as they depend on the platform and not so much on the device
> itself.
> 
> Can you do this special-case handling from device independent platform
> code, where you also setup dma_ops for other devices?

Hm, maybe at the bus level?

pci devices get s390_dma_ops, ccw devices get the noop dma ops (just a
bit of dead weight for non-virtio ccw devices, I guess).

The old style s390-virtio devices are the odd ones around, but I'd like
to invest the least time possible there to keep them going.
