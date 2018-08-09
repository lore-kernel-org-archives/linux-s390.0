From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v8 04/22] s390/zcrypt: Integrate ap_asm.h into
 include/asm/ap.h.
Date: Thu, 9 Aug 2018 11:06:45 +0200
Message-ID: <20180809110645.33b20c1f.cohuck@redhat.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1533739472-7172-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533739472-7172-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed,  8 Aug 2018 10:44:14 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Harald Freudenberger <freude@de.ibm.com>
> 
> Move all the inline functions from the ap bus header
> file ap_asm.h into the in-kernel api header file
> arch/s390/include/asm/ap.h so that KVM can make use
> of all the low level AP functions.
> 
> Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

You should add your own s-o-b if you are sending on patches written by
others (even if it does not matter in the end, when they are merged
through a different path anyway.)

> ---
>  arch/s390/include/asm/ap.h     |  284 ++++++++++++++++++++++++++++++++++++----
>  drivers/s390/crypto/ap_asm.h   |  261 ------------------------------------
>  drivers/s390/crypto/ap_bus.c   |   21 +---
>  drivers/s390/crypto/ap_bus.h   |    1 +
>  drivers/s390/crypto/ap_card.c  |    1 -
>  drivers/s390/crypto/ap_queue.c |    1 -
>  6 files changed, 259 insertions(+), 310 deletions(-)
>  delete mode 100644 drivers/s390/crypto/ap_asm.h
> 
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index c1bedb4..046e044 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -47,6 +47,50 @@ struct ap_queue_status {
>  };
>  
>  /**
> + * ap_intructions_available() - Test if AP instructions are available.
> + *
> + * Returns 0 if the AP instructions are installed.

Stumbled over this when I was looking at the usage in patch 7: if I see
a function called '_available' return 0, I'd assume that whatever the
function tests for is *not* available.

Rather call this function ap_instructions_check_availability() (and
keep the return code convention), or switch this to return 0 if not
available and !0 if available?

> + */
> +static inline int ap_instructions_available(void)
> +{
> +	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
> +	register unsigned long reg1 asm ("1") = -ENODEV;
> +	register unsigned long reg2 asm ("2");
> +
> +	asm volatile(
> +		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
> +		"0: la    %0,0\n"
> +		"1:\n"
> +		EX_TABLE(0b, 1b)
> +		: "+d" (reg1), "=d" (reg2)
> +		: "d" (reg0)
> +		: "cc");
> +	return reg1;
> +}
