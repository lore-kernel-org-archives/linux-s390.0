From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 01/19] KVM: s390: SIE considerations for AP Queue
 virtualization
Date: Thu, 2 Nov 2017 12:54:25 +0100
Message-ID: <8ff4f519-560b-04a0-2786-27eafcf7463f@de.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1507916344-3896-2-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-2-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

To make the whole series smaller I will apply some of these patches
directly (those of which are "obvious" and touch kvm/s390 only)


On 10/13/2017 07:38 PM, Tony Krowiak wrote:
> The Crypto Control Block (CRYCB) is referenced by the SIE state
> description and controls KVM guest access to the Adjunct
> Processor (AP) adapters, usage domains and control domains.
> This patch defines the AP control blocks to be used for
> controlling guest access to the AP adapters and domains.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>

thanks applied.
> ---
>  arch/s390/include/asm/kvm_host.h |   25 +++++++++++++++++++++----
>  1 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 51375e7..50a6b25 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -685,11 +685,28 @@ struct kvm_s390_crypto {
>  	__u8 dea_kw;
>  };
> 
> +#define APCB0_MASK_SIZE 1
> +struct kvm_s390_apcb0 {
> +	__u64 apm[APCB0_MASK_SIZE];		/* 0x0000 */
> +	__u64 aqm[APCB0_MASK_SIZE];		/* 0x0008 */
> +	__u64 adm[APCB0_MASK_SIZE];		/* 0x0010 */
> +	__u64 reserved18;			/* 0x0018 */
> +};
> +
> +#define APCB1_MASK_SIZE 4
> +struct kvm_s390_apcb1 {
> +	__u64 apm[APCB1_MASK_SIZE];		/* 0x0000 */
> +	__u64 aqm[APCB1_MASK_SIZE];		/* 0x0020 */
> +	__u64 adm[APCB1_MASK_SIZE];		/* 0x0040 */
> +	__u64 reserved60[4];			/* 0x0060 */
> +};
> +
>  struct kvm_s390_crypto_cb {
> -	__u8    reserved00[72];                 /* 0x0000 */
> -	__u8    dea_wrapping_key_mask[24];      /* 0x0048 */
> -	__u8    aes_wrapping_key_mask[32];      /* 0x0060 */
> -	__u8    reserved80[128];                /* 0x0080 */
> +	struct kvm_s390_apcb0 apcb0;		/* 0x0000 */
> +	__u8    reserved20[40];			/* 0x0020 */
> +	__u8    dea_wrapping_key_mask[24];	/* 0x0048 */
> +	__u8    aes_wrapping_key_mask[32];	/* 0x0060 */
> +	struct kvm_s390_apcb1 apcb1;		/* 0x0080 */
>  };
> 
>  /*
> 
