From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] s390/kernel: use stnsm instead of stosm
Date: Tue, 16 Dec 2014 10:31:59 +0100
Message-ID: <548FFC0F.9010605@de.ibm.com>
References: <1418722232-37902-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1418722232-37902-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Paolo,


sorry, should have only go to Martin and Heiko. 
Nothing to worry about from your side. :-)


Am 16.12.2014 um 10:30 schrieb Christian Borntraeger:
> At least on z196 stnsm is faster than stosm.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/irqflags.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/irqflags.h b/arch/s390/include/asm/irqflags.h
> index 37b9091..16aa0c7 100644
> --- a/arch/s390/include/asm/irqflags.h
> +++ b/arch/s390/include/asm/irqflags.h
> @@ -36,7 +36,7 @@ static inline notrace void __arch_local_irq_ssm(unsigned long flags)
> 
>  static inline notrace unsigned long arch_local_save_flags(void)
>  {
> -	return __arch_local_irq_stosm(0x00);
> +	return __arch_local_irq_stnsm(0xff);
>  }
> 
>  static inline notrace unsigned long arch_local_irq_save(void)
> 
