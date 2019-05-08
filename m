Return-Path: <SRS0=crtG=TI=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 8 May 2019 15:58:48 +0200 (CEST)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 07/10] s390/airq: use DMA memory for adapter interrupts
In-Reply-To: <20190426183245.37939-8-pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com> <20190426183245.37939-8-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1905081553580.1773@schleppi>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On Fri, 26 Apr 2019, Halil Pasic wrote:
> @@ -182,6 +190,8 @@ void airq_iv_release(struct airq_iv *iv)
>  	kfree(iv->ptr);
>  	kfree(iv->bitlock);
>  	kfree(iv->vector);

-  	kfree(iv->vector);

> +	dma_free_coherent(cio_get_dma_css_dev(), iv_size(iv->bits),
> +			  iv->vector, iv->vector_dma);
>  	kfree(iv->avail);
>  	kfree(iv);
>  }

Looks good to me but needs adaption to current code. Probably you can just
revert my changes introducing cacheline aligned vectors since we now use
a whole page.
