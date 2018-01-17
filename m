From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/6] s390: implement nospec_[load|ptr]
Date: Wed, 17 Jan 2018 14:58:45 +0100
Message-ID: <08d3bfc0-97ae-6f2b-c44b-531be00737cc@redhat.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
 <1516182519-10623-3-git-send-email-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1516182519-10623-3-git-send-email-schwidefsky@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On 17.01.2018 10:48, Martin Schwidefsky wrote:
> Implement nospec_load() and nospec_ptr() for s390 with the new
> gmb() barrier between the boundary condition and the load that
> may not be done speculatively.
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/include/asm/barrier.h | 38 ++++++++++++++++++++++++++++++++++++++
>  arch/s390/kernel/alternative.c  |  7 +++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
> index 1043260..b8836a6 100644
> --- a/arch/s390/include/asm/barrier.h
> +++ b/arch/s390/include/asm/barrier.h
> @@ -8,6 +8,8 @@
>  #ifndef __ASM_BARRIER_H
>  #define __ASM_BARRIER_H
>  
> +#include <asm/alternative.h>
> +
>  /*
>   * Force strict CPU ordering.
>   * And yes, this is required on UP too when we're talking
> @@ -23,6 +25,42 @@
>  
>  #define mb() do {  asm volatile(__ASM_BARRIER : : : "memory"); } while (0)
>  
> +static inline void gmb(void)
> +{
> +	asm volatile(
> +		ALTERNATIVE("", ".long 0xb2e8f000", 81)
> +		: : : "memory");
> +}

Just to be sure:

There are now 2 new facilities:

81 and 82.

Is 82 just the virtualization (SIE) support for 81?

-- 

Thanks,

David / dhildenb
