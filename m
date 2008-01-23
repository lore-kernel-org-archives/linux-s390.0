From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 23 Jan 2008 10:19:56 +0000
Subject: Re: [PATCH] s390: do local_irq_restore while spinning in
Message-Id: <20080123101956.GA13270@osiris.boeblingen.de.ibm.com>
In-Reply-To: <6.0.0.20.2.20080122184233.03a30b78@172.19.0.2>
References: <6.0.0.20.2.20080122184233.03a30b78@172.19.0.2>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 22, 2008 at 06:53:13PM +0900, Hisashi Hifumi wrote:
> Hi
>
> In s390's spin_lock_irqsave, interrupts remain disabled while spinning.
> In other architectures like x86 and powerpc, interrupts are re-enabled 
> while spinning
> if IRQ is not masked before spin_lock_irqsave is called.
>
> The following patch re-enables interrupts through local_irq_restore while 
> spinning
> for a lock acquisition. This can improve system response.
>
> Comments?

Thanks for your patch! Makes sense. I will change it so it will apply on
our patch queue and add it.
