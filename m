From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 08/19] s390/zcrypt: support for assigning adapters to
 matrix mdev
Date: Tue, 14 Nov 2017 14:22:44 +0100
Message-ID: <20171114142244.272d538d.cohuck@redhat.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1507916344-3896-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-9-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 13 Oct 2017 13:38:53 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Provides the sysfs interfaces for assigning an adapter to
> and unassigning an AP adapter from a mediated matrix device.
> 
> The IDs of the AP adapters assigned to the mediated matrix
> device are stored in a bit mask. The bits in the mask, from
> left to right, correspond to AP adapter numbers 0 to 255. The
> bit corresponding to the ID of the adapter being assigned will
> be set in the bit mask.
> 
> The relevant sysfs structures are:
> 
> /sys/devices/ap_matrix
> ... [matrix]
> ...... [mdev_supported_types]
> ......... [ap_matrix-passthrough]
> ............ [devices]
> ...............[$uuid]
> .................. adapters
> .................. assign_adapter
> .................. unassign_adapter
> 
> To assign an adapter to the $uuid mediated matrix device, write
> ID of the adapter (hex value) to the assign_adapter file. To
> unassign an adapter, write the ID of the adapter (hex value)
> to the unassign_adapter file. The list of adapters that have
> been assigned can be viewed by displaying the contents of the
> adapters file.
> 
> For example, to assign adapter 0xad to mediated matrix device
> $uuid:
> 
> 	echo ad > assign_adapter
> 
> To unassign adapter 0xad:
> 
> 	echo ad > unassign_adapter
> 
> To see the list of adapters assigned:
> 
> 	cat adapters
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/ap-config.h        |   13 +++
>  drivers/s390/crypto/vfio_ap_matrix_ops.c |  147 ++++++++++++++++++++++++++++++
>  2 files changed, 160 insertions(+), 0 deletions(-)
> 

> diff --git a/drivers/s390/crypto/vfio_ap_matrix_ops.c b/drivers/s390/crypto/vfio_ap_matrix_ops.c
> index 7d01f18..e4b1236 100644
> --- a/drivers/s390/crypto/vfio_ap_matrix_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_matrix_ops.c
> @@ -23,6 +23,7 @@
>  struct ap_matrix_mdev {
>  	struct mdev_device *mdev;
>  	struct list_head node;
> +	struct ap_config_masks masks;
>  };
>  
>  struct ap_matrix	*matrix;
> @@ -136,9 +137,155 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
>  	NULL,
>  };
>  
> +static int ap_matrix_id_is_xnum(char *id)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < strlen(id); i++) {
> +		if (!isxdigit(id[i]))
> +			return 0;
> +	}
> +
> +	return 1;
> +}

This feels like something for which an utility function should already
exist...

> +
> +static int ap_matrix_parse_id(const char *buf, unsigned int *id)
> +{
> +	int ret;
> +	char *bufcpy;
> +	char *id_str;
> +
> +	if ((strlen(buf) == 0) || (*buf == '\n')) {
> +		pr_err("%s: input buffer '%s' contains no valid hex values",
> +		       VFIO_AP_MATRIX_MODULE_NAME, buf);
> +		return -EINVAL;
> +	}
> +
> +	bufcpy = kzalloc(strlen(buf) + 1, GFP_KERNEL);
> +	if (!bufcpy)
> +		return -ENOMEM;
> +
> +	strcpy(bufcpy, buf);
> +	id_str = strim(bufcpy);
> +
> +	if (!ap_matrix_id_is_xnum(id_str)) {
> +		pr_err("%s: input id '%s' contains an invalid hex value '%s'",
> +		       VFIO_AP_MATRIX_MODULE_NAME, buf, id_str);
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	ret = kstrtouint (id_str, 16, id);
> +	if (ret || (*id >= AP_MATRIX_MAX_MASK_BITS)) {
> +		pr_err("%s: input id '%s' is not a value from 0 to %x",
> +		       VFIO_AP_MATRIX_MODULE_NAME, buf,
> +		       AP_MATRIX_MAX_MASK_BITS);
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	ret = 0;
> +
> +done:
> +	kfree(bufcpy);
> +	return ret;
> +}

Similarly, I suspect you are not the first person with similar parsing
needs.

> +
> +static ssize_t ap_matrix_adapters_assign(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	int ret;
> +	unsigned int apid;
> +	struct mdev_device *mdev = mdev_from_dev(dev);
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +
> +	ret = ap_matrix_parse_id(buf, &apid);
> +	if (ret)
> +		return ret;
> +
> +	set_bit_inv((unsigned long)apid,
> +		    (unsigned long *)matrix_mdev->masks.apm);

Probably needs a comment regarding byte order of the masks somewhere.

> +
> +	return count;
> +}
> +static DEVICE_ATTR(assign_adapter, 0644, NULL, ap_matrix_adapters_assign);
