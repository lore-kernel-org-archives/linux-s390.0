From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 16/19] KVM: s390: interface to configure KVM guest's AP
 matrix
Date: Tue, 14 Nov 2017 14:46:40 +0100
Message-ID: <20171114144640.4b575ca8.cohuck@redhat.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1507916344-3896-17-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-17-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 13 Oct 2017 13:39:01 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Provides an interface to assign AP adapters, usage domains
> and control domains to a KVM guest.
> 
> A KVM guest is started by executing the Start Interpretive Execution (SIE)
> instruction. The SIE state description is a control block that contains the
> state information for a KVM guest and is supplied as input to the SIE
> instruction. The SIE state description contains a field that references
> a Crypto Control Block (CRYCB). The CRYCB contains three bitmask fields
> identifying the adapters, usage domains and control domains assigned to the
> KVM guest:
> 
> * The AP Adapter Matrix (APM) field identifies the AP adapters assigned to
>   the KVM guest
> 
> * The AP Queue Matrix (AQM) field identifies the usage domains assigned to
>   the KVM guest
> 
> * The AP Domain matrix (ADM) field identifies the control domains
>   assigned to the KVM guest.
> 
> Each adapter, usage domain and control domain are identified by a number
> from 0 to 255. The bits in each mask, from left to right, correspond to
> the numbers 0-255. When a bit is set, the corresponding adapter,
> usage domain or control domain will be assigned to the KVM guest.
> 
> This patch will set the bits in the APM, AQM and ADM fields of the
> CRYCB referenced by the KVM guest's SIE state description. The process
> used is:
> 
> 1. Perform a logical AND of the AP matrix masks configured for the
>    mediated AP matrix device via its sysfs attributes files with
>    the matrix masks assigned to the LPAR in which the host linux
>    system is running to create the effective masks, EAPM, EAQM and
>    EADM.
> 
> 2. Set the APM, AQM and ADM in the CRYCB from the EAPM, EAQM and
>    EADM calculated in step 1.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/ap-config.h |    7 ++
>  arch/s390/kvm/ap-config.c         |  144 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 151 insertions(+), 0 deletions(-)
> 

> +static int ap_config_get_emasks(struct ap_config_masks *masks)
> +{
> +	int ret;
> +	struct ap_config_info config;
> +
> +	ret = ap_query_configuration(&config);
> +	if (ret) {
> +		if (ret == -EOPNOTSUPP) {
> +			pr_err("%s: Query AP configuration not supported",
> +			       __func__);
> +
> +			return ret;

I'm wondering whether we should check this at init time for vfio-ap? If
PQAP(QCI) is not supported, it probably does not make any sense to
pretend that we could do device assignment...

> +		}
> +
> +		pr_err("%s: Query AP configuration failed with rc=%d",
> +		       __func__, ret);
> +
> +		return ret;
> +	}
> +
> +	ret = ap_config_set_emask(AP_MATRIX_MASK_TYPE_ADAPTER,
> +				  (unsigned long *)masks->apm,
> +				  (unsigned long *)config.apm);
> +	if (ret)
> +		return ret;
> +
> +	ret = ap_config_set_emask(AP_MATRIX_MASK_TYPE_DOMAIN,
> +				  (unsigned long *)masks->aqm,
> +				  (unsigned long *)config.aqm);
> +	if (ret)
> +		return ret;
> +
> +	ret = ap_config_set_emask(AP_MATRIX_MASK_TYPE_CONTROL,
> +				  (unsigned long *)masks->adm,
> +				  (unsigned long *)config.adm);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +int ap_config_matrix(struct kvm *kvm, struct ap_config_masks *masks)
> +{
> +	int ret;
> +
> +	ret = ap_config_get_emasks(masks);
> +	if (ret)
> +		return ret;
> +
> +	ap_config_set_crycb_masks(kvm, masks);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ap_config_matrix);
