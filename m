Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 17 Sep 2020 16:34:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 07/16] s390/vfio-ap: sysfs attribute to display the
 guest's matrix
Message-ID: <20200917163448.4db80db3.cohuck@redhat.com>
In-Reply-To: <20200821195616.13554-8-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-8-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Fri, 21 Aug 2020 15:56:07 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The matrix of adapters and domains configured in a guest's CRYCB may
> differ from the matrix of adapters and domains assigned to the matrix mdev,
> so this patch introduces a sysfs attribute to display the matrix of a guest
> using the matrix mdev. For a matrix mdev denoted by $uuid, the crycb for a
> guest using the matrix mdev can be displayed as follows:
> 
>    cat /sys/devices/vfio_ap/matrix/$uuid/guest_matrix
> 
> If a guest is not using the matrix mdev at the time the crycb is displayed,
> an error (ENODEV) will be returned.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 58 +++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index efb229033f9e..30bf23734af6 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1119,6 +1119,63 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(matrix);
>  
> +static ssize_t guest_matrix_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct mdev_device *mdev = mdev_from_dev(dev);
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	char *bufpos = buf;
> +	unsigned long apid;
> +	unsigned long apqi;
> +	unsigned long apid1;
> +	unsigned long apqi1;
> +	unsigned long napm_bits = matrix_mdev->shadow_apcb.apm_max + 1;
> +	unsigned long naqm_bits = matrix_mdev->shadow_apcb.aqm_max + 1;
> +	int nchars = 0;
> +	int n;
> +
> +	if (!vfio_ap_mdev_has_crycb(matrix_mdev))
> +		return -ENODEV;
> +
> +	apid1 = find_first_bit_inv(matrix_mdev->shadow_apcb.apm, napm_bits);
> +	apqi1 = find_first_bit_inv(matrix_mdev->shadow_apcb.aqm, naqm_bits);
> +
> +	mutex_lock(&matrix_dev->lock);
> +
> +	if ((apid1 < napm_bits) && (apqi1 < naqm_bits)) {
> +		for_each_set_bit_inv(apid, matrix_mdev->shadow_apcb.apm,
> +				     napm_bits) {
> +			for_each_set_bit_inv(apqi,
> +					     matrix_mdev->shadow_apcb.aqm,
> +					     naqm_bits) {
> +				n = sprintf(bufpos, "%02lx.%04lx\n", apid,
> +					    apqi);
> +				bufpos += n;
> +				nchars += n;
> +			}
> +		}
> +	} else if (apid1 < napm_bits) {
> +		for_each_set_bit_inv(apid, matrix_mdev->shadow_apcb.apm,
> +				     napm_bits) {
> +			n = sprintf(bufpos, "%02lx.\n", apid);
> +			bufpos += n;
> +			nchars += n;
> +		}
> +	} else if (apqi1 < naqm_bits) {
> +		for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm,
> +				     naqm_bits) {
> +			n = sprintf(bufpos, ".%04lx\n", apqi);
> +			bufpos += n;
> +			nchars += n;
> +		}
> +	}
> +
> +	mutex_unlock(&matrix_dev->lock);
> +
> +	return nchars;
> +}

This basically looks like a version of matrix_show() operating on the
shadow apcb. I'm wondering if we could consolidate these two functions
by passing in the structure to operate on as a parameter? Might not be
worth the effort, though.
