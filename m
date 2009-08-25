From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Date: Tue, 25 Aug 2009 08:48:47 +0000
Subject: Re: [PATCH] cio: double put_device() in subchannel_register()
Message-Id: <alpine.LFD.2.00.0908251046060.3246@localhost.localdomain>
In-Reply-To: <4A92BA1C.4050909@gmail.com>
References: <4A92BA1C.4050909@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

On Mon, 24 Aug 2009, Roel Kluin wrote:

> If the device can't be registered, put_device(&cdev->dev) occured here
> and after out_err:.
> 

The additional put_device should not be removed.

To register a ccw device we use device_initialize, do some
asynchronous recognition and call io_subchannel_register() via a
workqueue.
So in io_subchannel_register the refcount should be 2 (1 for the
initialization and 1 for workqueue processing). If the device_add
fails at this point we drop both references, so that the devices'
release function gets called.

Regards,
Sebastian

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index 3c57c1a..8c17757 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -999,8 +999,6 @@ io_subchannel_register(struct work_struct *work)
>  		spin_lock_irqsave(sch->lock, flags);
>  		sch_set_cdev(sch, NULL);
>  		spin_unlock_irqrestore(sch->lock, flags);
> -		/* Release initial device reference. */
> -		put_device(&cdev->dev);
>  		goto out_err;
>  	}
>  out:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
