Return-Path: <SRS0=9P2n=T3=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 27 May 2019 14:00:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 8/8] virtio/s390: make airq summary indicators DMA
Message-ID: <20190527140018.7c2d34ff.cohuck@redhat.com>
In-Reply-To: <20190523162209.9543-9-mimu@linux.ibm.com>
References: <20190523162209.9543-1-mimu@linux.ibm.com>
        <20190523162209.9543-9-mimu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 23 May 2019 18:22:09 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.ibm.com>
> 
> Hypervisor needs to interact with the summary indicators, so these
> need to be DMA memory as well (at least for protected virtualization
> guests).
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

(...)

> @@ -1501,6 +1508,7 @@ static int __init virtio_ccw_init(void)
>  {
>  	/* parse no_auto string before we do anything further */
>  	no_auto_parse();
> +	summary_indicators = cio_dma_zalloc(MAX_AIRQ_AREAS);

What happens if this fails?

>  	return ccw_driver_register(&virtio_ccw_driver);
>  }
>  device_initcall(virtio_ccw_init);
