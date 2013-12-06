From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC PATCH v3 13/19] smp, s390: prepare for killing
 generic_smp_call_function_single_interrupt()
Date: Fri, 6 Dec 2013 10:43:21 +0100
Message-ID: <20131206094321.GC4524@osiris>
References: <1386173591-28514-1-git-send-email-liuj97@gmail.com>
 <1386173591-28514-14-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386173591-28514-14-git-send-email-liuj97@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shaohua Li <shli@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Thomas Gleixner <tglx@linutronix.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, Wang YanQing <udknight@gmail.com>, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 05, 2013 at 12:13:04AM +0800, Jiang Liu wrote:
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> ---
>  arch/s390/kernel/smp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

I assume you will take care and make sure it gets merged?
Besides that:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
