From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 2/4] KVM: s390: fix calculation of idle_mask array size
Date: Tue, 25 Mar 2014 14:55:38 +0100
Message-ID: <53318ADA.2080008@redhat.com>
References: <1395754523-43697-1-git-send-email-borntraeger@de.ibm.com> <1395754523-43697-3-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395754523-43697-3-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 25/03/2014 14:35, Christian Borntraeger ha scritto:
> From: Jens Freimann <jfrei@linux.vnet.ibm.com>
>
> We need BITS_TO_LONGS, not sizeof(long) to calculate
> the correct size.
>
> idle_mask is a bitmask, each bit representing the state
> of a cpu. The desired outcome is an array of unsigned long
> fields that can fit KVM_MAX_VCPUS bits. We should not use
> sizeof(long) which returnes the size in bytes, but BITS_TO_LONGS
>
> Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 734d302..c36cd35 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -213,8 +213,7 @@ struct kvm_s390_float_interrupt {
>  	struct list_head list;
>  	atomic_t active;
>  	int next_rr_cpu;
> -	unsigned long idle_mask[(KVM_MAX_VCPUS + sizeof(long) - 1)
> -				/ sizeof(long)];
> +	unsigned long idle_mask[BITS_TO_LONGS(KVM_MAX_VCPUS)];
>  	unsigned int irq_count;
>  };
>
>

Perhaps you can also use DECLARE_BITMAP, since you use 
find_first_bit/set_bit/clear_bit on idle_mask.

Paolo
