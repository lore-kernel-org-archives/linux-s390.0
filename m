Return-Path: <SRS0=rjjQ=ST=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH] KVM: s390: Fix potential spectre warnings
References: <20190417005414.47801-1-farman@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bdea8892-6818-93fa-fa2a-b2bad69a50d1@redhat.com>
Date: Wed, 17 Apr 2019 09:49:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190417005414.47801-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 17.04.19 02:54, Eric Farman wrote:
> Fix some warnings from smatch:
> 
> arch/s390/kvm/interrupt.c:2310 get_io_adapter() warn: potential spectre issue 'kvm->arch.adapters' [r] (local cap)
> arch/s390/kvm/interrupt.c:2341 register_io_adapter() warn: potential spectre issue 'dev->kvm->arch.adapters' [w]
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> A recent patch from Paolo [1] acted as a reminder (thanks, Christian!)
> that I had one for the s390 KVM code after some code reviews [2].
> Let's clean that up.
> 
> [1] https://patchwork.kernel.org/patch/10895463/
> [2] https://patchwork.kernel.org/patch/10788565/#22484223
> ---
>  arch/s390/kvm/interrupt.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 82162867f378..bfd55ad34a3e 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -14,6 +14,7 @@
>  #include <linux/kvm_host.h>
>  #include <linux/hrtimer.h>
>  #include <linux/mmu_context.h>
> +#include <linux/nospec.h>
>  #include <linux/signal.h>
>  #include <linux/slab.h>
>  #include <linux/bitmap.h>
> @@ -2307,6 +2308,7 @@ static struct s390_io_adapter *get_io_adapter(struct kvm *kvm, unsigned int id)
>  {
>  	if (id >= MAX_S390_IO_ADAPTERS)
>  		return NULL;
> +	id = array_index_nospec(id, MAX_S390_IO_ADAPTERS);
>  	return kvm->arch.adapters[id];

return kvm->arch.adapters[array_index_nospec(id, MAX_S390_IO_ADAPTERS)];

should exactly fit into a single line if I am not wrong.

>  }
>  
> @@ -2320,8 +2322,13 @@ static int register_io_adapter(struct kvm_device *dev,
>  			   (void __user *)attr->addr, sizeof(adapter_info)))
>  		return -EFAULT;
>  
> -	if ((adapter_info.id >= MAX_S390_IO_ADAPTERS) ||
> -	    (dev->kvm->arch.adapters[adapter_info.id] != NULL))
> +	if (adapter_info.id >= MAX_S390_IO_ADAPTERS)
> +		return -EINVAL;
> +
> +	adapter_info.id = array_index_nospec(adapter_info.id,
> +					     MAX_S390_IO_ADAPTERS);

I dislike that we are modifying adapter_info here. Can you use a local
variable instead?

> +
> +	if (dev->kvm->arch.adapters[adapter_info.id] != NULL)
>  		return -EINVAL;
>  
>  	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
> 

-- 

Thanks,

David / dhildenb
