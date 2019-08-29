Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] KVM: s390: Test for bad access register and size at
 the start of S390_MEM_OP
References: <20190829122517.31042-1-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <36ce3dc8-486b-05ce-b906-6ea6b5584bf7@redhat.com>
Date: Thu, 29 Aug 2019 15:57:27 +0200
MIME-Version: 1.0
In-Reply-To: <20190829122517.31042-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 29.08.19 14:25, Thomas Huth wrote:
> If the KVM_S390_MEM_OP ioctl is called with an access register >= 16,
> then there is certainly a bug in the calling userspace application.
> We check for wrong access registers, but only if the vCPU was already
> in the access register mode before (i.e. the SIE block has recorded
> it). The check is also buried somewhere deep in the calling chain (in
> the function ar_translation()), so this is somewhat hard to find.
> 
> It's better to always report an error to the userspace in case this
> field is set wrong, and it's safer in the KVM code if we block wrong
> values here early instead of relying on a check somewhere deep down
> the calling chain, so let's add another check to kvm_s390_guest_mem_op()
> directly.
> 
> We also should check that the "size" is non-zero here (thanks to Janosch
> Frank for the hint!). If we do not check the size, we could call vmalloc()
> with this 0 value, and this will cause a kernel warning.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Check mop->size to be non-zero
> 
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f329dcb3f44c..49d7722229ae 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4255,7 +4255,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
>  	const u64 supported_flags = KVM_S390_MEMOP_F_INJECT_EXCEPTION
>  				    | KVM_S390_MEMOP_F_CHECK_ONLY;
>  
> -	if (mop->flags & ~supported_flags)
> +	if (mop->flags & ~supported_flags || mop->ar >= NUM_ACRS || !mop->size)
>  		return -EINVAL;
>  
>  	if (mop->size > MEM_OP_MAX_SIZE)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
