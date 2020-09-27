Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61704 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbgI0AD0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Sep 2020 20:03:26 -0400
Date: Sun, 27 Sep 2020 02:03:16 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v10 10/16] s390/vfio-ap: allow configuration of matrix
 mdev in use by a KVM guest
Message-ID: <20200927020316.38bf3fa1.pasic@linux.ibm.com>
In-Reply-To: <20200821195616.13554-11-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-11-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 21 Aug 2020 15:56:10 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The current support for pass-through crypto adapters does not allow
> configuration of a matrix mdev when it is in use by a KVM guest. Let's
> allow AP resources - i.e., adapters, domains and control domains - to be
> assigned to or unassigned from a matrix mdev while it is in use by a guest.
> This is in preparation for the introduction of support for dynamic
> configuration of the AP matrix for a running KVM guest.

AFAIU this will let the user do the assign, which will however only take
effect if the same mdev is re-used with a freshly constructed VM, or?

This is however supposed to change real soon (in patch 11). From the
perspective of bisectability we would end up with a single commit that
acts funny.

How about switching up patches 10 and 11. This way the changes you have
in the current 11 would remain dormant until the changes in the current
10 enable the complete new feature (hotplug)?


> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 24fd47e43b80..cf3321eb239b 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -773,10 +773,6 @@ static ssize_t assign_adapter_store(struct device *dev,
>  	struct mdev_device *mdev = mdev_from_dev(dev);
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>  
> -	/* If the guest is running, disallow assignment of adapter */
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> -
>  	ret = kstrtoul(buf, 0, &apid);
>  	if (ret)
>  		return ret;
> @@ -828,10 +824,6 @@ static ssize_t unassign_adapter_store(struct device *dev,
>  	struct mdev_device *mdev = mdev_from_dev(dev);
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>  
> -	/* If the guest is running, disallow un-assignment of adapter */
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> -
>  	ret = kstrtoul(buf, 0, &apid);
>  	if (ret)
>  		return ret;
> @@ -891,10 +883,6 @@ static ssize_t assign_domain_store(struct device *dev,
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>  	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
>  
> -	/* If the guest is running, disallow assignment of domain */
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> -
>  	ret = kstrtoul(buf, 0, &apqi);
>  	if (ret)
>  		return ret;
> @@ -946,10 +934,6 @@ static ssize_t unassign_domain_store(struct device *dev,
>  	struct mdev_device *mdev = mdev_from_dev(dev);
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>  
> -	/* If the guest is running, disallow un-assignment of domain */
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> -
>  	ret = kstrtoul(buf, 0, &apqi);
>  	if (ret)
>  		return ret;
> @@ -991,10 +975,6 @@ static ssize_t assign_control_domain_store(struct device *dev,
>  	struct mdev_device *mdev = mdev_from_dev(dev);
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>  
> -	/* If the guest is running, disallow assignment of control domain */
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> -
>  	ret = kstrtoul(buf, 0, &id);
>  	if (ret)
>  		return ret;
> @@ -1036,10 +1016,6 @@ static ssize_t unassign_control_domain_store(struct device *dev,
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>  	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
>  
> -	/* If the guest is running, disallow un-assignment of control domain */
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> -
>  	ret = kstrtoul(buf, 0, &domid);
>  	if (ret)
>  		return ret;
