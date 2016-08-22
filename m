From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 4/4] KVM-S390: Delete an unnecessary initialisation for
 a buffer variable
Date: Mon, 22 Aug 2016 15:01:15 +0200
Message-ID: <20160822150115.0fe8f20c.cornelia.huck@de.ibm.com>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
        <6cf36937-3937-0521-5f11-258f557e0c32@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <6cf36937-3937-0521-5f11-258f557e0c32@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?= <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Aug 2016 20:12:15 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 17 Aug 2016 19:28:15 +0200
> 
> The variable "bp_data" will eventually be set to an appropriate pointer
> from a call of the memdup_user() function.
> Thus omit the explicit initialisation which became unnecessary with
> a previous update step.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/s390/kvm/guestdbg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> index f2514af..ad04609 100644
> --- a/arch/s390/kvm/guestdbg.c
> +++ b/arch/s390/kvm/guestdbg.c
> @@ -207,7 +207,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>  			    struct kvm_guest_debug *dbg)
>  {
>  	int ret = 0, nr_wp = 0, nr_bp = 0, i, size;
> -	struct kvm_hw_breakpoint *bp_data = NULL;
> +	struct kvm_hw_breakpoint *bp_data;
>  	struct kvm_hw_wp_info_arch *wp_info = NULL;
>  	struct kvm_hw_bp_info_arch *bp_info = NULL;
> 

NACK.
