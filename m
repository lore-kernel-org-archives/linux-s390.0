From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v4 09/16] vfio: ccw: realize VFIO_DEVICE_GET_REGION_INFO
 ioctl
Date: Tue, 21 Mar 2017 12:47:34 -0600
Message-ID: <20170321124734.57ee620c@t450s.home>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
        <20170317031743.40128-10-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170317031743.40128-10-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 17 Mar 2017 04:17:36 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Introduce device information about vfio-ccw: VFIO_DEVICE_FLAGS_CCW.
> Realize VFIO_DEVICE_GET_REGION_INFO ioctl for vfio-ccw.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_ops.c | 78 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       | 11 ++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 878c882..f3300dd 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -188,6 +188,83 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>  	return count;
>  }
>  
> +static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info)
> +{
> +	info->flags = VFIO_DEVICE_FLAGS_CCW;
> +	info->num_regions = VFIO_CCW_NUM_REGIONS;
> +	info->num_irqs = 0;
> +
> +	return 0;
> +}
> +
> +static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
> +					 u16 *cap_type_id,
> +					 void **cap_type)
> +{
> +	switch (info->index) {
> +	case VFIO_CCW_CONFIG_REGION_INDEX:
> +		info->offset = 0;
> +		info->size = sizeof(struct ccw_io_region);
> +		info->flags = VFIO_REGION_INFO_FLAG_READ
> +			      | VFIO_REGION_INFO_FLAG_WRITE;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
> +				   unsigned int cmd,
> +				   unsigned long arg)
> +{
> +	int ret = 0;
> +	unsigned long minsz;
> +
> +	switch (cmd) {
> +	case VFIO_DEVICE_GET_INFO:
> +	{
> +		struct vfio_device_info info;
> +
> +		minsz = offsetofend(struct vfio_device_info, num_irqs);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz)
> +			return -EINVAL;
> +
> +		ret = vfio_ccw_mdev_get_device_info(&info);
> +		if (ret)
> +			return ret;
> +
> +		return copy_to_user((void __user *)arg, &info, minsz);
> +	}
> +	case VFIO_DEVICE_GET_REGION_INFO:
> +	{
> +		struct vfio_region_info info;
> +		u16 cap_type_id = 0;
> +		void *cap_type = NULL;
> +
> +		minsz = offsetofend(struct vfio_region_info, offset);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz)
> +			return -EINVAL;
> +
> +		ret = vfio_ccw_mdev_get_region_info(&info, &cap_type_id,
> +						    &cap_type);
> +		if (ret)
> +			return ret;
> +
> +		return copy_to_user((void __user *)arg, &info, minsz);
> +	}
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
>  static const struct mdev_parent_ops vfio_ccw_mdev_ops = {
>  	.owner			= THIS_MODULE,
>  	.supported_type_groups  = mdev_type_groups,
> @@ -197,6 +274,7 @@ static const struct mdev_parent_ops vfio_ccw_mdev_ops = {
>  	.release		= vfio_ccw_mdev_release,
>  	.read			= vfio_ccw_mdev_read,
>  	.write			= vfio_ccw_mdev_write,
> +	.ioctl			= vfio_ccw_mdev_ioctl,
>  };
>  
>  int vfio_ccw_mdev_reg(struct subchannel *sch)
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 6183789..3fd70ff 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -198,6 +198,7 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
>  #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
>  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
> +#define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  };
> @@ -447,6 +448,16 @@ enum {
>  	VFIO_PCI_NUM_IRQS
>  };
>  
> +/*
> + * The vfio-ccw bus driver makes use of the following fixed region.
> + * Unimplemented regions return a size of zero.
> + */
> +
> +enum {
> +	VFIO_CCW_CONFIG_REGION_INDEX,
> +	VFIO_CCW_NUM_REGIONS
> +};
> +
>  /**
>   * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IORW(VFIO_TYPE, VFIO_BASE + 12,
>   *					      struct vfio_pci_hot_reset_info)


Acked-by: Alex Williamson <alex.williamson@redhat.com>
