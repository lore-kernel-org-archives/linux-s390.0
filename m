From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 11/14] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
Date: Thu, 15 Mar 2018 10:42:33 +0100
Message-ID: <fee58106-a481-aaf8-7fb6-8d51c4b7e906@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-12-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521051954-25715-12-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 14/03/2018 19:25, Tony Krowiak wrote:
> Provides a sysfs interface to view the AP matrix configured for the
> mediated matrix device.
>
> The relevant sysfs structures are:
>
> /sys/devices/vfio_ap
> ... [matrix]
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ...............[$uuid]
> .................. matrix
>
> To view the matrix configured for the mediated matrix device,
> print the matrix file:
>
> 	cat matrix
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c |   39 +++++++++++++++++++++++++++++++++++++
>   1 files changed, 39 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 461d450..04f7a92 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -692,6 +692,44 @@ static ssize_t control_domains_show(struct device *dev,
>   }
>   DEVICE_ATTR_RO(control_domains);
>
> +static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct mdev_device *mdev = mdev_from_dev(dev);
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	char *bufpos = buf;
> +	unsigned long apid;
> +	unsigned long apqi;
> +	int nchars = 0;
> +	int n;
> +
> +	n = sprintf(bufpos, "ADAPTER.DOMAIN\n");

For easy parsing it is better to only report the interesting data
and let a user space utility make fancy presentation.

> +	bufpos += n;
> +	nchars += n;
> +
> +	n = sprintf(bufpos, "--------------\n");
> +	bufpos += n;
> +	nchars += n;
> +
> +	for_each_set_bit_inv(apid, matrix_mdev->matrix->apm,
> +			     matrix_mdev->matrix->apm_max) {
> +		n = sprintf(bufpos, "%02lx\n", apid);
> +		bufpos += n;
> +		nchars += n;
> +
> +		for_each_set_bit_inv(apqi, matrix_mdev->matrix->aqm,
> +				     matrix_mdev->matrix->aqm_max) {
> +			n = sprintf(bufpos, "%02lx.%04lx\n", apid, apqi);
> +			bufpos += n;
> +			nchars += n;
> +		}
> +	}
> +
> +	return nchars;
> +}
> +DEVICE_ATTR_RO(matrix);
> +
> +
>   static struct attribute *vfio_ap_mdev_attrs[] = {
>   	&dev_attr_assign_adapter.attr,
>   	&dev_attr_unassign_adapter.attr,
> @@ -700,6 +738,7 @@ static ssize_t control_domains_show(struct device *dev,
>   	&dev_attr_assign_control_domain.attr,
>   	&dev_attr_unassign_control_domain.attr,
>   	&dev_attr_control_domains.attr,
> +	&dev_attr_matrix.attr,
>   	NULL,
>   };
>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
