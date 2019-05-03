Return-Path: <SRS0=yMf+=TD=vger.kernel.org=kvm-owner@kernel.org>
Date: Fri, 3 May 2019 11:31:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 02/10] virtio/s390: DMA support for virtio-ccw
Message-ID: <20190503113142.7a93da81.cohuck@redhat.com>
In-Reply-To: <20190426183245.37939-3-pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-3-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 26 Apr 2019 20:32:37 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Currently virtio-ccw devices do not work if the device has
> VIRTIO_F_IOMMU_PLATFORM. In future we do want to support DMA API with
> virtio-ccw.
> 
> Let us do the plumbing, so the feature VIRTIO_F_IOMMU_PLATFORM works
> with virtio-ccw.
> 
> Let us also switch from legacy avail/used accessors to the DMA aware
> ones (even if it isn't strictly necessary), and remove the legacy
> accessors (we were the last users).
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 22 +++++++++++++++-------
>  include/linux/virtio.h           | 17 -----------------
>  2 files changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 2c66941ef3d0..42832a164546 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c

(...)

> @@ -1258,6 +1257,16 @@ static int virtio_ccw_online(struct ccw_device *cdev)
>  		ret = -ENOMEM;
>  		goto out_free;
>  	}
> +
> +	vcdev->vdev.dev.parent = &cdev->dev;
> +	cdev->dev.dma_mask = &vcdev->dma_mask;
> +	/* we are fine with common virtio infrastructure using 64 bit DMA */
> +	ret = dma_set_mask_and_coherent(&cdev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		dev_warn(&cdev->dev, "Failed to enable 64-bit DMA.\n");

Drop the trailing period?

> +		goto out_free;
> +	}
> +
>  	vcdev->config_block = kzalloc(sizeof(*vcdev->config_block),
>  				   GFP_DMA | GFP_KERNEL);
>  	if (!vcdev->config_block) {

(...)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Also 5.2 material, I think.
