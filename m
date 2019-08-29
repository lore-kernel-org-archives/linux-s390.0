Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfH2MkV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Aug 2019 08:40:21 -0400
Date: Thu, 29 Aug 2019 14:40:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] KVM: s390: Test for bad access register and size at
 the start of S390_MEM_OP
Message-ID: <20190829144013.322edb0a.cohuck@redhat.com>
In-Reply-To: <20190829122517.31042-1-thuth@redhat.com>
References: <20190829122517.31042-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 14:25:17 +0200
Thomas Huth <thuth@redhat.com> wrote:

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

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
