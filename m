Return-Path: <SRS0=rkwH=SM=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 10 Apr 2019 10:46:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 10/12] virtio/s390: consolidate DMA allocations
Message-ID: <20190410104649.12cdbcba.cohuck@redhat.com>
In-Reply-To: <20190404231622.52531-11-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-11-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri,  5 Apr 2019 01:16:20 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> We can reduce the number of DMA allocations by pulling the bits
> of memory that belongs to virtio_ccw_device and needs to be DMA
> memory into a single area.

That makes a lot of sense (maybe start with introducing the dma area
from the beginning?), but...

> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 48 ++++++++++++++--------------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index aa45a6a027ae..7268149f2ee8 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -49,12 +49,12 @@ struct vq_config_block {
>  struct vcdev_dma_area {
>  	unsigned long indicators;
>  	unsigned long indicators2;
> +	struct vq_config_block config_block;
> +	__u8 status; /* TODO check __aligned(8); */

...I think that needs attention.

>  };
>  
>  struct virtio_ccw_device {
>  	struct virtio_device vdev;
> -	__u8 *status;
> -	dma_addr_t status_dma_addr;
>  	__u8 config[VIRTIO_CCW_CONFIG_SIZE];
>  	struct ccw_device *cdev;
>  	__u32 curr_io;
