From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 02/12] KVM: s390: define GISA format-0 data structure
Date: Tue, 16 Jan 2018 21:25:12 +0100
Message-ID: <d25b016f-eb6f-7b8e-87d8-9224291be6c8@redhat.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-3-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-3-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


> +struct kvm_s390_gisa {
> +	u32 next_alert;
> +	u8 ipm;
> +	u8 reserved01;
> +	u8:6;
> +	u8 g:1;
> +	u8 c:1;
> +	u8 iam;
> +	u8 reserved02[4];
> +	u32 airq_count;
> +};
> +
>  /*
> - * sie_page2 has to be allocated as DMA because fac_list and crycb need
> - * 31bit addresses in the sie control block.
> + * sie_page2 has to be allocated as DMA because fac_list, crycb and
> + * gisa need 31bit addresses in the sie control block.
>   */
>  struct sie_page2 {
>  	__u64 fac_list[S390_ARCH_FAC_LIST_SIZE_U64];	/* 0x0000 */
>  	struct kvm_s390_crypto_cb crycb;		/* 0x0800 */
> -	u8 reserved900[0x1000 - 0x900];			/* 0x0900 */
> +	struct kvm_s390_gisa gisa __aligned(sizeof(struct kvm_s390_gisa)); /* 0x0900 */

can we instead specify sie_page2 as packed if really needed? (I can see
that we have a BUILD_BUG_ON below, which is nice)

(alignment within well defined data structures looks strange)

> +	u8 reserved910[0x1000 - 0x910];			/* 0x0910 */
>  };
>  
>  struct kvm_s390_vsie {
> @@ -757,6 +772,7 @@ struct kvm_arch{
>  	struct kvm_s390_migration_state *migration_state;
>  	/* subset of available cpu features enabled by user space */
>  	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
> +	struct kvm_s390_gisa *gisa;

What's this little fellow doing in this patch? :)


-- 

Thanks,

David / dhildenb
