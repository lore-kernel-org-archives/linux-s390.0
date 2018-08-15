From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 17/22] s390: vfio-ap: zeroize the AP queues.
Date: Wed, 15 Aug 2018 18:24:01 +0200
Message-ID: <20180815182401.4cfa0a78.cohuck@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-18-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534196899-16987-18-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 13 Aug 2018 17:48:14 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

Nit: please drop the leading period in the subject.

> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Let's call PAPQ(ZAPQ) to zeroize a queue:
> 
> * For each queue configured for a mediated matrix device
>   when it is released.
> 
> Zeroizing a queue resets the queue, clears all pending
> messages for the queue entries and disables adapter interruptions
> associated with the queue.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c     |   25 +++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_private.h |   25 +++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 0 deletions(-)
> 

> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 3e8534b..34f982a 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -74,4 +74,29 @@ struct ap_matrix_mdev {
>  extern int vfio_ap_mdev_register(void);
>  extern void vfio_ap_mdev_unregister(void);
>  
> +static inline int vfio_ap_reset_queue(unsigned int apid, unsigned int apqi,
> +				      unsigned int retry)
> +{
> +	struct ap_queue_status status;
> +
> +	do {
> +		status = ap_zapq(AP_MKQID(apid, apqi));
> +		switch (status.response_code) {
> +		case AP_RESPONSE_NORMAL:
> +			return 0;
> +		case AP_RESPONSE_RESET_IN_PROGRESS:
> +		case AP_RESPONSE_BUSY:
> +			msleep(20);
> +			break;
> +		default:
> +			pr_warn("%s: error zeroizing %02x.%04x: response code %d\n",
> +				VFIO_AP_MODULE_NAME, apid, apqi,
> +				status.response_code);

How can we end up here? Does this mean that we just don't know what to
do with this response, or is this something that should never happen?
(How much sense does it make to print an error?)

> +			return -EIO;
> +		}
> +	} while (retry--);
> +
> +	return -EBUSY;
> +}
> +
>  #endif /* _VFIO_AP_PRIVATE_H_ */
