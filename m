From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC 13/19] s390/zcrypt: validate control domain assignment
Date: Mon, 16 Oct 2017 11:13:58 +0200
Message-ID: <20171016111358.12248624@mschwideX1>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1507916344-3896-14-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-14-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 13 Oct 2017 13:38:58 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> The AP control domain being assigned to the mediated
> matrix driver must be assigned to the LPAR.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_matrix_ops.c |   33 ++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_matrix_ops.c b/drivers/s390/crypto/vfio_ap_matrix_ops.c
> index 2387916..10a006c 100644
> --- a/drivers/s390/crypto/vfio_ap_matrix_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_matrix_ops.c
> @@ -469,12 +469,41 @@ static ssize_t ap_matrix_domains_show(struct device *dev,
>  static DEVICE_ATTR(domains, 0644, ap_matrix_domains_show,
>  		   NULL);
> 
> +static int
> +ap_matrix_validate_control_domains(struct ap_matrix_mdev *matrix_mdev,
> +				   unsigned long id)
> +{
> +	int ret;
> +	struct ap_config_info config;
> +
> +	memset(&config, 0, sizeof(config));
> +
> +	ret = ap_query_configuration(&config);
> +	if (ret == -EOPNOTSUPP)
> +		return 0;
> +
> +	if (ret) {
> +		pr_err("%s: query AP configuration failed with rc %d",
> +		       VFIO_AP_MATRIX_MODULE_NAME, ret);
> +		return ret;
> +	}
> +
> +	if (!test_bit_inv(id, (unsigned long *)config.adm)) {
> +		pr_err("%s: control domain %04lx is not installed on the lpar",
> +		       VFIO_AP_MATRIX_MODULE_NAME, id);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  static ssize_t ap_matrix_control_domain_assign(struct device *dev,
>  					       struct device_attribute *attr,
>  					       const char *buf, size_t count)
>  {
>  	int ret;
>  	unsigned int id;
> +
>  	struct mdev_device *mdev = mdev_from_dev(dev);
>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> 
> @@ -482,6 +511,10 @@ static ssize_t ap_matrix_control_domain_assign(struct device *dev,
>  	if (ret)
>  		return ret;
> 
> +	ret = ap_matrix_validate_control_domains(matrix_mdev, id);
> +	if (ret)
> +		return ret;
> +
>  	set_bit_inv((unsigned long)id,
>  		    (unsigned long *)matrix_mdev->masks.adm);
> 

Is there a specific reason why patch #13 is separate from patch #12 that
introduces the domain assignment? The assignment code does not make much
sense with the check if the domain is assigned to the LPAR, no?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
