From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 03/12] s390/bitops: add test_and_clear_bit_inv()
Date: Tue, 16 Jan 2018 21:13:09 +0100
Message-ID: <69389a23-be84-21da-3b17-167c0d1e72fc@redhat.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-4-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-4-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 16.01.2018 21:02, Christian Borntraeger wrote:
> From: Jens Freimann <jfrei@linux.vnet.ibm.com>
> 
> This patch adds a MSB0 bit numbering version of test_and_clear_bit().
> 
> Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/bitops.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
> index 31e400c1a1f3..86e5b2fdee3c 100644
> --- a/arch/s390/include/asm/bitops.h
> +++ b/arch/s390/include/asm/bitops.h
> @@ -261,6 +261,11 @@ static inline void clear_bit_inv(unsigned long nr, volatile unsigned long *ptr)
>  	return clear_bit(nr ^ (BITS_PER_LONG - 1), ptr);
>  }
>  
> +static inline int test_and_clear_bit_inv(unsigned long nr, volatile unsigned long *ptr)
> +{
> +	return test_and_clear_bit(nr ^ (BITS_PER_LONG - 1), ptr);
> +}
> +
>  static inline void __set_bit_inv(unsigned long nr, volatile unsigned long *ptr)
>  {
>  	return __set_bit(nr ^ (BITS_PER_LONG - 1), ptr);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
