Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728700AbgJ1V5l (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Oct 2020 17:57:41 -0400
Date: Wed, 28 Oct 2020 09:17:58 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v11 07/14] s390/vfio-ap: sysfs attribute to display the
 guest's matrix
Message-ID: <20201028091758.73aa77a3.pasic@linux.ibm.com>
In-Reply-To: <20201022171209.19494-8-akrowiak@linux.ibm.com>
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
        <20201022171209.19494-8-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Thu, 22 Oct 2020 13:12:02 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> +static ssize_t guest_matrix_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	ssize_t nchars;
> +	struct mdev_device *mdev = mdev_from_dev(dev);
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +
> +	if (!vfio_ap_mdev_has_crycb(matrix_mdev))
> +		return -ENODEV;

I'm wondering, would it make sense to have guest_matrix display the would
be guest matrix when we don't have a KVM? With the filtering in
place, the question in what guest_matrix would my (assign) matrix result
right now if I were to hook up my vfio_ap_mdev to a guest seems a
legitimate one.


> +
> +	mutex_lock(&matrix_dev->lock);
> +	nchars = vfio_ap_mdev_matrix_show(&matrix_mdev->shadow_apcb, buf);
> +	mutex_unlock(&matrix_dev->lock);
> +
> +	return nchars;
> +}
> +static DEVICE_ATTR_RO(guest_matrix);
