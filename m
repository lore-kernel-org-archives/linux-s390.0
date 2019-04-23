Return-Path: <SRS0=oVSW=SZ=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 5/8] s390: vfio-ap: wait for queue empty on queue reset
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
 <1555796980-27920-6-git-send-email-akrowiak@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 23 Apr 2019 14:50:26 +0200
MIME-Version: 1.0
In-Reply-To: <1555796980-27920-6-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9a23da6d-89a8-227d-b756-6e002b0199e3@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 20/04/2019 23:49, Tony Krowiak wrote:
> Refactors the AP queue reset function to wait until the queue is empty
> after the PQAP(ZAPQ) instruction is executed to zero out the queue as
> required by the AP architecture.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 35 ++++++++++++++++++++++++++++++++---
>   1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 091804317c5e..31ce30ee784d 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -744,15 +744,44 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>   	return NOTIFY_OK;
>   }
>   
> -static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
> -				    unsigned int retry)
> +static void vfio_ap_mdev_wait_for_qempty(unsigned long apid, unsigned long apqi)
>   {
>   	struct ap_queue_status status;
> +	ap_qid_t qid = AP_MKQID(apid, apqi);
> +	int retry = 5;
> +
> +	do {
> +		status = ap_tapq(qid, NULL);
> +		switch (status.response_code) {
> +		case AP_RESPONSE_NORMAL:
> +			if (status.queue_empty)
> +				return;
> +			msleep(20);
> +			break;
> +		case AP_RESPONSE_RESET_IN_PROGRESS:
> +		case AP_RESPONSE_BUSY:
> +			msleep(20);
> +			break;
> +		default:
> +			pr_warn("%s: tapq err %02x: 0x%04x may not be empty\n",
> +				__func__, status.response_code, q->apqn);

q is not defined. use qid ?


> +			return;
> +		}
> +	} while (--retry);
> +}
> +
> +int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi)
> +{
> +	struct ap_queue_status status;
> +	int retry = 5;
>   
>   	do {
>   		status = ap_zapq(AP_MKQID(apid, apqi));
>   		switch (status.response_code) {
>   		case AP_RESPONSE_NORMAL:
> +			vfio_ap_mdev_wait_for_qempty(apid, apqi);
> +			return 0;
> +		case AP_RESPONSE_DECONFIGURED:
>   			return 0;
>   		case AP_RESPONSE_RESET_IN_PROGRESS:
>   		case AP_RESPONSE_BUSY:
> @@ -778,7 +807,7 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>   			     matrix_mdev->matrix.apm_max + 1) {
>   		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>   				     matrix_mdev->matrix.aqm_max + 1) {
> -			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
> +			ret = vfio_ap_mdev_reset_queue(apid, apqi);
>   			/*
>   			 * Regardless whether a queue turns out to be busy, or
>   			 * is not operational, we need to continue resetting
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
