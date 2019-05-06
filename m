Return-Path: <SRS0=l9rD=TG=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 3/7] s390: vfio-ap: sysfs interface to display guest
 CRYCB
References: <1556918073-13171-1-git-send-email-akrowiak@linux.ibm.com>
 <1556918073-13171-4-git-send-email-akrowiak@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 6 May 2019 08:54:31 +0200
MIME-Version: 1.0
In-Reply-To: <1556918073-13171-4-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <a2361365-050e-dfdd-ccd2-0167ccfcdfbf@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 03/05/2019 23:14, Tony Krowiak wrote:
> Introduces a sysfs interface on the matrix mdev device to display the
> contents of the shadow of the guest's CRYCB
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 59 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 44a04b4aa9ae..1021466cb661 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -771,6 +771,64 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
>   }
>   static DEVICE_ATTR_RO(matrix);
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
> +	unsigned long napm_bits;
> +	unsigned long naqm_bits;
> +	int nchars = 0;
> +	int n;
> +
> +	if (!matrix_mdev->shadow_crycb)
> +		return -ENODEV;
> +
> +	mutex_lock(&matrix_dev->lock);
> +	napm_bits = matrix_mdev->shadow_crycb->apm_max + 1;
> +	naqm_bits = matrix_mdev->shadow_crycb->aqm_max + 1;
> +	apid1 = find_first_bit_inv(matrix_mdev->shadow_crycb->apm, napm_bits);
> +	apqi1 = find_first_bit_inv(matrix_mdev->shadow_crycb->aqm, naqm_bits);
> +
> +	if ((apid1 < napm_bits) && (apqi1 < naqm_bits)) {
> +		for_each_set_bit_inv(apid, matrix_mdev->shadow_crycb->apm,
> +				     napm_bits) {
> +			for_each_set_bit_inv(apqi,
> +					     matrix_mdev->shadow_crycb->aqm,
> +					     naqm_bits) {
> +				n = sprintf(bufpos, "%02lx.%04lx\n", apid,
> +					    apqi);
> +				bufpos += n;
> +				nchars += n;
> +			}
> +		}
> +	} else if (apid1 < napm_bits) {
> +		for_each_set_bit_inv(apid, matrix_mdev->shadow_crycb->apm,
> +				     napm_bits) {
> +			n = sprintf(bufpos, "%02lx.\n", apid);
> +			bufpos += n;
> +			nchars += n;
> +		}
> +	} else if (apqi1 < naqm_bits) {
> +		for_each_set_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm,
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
> +static DEVICE_ATTR_RO(guest_matrix);
> +
>   static struct attribute *vfio_ap_mdev_attrs[] = {
>   	&dev_attr_assign_adapter.attr,
>   	&dev_attr_unassign_adapter.attr,
> @@ -780,6 +838,7 @@ static struct attribute *vfio_ap_mdev_attrs[] = {
>   	&dev_attr_unassign_control_domain.attr,
>   	&dev_attr_control_domains.attr,
>   	&dev_attr_matrix.attr,
> +	&dev_attr_guest_matrix.attr,
>   	NULL,
>   };
>   
> 

Code seems very similar to matrix_show, can't you share the code?





-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
