Return-Path: <SRS0=ZS0J=TJ=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 9 May 2019 12:11:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 05/10] s390/cio: introduce DMA pools to cio
Message-ID: <20190509121106.48aa04db.cohuck@redhat.com>
In-Reply-To: <20190508232210.5a555caa.pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-6-pasic@linux.ibm.com>
        <alpine.LFD.2.21.1905081447280.1773@schleppi>
        <20190508232210.5a555caa.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Sebastian Ott <sebott@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 8 May 2019 23:22:10 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 8 May 2019 15:18:10 +0200 (CEST)
> Sebastian Ott <sebott@linux.ibm.com> wrote:

> > > @@ -1063,6 +1163,7 @@ static int __init css_bus_init(void)
> > >  		unregister_reboot_notifier(&css_reboot_notifier);
> > >  		goto out_unregister;
> > >  	}
> > > +	cio_dma_pool_init();    
> > 
> > This is too late for early devices (ccw console!).  
> 
> You have already raised concern about this last time (thanks). I think,
> I've addressed this issue: tje cio_dma_pool is only used by the airq
> stuff. I don't think the ccw console needs it. Please have an other look
> at patch #6, and explain your concern in more detail if it persists.

What about changing the naming/adding comments here, so that (1) folks
aren't confused by the same thing in the future and (2) folks don't try
to use that pool for something needed for the early ccw consoles?
