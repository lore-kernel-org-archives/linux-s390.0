From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH v2 03/12] s390/bitops: add test_and_clear_bit_inv()
Date: Thu, 25 Jan 2018 14:53:41 +0100
Message-ID: <20180125145341.3a536ea0@mschwideX1>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
        <20180125132848.175942-4-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125132848.175942-4-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Jan 2018 14:28:39 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Jens Freimann <jfrei@linux.vnet.ibm.com>
> 
> This patch adds a MSB0 bit numbering version of test_and_clear_bit().
> 
> Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/bitops.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
> index 31e400c..86e5b2f 100644
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

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
