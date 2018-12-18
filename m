From: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v3 2/6] vfio: ccw: Rework subchannel state on setup
Date: Tue, 18 Dec 2018 12:44:17 -0500
Message-ID: <ccead686-3c35-9a4a-3d9e-b88fd7170205@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
 <1543408867-16465-3-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543408867-16465-3-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, pasic@linux.vnet.ibm.com
Cc: cohuck@redhat.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

My questions to this patch from the original RFC series are still 
outstanding.  :(

https://marc.info/?l=linux-s390&m=154223063716128&w=2

On 11/28/2018 07:41 AM, Pierre Morel wrote:
> The subchannel enablement and the according setting to the
> VFIO_CCW_STATE_STANDBY state should only be done when all
> parts of the VFIO mediated device have been initialized
> i.e. after the mediated device has been successfully opened.
> 
> Let's stay in VFIO_CCW_STATE_NOT_OPER until the mediated
> device has been opened and set the VFIO_CCW_STATE_STANDBY
> on a successful open.
> 
> On release the state is set back to VFIO_CCW_STATE_NOT_OPER
> by vfio_ccw_sch_quiesce().
> 
> When the mediated device is closed,  disable the sub channel
> by calling vfio_ccw_sch_quiesce().
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_async.c   | 11 +++++++++++

Ah, this series is built on Connie's async changes.  Okay.  [1]

>   drivers/s390/cio/vfio_ccw_drv.c     | 10 +---------
>   drivers/s390/cio/vfio_ccw_ops.c     | 27 +++++++++++++++++++++------
>   drivers/s390/cio/vfio_ccw_private.h |  1 +
>   4 files changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
> index 8c7f51d..033574e 100644
> --- a/drivers/s390/cio/vfio_ccw_async.c
> +++ b/drivers/s390/cio/vfio_ccw_async.c
> @@ -76,6 +76,17 @@ const struct vfio_ccw_regops vfio_ccw_async_region_ops = {
>   	.release = vfio_ccw_async_region_release,
>   };
>   
> +void vfio_ccw_unregister_async_dev_regions(struct vfio_ccw_private *private)
> +{
> +	int i;
> +
> +	for (i = 0; i < private->num_regions; i++)
> +		private->region[i].ops->release(private, &private->region[i]);
> +	private->num_regions = 0;
> +	kfree(private->region);
> +	private->region = NULL;
> +} > +
>   int vfio_ccw_register_async_dev_regions(struct vfio_ccw_private *private)
>   {
>   	return vfio_ccw_register_dev_region(private,
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index bce7fed..d3527b6 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -133,26 +133,18 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
>   	private->sch = sch;
>   	dev_set_drvdata(&sch->dev, private);
>   
> -	spin_lock_irq(sch->lock);
>   	private->state = VFIO_CCW_STATE_NOT_OPER;
>   	sch->isc = VFIO_CCW_ISC;
> -	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
> -	spin_unlock_irq(sch->lock);
> -	if (ret)
> -		goto out_free;
>   
>   	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
>   	atomic_set(&private->avail, 1);
> -	private->state = VFIO_CCW_STATE_STANDBY;
>   
>   	ret = vfio_ccw_mdev_reg(sch);
>   	if (ret)
> -		goto out_disable;
> +		goto out_free;
>   
>   	return 0;
>   
> -out_disable:
> -	cio_disable_subchannel(sch);
>   out_free:
>   	dev_set_drvdata(&sch->dev, NULL);
>   	if (private->cmd_region)
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 0e1f7f7b..cc7d46a 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -113,14 +113,11 @@ static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>   	struct vfio_ccw_private *private =
>   		dev_get_drvdata(mdev_parent_dev(mdev));
>   
> -	if (private->state == VFIO_CCW_STATE_NOT_OPER)
> -		return -ENODEV;
> -
>   	if (atomic_dec_if_positive(&private->avail) < 0)
>   		return -EPERM;
>   
>   	private->mdev = mdev;
> -	private->state = VFIO_CCW_STATE_IDLE;
> +	private->state = VFIO_CCW_STATE_NOT_OPER;
>   
>   	return 0;
>   }
> @@ -148,6 +145,7 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
>   	struct vfio_ccw_private *private =
>   		dev_get_drvdata(mdev_parent_dev(mdev));
>   	unsigned long events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
> +	struct subchannel *sch = private->sch;
>   	int ret;
>   
>   	private->nb.notifier_call = vfio_ccw_mdev_notifier;
> @@ -159,8 +157,24 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
>   
>   	ret = vfio_ccw_register_async_dev_regions(private);
>   	if (ret)
> -		vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> -					 &private->nb);
> +		goto err_regions;
> +
> +	spin_lock_irq(private->sch->lock);
> +	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
> +	if (ret)
> +		goto err_enable;
> +
> +	private->state = VFIO_CCW_STATE_STANDBY;
> +	spin_unlock_irq(sch->lock);
> +	return 0;
> +
> +err_enable:
> +	spin_unlock_irq(sch->lock);
> +	vfio_ccw_unregister_async_dev_regions(private);
> +
> +err_regions:
> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +				 &private->nb);
>   	return ret;
>   }
>   
> @@ -170,6 +184,7 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
>   		dev_get_drvdata(mdev_parent_dev(mdev));
>   	int i;
>   
> +	vfio_ccw_sch_quiesce(private->sch);
>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>   				 &private->nb);

[1] If Connie's async patches go in first, then the stuff in your 
"vfio_ccw_unregister_async_dev_regions" is also added here.  That could 
be removed and replaced with a call to your new function, yes?

>   
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 1a41a14..5d799b7 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -54,6 +54,7 @@ int vfio_ccw_register_dev_region(struct vfio_ccw_private *private,
>   				 size_t size, u32 flags, void *data);
>   
>   int vfio_ccw_register_async_dev_regions(struct vfio_ccw_private *private);
> +void vfio_ccw_unregister_async_dev_regions(struct vfio_ccw_private *private);
>   
>   /**
>    * struct vfio_ccw_private
> 
