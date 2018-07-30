From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 30 Jul 2018 13:19:37 +0000
Subject: Re: [PATCH v7 11/22] s390: vfio-ap: sysfs interfaces to configure domains
Message-Id: <20180730151937.56e7c3f5.cohuck@redhat.com>
In-Reply-To: <20180726195429.31960-12-borntraeger@de.ibm.com>
References: <20180726195429.31960-12-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Jul 2018 21:54:18 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:


> +static ssize_t assign_domain_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	int ret;
> +	unsigned long apqi;
> +	struct mdev_device *mdev = mdev_from_dev(dev);
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
> +
> +	ret = kstrtoul(buf, 0, &apqi);
> +	if (ret || (apqi > max_apqi)) {
> +		pr_warn("%s: %s: domain id '%s' not a value from 0 to %02lu(%#04lx)\n",
> +		       VFIO_AP_MODULE_NAME, __func__, buf, max_apqi, max_apqi);

I have the same comments regarding messages and checking as for the
previous patch.

> +
> +		if (!ret)
> +			ret = -EINVAL;
> +
> +		return ret;
> +	}
> +
> +	/* Set the bit in the AQM (bitmask) corresponding to the AP domain
> +	 * number (APQI). The bits in the mask, from most significant to least
> +	 * significant, correspond to numbers 0-255.
> +	 */
> +	mutex_lock(&matrix_dev.lock);
> +	set_bit_inv(apqi, matrix_mdev->matrix.aqm);
> +	ret = count;
> +
> +	mutex_unlock(&matrix_dev.lock);
> +
> +	return ret;
> +}
> +DEVICE_ATTR_WO(assign_domain);
