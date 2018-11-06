From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v1 4/7] vfio: ap: AP Queue Interrupt Control VFIO ioctl
 calls
Date: Tue, 6 Nov 2018 15:21:19 -0500
Message-ID: <7e4cbc97-8c77-b393-efdd-6fd8550c15f1@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
 <1541009577-29656-5-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541009577-29656-5-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 10/31/18 2:12 PM, Pierre Morel wrote:
> This is the implementation of the VFIO ioctl calls to handle
> the AQIC interception and use GISA to handle interrupts.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 95 +++++++++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 272ef427dcc0..f68102163bf4 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -895,12 +895,107 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
>   	return copy_to_user((void __user *)arg, &info, minsz);
>   }
>   
> +static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,

In keeping with the other function names in this file, how about
naming this function vfio_ap_mdev_setirq???

> +			   struct vfio_ap_aqic *parm)
> +{
> +	struct aqic_gisa aqic_gisa = reg2aqic(0);
> +	struct kvm_s390_gisa *gisa = matrix_mdev->kvm->arch.gisa;
> +	struct ap_status ap_status = reg2status(0);
> +	unsigned long p;
> +	int ret = -1;
> +	int apqn;
> +	uint32_t gd;
> +
> +	apqn = (int)(parm->cmd & 0xffff);
> +
> +	gd = matrix_mdev->kvm->vcpus[0]->arch.sie_block->gd;
> +	if (gd & 0x01)
> +		aqic_gisa.f = 1;
> +	aqic_gisa.gisc = matrix_mdev->gisc;

Can't you get this value from parm? I don't see any relationship
between the mdev device and gisc, why store it there?

> +	aqic_gisa.isc = GAL_ISC;
> +	aqic_gisa.ir = 1;
> +	aqic_gisa.gisao = gisa->next_alert >> 4;
> +
> +	p = (unsigned long) page_address(matrix_mdev->map->page);
> +	p += (matrix_mdev->map->guest_addr & 0x0fff);
> +
> +	ret = ap_host_aqic((uint64_t)apqn, aqic2reg(aqic_gisa), p);
> +	parm->status = ret;
> +
> +	ap_status = reg2status(ret);
> +	return (ap_status.rc) ? -EIO : 0;
> +}
> +
> +static int ap_ioctl_clrirq(struct ap_matrix_mdev *matrix_mdev,
> +			   struct vfio_ap_aqic *parm)

In keeping with the other function names in this file, how about
naming this function vfio_ap_mdev_clrirq, or better yet,
vfio_ap_mdev_clear_irq???

> +{
> +	struct aqic_gisa aqic_gisa = reg2aqic(0);
> +	struct ap_status ap_status = reg2status(0) > +	int apqn;
> +	int retval;
> +	uint32_t gd;
> +
> +	apqn = (int)(parm->cmd & 0xffff);
> +
> +	gd = matrix_mdev->kvm->vcpus[0]->arch.sie_block->gd;
> +	if (gd & 0x01)
> +		aqic_gisa.f = 1;
> +	aqic_gisa.ir = 0;
> +
> +	retval = ap_host_aqic((uint64_t)apqn, aqic2reg(aqic_gisa), 0);
> +	parm->status = retval;
> +
> +	ap_status = reg2status(retval);
> +	return (ap_status.rc) ? -EIO : 0;
> +}
> +
>   static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
>   				    unsigned int cmd, unsigned long arg)
>   {
>   	int ret;
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct s390_io_adapter *adapter;
> +	struct vfio_ap_aqic parm;
> +	struct s390_map_info *map;
> +	int apqn, found = 0;
>   
>   	switch (cmd) {
> +	case VFIO_AP_SET_IRQ:
> +		if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
> +			return -EFAULT;
> +		apqn = (int)(parm.cmd & 0xffff);
> +		parm.status &= 0x00000000ffffffffUL;
> +		matrix_mdev->gisc = parm.status & 0x07;

It seems that the only reason for the 'gisc' field in matrix_mdev
is to pass the value to the ap_ioctl_setirq() function. Since the
gisc has nothing to do with the mdev device and the 'parm' is being
passed to ap_ioctl_setirq(), why not just eliminate the
matrix_mdev->gisc field and get it from the 'parm' parameter in
ap_ioctl_setirq()?

> +		/* find the adapter */ap_ioctl_setirq()
> +		adapter = matrix_mdev->kvm->arch.adapters[parm.adapter_id];
> +		if (!adapter)
> +			return -ENOENT;
> +		down_write(&adapter->maps_lock);
> +		list_for_each_entry(map, &adapter->maps, list) {
> +			if (map->guest_addr == parm.nib) {
> +				found = 1;
> +				break;
> +			}
> +		}
> +		up_write(&adapter->maps_lock);
> +
> +		if (!found)
> +			return -EINVAL;
> +
> +		matrix_mdev->map = map;

See my comment above about matrix_mdev->gisc. Can't we just get rid
of the matrix_mdev->map field and pass the map into the
ap_ioctl_setirq() function?

> +		ret = ap_ioctl_setirq(matrix_mdev, &parm);
> +		parm.status &= 0x00000000ffffffffUL;
> +		if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
> +			return -EFAULT;
> +
> +		break;

IMHO, the case statements should only determine which ioctl is being
invoked and call the appropriate function to handle it. All of the above
code could be in an intermediate function called from this case
statement, thus reducing the case to calling the intermediate function.

> +	case VFIO_AP_CLEAR_IRQ:
> +		if (copy_from_user(&parm, (void __user *)arg, sizeof(parm)))
> +			return -EFAULT;
> +		ret = ap_ioctl_clrirq(matrix_mdev, &parm);
> +		if (copy_to_user((void __user *)arg, &parm, sizeof(parm)))
> +			return -EFAULT;
> +		break;
>   	case VFIO_DEVICE_GET_INFO:
>   		ret = vfio_ap_mdev_get_device_info(arg);
>   		break;
> 
