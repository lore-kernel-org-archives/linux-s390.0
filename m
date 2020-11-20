Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 20 Nov 2020 08:55:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] s390: cio: fix two use-after-free bugs in device.c
Message-ID: <20201120085526.257a5596.cohuck@redhat.com>
In-Reply-To: <20201120074849.31557-1-miaoqinglang@huawei.com>
References: <20201120074849.31557-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 15:48:49 +0800
Qinglang Miao <miaoqinglang@huawei.com> wrote:

> put_device calls release function which do kfree() inside.
> So following use of sch&cdev would cause use-after-free bugs.
> 
> Fix these by simply adjusting the position of put_device.
> 
> Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
> Fixes: 74bd0d859dc3 ("s390/cio: fix unlocked access of online member")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/s390/cio/device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index b29fe8d50..69492417b 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -1664,10 +1664,10 @@ void __init ccw_device_destroy_console(struct ccw_device *cdev)
>  	struct io_subchannel_private *io_priv = to_io_private(sch);
>  
>  	set_io_private(sch, NULL);
> -	put_device(&sch->dev);
> -	put_device(&cdev->dev);
>  	dma_free_coherent(&sch->dev, sizeof(*io_priv->dma_area),
>  			  io_priv->dma_area, io_priv->dma_area_dma);
> +	put_device(&sch->dev);
> +	put_device(&cdev->dev);

That change looks reasonable.

>  	kfree(io_priv);
>  }
>  
> @@ -1774,8 +1774,8 @@ static int ccw_device_remove(struct device *dev)
>  				      ret, cdev->private->dev_id.ssid,
>  				      cdev->private->dev_id.devno);
>  		/* Give up reference obtained in ccw_device_set_online(). */
> -		put_device(&cdev->dev);
>  		spin_lock_irq(cdev->ccwlock);
> +		put_device(&cdev->dev);

As the comment above states, the put_device() gives up the reference
obtained in ccw_device_set_online(). There's at least one more
reference remaining (held by the caller of the remove function). Moving
the put_device() does not fix anything here.

>  	}
>  	ccw_device_set_timeout(cdev, 0);
>  	cdev->drv = NULL;
