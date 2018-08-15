From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 15/22] s390: vfio-ap: implement mediated device open
 callback
Date: Wed, 15 Aug 2018 18:08:14 +0200
Message-ID: <20180815180814.5985e3f0.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-16-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534196899-16987-16-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 13 Aug 2018 17:48:12 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Implements the open callback on the mediated matrix device.
> The function registers a group notifier to receive notification
> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
> the vfio_ap device driver will get access to the guest's
> kvm structure. The open callback must ensure that only one
> mediated device shall be opened per guest.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c     |  174 ++++++++++++++++++++++++++++++++-
>  drivers/s390/crypto/vfio_ap_private.h |    2 +
>  2 files changed, 175 insertions(+), 1 deletions(-)

> @@ -602,7 +633,6 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
>  }
>  DEVICE_ATTR_RO(matrix);
>  
> -

Nit: whitespace change

>  static struct attribute *vfio_ap_mdev_attrs[] = {
>  	&dev_attr_assign_adapter.attr,
>  	&dev_attr_unassign_adapter.attr,

(...)

> +/**
> + * vfio_ap_mdev_open_once
> + *
> + * @matrix_mdev: a mediated matrix device
> + *
> + * Return 0 if no other mediated matrix device has been opened for the
> + * KVM guest assigned to @matrix_mdev; otherwise, returns an error.
> + */
> +static int vfio_ap_mdev_open_once(struct ap_matrix_mdev *matrix_mdev,
> +				  struct kvm *kvm)

You're passing kvm in here, but do not use it.

> +{
> +	struct ap_matrix_mdev *m;
> +
> +	mutex_lock(&matrix_dev.lock);
> +
> +	list_for_each_entry(m, &matrix_dev.mdev_list, list) {
> +		if ((m != matrix_mdev) && (m->kvm == matrix_mdev->kvm)) {

If you used it here instead of matrix_mdev->kvm...

> +			mutex_unlock(&matrix_dev.lock);
> +			return -EPERM;
> +		}
> +	}
> +
> +	mutex_unlock(&matrix_dev.lock);
> +
> +	return 0;
> +}
> +
> +static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	int ret;
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
> +		return NOTIFY_OK;
> +
> +	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
> +
> +	matrix_mdev->kvm = data;
> +	if (data == NULL)
> +		return NOTIFY_OK;
> +
> +	ret = vfio_ap_mdev_open_once(matrix_mdev, data);

...you could move this up to before overwriting matrix_mdev->kvm and
bailing out when the check failed, which makes more sense to me.

> +	if (ret)
> +		return ret;
> +
> +	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
> +	if (ret)
> +		return ret;

It probably makes more sense to return NOTIFY_DONE in the error case
(NOTIFY_BAD does not sound like a good idea as it would stop processing
the notifier chain).

> +
> +	vfio_ap_mdev_copy_masks(matrix_mdev);
> +
> +	return NOTIFY_OK;
> +}

Otherwise, looks sane.
