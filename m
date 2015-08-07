From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] kvm:s390:Fix assumption that kvm_set_irq_routing is always
 run successfully
Date: Fri, 07 Aug 2015 11:09:07 +0200
Message-ID: <55C475B3.1080303@de.ibm.com>
References: <1438880754-27149-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438880754-27149-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Nicholas Krause <xerofoify@gmail.com>, gleb@kernel.org
Cc: pbonzini@redhat.com, cornelia.huck@de.ibm.com, linux390@de.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am 06.08.2015 um 19:05 schrieb Nicholas Krause:
> This fixes the assumption that kvm_set_irq_routing is always run
> successfully by instead making it equal to the variable r which
> we use for returning in the function kvm_arch_vm_ioctl instead
> of making r equal to zero when calling this particular function
> and incorrectly making the caller of kvm_arch_vm_ioctl think
> the function has run successfully.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f32f843..660860f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -879,8 +879,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		if (kvm->arch.use_irqchip) {
>  			/* Set up dummy routing. */
>  			memset(&routing, 0, sizeof(routing));
> -			kvm_set_irq_routing(kvm, &routing, 0, 0);
> -			r = 0;
> +			r = kvm_set_irq_routing(kvm, &routing, 0, 0);
>  		}
>  		break;
>  	}
> 

Thanks, applied with changed prefix (KVM: s390:)
