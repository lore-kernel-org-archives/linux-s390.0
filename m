From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [Patchv5 6/7] KVM: async_pf:  Async page fault support on s390
Date: Sun, 13 Oct 2013 12:30:32 +0300
Message-ID: <20131013093032.GE15657@redhat.com>
References: <1381244100-59056-1-git-send-email-borntraeger@de.ibm.com>
 <1381244100-59056-7-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381244100-59056-7-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 08, 2013 at 04:54:59PM +0200, Christian Borntraeger wrote:
> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> index 33d52b8..1e8fced 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -17,9 +17,12 @@
>  #define __KVM_S390
>  
>  /* Device control API: s390-specific devices */
> -#define KVM_DEV_FLIC_DEQUEUE 1
> -#define KVM_DEV_FLIC_ENQUEUE 2
> -#define KVM_DEV_FLIC_CLEAR_IRQS 3
Those were introduced in patch 2. Fix spaces there please.

> +#define KVM_DEV_FLIC_DEQUEUE		1
> +#define KVM_DEV_FLIC_ENQUEUE		2
> +#define KVM_DEV_FLIC_CLEAR_IRQS		3
> +#define KVM_DEV_FLIC_APF_ENABLE		4
> +#define KVM_DEV_FLIC_APF_DISABLE	5
> +#define KVM_DEV_FLIC_APF_DISABLE_WAIT	6
Those need to be documented in
Documentation/virtual/kvm/devices/s390_flic.txt

--
			Gleb.
