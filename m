From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 16/19] KVM: s390: interface to configure KVM guest's AP
 matrix
Date: Mon, 16 Oct 2017 16:22:09 -0400
Message-ID: <b07e83ff-b19a-cacf-0322-c37af0f67f81@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-17-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-17-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 10/13/2017 01:39 PM, Tony Krowiak wrote:
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
>    the KVM guest
>
> * The AP Queue Matrix (AQM) field identifies the usage domains assigned to
>    the KVM guest
>
> * The AP Domain matrix (ADM) field identifies the control domains
>    assigned to the KVM guest.
>
> Each adapter, usage domain and control domain are identified by a number
> from 0 to 255. The bits in each mask, from left to right, correspond to
> the numbers 0-255. When a bit is set, the corresponding adapter,
> usage domain or control domain will be assigned to the KVM guest.
>
> This patch will set the bits in the APM, AQM and ADM fields of the
> CRYCB referenced by the KVM guest's SIE state description. The process
> used is:
There is a step missing here and is also missing from the code.
By architectural convention, all bits set in the ADM must also
be set in the AQM, but the ADM may have bits set that are not
set in the AQM. In other words, all usage domains are control
domains, but some control domains may not be usage usage domains.
So, the ADM contained in the CRYCB will be set with the bits
resulting from the logical OR of the ADM and AQM configured for
the mediated AP matrix device via its sysfs attributes files.
>
> 1. Perform a logical AND of the AP matrix masks configured for the
>     mediated AP matrix device via its sysfs attributes files with
>     the matrix masks assigned to the LPAR in which the host linux
>     system is running to create the effective masks, EAPM, EAQM and
>     EADM.
>
> 2. Set the APM, AQM and ADM in the CRYCB from the EAPM, EAQM and
>     EADM calculated in step 1.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>   arch/s390/include/asm/ap-config.h |    7 ++
>   arch/s390/kvm/ap-config.c         |  144 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 151 insertions(+), 0 deletions(-)
>
> diff --git a/arch/s390/include/asm/ap-config.h b/arch/s390/include/asm/ap-config.h
> index 3064215..866f008 100644
> --- a/arch/s390/include/asm/ap-config.h
> +++ b/arch/s390/include/asm/ap-config.h
> @@ -10,16 +10,23 @@
>   #define _ASM_KVM_AP_CONFIG_H_
>
>   #include <linux/types.h>
> +#include <linux/kvm_host.h>
>
>   #define AP_MATRIX_MAX_MASK_BITS		256
>   #define AP_MATRIX_MASK_INDICES		(AP_MATRIX_MAX_MASK_BITS / \
>   					(sizeof(u64) * 8))
>   #define AP_MATRIX_MAX_MASK_BYTES	(AP_MATRIX_MASK_INDICES * sizeof(u64))
>
> +#define AP_MATRIX_MASK_TYPE_ADAPTER	"adapter"
> +#define AP_MATRIX_MASK_TYPE_DOMAIN	"domain"
> +#define AP_MATRIX_MASK_TYPE_CONTROL	"control domain"
> +
>   struct ap_config_masks {
>   	u64 apm[AP_MATRIX_MASK_INDICES];
>   	u64 aqm[AP_MATRIX_MASK_INDICES];
>   	u64 adm[AP_MATRIX_MASK_INDICES];
>   };
>
> +extern int ap_config_matrix(struct kvm *kvm, struct ap_config_masks *masks);
> +
>   #endif /* _ASM_KVM_AP_CONFIG_H_ */
> diff --git a/arch/s390/kvm/ap-config.c b/arch/s390/kvm/ap-config.c
> index 84fdf43..dc79798 100644
> --- a/arch/s390/kvm/ap-config.c
> +++ b/arch/s390/kvm/ap-config.c
> @@ -7,3 +7,147 @@
>    */
>
>   #include <asm/ap-config.h>
> +#include <asm/ap.h>
> +#include <linux/bitops.h>
> +
> +static inline int is_format2_crycb(struct kvm *kvm)
> +{
> +	int fmt2_mask = kvm->arch.crypto.crycbd & CRYCB_FORMAT2;
> +
> +	return (fmt2_mask == CRYCB_FORMAT2);
> +}
> +
> +static inline u64 *ap_config_get_crycb_apm(struct kvm *kvm)
> +{
> +	u64 *apm;
> +
> +	if (is_format2_crycb(kvm))
> +		apm = kvm->arch.crypto.crycb->apcb1.apm;
> +	else
> +		apm = kvm->arch.crypto.crycb->apcb0.apm;
> +
> +	return apm;
> +}
> +
> +static inline u64 *ap_config_get_crycb_aqm(struct kvm *kvm)
> +{
> +	u64 *aqm;
> +
> +	if (is_format2_crycb(kvm))
> +		aqm = kvm->arch.crypto.crycb->apcb1.aqm;
> +	else
> +		aqm = kvm->arch.crypto.crycb->apcb0.aqm;
> +
> +	return aqm;
> +}
> +
> +static inline u64 *ap_config_get_crycb_adm(struct kvm *kvm)
> +{
> +	u64 *adm;
> +
> +	if (is_format2_crycb(kvm))
> +		adm = kvm->arch.crypto.crycb->apcb1.adm;
> +	else
> +		adm = kvm->arch.crypto.crycb->apcb0.adm;
> +
> +	return adm;
> +}
> +
> +static void ap_config_set_crycb_masks(struct kvm *kvm,
> +				    struct ap_config_masks *masks)
> +{
> +	size_t i;
> +	size_t masksz;
> +	u64 *mask = ap_config_get_crycb_apm(kvm);
> +
> +	masksz = (is_format2_crycb(kvm)) ? APCB1_MASK_SIZE : APCB0_MASK_SIZE;
> +
> +	for (i = 0; i < masksz; i++)
> +		mask[i] = masks->apm[i];
> +
> +	mask = ap_config_get_crycb_aqm(kvm);
> +
> +	for (i = 0; i < masksz; i++)
> +		mask[i] = masks->aqm[i];
> +
> +	mask = ap_config_get_crycb_adm(kvm);
> +
> +	for (i = 0; i < masksz; i++)
> +		mask[i] = masks->adm[i];
> +}
> +
> +static int ap_config_set_emask(const char *mask_type, unsigned long *mask,
> +			       unsigned long *cfgmask)
> +{
> +	unsigned long id;
> +	unsigned long nbits = AP_MATRIX_MAX_MASK_BITS;
> +
> +	id = find_first_bit_inv(mask, nbits);
> +	while (id < nbits) {
> +		if (!test_bit_inv(id, cfgmask)) {
> +			clear_bit_inv(id, mask);
> +			pr_err("%s: %s %02lx is not installed on the host system",
> +			       __func__, mask_type, id);
> +			return -ENODEV;
> +		}
> +
> +		id = find_next_bit_inv(mask, nbits, id + 1);
> +	}
> +
> +	return 0;
> +}
> +
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
For the reasons stated earlier in this response, we need to do a
logical OR of the bits in the ADM with those in the AQM here:

size_t i;

for (i = 0; i < AP_MATRIX_MASK_INDICES; i++)
     masks->adm[i] |= masks->aqm[i];
> +	ret = ap_config_get_emasks(masks);
> +	if (ret)
> +		return ret;
> +
> +	ap_config_set_crycb_masks(kvm, masks);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ap_config_matrix);
