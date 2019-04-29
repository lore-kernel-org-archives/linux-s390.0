Return-Path: <SRS0=+MMY=S7=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 29 Apr 2019 18:07:02 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v7 2/4] vfio: ap: register IOMMU VFIO notifier
In-Reply-To: <1556283688-556-3-git-send-email-pmorel@linux.ibm.com>
References: <1556283688-556-1-git-send-email-pmorel@linux.ibm.com>
        <1556283688-556-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190429180702.641c9110.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 26 Apr 2019 15:01:26 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> @@ -858,7 +887,17 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>  		return ret;
>  	}
>  
> -	return 0;
> +	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
> +	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +				     &events, &matrix_mdev->iommu_notifier);
> +	if (!ret)
> +		return ret;
> +
> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> +				 &matrix_mdev->group_notifier);
> +	module_put(THIS_MODULE);

Can you please explain this module_put() here? I don't see anything in
the cover letter.

Regards,
Halil

> +	return ret;
>  }
