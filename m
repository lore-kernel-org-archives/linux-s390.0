From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 18/22] s390: vfio-ap: implement VFIO_DEVICE_RESET
 ioctl
Date: Wed, 15 Aug 2018 18:38:35 +0200
Message-ID: <20180815183835.66470bc6.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-19-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534196899-16987-19-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 13 Aug 2018 17:48:15 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Implements the VFIO_DEVICE_RESET ioctl. This ioctl zeroizes
> all of the AP queues assigned to the guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index cc90323..d4a065b 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -832,7 +832,7 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
>  	if (info.argsz < minsz)
>  		return -EINVAL;
>  
> -	info.flags = VFIO_DEVICE_FLAGS_AP;
> +	info.flags = VFIO_DEVICE_FLAGS_AP | VFIO_DEVICE_FLAGS_RESET;
>  	info.num_regions = 0;
>  	info.num_irqs = 0;
>  
> @@ -848,6 +848,9 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
>  	case VFIO_DEVICE_GET_INFO:
>  		ret = vfio_ap_mdev_get_device_info(arg);
>  		break;
> +	case VFIO_DEVICE_RESET:
> +		ret = vfio_ap_mdev_reset_queues(mdev, true);

If I see it correctly, you call this function only ever with force ==
true (here and in the previous patch). Is that what you intended?

> +		break;
>  	default:
>  		ret = -EOPNOTSUPP;
>  		break;
