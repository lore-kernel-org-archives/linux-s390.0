Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29134 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727857AbgLBUa3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Dec 2020 15:30:29 -0500
Date: Wed, 2 Dec 2020 13:28:38 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 1/2] vfio-mdev: Wire in a request handler for mdev
 parent
Message-ID: <20201202132838.6a872c17@w520.home>
In-Reply-To: <20201120180740.87837-2-farman@linux.ibm.com>
References: <20201120180740.87837-1-farman@linux.ibm.com>
        <20201120180740.87837-2-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Fri, 20 Nov 2020 19:07:39 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> While performing some destructive tests with vfio-ccw, where the
> paths to a device are forcible removed and thus the device itself
> is unreachable, it is rather easy to end up in an endless loop in
> vfio_del_group_dev() due to the lack of a request callback for the
> associated device.
> 
> In this example, one MDEV (77c) is used by a guest, while another
> (77b) is not. The symptom is that the iommu is detached from the
> mdev for 77b, but not 77c, until that guest is shutdown:
> 
>     [  238.794867] vfio_ccw 0.0.077b: MDEV: Unregistering
>     [  238.794996] vfio_mdev 11f2d2bc-4083-431d-a023-eff72715c4f0: Removing from iommu group 2
>     [  238.795001] vfio_mdev 11f2d2bc-4083-431d-a023-eff72715c4f0: MDEV: detaching iommu
>     [  238.795036] vfio_ccw 0.0.077c: MDEV: Unregistering
>     ...silence...
> 
> Let's wire in the request call back to the mdev device, so that a
> device being physically removed from the host can be (gracefully?)
> handled by the parent device at the time the device is removed.
> 
> Add a message when registering the device if a driver doesn't
> provide this callback, so a clue is given that this same loop
> may be encountered in a similar situation.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/vfio/mdev/mdev_core.c |  4 ++++
>  drivers/vfio/mdev/vfio_mdev.c | 10 ++++++++++
>  include/linux/mdev.h          |  4 ++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index b558d4cfd082..6de97d25a3f8 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -154,6 +154,10 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
>  	if (!dev)
>  		return -EINVAL;
>  
> +	/* Not mandatory, but its absence could be a problem */
> +	if (!ops->request)
> +		dev_info(dev, "Driver cannot be asked to release device\n");
> +
>  	mutex_lock(&parent_list_lock);
>  
>  	/* Check for duplicate */
> diff --git a/drivers/vfio/mdev/vfio_mdev.c b/drivers/vfio/mdev/vfio_mdev.c
> index 30964a4e0a28..06d8fc4a6d72 100644
> --- a/drivers/vfio/mdev/vfio_mdev.c
> +++ b/drivers/vfio/mdev/vfio_mdev.c
> @@ -98,6 +98,15 @@ static int vfio_mdev_mmap(void *device_data, struct vm_area_struct *vma)
>  	return parent->ops->mmap(mdev, vma);
>  }
>  
> +static void vfio_mdev_request(void *device_data, unsigned int count)
> +{
> +	struct mdev_device *mdev = device_data;
> +	struct mdev_parent *parent = mdev->parent;
> +
> +	if (parent->ops->request)
> +		parent->ops->request(mdev, count);

What do you think about duplicating the count==0 notice in the else
case here?  ie.

	else if (count == 0)
		dev_notice(mdev_dev(mdev), "No mdev vendor driver	request callback support, blocked until released by user\n");

This at least puts something in the log a bit closer to the timeframe
of a possible issue versus the registration nag.  vfio-core could do
this too, but vfio-mdev registers a request callback on behalf of all
mdev devices, so vfio-core would no longer have visibility for this
case.

Otherwise this series looks fine to me and I can take it through the
vfio tree.  Thanks,

Alex

> +}
> +
>  static const struct vfio_device_ops vfio_mdev_dev_ops = {
>  	.name		= "vfio-mdev",
>  	.open		= vfio_mdev_open,
> @@ -106,6 +115,7 @@ static const struct vfio_device_ops vfio_mdev_dev_ops = {
>  	.read		= vfio_mdev_read,
>  	.write		= vfio_mdev_write,
>  	.mmap		= vfio_mdev_mmap,
> +	.request	= vfio_mdev_request,
>  };
>  
>  static int vfio_mdev_probe(struct device *dev)
> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
> index 0ce30ca78db0..9004375c462e 100644
> --- a/include/linux/mdev.h
> +++ b/include/linux/mdev.h
> @@ -72,6 +72,9 @@ struct device *mdev_get_iommu_device(struct device *dev);
>   * @mmap:		mmap callback
>   *			@mdev: mediated device structure
>   *			@vma: vma structure
> + * @request:		request callback to release device
> + *			@mdev: mediated device structure
> + *			@count: request sequence number
>   * Parent device that support mediated device should be registered with mdev
>   * module with mdev_parent_ops structure.
>   **/
> @@ -92,6 +95,7 @@ struct mdev_parent_ops {
>  	long	(*ioctl)(struct mdev_device *mdev, unsigned int cmd,
>  			 unsigned long arg);
>  	int	(*mmap)(struct mdev_device *mdev, struct vm_area_struct *vma);
> +	void	(*request)(struct mdev_device *mdev, unsigned int count);
>  };
>  
>  /* interface for exporting mdev supported type attributes */
