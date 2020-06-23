Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731853AbgFWJDD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Jun 2020 05:03:03 -0400
Date: Tue, 23 Jun 2020 10:02:57 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 6/8] arm: Break cyclic percpu include
Message-ID: <20200623090257.GA3743@willie-the-truck>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.454517573@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623083721.454517573@infradead.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

On Tue, Jun 23, 2020 at 10:36:51AM +0200, Peter Zijlstra wrote:
> In order to use <asm/percpu.h> in irqflags.h, we need to make sure
> asm/percpu.h does not itself depend on irqflags.h.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm/include/asm/percpu.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/arch/arm/include/asm/percpu.h
> +++ b/arch/arm/include/asm/percpu.h
> @@ -10,6 +10,8 @@
>   * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
>   */
>  #if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
> +register unsigned long current_stack_pointer asm ("sp");

If you define this unconditionally, then we can probably get rid of the
copy in asm/thread_info.h, rather than duplicate the same #define.

Will
