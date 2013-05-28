From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: s390: Add "devname:kvm" alias.
Date: Tue, 28 May 2013 11:00:33 +0200
Message-ID: <51A47231.8020001@redhat.com>
References: <1369672953-33705-1-git-send-email-cornelia.huck@de.ibm.com> <1369672953-33705-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1369672953-33705-2-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Il 27/05/2013 18:42, Cornelia Huck ha scritto:
> Providing a "devname:kvm" module alias enables automatic loading of
> the kvm module when /dev/kvm is opened.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 93444c4..3b597e5 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1138,3 +1138,12 @@ static void __exit kvm_s390_exit(void)
>  
>  module_init(kvm_s390_init);
>  module_exit(kvm_s390_exit);
> +
> +/*
> + * Enable autoloading of the kvm module.
> + * Note that we add the module alias here instead of virt/kvm/kvm_main.c
> + * since x86 takes a different approach.
> + */
> +#include <linux/miscdevice.h>
> +MODULE_ALIAS_MISCDEV(KVM_MINOR);
> +MODULE_ALIAS("devname:kvm");
> 

Looks good for 3.10.  Should I take this since Alex is on holiday, or
should I wait for him to come back?

Paolo
