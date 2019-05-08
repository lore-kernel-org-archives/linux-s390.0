Return-Path: <SRS0=crtG=TI=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 8 May 2019 23:22:10 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 05/10] s390/cio: introduce DMA pools to cio
In-Reply-To: <alpine.LFD.2.21.1905081447280.1773@schleppi>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-6-pasic@linux.ibm.com>
        <alpine.LFD.2.21.1905081447280.1773@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190508232210.5a555caa.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 8 May 2019 15:18:10 +0200 (CEST)
Sebastian Ott <sebott@linux.ibm.com> wrote:

> > +void cio_gp_dma_free(struct gen_pool *gp_dma, void *cpu_addr, size_t size)
> > +{
> > +	if (!cpu_addr)
> > +		return;
> > +	memset(cpu_addr, 0, size);  
> 
> Hm, normally I'd do the memset during alloc not during free - but maybe
> this makes more sense here with your usecase in mind.

I allocate the backing as zeroed, and zero the memory before putting it
back to the pool. So the stuff in the pool is always zeroed.

> 
> > @@ -1063,6 +1163,7 @@ static int __init css_bus_init(void)
> >  		unregister_reboot_notifier(&css_reboot_notifier);
> >  		goto out_unregister;
> >  	}
> > +	cio_dma_pool_init();  
> 
> This is too late for early devices (ccw console!).

You have already raised concern about this last time (thanks). I think,
I've addressed this issue: tje cio_dma_pool is only used by the airq
stuff. I don't think the ccw console needs it. Please have an other look
at patch #6, and explain your concern in more detail if it persists.

(@Mimu: What do you think, am I wrong here?)

Thanks for having a look!

Regards,
Halil
