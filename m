From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v11 06/26] s390: vfio-ap: sysfs interfaces to configure
 adapters
Date: Wed, 26 Sep 2018 15:19:19 +0200
Message-ID: <20180926151919.034f0a2e.cohuck@redhat.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
        <20180925231641.4954-7-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925231641.4954-7-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 25 Sep 2018 19:16:21 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces two new sysfs attributes for the VFIO mediated
> matrix device for assigning AP adapters to and unassigning
> AP adapters from a mediated matrix device. The IDs of the
> AP adapters assigned to the mediated matrix device will be
> stored in an AP mask (APM).
> 
> The bits in the APM, from most significant to least significant
> bit, correspond to AP adapter IDs (APID) 0 to 255. On
> some systems, the maximum allowable adapter number may be less
> than 255 - depending upon the host's AP configuration - and
> assignment may be rejected if the input adapter ID exceeds the
> limit.
> 
> When an adapter is assigned, the bit corresponding to the APID
> will be set in the APM. Likewise, when an adapter is
> unassigned, the bit corresponding to the APID will be cleared
> from the APM.
> 
> In order to successfully assign an adapter, the APQNs derived from
> the adapter ID being assigned and the queue indexes of all domains
> previously assigned:
> 
> 1. Must be bound to the vfio_ap device driver.
> 
> 2. Must not be assigned to any other mediated matrix device
> 
> If there are no domains assigned to the mdev, then there must
> be an AP queue bound to the vfio_ap device driver with an
> APQN containing the APID, otherwise all domains
> subsequently assigned will fail because there will be no
> AP queues bound with an APQN containing the adapter ID.
> 
> Assigning or un-assigning an AP adapter will be rejected if
> a guest using the mediated matrix device is running.
> 
> The relevant sysfs structures are:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ...............[$uuid]
> .................. assign_adapter
> .................. unassign_adapter
> 
> To assign an adapter to the $uuid mediated matrix device's APM,
> write the APID to the assign_adapter file. To unassign an adapter,
> write the APID to the unassign_adapter file. The APID is specified
> using conventional semantics: If it begins with 0x the number will
> be parsed as a hexadecimal number; if it begins with a 0 the number
> will be parsed as an octal number; otherwise, it will be parsed as a
> decimal number.
> 
> For example, to assign adapter 173 (0xad) to the mediated matrix
> device $uuid:
> 
> 	echo 173 > assign_adapter
> 
> 	or
> 
> 	echo 0xad > assign_adapter
> 
> 	or
> 
> 	echo 0255 > assign_adapter
> 
> To unassign adapter 173 (0xad):
> 
> 	echo 173 > unassign_adapter
> 
> 	or
> 
> 	echo 0xad > unassign_adapter
> 
> 	or
> 
> 	echo 0255 > unassign_adapter
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 291 ++++++++++++++++++++++++++++++
>  1 file changed, 291 insertions(+)

> +static ssize_t assign_adapter_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	int ret;
> +	unsigned long apid;
> +	struct mdev_device *mdev = mdev_from_dev(dev);
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +
> +	ret = kstrtoul(buf, 0, &apid);
> +	if (ret)
> +		return ret;
> +
> +	if (apid > matrix_mdev->matrix.apm_max)
> +		return -ENODEV;
> +
> +	/* Set the bit in the AP mask (APM) corresponding to the AP adapter
> +	 * number (APID). The bits in the mask, from most significant to least
> +	 * significant bit, correspond to APIDs 0-255.
> +	 */

Minor nit: Comment should start with a single /*

(really minor and trivial to fix up; just to demonstrate I actually
looked at the patch ;)

> +	mutex_lock(&matrix_dev->lock);
> +
> +	ret = vfio_ap_mdev_verify_queues_reserved_for_apid(matrix_mdev, apid);
> +	if (ret)
> +		goto done;
> +
> +	set_bit_inv(apid, matrix_mdev->matrix.apm);
> +
> +	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
> +	if (ret)
> +		goto share_err;
> +
> +	ret = count;
> +	goto done;
> +
> +share_err:
> +	clear_bit_inv(apid, matrix_mdev->matrix.apm);
> +done:
> +	mutex_unlock(&matrix_dev->lock);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_WO(assign_adapter);

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
