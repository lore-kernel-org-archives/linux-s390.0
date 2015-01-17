From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH/RFC 14/21] KVM: s390: clear the pfault queue if user
 space sets the invalid token
Date: Sat, 17 Jan 2015 11:50:09 +0100
Message-ID: <20150117105009.GA12539@osiris>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
 <1421329414-76826-15-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421329414-76826-15-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 15, 2015 at 02:43:27PM +0100, Christian Borntraeger wrote:
> From: David Hildenbrand <dahi@linux.vnet.ibm.com>
> 
> We need a way to clear the async pfault queue from user space (e.g.
> for resets and SIGP SET ARCHITECTURE).
> 
> This patch simply clears the queue as soon as user space sets the
> invalid pfault token. The definition of the invalid token is moved
> to uapi.
> 
> Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 1 -
>  arch/s390/include/uapi/asm/kvm.h | 3 +++
>  arch/s390/kvm/kvm-s390.c         | 4 ++++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 4de479e..b617052 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -469,7 +469,6 @@ struct kvm_vcpu_arch {
>  	};
>  	struct gmap *gmap;
>  	struct kvm_guestdbg_info_arch guestdbg;
> -#define KVM_S390_PFAULT_TOKEN_INVALID	(-1UL)
>  	unsigned long pfault_token;
>  	unsigned long pfault_select;
>  	unsigned long pfault_compare;
> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> index 9c01159..ac3000d 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -108,6 +108,9 @@ struct kvm_guest_debug_arch {
>  	struct kvm_hw_breakpoint __user *hw_bp;
>  };
>  
> +/* for KVM_SYNC_PFAULT and KVM_REG_S390_PFTOKEN */
> +#define KVM_S390_PFAULT_TOKEN_INVALID	0xffffffffffffffffUL

uapi is for both 64 bit and (theoretically) also 32 bit. So this
should be 0xfff...ffULL instead of UL to prevent a different compat
ABI.
