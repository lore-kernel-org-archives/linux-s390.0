From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v10 11/26] s390: vfio-ap: implement mediated device open
 callback
Date: Tue, 18 Sep 2018 19:00:43 +0200
Message-ID: <0ba9647d-76d8-1a6c-bed0-fadd0af496cc@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 09/12/2018 09:43 PM, Tony Krowiak wrote:
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
> +{
> +	struct ap_matrix_mdev *m;
> +
> +	mutex_lock(&matrix_dev->lock);
> +
> +	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
> +		if ((m != matrix_mdev) && (m->kvm == kvm)) {
> +			mutex_unlock(&matrix_dev->lock);
> +			return -EPERM;
> +		}
> +	}
> +
> +	mutex_unlock(&matrix_dev->lock);
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
> +	if (!data) {
> +		matrix_mdev->kvm = NULL;
> +		return NOTIFY_OK;
> +	}
> +
> +	ret = vfio_ap_mdev_open_once(matrix_mdev, data);

This could be racy. Two threads doing vfio_ap_mdev_group_notifier()
can first get 0 here in a sense that there is no such kvm in the list,
and then both set the very same kvm three lines below. Which would
result in what we are trying to prevent.

Also vfio_ap_mdev_open_once() does not seem like an appropriate name
any more. If we were to do the matrix_mdev->kvm = kvm in there we could
call it something like vfio_ap_mdev_set_kvm().

> +	if (ret)
> +		return NOTIFY_DONE;
> +
> +	matrix_mdev->kvm = data;
> +
> +	ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
> +	if (ret)
> +		return ret;
> +
> +	vfio_ap_mdev_copy_masks(matrix_mdev);
> +
> +	return NOTIFY_OK;
> +}
