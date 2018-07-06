From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 09/21] s390: vfio-ap: structure for storing mdev matrix
Date: Fri, 6 Jul 2018 16:26:23 +0200
Message-ID: <8a708a2e-3961-bd0c-9354-705070ada83d@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-10-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306683-7270-10-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 06/29/2018 11:11 PM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces a new structure for storing the AP matrix configured
> for the mediated matrix device via its sysfs attributes files.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     |   12 ++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |   24 ++++++++++++++++++++++++
>   2 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 4e61e33..bf7ed9f 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -20,6 +20,17 @@
>   DEFINE_SPINLOCK(mdev_list_lock);
>   LIST_HEAD(mdev_list);
> 
> +static void vfio_ap_matrix_init(struct ap_matrix *matrix)
> +{
> +	/* Test if PQAP(QCI) instruction is available */
> +	if (test_facility(12))
> +		ap_qci(&matrix->info);
> +
> +	matrix->apm_max = matrix->info.apxa ? matrix->info.Na : 63;
> +	matrix->aqm_max = matrix->info.apxa ? matrix->info.Nd : 15;
> +	matrix->adm_max = matrix->info.apxa ? matrix->info.Nd : 15;
> +}
> +
>   static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>   {
>   	struct ap_matrix_dev *matrix_dev =
> @@ -31,6 +42,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>   		return -ENOMEM;
> 
>   	matrix_mdev->name = dev_name(mdev_dev(mdev));
> +	vfio_ap_matrix_init(&matrix_mdev->matrix);
>   	mdev_set_drvdata(mdev, matrix_mdev);
> 
>   	if (atomic_dec_if_positive(&matrix_dev->available_instances) < 0) {
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 3de1275..ae771f5 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -29,9 +29,33 @@ struct ap_matrix_dev {
>   	atomic_t available_instances;
>   };
> 
> +/**
> + * The AP matrix is comprised of three bit masks identifying the adapters,
> + * queues (domains) and control domains that belong to an AP matrix. The bits i
> + * each mask, from least significant to most significant bit, correspond to IDs
> + * 0 to 255. When a bit is set, the corresponding ID belongs to the matrix.
> + *
> + * @apm identifies the AP adapters in the matrix
> + * @apm_max: max adapter number in @apm
> + * @aqm identifies the AP queues (domains) in the matrix
> + * @aqm_max: max domain number in @aqm
> + * @adm identifies the AP control domains in the matrix
> + * @adm_max: max domain number in @adm
> + */
> +struct ap_matrix {
> +	unsigned long apm_max;
> +	DECLARE_BITMAP(apm, 256);
> +	unsigned long aqm_max;
> +	DECLARE_BITMAP(aqm, 256);
> +	unsigned long adm_max;
> +	DECLARE_BITMAP(adm, 256);
> +	struct ap_config_info info;

Why do we maintain (and populate by doing a QCI) the info member on a
per mdev device basis?

> +};
> +
>   struct ap_matrix_mdev {
>   	const char *name;
>   	struct list_head list;
> +	struct ap_matrix matrix;
>   };
> 
>   static struct ap_matrix_dev *to_ap_matrix_dev(struct device *dev)
> 
