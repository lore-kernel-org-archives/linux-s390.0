Return-Path: <SRS0=9P2n=T3=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 27 May 2019 12:53:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 4/8] s390/airq: use DMA memory for adapter interrupts
Message-ID: <20190527125320.7540049a.cohuck@redhat.com>
In-Reply-To: <20190523162209.9543-5-mimu@linux.ibm.com>
References: <20190523162209.9543-1-mimu@linux.ibm.com>
        <20190523162209.9543-5-mimu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 23 May 2019 18:22:05 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.ibm.com>
> 
> Protected virtualization guests have to use shared pages for airq
> notifier bit vectors, because hypervisor needs to write these bits.
> 
> Let us make sure we allocate DMA memory for the notifier bit vectors by
> replacing the kmem_cache with a dma_cache and kalloc() with
> cio_dma_zalloc().
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  arch/s390/include/asm/airq.h |  2 ++
>  drivers/s390/cio/airq.c      | 32 ++++++++++++++++++++------------
>  drivers/s390/cio/cio.h       |  2 ++
>  drivers/s390/cio/css.c       |  1 +
>  4 files changed, 25 insertions(+), 12 deletions(-)

(...)

> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index 789f6ecdbbcc..f09521771a32 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -1173,6 +1173,7 @@ static int __init css_bus_init(void)
>  		goto out_unregister;
>  	}
>  	cio_dma_pool_init();
> +	airq_init();
>  	css_init_done = 1;
>  
>  	/* Enable default isc for I/O subchannels. */

Not directly related to this patch (I don't really have any comment
here), but I started looking at the code again and now I'm wondering
about chsc. I think it came up before, but I can't remember if chsc
needed special treatment... Anyway, css_bus_init() uses some chscs
early (before cio_dma_pool_init), so we could not use the pools there,
even if we wanted to. Do chsc commands either work, or else fail
benignly on a protected virt guest?
