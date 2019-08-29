Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH2LSw (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Aug 2019 07:18:52 -0400
Date: Thu, 29 Aug 2019 13:18:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: Test for bad access register at the start of
 S390_MEM_OP
Message-ID: <20190829131845.5a72231a.cohuck@redhat.com>
In-Reply-To: <20190829105356.27805-1-thuth@redhat.com>
References: <20190829105356.27805-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 12:53:56 +0200
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
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f329dcb3f44c..725690853cbd 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4255,7 +4255,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
>  	const u64 supported_flags = KVM_S390_MEMOP_F_INJECT_EXCEPTION
>  				    | KVM_S390_MEMOP_F_CHECK_ONLY;
>  
> -	if (mop->flags & ~supported_flags)
> +	if (mop->flags & ~supported_flags || mop->ar >= NUM_ACRS)
>  		return -EINVAL;

This also matches the value that ar_translation would return, so seems
sane.

>  
>  	if (mop->size > MEM_OP_MAX_SIZE)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Btw: should Documentation/virt/kvm/api.txt spell out the valid range
for ar explicitly?
