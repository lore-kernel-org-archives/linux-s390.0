Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 3 Jun 2019 16:22:19 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 2/8] s390/cio: introduce DMA pools to cio
In-Reply-To: <20190603160428.2112077a.pasic@linux.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
        <20190529122657.166148-3-mimu@linux.ibm.com>
        <20190603133745.240c00a7.cohuck@redhat.com>
        <035b4bd3-5856-e8e5-91bf-ba0b5c7c3736@linux.ibm.com>
        <20190603160428.2112077a.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190603162219.31de2df9.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 3 Jun 2019 16:04:28 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 3 Jun 2019 14:09:02 +0200
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
> > >> @@ -1059,16 +1168,19 @@ static int __init css_bus_init(void)
> > >>   	if (ret)
> > >>   		goto out_unregister;
> > >>   	ret = register_pm_notifier(&css_power_notifier);
> > >> -	if (ret) {
> > >> -		unregister_reboot_notifier(&css_reboot_notifier);
> > >> -		goto out_unregister;
> > >> -	}
> > >> +	if (ret)
> > >> +		goto out_unregister_rn;
> > >> +	ret = cio_dma_pool_init();
> > >> +	if (ret)
> > >> +		goto out_unregister_rn;  
> > > 
> > > Don't you also need to unregister the pm notifier on failure here?  
> > 
> > Mmh, that was the original intention. Thanks!
> 
> I suppose we could also move cio_dma_pool_init() right before the
> register_reboot_notifier() call and goto out_unregister on error.
> 

Forget it, then we have to rollback the pool creation if the register
stuff fails... Sorry for the noise.

Regards,
Halil
