Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 3 Dec 2020 11:19:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] s390/vfio-ap: Clean up vfio_ap resources when KVM
 pointer invalidated
Message-ID: <20201203111907.72a89884.cohuck@redhat.com>
In-Reply-To: <20201202234101.32169-1-akrowiak@linux.ibm.com>
References: <20201202234101.32169-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com

On Wed,  2 Dec 2020 18:41:01 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The vfio_ap device driver registers a group notifier with VFIO when the
> file descriptor for a VFIO mediated device for a KVM guest is opened to
> receive notification that the KVM pointer is set (VFIO_GROUP_NOTIFY_SET_KVM
> event). When the KVM pointer is set, the vfio_ap driver stashes the pointer
> and calls the kvm_get_kvm() function to increment its reference counter.
> When the notifier is called to make notification that the KVM pointer has
> been set to NULL, the driver should clean up any resources associated with
> the KVM pointer and decrement its reference counter. The current
> implementation does not take care of this clean up.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index e0bde8518745..eeb9c9130756 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1083,6 +1083,17 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>  	return NOTIFY_DONE;
>  }
>  
> +static void vfio_ap_mdev_put_kvm(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	if (matrix_mdev->kvm) {
> +		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> +		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> +		vfio_ap_mdev_reset_queues(matrix_mdev->mdev);
> +		kvm_put_kvm(matrix_mdev->kvm);
> +		matrix_mdev->kvm = NULL;
> +	}
> +}
> +
>  static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>  				       unsigned long action, void *data)
>  {
> @@ -1095,7 +1106,7 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>  	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
>  
>  	if (!data) {
> -		matrix_mdev->kvm = NULL;
> +		vfio_ap_mdev_put_kvm(matrix_mdev);

Hm. I'm wondering whether you need to hold the maxtrix_dev lock here as
well?

>  		return NOTIFY_OK;
>  	}
>  
> @@ -1222,13 +1233,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>  
>  	mutex_lock(&matrix_dev->lock);
> -	if (matrix_mdev->kvm) {
> -		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> -		matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> -		vfio_ap_mdev_reset_queues(mdev);
> -		kvm_put_kvm(matrix_mdev->kvm);
> -		matrix_mdev->kvm = NULL;
> -	}
> +	vfio_ap_mdev_put_kvm(matrix_mdev);
>  	mutex_unlock(&matrix_dev->lock);
>  
>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
