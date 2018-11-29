From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 3/3] vfio: ap: AP Queue Interrupt Control VFIO ioctl
 calls
Date: Thu, 29 Nov 2018 12:37:26 +0100
Message-ID: <20181129123726.62b04690.cohuck@redhat.com>
References: <1542906675-7949-1-git-send-email-pmorel@linux.ibm.com>
        <1542906675-7949-4-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542906675-7949-4-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 22 Nov 2018 18:11:15 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> This is the implementation of the VFIO ioctl calls to handle
> the AQIC interception and use GISA to handle interrupts.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 110 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 109 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 272ef42..f6e942f 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -895,12 +895,121 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
>  	return copy_to_user((void __user *)arg, &info, minsz);
>  }
>  
> +static unsigned long vfio_ap_get_nib(struct kvm *kvm, struct vfio_ap_aqic *parm)
> +{
> +	struct s390_io_adapter *adapter;
> +	struct s390_map_info *map;
> +	unsigned long nib;
> +	int found = 0;
> +
> +	/* find the adapter */
> +	if (parm->adapter_id > MAX_S390_IO_ADAPTERS)
> +		return 0;
> +
> +	adapter = kvm->arch.adapters[parm->adapter_id];
> +	if (!adapter)
> +		return 0;
> +
> +	down_write(&adapter->maps_lock);
> +	list_for_each_entry(map, &adapter->maps, list) {
> +		if (map->guest_addr == parm->nib) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +	up_write(&adapter->maps_lock);

Regardless of which user space interface you ultimately use: I think
you should leave poking the adapter handling innards to the adapter
code and instead create and use an interface to look up the mapping
from the guest address.

> +
> +	if (!found)
> +		return 0;
> +
> +	nib = (unsigned long) page_address(map->page);
> +	nib += (map->guest_addr & 0x0fff);
> +
> +	return nib;
> +}
