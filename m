From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 14 Jun 2013 08:20:53 +0000
Subject: Re: [PATCH] s390: Only define synchronize_irq() on SMP
Message-Id: <20130614082053.GA4475@osiris>
In-Reply-To: <1371169124.10688.59.camel@deadeye.wl.decadent.org.uk>
References: <1371169124.10688.59.camel@deadeye.wl.decadent.org.uk>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jun 14, 2013 at 01:18:44AM +0100, Ben Hutchings wrote:
> In uniprocessor configurations, synchronize_irq() is defined in
> <linux/hardirq.h> as a macro, and this function definition fails to
> compile.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: stable@vger.kernel.org # 3.9
> ---
>  arch/s390/kernel/irq.c |    2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.
